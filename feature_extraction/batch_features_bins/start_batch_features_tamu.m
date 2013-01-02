%start_batch_features_tamu.m
%configure and initiate batch processing for feature extractiom
%NOTE: This is currently set for rotated camera. 

in_url = 'http://toast.tamu.edu/ifcb3/'; %USER web services to access data
out_base_dir = 'g:\work\test\features\'; %USER main blob output location
year = 2012; %USER
%USER choose start and end day to encompass range to process; already
%completed or non-existent days will be skipped automatically
start_day = '2012-08-08';  %USER
end_day = '2012-08-30'; %USER

out_dir = [out_base_dir num2str(year) filesep];
if ~exist(out_dir, 'dir'),
    mkdir(out_dir)
    mkdir([out_dir 'multiblob' filesep])
end;

filelist = get_filelist(in_url, start_day, end_day);

files_done = dir([out_dir 'D*.mat']);
files_done = char(files_done.name);
files_done = cellstr(files_done(:,1:end-4));
filelist2 = setdiff(filelist, files_done); 
batch_features_rotate( in_url, filelist2, out_dir );