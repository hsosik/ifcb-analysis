resultpath = '\\raspberry\d_work\IFCB1\ifcb_data_mvco_jun06\Manual_fromClass\';
load([resultpath 'manual_list']) %load the manual list detailing annotate mode for each sample file
load ml_analyzed_all %load the milliliters analyzed for all sample files
biovolpath = '\\queenrose\IFCB1\ifcb_data_mvco_jun06\biovolume\';
micron_factor = 1/3.4; %microns per pixel

mode_list = manual_list(1,2:end-1); mode_list = [mode_list 'ciliate_ditylum'];
%find ml_analyzed matching each manual file
filelist = char(manual_list(2:end,1)); filelist = cellstr(filelist(:,1:end-4));

[~,ia, ib] = intersect(filelist, filelist_all);
if length(ia) ~= length(filelist),
    disp('missing some ml_analyzed values; need to make updated ml_analyzed all.mat?')
    pause
end;
temp = NaN(size(filelist));
temp(ia) = ml_analyzed(ib);
ml_analyzed = temp;
%clean up from ml_analyzed_all
clear filelist_all looktime matdate minproctime runtim
filelist_all = filelist;

%calculate date
fstr = char(filelist);
year = str2num(fstr(:,7:10));
yearday = str2num(fstr(:,12:14));
hour = str2num(fstr(:,16:17));
min = str2num(fstr(:,18:19));
sec = str2num(fstr(:,20:21));
matdate = datenum(year,0,yearday,hour,min,sec);
clear fstr year yearday hour min sec

load([resultpath char(manual_list(2,1))]) %read first file to get classes
class2use_manual_first = class2use_manual;
class2use_first_sub = class2use_sub4; %this is specific for one sub case = ciliates
class_ciliate = {'ciliate' 'not_ciliate' 'ciliate_mix' 'tintinnid' 'Myrionecta' 'Laboea'};
numclass1 = length(class2use_manual);
numclass2 = length(class2use_sub4);
numclass = numclass1 + numclass2;
class2use_here = [class2use_manual_first class2use_sub4];
[~,ind_ciliate] = intersect(class2use_here, class_ciliate);
%classcount = NaN(length(filelist),numclass);  %initialize output
%classbiovol = classcount;
%classcarbon = classcount;
for classnum = 1:length(class_ciliate),
    ml_analyzed_struct.(class_ciliate{classnum}) = NaN(1,length(ml_analyzed));
    [biovol.(class_ciliate{classnum}){1:length(ml_analyzed)}] = deal([]);
    %[biovol.(class_ciliate{classnum})(1:length(ml_analyzed))] = deal([]);
    %biovol.(char(class_ciliate(classnum))) = num2cell(NaN(1,length(ml_analyzed)));
end;
eqdiam = biovol;
for loopcount = 1:length(mode_list),
    annotate_mode = char(mode_list(loopcount));
    switch annotate_mode
        case 'all categories'
            %use them all
            class_cat = 1:numclass;
            manual_only = 0;
            list_col = strmatch(annotate_mode, manual_list(1,:));
            mode_ind = find(cell2mat(manual_list(2:end,list_col)));
        case 'ciliates'
            [~, class_cat] = intersect(class2use_here, ['ciliate' class2use_first_sub]);
            manual_only = 0;
            list_col = strmatch(annotate_mode, manual_list(1,:));
            mode_ind = find(cell2mat(manual_list(2:end,list_col)) & ~cell2mat(manual_list(2:end,2)));
        case 'ditylum'
            [~, class_cat] = intersect(class2use_here, 'Ditylum');
            manual_only = 0;
            list_col = strmatch(annotate_mode, manual_list(1,:));
            mode_ind = find(cell2mat(manual_list(2:end,list_col)) & ~cell2mat(manual_list(2:end,2)) & ~cell2mat(manual_list(2:end,strmatch('diatoms', mode_list)+1)));
        case 'diatoms'
            %all except mix, mix_elongated, and detritus
            [~, class_cat] = setdiff(class2use_here, {'mix' 'detritus'});
            manual_only = 0;
            list_col = strmatch(annotate_mode, manual_list(1,:));
            mode_ind = find(cell2mat(manual_list(2:end,list_col)) & ~cell2mat(manual_list(2:end,2)));
        case 'big ciliates'
            [~, class_cat] = intersect(class2use_here, {'tintinnid' 'Laboea'});
            manual_only = 0;
            list_col = strmatch(annotate_mode, manual_list(1,:));
            mode_ind = find(cell2mat(manual_list(2:end,list_col)) & ~cell2mat(manual_list(2:end,2)) & ~cell2mat(manual_list(2:end,strmatch('ciliates', mode_list)+1)));
        case 'special big only'
            [~, class_cat] = intersect(class2use_here, {'Ceratium' 'Eucampia' 'Ephemera' 'bad' 'Dinophysis' 'Lauderia' 'Licmophora' 'Phaeocystis' 'Stephanopyxis' ...
                'Coscinodiscus' 'Odontella' 'Guinardia_striata' 'tintinnid' 'Laboea' 'Hemiaulus' 'Paralia' 'Guinardia_flaccida' 'Corethron' 'Dactyliosolen' 'Dictyocha'...
                'Dinobryon' 'Ditylum' 'Pleurosigma' 'Prorocentrum' 'Rhizosolenia' 'Thalassionema' 'clusterflagellate' 'kiteflagellates' 'Pyramimonas'});
            manual_only = 1;
            list_col = strmatch(annotate_mode, manual_list(1,:));
            mode_ind = find(cell2mat(manual_list(2:end,list_col)) & ~cell2mat(manual_list(2:end,2)));
        case 'ciliate_ditylum'
            [~, class_cat] = intersect(class2use_here, ['Ditylum' 'ciliate' class2use_first_sub]);
            manual_only = 0;
            mode_ind = find(~cell2mat(manual_list(2:end,2)) & cell2mat(manual_list(2:end,3)) & cell2mat(manual_list(2:end,4)) & ~cell2mat(manual_list(2:end,5)) & cell2mat(manual_list(2:end,6)));
    end;
    class_cat = intersect(class_cat, ind_ciliate);
    [~,temp1,temp2] = intersect(class2use_first_sub, class2use_here(class_cat));
    class_cat2(temp2) = temp1;
    filelist = cell2struct(manual_list(mode_ind+1,1),{'name'},2);
    
    for filecount = 1:length(filelist),
        filename = filelist(filecount).name;
        disp(filename)
        for classnum = 1:length(class_cat),
            ml_analyzed_struct.(char(class2use_here(class_cat(classnum))))(mode_ind(filecount)) = ml_analyzed(mode_ind(filecount));
        end;
        load([resultpath filename])
        load([biovolpath filename]) %targets
        tind = char(targets.pid); %find the ROI indices excluding second in stitched pair
        tind = str2num(tind(:,end-4:end));
        classlist = classlist(tind,:);
        if ~isequal(class2use_manual, class2use_manual_first)
            disp('class2use_manual does not match previous files!!!')
            %     keyboard
        end;
        if exist('class2use_sub4', 'var'),
            if ~isequal(class2use_sub4, class2use_first_sub)
                disp('class2use_sub4 does not match previous files!!!')
                keyboard
            end;
        end;
        
        for classnum = 1:length(class_cat),
            if class_cat(classnum) <= numclass1,
                if manual_only,
                    cind = find(classlist(:,2) == class_cat(classnum));
                else
                    cind = find(classlist(:,2) == class_cat(classnum) | (isnan(classlist(:,2)) & classlist(:,3) == class_cat(classnum)));
                end;
                if ~isempty(cind),
                    biovol.(char(class2use_here(class_cat(classnum))))(mode_ind(filecount)) = {targets.Biovolume(cind)*micron_factor.^3};
                    eqdiam.(char(class2use_here(class_cat(classnum))))(mode_ind(filecount)) = {targets.EquivDiameter(cind)*micron_factor};
                end;
            else %subdivide case
               if exist('class2use_sub4', 'var'),
                    cind = find(classlist(:,4) == class_cat2(classnum));
                    if ~isempty(cind),
                        biovol.(char(class2use_here(class_cat(classnum))))(mode_ind(filecount)) = {targets.Biovolume(cind)*micron_factor.^3};
                        eqdiam.(char(class2use_here(class_cat(classnum))))(mode_ind(filecount)) = {targets.EquivDiameter(cind)*micron_factor};
                    end;
               end;
            end;
        end;
    clear class2use_manual class2use_auto class2use_sub* classlist
    end;
end;

filelist = filelist_all;
class2use = class2use_here;
if ~exist([resultpath 'summary\'], 'dir')
    mkdir([resultpath 'summary\'])
end;
datestr = date; datestr = regexprep(datestr,'-','');
save([resultpath 'summary\ciliate_manual_' datestr], 'matdate', 'ml_analyzed_struct', 'biovol', 'filelist', 'eqdiam')

return

%create and save daily binned results
[matdate_bin, classcount_bin, ml_analyzed_mat_bin] = make_day_bins(matdate,classcount, ml_analyzed_mat);
[matdate_bin, classbiovol_bin, ml_analyzed_mat_bin] = make_day_bins(matdate,classbiovol, ml_analyzed_mat);
save([resultpath 'summary\count_biovol_manual_' datestr '_day'], 'matdate_bin', 'classcount_bin', 'classbiovol_bin', 'ml_analyzed_mat_bin', 'class2use')

