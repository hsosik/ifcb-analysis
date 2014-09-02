resultpath = '\\raspberry\d_work\IFCB1\ifcb_data_mvco_jun06\Manual_fromClass_backup_20Aug2014\';
load([resultpath 'manual_list']) %load the manual list detailing annotate mode for each sample file
load \\raspberry\d_work\IFCB1\code_mar10_mvco\ml_analyzed_all %load the milliliters analyzed for all sample files
resultpath = '\\raspberry\d_work\IFCB1\ifcb_data_mvco_jun06\Manual_fromClass_backup_20Aug2014\';

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
clear filelist_all looktime matdate minproctime runtime
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

load class2use_MVCOciliate
load([resultpath char(manual_list(2,1))], 'class2use_sub4') %read first file to get classes
load class2use_MVCOmanual3 %get the master list to start
class2use_manual = class2use;
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
    [ class_cat, list_col, mode_ind, manual_only ] = config_annotate_mode_old_case_withsub4( annotate_mode, class2use_here, class2use_first_sub, manual_list, mode_list );
    filelist = cell2struct(manual_list(mode_ind+1,1),{'name'},2);
    for filecount = 1:length(filelist),
        filename = filelist(filecount).name;
        disp(filename)
        ml_analyzed_mat(mode_ind(filecount),class_cat) = ml_analyzed(mode_ind(filecount));
        load([resultpath filename])
        if ~isequal(class2use_manual, class2use_manual_first)
            disp('class2use_manual does not match previous files!!!')
       %     keyboard
        end;
        temp = zeros(1,numclass); %init as zeros for case of subdivide checked but none found, ml_analyzed will be positive only if in class_cat, else NaN
        for classnum = 1:numclass1,
            if manual_only,
                temp(classnum) = size(find(classlist(:,2) == classnum),1);
            else
                temp(classnum) = size(find(classlist(:,2) == classnum | (isnan(classlist(:,2)) & classlist(:,3) == classnum)),1);
            end;
        end;
%        if exist('class2use_sub4', 'var'),
        if size(classlist,2) > 3
%            if ~isequal(class2use_sub4, class2use_first_sub)
%                disp('class2use_sub4 does not match previous files!!!')
%                keyboard
%            end;
            for classnum = 1:numclass2,
                temp(classnum+numclass1) = size(find(classlist(:,4) == classnum),1);
            end;
        end;
        %classcount(mode_ind(filecount),class_cat) = temp(class_cat);
        classcount(mode_ind(filecount),:) = temp;
        clear class2use_manual class2use_auto class2use_sub* classlist
    end;
end;

filelist = filelist_all;
class2use = class2use_here;
if ~exist([resultpath 'summary\'], 'dir')
    mkdir([resultpath 'summary\'])
end;
datestr = date; datestr = regexprep(datestr,'-','');
save([resultpath 'summary\count_manual_' datestr], 'matdate', 'ml_analyzed_mat', 'classcount', 'filelist', 'class2use')
save([resultpath 'summary\count_manual_current'], 'matdate', 'ml_analyzed_mat', 'classcount', 'filelist', 'class2use')


%create and save daily binned results
[matdate_bin, classcount_bin, ml_analyzed_mat_bin] = make_day_bins(matdate,classcount, ml_analyzed_mat);
save([resultpath 'summary\count_manual_' datestr '_day'], 'matdate_bin', 'classcount_bin', 'ml_analyzed_mat_bin', 'class2use')
save([resultpath 'summary\count_manual_current_day'], 'matdate_bin', 'classcount_bin', 'ml_analyzed_mat_bin', 'class2use')

