resultpath = '\\raspberry\d_work\IFCB1\ifcb_data_mvco_jun06\Manual_fromClass\';
load([resultpath 'manual_list']) %load the manual list detailing annotate mode for each sample file
load \\raspberry\d_work\IFCB1\code_mar10_mvco\ml_analyzed_all %load the milliliters analyzed for all sample files
biovolpath_base = '\\queenrose\g_work_ifcb1\ifcb_data_mvco_jun06\biovolume\';
%feapath_base1 = '\\queenrose\g_work_ifcb1\ifcb_data_mvco_jun06\featuresXXXX_v1\';
feapath_base = '\\queenrose\g_work_ifcb1\ifcb_data_mvco_jun06\featuresXXXX_v2\';
csv_path = 'http://ifcb-data.whoi.edu/mvco/';
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
load class2use_MVCOmanual3 %get the master list to start
class2use_manual = class2use;
class2use_manual_first = class2use_manual;
class2use_first_sub = class2use_sub4; %this is specific for one sub case = ciliates
%class_ciliate = {'ciliate' 'not_ciliate' 'ciliate_mix' 'tintinnid' 'Myrionecta' 'Laboea'};
numclass1 = length(class2use_manual);
numclass2 = length(class2use_sub4);
numclass = numclass1 + numclass2;
class2use_here = [class2use_manual_first class2use_sub4];
%[~,ind_ciliate] = intersect(class2use_here, class_ciliate);
%classcount = NaN(length(filelist),numclass);  %initialize output
%classbiovol = classcount;
%classcarbon = classcount;
for classnum = 1:length(class2use_here),
    ml_analyzed_struct.(class2use_here{classnum}) = NaN(1,length(ml_analyzed));
    [biovol.(class2use_here{classnum}){1:length(ml_analyzed)}] = deal([]);
    [perim.(class2use_here{classnum}){1:length(ml_analyzed)}] = deal([]);
    %[biovol.(class_ciliate{classnum})(1:length(ml_analyzed))] = deal([]);
    %biovol.(char(class_ciliate(classnum))) = num2cell(NaN(1,length(ml_analyzed)));
end;
eqdiam = biovol;
roiID = biovol;
chlL = biovol; chlH = biovol;
sscL = biovol; sscH = biovol;
for loopcount = 1:length(mode_list),
    annotate_mode = char(mode_list(loopcount));
    [ class_cat, list_col, mode_ind, manual_only ] = config_annotate_mode( annotate_mode, class2use_here, class2use_first_sub, manual_list, mode_list );
   % class_cat = intersect(class_cat, ind_ciliate);
   % [~,temp1,temp2] = intersect(class2use_first_sub, class2use_here(class_cat));
   % class_cat2(temp2) = temp1;
    filelist = cell2struct(manual_list(mode_ind+1,1),{'name'},2);
    
    for filecount = 1:length(filelist),
        filename = filelist(filecount).name;
        disp([annotate_mode ': ' filename])
        for classnum = 1:length(class_cat),
            ml_analyzed_struct.(char(class2use_here(class_cat(classnum))))(mode_ind(filecount)) = ml_analyzed(mode_ind(filecount));
        end;
        %ml_analyzed_mat(mode_ind(filecount),class_cat) = ml_analyzed(mode_ind(filecount));
        load([resultpath filename])
        yr = str2num(filename(7:10));
%         if yr < 2013,
%             biovolpath = [biovolpath_base 'biovolume' filename(7:10) '\'];
%             load([biovolpath filename]) %targets
%             tind = char(targets.pid); %find the ROI indices excluding second in stitched pair
%             tind = str2num(tind(:,end-4:end));
%             feapath = regexprep(feapath_base1, 'XXXX', filename(7:10));
%             [~,file] = fileparts(filename);
%             feastruct = importdata([feapath file '_fea_v1.csv'], ','); 
%             ind = strmatch('Perimeter', feastruct.colheaders);
%             targets.Perimeter = feastruct.data(:,ind);
%          else %2013 and later, v2 features with biovolume
            clear targets
            feapath = regexprep(feapath_base, 'XXXX', filename(7:10));
            [~,file] = fileparts(filename);
            csv_data = get_csv_file([csv_path file '.csv']);
            targets = csv2targets(csv_data);
            feastruct = importdata([feapath file '_fea_v2.csv'], ','); 
            ind = strmatch('Biovolume', feastruct.colheaders);
            targets.Biovolume = feastruct.data(:,ind);
            ind = strmatch('EquivDiameter', feastruct.colheaders);
            targets.EquivDiameter = feastruct.data(:,ind);
            ind = strmatch('Perimeter', feastruct.colheaders);
            targets.Perimeter = feastruct.data(:,ind);
            ind = strmatch('roi_number', feastruct.colheaders);
            tind = feastruct.data(:,ind);
            [~,f] = fileparts(filename);
            targets.pid = cellstr(strcat(f,'_', num2str(tind, '%05.0f')));
                        
%        end;
        
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
        
        for classnum = 1:numclass1,
            if manual_only,
                cind = find(classlist(:,2) == classnum);
            else
                cind = find(classlist(:,2) == classnum | (isnan(classlist(:,2)) & classlist(:,3) == classnum));
            end;
            if ~isempty(cind),
                biovol.(char(class2use_here(classnum)))(mode_ind(filecount)) = {targets.Biovolume(cind)*micron_factor.^3};
                eqdiam.(char(class2use_here(classnum)))(mode_ind(filecount)) = {targets.EquivDiameter(cind)*micron_factor};
                roiID.(char(class2use_here(classnum)))(mode_ind(filecount)) = {char(targets.pid(cind))};
                perim.(char(class2use_here(classnum)))(mode_ind(filecount)) = {targets.Perimeter(cind)*micron_factor};
                chlL.(char(class2use_here(classnum)))(mode_ind(filecount)) = {targets.fluorescenceLow(cind)};
                chlH.(char(class2use_here(classnum)))(mode_ind(filecount)) = {targets.fluorescenceHigh(cind)};
                sscL.(char(class2use_here(classnum)))(mode_ind(filecount)) = {targets.scatteringLow(cind)};
                sscH.(char(class2use_here(classnum)))(mode_ind(filecount)) = {targets.scatteringHigh(cind)};
            end;
        end;
        if exist('class2use_sub4', 'var'),
             if ~isequal(class2use_sub4, class2use_first_sub)
                disp('class2use_sub4 does not match previous files!!!')
                keyboard
            end;
            for classnum = 1:numclass2,
                cind = find(classlist(:,4) == classnum);
                if ~isempty(cind),
                    biovol.(char(class2use_here(classnum+numclass1)))(mode_ind(filecount)) = {targets.Biovolume(cind)*micron_factor.^3};
                    eqdiam.(char(class2use_here(classnum+numclass1)))(mode_ind(filecount)) = {targets.EquivDiameter(cind)*micron_factor};
                    perim.(char(class2use_here(classnum+numclass1)))(mode_ind(filecount)) = {targets.Perimeter(cind)*micron_factor};
                    roiID.(char(class2use_here(classnum+numclass1)))(mode_ind(filecount)) = {char(targets.pid(cind))};
                    chlL.(char(class2use_here(classnum+numclass1)))(mode_ind(filecount)) = {targets.fluorescenceLow(cind)};
                    chlH.(char(class2use_here(classnum+numclass1)))(mode_ind(filecount)) = {targets.fluorescenceHigh(cind)};
                    sscL.(char(class2use_here(classnum+numclass1)))(mode_ind(filecount)) = {targets.scatteringLow(cind)};
                    sscH.(char(class2use_here(classnum+numclass1)))(mode_ind(filecount)) = {targets.scatteringHigh(cind)};
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
save([resultpath 'summary\count_biovol_size_adc_manual_' datestr], 'matdate', 'ml_analyzed_struct', 'biovol', 'filelist', 'eqdiam', 'perim', 'roiID', 'chlL', 'chlH', 'sscL', 'sscH')

return

%create and save daily binned results
[matdate_bin, classcount_bin, ml_analyzed_mat_bin] = make_day_bins(matdate,classcount, ml_analyzed_mat);
[matdate_bin, classbiovol_bin, ml_analyzed_mat_bin] = make_day_bins(matdate,classbiovol, ml_analyzed_mat);
save([resultpath 'summary\count_biovol_manual_' datestr '_day'], 'matdate_bin', 'classcount_bin', 'classbiovol_bin', 'ml_analyzed_mat_bin', 'class2use')

