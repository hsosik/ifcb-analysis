classifierName = '/Volumes/TOSHIBA EXT/whoi_data/output_manual_classify/summary/Sherbrooke_trees_test';
yr = 2012;
out_dir = '/Volumes/TOSHIBA EXT/whoi_data/class/2012/'; %class out floder
in_dir = 'http://profileur.flsh.usherbrooke.ca/myifcb/';
%for V2 web services, set fea_dir = in_dir;
fea_dir = '/Volumes/TOSHIBA EXT/whoi_data/features/2012/';
% filelist = [];
% for day = 316:316,
%     filelist = [filelist list_day(datestr(datenum(yr,0,day),29), in_dir)];
% end;
filelist = dir([fea_dir '*.csv']);
filelist = {filelist.name}';
filelist=filelist(1:5:end); 
filelist = regexprep(filelist, in_dir, '')';
files_done = dir([out_dir 'IFCB*class_v1.mat']);
files_done = char(files_done.name);
files_done = cellstr(files_done(:,1:end-13));
filelist2 = setdiff(filelist, files_done);
if isequal(in_dir, fea_dir),
    filelist2 = strcat(filelist2,'_features.csv');
else
    filelist2 = strcat(filelist2);  %USER specify v1 or v2 features as appropriate
end;
disp(['processing ' num2str(length(filelist2)) ' files'])
batch_classify( fea_dir, filelist2, out_dir, classifierName );
