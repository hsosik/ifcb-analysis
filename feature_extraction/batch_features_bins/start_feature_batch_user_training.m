%IFCB image processing; Heidi M. Sosik, Woods Hole Oceanographic Institution, Aug 2015
%configure and initiate batch processing for feature extractiom

out_dir = 'C:\work\IFCB\user_training_test_data\features\2014\'; %USER where to output features
in_dir_base = 'C:\work\IFCB\user_training_test_data\data\2014\'; %USER where to access roi data
in_dir_blob_base = 'C:\work\IFCB\user_training_test_data\blobs\2014\'; %USER where to access blobs
parallel_proc_flag = true; 

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
