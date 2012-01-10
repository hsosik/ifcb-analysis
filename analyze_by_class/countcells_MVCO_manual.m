resultpath = '\\raspberry\d_work\IFCB1\ifcb_data_mvco_jun06\Manual_fromClass\';
load([resultpath 'manual_list']) %load the manual list detailing annotate mode for each sample file
load ml_analyzed_all %load the milliliters analyzed for all sample files

mode_list = manual_list(1,2:end-1);
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
numclass1 = length(class2use_manual);
numclass2 = length(class2use_sub4);
numclass = numclass1 + numclass2;
class2use_here = [class2use_manual_first class2use_sub4];
classcount = NaN(length(filelist),numclass);  %initialize output
ml_analyzed_mat = classcount;
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
            [~, class_cat] = intersect(class2use_here, 'ditylum');
            manual_only = 0;
            list_col = strmatch(annotate_mode, manual_list(1,:));
            mode_ind = find(cell2mat(manual_list(2:end,list_col)) & ~cell2mat(manual_list(2:end,2)) & ~cell2mat(manual_list(2:end,strmatch('diatoms', mode_list)+1)));
        case 'diatoms'
            %all except mix, mix_elongated, and detritus
            [~, class_cat] = setdiff(class2use_here, {'mix' 'mix_elongated' 'detritus'});
            manual_only = 0;
            list_col = strmatch(annotate_mode, manual_list(1,:));
            mode_ind = find(cell2mat(manual_list(2:end,list_col)) & ~cell2mat(manual_list(2:end,2)));
        case 'big ciliates'
            [~, class_cat] = intersect(class2use_here, {'tintinnid' 'Laboea'});
            manual_only = 0;
            list_col = strmatch(annotate_mode, manual_list(1,:));
            mode_ind = find(cell2mat(manual_list(2:end,list_col)) & ~cell2mat(manual_list(2:end,2)) & ~cell2mat(manual_list(2:end,strmatch('ciliates', mode_list)+1)));
        case 'special big only'
            [~, class_cat] = intersect(class2use_here, {'Ceratium' 'Eucampia' 'bad' 'Dinophysis' 'Lauderia' 'Licmophora' 'Phaeocystis' 'Stephanopyxis' 'Coscinodiscus' 'Odontella' 'Guinardia_striata'});
            manual_only = 1;
            list_col = strmatch(annotate_mode, manual_list(1,:));
            mode_ind = find(cell2mat(manual_list(2:end,list_col)) & ~cell2mat(manual_list(2:end,2)));
    end;
    filelist = cell2struct(manual_list(mode_ind+1,1),{'name'},2);
    for filecount = 1:length(filelist),
        filename = filelist(filecount).name;
        disp(filename)
        ml_analyzed_mat(mode_ind(filecount),class_cat) = ml_analyzed(mode_ind(filecount));
        load([resultpath filename])
        if ~isequal(class2use_manual, class2use_manual_first)
            disp('class2use_manual does not match previous files!!!')
            keyboard
        end;
        temp = NaN(1,numclass);
        for classnum = 1:numclass1,
            if manual_only,
                temp(classnum) = size(find(classlist(:,2) == classnum),1);
            else
                temp(classnum) = size(find(classlist(:,2) == classnum | (isnan(classlist(:,2)) & classlist(:,3) == classnum)),1);
            end;
        end;
        if exist('class2use_sub4', 'var'),
             if ~isequal(class2use_sub4, class2use_first_sub)
                disp('class2use_sub4 does not match previous files!!!')
                keyboard
            end;
            for classnum = 1:numclass2,
                temp(classnum+numclass1) = size(find(classlist(:,4) == classnum),1);
            end;
        end;
        classcount(mode_ind(filecount),class_cat) = temp(class_cat);
        clear class2use_manual class2use_auto class2use_sub* classlist
    end;
end;

filelist = filelist_all;
class2use = class2use_here;
save count_manual_10Jan2012 matdate ml_analyzed_mat classcount filelist class2use

