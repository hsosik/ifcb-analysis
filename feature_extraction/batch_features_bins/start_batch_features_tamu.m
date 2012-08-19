%start_batch_tamu.m
%configure and initiate batch processing for blob extractiom

%in_url = 'http://toast.tamu.edu/ifcb7_new_data/'; %USER web services to access data
in_url = 'http://ifcb-data.whoi.edu/saltpond/';
out_base_dir = 'G:\work\test\features\'; %USER main blob output location
year = 2012; %USER
%USER choose start and end day to encompass range to process; already
%completed or non-existent days will be skipped automatically
start_day = '2012-08-10';  %USER
end_day = '2012-08-20'; %USER

out_dir = [out_base_dir num2str(year) filesep];
if ~exist(out_dir, 'dir'),
    mkdir(out_dir)
end;

filelist = get_filelist(in_url, start_day, end_day);

files_done = dir([out_dir 'D*.mat']);
files_done = char(files_done.name);
files_done = cellstr(files_done(:,1:end-4));
filelist2 = setdiff(filelist, files_done); 
batch_features_rotate( in_url, filelist2, out_dir );