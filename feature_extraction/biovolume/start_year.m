basedir2 = '\\demi\blobs\2012\';
daystr = '2012_';
daylist = dir([basedir2 daystr '*']); 
daylist = daylist([daylist.isdir]);
filelist = [];
num2do = 300;%30
for count = 1:length(daylist),
    disp(daylist(count).name)
    filestemp = [dir([basedir2 daylist(count).name '\IFCB*.zip'])];
    filelist = [filelist; filestemp(1:min([length(filestemp),num2do]))];
end;
filelist = {filelist.name}';
filelist = regexprep(filelist,'_blobs_v2.zip','');

%in_dir = ['\\demi\blobs\2012\' daystr '\'];
out_dir = '\\Queenrose\g_work_ifcb1\ifcb_data_mvco_jun06\biovolume\biovolume2012\'; %G-drive share
%out_dir = '/mnt/queenrose/ifcb_data_mvco_jun06/biovolume/biovolume2012/'; %G-drive share

%out_dir_all = {'\\Queenrose\g_work_ifcb1\ifcb_data_mvco_jun06\biovolume\biovolume2006\'...
%    '\\Queenrose\g_work_ifcb1\ifcb_data_mvco_jun06\biovolume\biovolume2007\'...
%    '\\Queenrose\g_work_ifcb1\ifcb_data_mvco_jun06\biovolume\biovolume2008\'...
%    '\\Queenrose\g_work_ifcb1\ifcb_data_mvco_jun06\biovolume\biovolume2009\'...
%    '\\Queenrose\g_work_ifcb1\ifcb_data_mvco_jun06\biovolume\biovolume2010\'...
%    '\\Queenrose\g_work_ifcb1\ifcb_data_mvco_jun06\biovolume\biovolume2011\'...
%    '\\Queenrose\g_work_ifcb1\ifcb_data_mvco_jun06\biovolume\biovolume2012\'};
in_dir = 'http://ifcb-data.whoi.edu/mvco/';

files_done = dir([out_dir 'IFCB*.mat']);
%for count = 1:length(out_dir_all),
%    temp = dir([out_dir_all{count} 'IFCB*.mat']);
%    files_done = [files_done; temp];
%end;
files_done = char(files_done.name);
files_done = cellstr(files_done(:,1:end-4));
filelist2 = setdiff(filelist, files_done); %1:4009 before 2010
disp(['processing ' num2str(length(filelist2)) ' files'])
batch_volume( in_dir, filelist2, out_dir );