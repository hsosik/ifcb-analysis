out_dir = '\\queenrose\g_work_ifcb1\tamu\features2010_v1\';
in_dir = 'http://toast.tamu.edu/ifcb3/'; %USER web services to access data
filelist = [];
for day = 1:2,
    filelist = [filelist list_day(datestr(datenum(2010,0,day),29), in_dir)];
end;
disp(filelist(end))
filelist = regexprep(filelist, in_dir, '')';
files_done = dir([out_dir 'IFCB*fea_v1.csv']);
files_done = char(files_done.name);
files_done = cellstr(files_done(:,1:end-11));
filelist2 = setdiff(filelist, files_done); 
disp(['processing ' num2str(length(filelist2)) ' files'])
batch_features( in_dir, filelist2, out_dir );
