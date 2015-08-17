function [ ] = start_blob_batch_user_training(in_dir_base , out_dir_blob_base, parallel_proc_flag)
%function [ ] = start_blob_batch_user_training(in_dir_base , out_dir_blob_base, parallel_proc_flag)
%For example:  
%start_blob_batch_user_training('C:\work\IFCB\user_training_test_data\data\2014\', 'C:\work\IFCB\user_training_test_data\blobs\2014\', false)
%IFCB image processing: configure and initiate batch processing for blob extraction
%Heidi M. Sosik, Woods Hole Oceanographic Institution, Aug 2015
%
%example input variables
%   in_dir_base = 'C:\work\IFCB\user_training_test_data\data\2014\'; %USER local data location (where are your *.roi files)
%   out_dir_blob_base = 'C:\work\IFCB\user_training_test_data\blobs\2014\'; %USER local data location for blob reults
%   parallel_proc_flag = false; %USER true to enable parallel processing

if ~exist('parallel_proc_flag', 'var')
    parallel_proc_flag = false; %default
end

if ~exist(out_dir_blob_base, 'dir'),
    mkdir(out_dir_blob_base)
end;
daydir = dir([in_dir_base 'D*']);
daydir = daydir([daydir.isdir]); 
bins = [];
in_dir = [];
out_dir_blob = [];
for ii = 1:length(daydir),
    in_dir_temp = [in_dir_base daydir(ii).name filesep];
    bins_temp = dir([in_dir_temp '*.adc']);
    bins_temp = regexprep({bins_temp.name}', '.adc', '');
    daystr = char(bins_temp(1)); daystr = daystr(1:9);
    out_dir_blob_temp = [out_dir_blob_base daystr filesep];
    bins_done = dir([out_dir_blob_temp '*.zip']);
    bins_done = regexprep({bins_done.name}', '_blobs_v2.zip', '');
    [bins_temp,ia] = setdiff(bins_temp, bins_done);
    if ~isempty(bins_temp)
        daystr = char(bins_temp); daystr = daystr(:,1:9);
        in_dir = [in_dir; repmat(cellstr(in_dir_temp),length(bins_temp),1)];
        out_dir_blob_temp = cellstr([repmat(out_dir_blob_temp,length(bins_temp),1)]);
        out_dir_blob = [out_dir_blob; out_dir_blob_temp];
        bins = [bins; bins_temp];
    end;
end;

nfiles = length(bins); 
disp(['processing ' num2str(nfiles) ' files'])
if nfiles > 0
    batch_blobs(in_dir, out_dir_blob, bins, parallel_proc_flag);
end

end