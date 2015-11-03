%start_batch_features_tamu.m
%configure and initiate batch processing for feature extractiom
%NOTE: This is currently set for rotated camera. 
%addpath('/home/hsosik/ifcbcode/webservice_tools/'); 
%addpath('/home/hsosik/ifcbcode/feature_extraction/');
%addpath('/home/hsosik/ifcbcode/dipum_toolbox_2.0.1/');

in_url = 'http://ifcb-data.whoi.edu/Healy1101/'; %USER web services to access data
%out_base_dir = '//mnt/queenrose/ifcb_data_mvco_jun06/saltpond_features2012/'; %USER main blob output location
out_base_dir = '\\floatcoat\IFCBdata\IFCB8_HLY1101\features\'; %USER main blob output location
year = 2011; %USER
%USER choose start and end day to encompass range to process; already
%completed or non-existent days will be skipped automatically
start_day = '2011-06-01';  %USER
end_day = '2011-08-01'; %USER

out_dir = [out_base_dir num2str(year) filesep];
if ~exist(out_dir, 'dir'),
    mkdir(out_dir)
    mkdir([out_dir 'multiblob' filesep])
end;

filelist = get_filelist(in_url, start_day, end_day);

files_done = dir([out_dir 'I*.csv']);
files_done = char(files_done.name);
files_done = cellstr(files_done);
files_done = regexprep(files_done, '_fea_v1.csv', '');
filelist2 = setdiff(filelist, files_done); 
disp(['processing ' num2str(length(filelist2)) ' files'])
batch_features( in_url, filelist2, out_dir );