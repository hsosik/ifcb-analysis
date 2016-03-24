function [ ] = start_feature_batch_teset(in_dir, manual_dir , in_dir_blob_base, out_dir, parallel_proc_flag)
%function [ ] = start_feature_batch_user_training(in_dir_base , in_dir_blob_base, out_dir, parallel_proc_flag)
%For example:
%start_feature_batch_test('http://ifcb-data.whoi.edu/mvco/', 'C:\work\IFCB\ifcb_data_MVCO_jun06\Manual_fromClass\' , [], 'C:\work\IFCB\ifcb_data_MVCO_jun06\features_test\', false)
%
%IFCB image processing: configure and initiate batch processing for feature extraction
%Heidi M. Sosik, Woods Hole Oceanographic Institution, August 2015
%
%example input variables:
%   manual_dir = 'C:\work\IFCB\ifcb_data_MVCO_jun06\Manual_fromClass\'; %USER where 
%   in_dir_blob_base = 'http://ifcb-data.whoi.edu/mvco'; %USER where to access blobs
%   out_dir = 'C:\work\IFCB\ifcb_data_MVCO_jun06\features_test\';
%   parallel_proc_flag = false; %USER true for parallel processing

if ~exist('parallel_proc_flag', 'var')
    parallel_proc_flag = false; %default
end

if ~exist(out_dir, 'dir'),
    mkdir(out_dir)
end;

bins = dir([manual_dir 'I*.mat']);
bins = regexprep({bins.name}', '.mat', '');
bins_done = dir([out_dir '*.csv']);
bins_done = regexprep({bins_done.name}', '_fea_v2.csv', '');
[bins,ia] = setdiff(bins, bins_done);
nfiles = length(bins); 
disp(['processing ' num2str(nfiles) ' files'])
if nfiles > 0
    batch_features_test( in_dir, bins, out_dir, in_dir_blob_base , parallel_proc_flag);
end

end