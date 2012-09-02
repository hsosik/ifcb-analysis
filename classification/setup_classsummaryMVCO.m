resultpath = '\\raspberry\d_work\IFCB1\ifcb_data_mvco_jun06\Manual_fromClass\';
%filelist = get_filelist_manual([resultpath 'manual_list'],2,[2006:2012], 'all'); %manual_list, column to use, year to find
%filelist_manual = {filelist.name}';
%mdate = IFCB_file2date({filelist.name});

load([resultpath 'manual_list']) %load the manual list detailing annotate mode for each sample file
filelist = manual_list(2:end,1); %filelist = cellstr(filelist(:,1:end-4));
filelist = regexprep(filelist, '.mat', '');
clear manual_list resultpath
mdate = IFCB_file2date(filelist);

load('ml_analyzed_all', 'ml_analyzed', 'filelist_all');
[~,ia, ib] = intersect(filelist, filelist_all);
if length(ia) ~= length(filelist),
    disp('missing some ml_analyzed values; need to make updated ml_analyzed all.mat?')
    pause
end;
temp = NaN(size(filelist));
temp(ia) = ml_analyzed(ib);
ml_analyzed_list = temp;
clear ml_analyzed filelist_all temp ia ib 

classfilestr = '_class_v1';
[ filelist, classfiles ] = resolve_MVCOclassfiles( filelist, classfilestr );

temp = load(classfiles{1}, 'class2useTB');
class2use = temp.class2useTB; clear temp classfilestr
classcount = NaN(length(filelist),length(class2use));
classcount_above_optthresh = classcount;
classcount_above_adhocthresh = classcount;
num2dostr = num2str(length(filelist));
adhocthresh = 0.5;
for filecount = 1:length(filelist),
    disp(['reading ' num2str(filecount) ' of ' num2dostr])
    [classcount(filecount,:), classcount_above_optthresh(filecount,:), classcount_above_adhocthresh(filecount,:), class2useTB] = summarize_TBclassMVCO(classfiles{filecount}, adhocthresh);
    %[man_temp, class2use_manual] = summacrize_manualMVCO([resultpath filelist_manual{filecount}]);
    %manual_classcount(filecount,1:length(class2use_manual)) = man_temp; 
end;
clear num2dostr filecount

classcountTB = classcount;
classcountTB_above_optthresh = classcount_above_optthresh;
classcountTB_above_adhocthresh = classcount_above_adhocthresh;
ml_analyzedTB = ml_analyzed_list;
mdateTB = mdate;
filelistTB = filelist;

save('summary_manualTB', 'class2useTB', 'classcountTB', 'classcountTB_above_optthresh', 'classcountTB_above_adhocthresh', 'ml_analyzedTB', 'mdateTB', 'filelistTB', 'adhocthresh')
