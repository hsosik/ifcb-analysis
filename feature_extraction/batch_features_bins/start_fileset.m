load(['list2012A']) %load the list of bins to process
%filelist = {'IFCB5_2011_063_214358'};
out_dir = '\\queenrose\g_work_ifcb1\ifcb_data_mvco_jun06\features2012_v0\';
in_dir = 'http://ifcb-data.whoi.edu/mvco/';
files_done = dir([out_dir 'IFCB*.mat']);
files_done = char(files_done.name);
files_done = cellstr(files_done(:,1:end-4));
filelist2 = setdiff(filelist, files_done); 
batch_features( in_dir, filelist2, out_dir );