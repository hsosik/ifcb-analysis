resultpath = '\\sosiknas1\IFCB_products\MVCO\Manual_fromClass\';
load([resultpath 'manual_list']) %load the manual list detailing annotate mode for each sample file
load \\sosiknas1\IFCB_products\MVCO\ml_analyzed\ml_analyzed_all %load the milliliters analyzed for all sample files

urlstr = 'http://ifcb-data.whoi.edu/mvco/';

load class2use_MVCOmanual6 %get the master list to start
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
clear filelist_all looktime matdate minproctime runtime ia ib

ia = find(isnan(ml_analyzed));
files_missing_ml = filelist(ia); %assume these are the D files
temp = IFCB_volume_analyzed([repmat(urlstr,length(ia),1) char(filelist(ia)) repmat('.hdr', length(ia),1)]);
ml_analyzed(ia) = temp;

%mark NaNs in ml_analyzed for classify not complete in manual annotation
analyzed_flag = classes_byfile.classes_checked; analyzed_flag(analyzed_flag == 0) = NaN;
ml_analyzed_mat = repmat(ml_analyzed,1,length(class2use)).*analyzed_flag;

load('\\sosiknas1\IFCB_products\MVCO\Manual_fromClass\summary_webMC\summaryOne_results.mat')

%calculate date
matdate = IFCB_file2date(filelist);;