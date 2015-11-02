addpath('/home/hsosik/ifcbcode/webservice_tools/');
addpath('/home/hsosik/ifcbcode/feature_extraction/');
addpath('/home/hsosik/ifcbcode/dipum_toolbox_2.0.1/');
%filelist = {'IFCB5_2011_063_214358'};
filelist = list_bins('2011-01-01T00:00:00Z', 10000);
temp = char(filelist);
filelist = filelist(strmatch('2010', temp(:,38:41)));
save filelist2010a filelist
%load filelist2011c
filelist = filelist(1:18:end); %~4 per day
%out_dir = '\\queenrose\g_work_ifcb1\ifcb_data_mvco_jun06\features2012_v1\';
out_dir = '/mnt/queenrose/ifcb_data_mvco_jun06/features2011_v1/';
in_dir = 'http://ifcb-data.whoi.edu/mvco/';
filelist = regexprep(filelist, in_dir, '')';
files_done = dir([out_dir 'IFCB*fea_v1.csv']);
files_done = char(files_done.name);
files_done = cellstr(files_done(:,1:end-11));
filelist2 = setdiff(filelist, files_done); 
%filelist2 = filelist2(2:end); %FUDGE TO skip messed up file
disp(['processing ' num2str(length(filelist2)) ' files'])
batch_features( in_dir, filelist2, out_dir );
