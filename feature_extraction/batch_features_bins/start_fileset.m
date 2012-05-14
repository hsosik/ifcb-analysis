%load(['list2012A']) %load the list of bins to process
%filelist = {'IFCB5_2011_063_214358'};
%filelist = list_bins([],5000);
filelist = list_bins('2012-03-01T00:00:00Z', 2000);
temp = char(filelist);
filelist = filelist(strmatch('2012', temp(:,38:41)));
filelist = filelist(1:18:end); %~4 per day
out_dir = '\\queenrose\g_work_ifcb1\ifcb_data_mvco_jun06\features2012_v1\';
in_dir = 'http://ifcb-data.whoi.edu/mvco/';
filelist = regexprep(filelist, in_dir, '')';
files_done = dir([out_dir 'IFCB*fea_v1.csv']);
files_done = char(files_done.name);
files_done = cellstr(files_done(:,1:end-11));
filelist2 = setdiff(filelist, files_done); 
%filelist2 = filelist2(2:end); %FUDGE TO skip messed up file
disp(['processing ' num2str(length(filelist2)) ' files'])
batch_features( in_dir, filelist2, out_dir );