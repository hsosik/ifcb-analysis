classifierName = 'MVCO_trees_25Jun2012';
yr = 2013;
out_dir = ['\\queenrose\g_work_ifcb1\ifcb_data_mvco_jun06\class' num2str(yr) '_v1\'];
in_dir = 'http://demi.whoi.edu/mvco/';
filelist = [];
for day = 70:96,
    filelist = [filelist list_day(datestr(datenum(yr,0,day),29), in_dir)];
end;
filelist = regexprep(filelist, in_dir, '')';
files_done = dir([out_dir 'IFCB*class_v1.mat']);
files_done = char(files_done.name);
files_done = cellstr(files_done(:,1:end-13));
filelist2 = setdiff(filelist, files_done); 
disp(['processing ' num2str(length(filelist2)) ' files'])
if ~isempty(filelist2),
    filelist2 = strcat(filelist2,'_features.csv');
    batch_classify( in_dir, filelist2, out_dir, classifierName );
end;
