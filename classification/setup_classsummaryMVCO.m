resultpath = '\\raspberry\d_work\IFCB1\ifcb_data_mvco_jun06\Manual_fromClass\';
filelist = get_filelist_manual([resultpath 'manual_list'],2,[2006:2012], 'all'); %manual_list, column to use, year to find
filelist_manual = {filelist.name}';
mdate = IFCB_file2date({filelist.name});
load('ml_analyzed_all', 'ml_analyzed', 'filelist_all');
ml_analyzed_list = NaN(length(mdate),1);
for ii = 1:length(filelist_manual),
    ind = strmatch(filelist_manual{1}(1:end-4), filelist_all);
    ml_analyzed_list(ii) = ml_analyzed(ind);
end;
clear ml_analyzed filelist_all

classfilestr = '_class_v1';
[ filelist, classfiles ] = resolve_MVCOclassfiles( filelist, classfilestr );

temp = load(classfiles{1}, 'class2useTB');
class2use = temp.class2useTB; clear temp
classcount = NaN(length(filelist),length(class2use));
classcount_above_thresh = classcount;
manual_classcount = NaN(length(filelist),73); 
num2dostr = num2str(length(filelist));
for filecount = 1:length(filelist),
    disp(['reading ' num2str(filecount) ' of ' num2dostr])
    [classcount(filecount,:), classcount_above_thresh(filecount,:), class2useTB] = summarize_TBclassMVCO(classfiles{filecount});
    [man_temp, class2use_manual] = summarize_manualMVCO([resultpath filelist_manual{filecount}]);
    manual_classcount(filecount,1:length(class2use_manual)) = man_temp; 
end;
