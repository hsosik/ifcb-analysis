%batch_blobs('http://ifcb-data.whoi.edu/underway/', 'G:\work\Healy1001\blobs\');

in_dir = 'http://ifcb-data.whoi.edu/saltpond/'; %web services to access data
out_base_dir = 'G:\work\test\blobs\'; %main blob output location
local_base_dir = '\\mellon\saltpond\D2012\'; %local disk of files to process

day_dirs = dir([local_base_dir 'D*']);
day_dirs = day_dirs([day_dirs.isdir]);

for day_count = 1:1, %length(day_dirs),
    local_dir = [local_base_dir day_dirs(day_count).name filesep];
    out_dir = [out_base_dir day_dirs(day_count).name filesep];
    if ~exist(out_dir, 'dir'), 
        mkdir(out_dir)
    end;
    bins =  dir([local_dir 'D*.adc']);
    bins = bins(find([bins.bytes]>0));
    bins2 = dir([out_dir 'D*']);
    bins = regexprep({bins.name}, '.adc', ''); 
    bins2 = regexprep({bins2.name}, '_blobs_v2.zip', '');
    [~,ii] = setdiff(bins, bins2);
    bins = bins(ii);
    batch_blobs(in_dir, out_dir, bins);
end;
    