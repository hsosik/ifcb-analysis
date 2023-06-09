function [new_meta_data] = add_fixed_ml_analyzed_to_summary(old_meta_data, timeseries)
% incorporates Heidi's fixed ml_analyzed data into summary files using .mat
% files available in IFCB_products/summary
% old_meta_data is the typical meta data table
% timeseries is the project name e.g. 'MVCO', 'NESLTER_broadscale', etc
if strcmp(timeseries, 'MVCO')
    path_start = ['\\sosiknas1\IFCB_products\', timeseries, '\summary_v4\'];
else
    path_start = ['\\sosiknas1\IFCB_products\', timeseries, '\summary\'];
end

% collect all ml_new data:
ff = dir([path_start, 'ml_new*']);
all_filelist = {}; all_ml = [];
for i = 1:length(ff)
    fn = ff(i).name;
    load([path_start, fn]);

    all_filelist = cat(1, all_filelist, filelist);
    all_ml =  cat(1, all_ml, ml_analyzed);
   
end

newtab = table();
if iscell(old_meta_data.pid)
    newtab.pid = all_filelist;
else
    newtab.pid = string(all_filelist);
end
newtab.new_ml = all_ml;

% data that doesn't need changing
tmp_meta = old_meta_data(~ismember(old_meta_data.pid, newtab.pid), :);

% join data that does need changing:
new_meta_data = innerjoin(old_meta_data, newtab);
new_meta_data.ml_analyzed = new_meta_data.new_ml;
new_meta_data.new_ml = [];


% add old data:
new_meta_data = cat(1, new_meta_data, tmp_meta);

% extract duplicates:
[uniqueA, i, j] = unique(filelist,'first');
dupidx = find(not(ismember(1:numel(filelist),i)));
duptab = new_meta_data(ismember(new_meta_data.pid, filelist(dupidx)), :);
% if duplicates exist, check ml_analyed. if =, remove 1. if not, error:
upid = unique(duptab.pid);
rmidx = [];
for i = 1:length(upid)
    tmptab = duptab(ismember(duptab.pid, upid(i)),:);
    if length(unique(tmptab.ml_analyzed)) == 1
        rmidx = [rmidx; find(ismember(new_meta_data.pid, upid{i}),1)];
    else
        error('duplicate ml analyzed in new files. check and fix.');
    end
end
new_meta_data(rmidx, :) = [];

end