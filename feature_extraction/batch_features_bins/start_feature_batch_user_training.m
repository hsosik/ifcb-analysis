function [ ] = start_feature_batch_user_training(in_dir_base , in_dir_blob_base, out_dir, parallel_proc_flag)
%function [ ] = start_feature_batch_user_training(in_dir_base , in_dir_blob_base, out_dir, parallel_proc_flag)
%For example:
%start_feature_batch_user_training('C:\work\IFCB\user_training_test_data\data\2014\' , 'C:\work\IFCB\user_training_test_data\blobs\2014\', 'C:\work\IFCB\user_training_test_data\features\2014\', false)
%
%IFCB image processing: configure and initiate batch processing for feature extraction
%Heidi M. Sosik, Woods Hole Oceanographic Institution, August 2015
%
%example input variables:
%   out_dir = 'C:\work\IFCB\user_training_test_data\features\2014\'; %USER where to output features
%   in_dir_base = 'C:\work\IFCB\user_training_test_data\data\2014\'; %USER where to access roi data
%   in_dir_blob_base = 'C:\work\IFCB\user_training_test_data\blobs\2014\'; %USER where to access blobs
%   parallel_proc_flag = false; %USER true for parallel processing

if ~exist('parallel_proc_flag', 'var')
    parallel_proc_flag = false; %default
end

if ~exist(out_dir, 'dir'),
    mkdir(out_dir)
end;

daydir = dir([in_dir_base 'D*']);
daydir = daydir([daydir.isdir]); 
bins = [];
in_dir = [];
in_dir_blob = [];
for ii = 1:length(daydir),
    in_dir_temp = [in_dir_base daydir(ii).name filesep];
    bins_temp = dir([in_dir_temp '*.adc']);
    bins_temp = regexprep({bins_temp.name}', '.adc', '');
    daystr = char(bins_temp); daystr = daystr(:,1:9);
    in_dir_blob_temp = cellstr([repmat(in_dir_blob_base,length(bins_temp),1) daystr repmat(filesep, length(bins_temp),1)]);
    in_dir = [in_dir; repmat(cellstr(in_dir_temp),length(bins_temp),1)];
    in_dir_blob = [in_dir_blob; in_dir_blob_temp];
    bins = [bins; bins_temp];
end;
bins_done = dir([out_dir '*.csv']);
bins_done = regexprep({bins_done.name}', '_fea_v2.csv', '');
[bins,ia] = setdiff(bins, bins_done);
in_dir = in_dir(ia);
in_dir_blob = in_dir_blob(ia);

nfiles = length(bins); 
disp(['processing ' num2str(nfiles) ' files'])
if nfiles > 0
    batch_features( in_dir, bins, out_dir, in_dir_blob , parallel_proc_flag);
end

end