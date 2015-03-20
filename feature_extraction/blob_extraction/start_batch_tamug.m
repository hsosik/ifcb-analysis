%start_batch_tamu.m
%configure and initiate batch processing for blob extractiom

in_dir_base = 'C:\IFCB\data\test\'; %USER web services to access data
out_dir_blob_base = 'C:\IFCB\blobs_test\D2015\';

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
    bins_done = regexprep({bins_done.name}', '.zip', '');
    [bins_temp,ia] = setdiff(bins_temp, bins_done);
    if ~isempty(bins_temp)
        %daystr = char(bins_temp); daystr = daystr(:,1:9);
        in_dir = [in_dir; repmat(cellstr(in_dir_temp),length(bins_temp),1)];
        out_dir_blob_temp = cellstr([repmat(out_dir_blob_temp,length(bins_temp),1) repmat(filesep, length(bins_temp),1)]);
        out_dir_blob = [out_dir_blob; out_dir_blob_temp];
        bins = [bins; bins_temp];
    end;
end;

disp(['processing ' num2str(length(bins)) ' files'])

batch_blobs(in_dir, out_dir_blob, bins);
