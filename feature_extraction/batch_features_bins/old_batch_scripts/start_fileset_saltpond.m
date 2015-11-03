%load(['list2012A']) %load the list of bins to process

basepath = '\\mellon\saltpond\D2012\';
daylist = dir([basepath 'D*']);
daylist = {daylist.name}';
filelist = [];
for ii = 1:length(daylist),
    temp = dir([basepath daylist{ii} '\D*.adc']);
    temp = regexprep({temp.name}', '.adc', '');
    filelist = [filelist; temp];
end;

out_dir = '\\queenrose\Rob\SaltPond\features\';
in_dir = 'http://ifcb-data.whoi.edu/saltpond/';
files_done = dir([out_dir 'D*.mat']);
files_done = char(files_done.name);
files_done = cellstr(files_done(:,1:end-4));
filelist2 = setdiff(filelist, files_done); 
batch_features( in_dir, filelist2, out_dir );