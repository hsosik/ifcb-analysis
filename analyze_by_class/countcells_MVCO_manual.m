resultpath = '\\sosiknas1\IFCB_products\MVCO\Manual_fromClass\';
urlstr = 'http://ifcb-data.whoi.edu/mvco/';
load([resultpath 'manual_list']) %load the manual list detailing annotate mode for each sample file
load \\sosiknas1\IFCB_products\MVCO\ml_analyzed\ml_analyzed_all %load the milliliters analyzed for all sample files

load class2use_MVCOmanual5 %get the master list to start
[ classes_byfile, classes_bymode ] = get_annotated_classesMVCO( class2use, manual_list);

filelist = classes_byfile.filelist;

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

ia = find(isnan(ml_analyzed));
files_missing_ml = filelist(ia); %assume these are the D files
temp = IFCB_volume_analyzed([repmat(urlstr,length(ia),1) char(filelist(ia)) repmat('.hdr', length(ia),1)]);
ml_analyzed(ia) = temp;


%mark NaNs in ml_analyzed for classify not complete in manual annotation
analyzed_flag = classes_byfile.classes_checked; analyzed_flag(analyzed_flag == 0) = NaN;
ml_analyzed_mat = repmat(ml_analyzed,1,length(class2use)).*analyzed_flag;

%calculate date
matdate = IFCB_file2date(filelist);;

class2use_manual = class2use;
class2use_manual_first = class2use_manual;
numclass = length(class2use_manual);
class2use_here = [class2use_manual_first]; 
classcount = NaN(length(filelist),numclass);  %initialize output

for filecount = 1:length(filelist),
    filename = filelist{filecount};
    disp(filename)
    load([resultpath filename])
    if ~isequal(class2use_manual, class2use_manual_first)
        disp('class2use_manual does not match previous files!!!')
        %     keyboard
    end;
    temp = zeros(1,numclass); %init as zeros for case of subdivide checked but none found, ml_analyzed will be positive only if in class_cat, else NaN
    for classnum = 1:numclass,
        temp(classnum) = size(find(classlist(:,2) == classnum | (isnan(classlist(:,2)) & classlist(:,3) == classnum)),1);
    end;
    
    classcount(filecount,:) = temp;
    clear class2use_manual class2use_auto class2use_sub* classlist
end;

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

