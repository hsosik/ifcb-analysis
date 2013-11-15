savedir = '\\queenrose\E_work\Brosnahan_Temp\';
classifierName = [savedir 'lab_trees_15Nov2013'];
yr = 2013;
out_dir = ['\\queenrose\E_work\Brosnahan_Temp\class' num2str(yr) '_v1\'];
in_dir = 'http://mellon.whoi.edu/lab/';
%for V2 web services, set fea_dir = in_dir;
fea_dir = '\\queenrose\E_work\Brosnahan_Temp\features\';
filelist = [];
for day = 282:319,
    filelist = [filelist list_day(datestr(datenum(yr,0,day),29), in_dir)];
end;
filelist = regexprep(filelist, in_dir, '')';
files_done = dir([out_dir 'D*class_v1.mat']);
files_done = char(files_done.name);
files_done = cellstr(files_done(:,1:end-13));
filelist2 = setdiff(filelist, files_done);
if isequal(in_dir, fea_dir),
    filelist2 = strcat(filelist2,'_features.csv');
else
    filelist2 = strcat(filelist2,'_fea_v2.csv');  %USER specify v1 or v2 features as appropriate
end;
disp(['processing ' num2str(length(filelist2)) ' files'])
batch_classify( fea_dir, filelist2, out_dir, classifierName );
