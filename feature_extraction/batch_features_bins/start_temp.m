resultpath = '\\raspberry\d_work\IFCB1\ifcb_data_mvco_jun06\Manual_fromClass\';
load([resultpath 'manual_list']) %load the manual list detailing annotate mode for each sample file
filelist = manual_list(2:end,1);
filelist = regexprep(filelist,'.mat','');
out_dir = '\\queenrose\ifcb_data_mvco_jun06\biovolume\';
in_dir = 'http://ifcb-data.whoi.edu/test/';
files_done = dir([out_dir 'IFCB*.mat']);
files_done = char(files_done.name);
files_done = cellstr(files_done(:,1:end-4));
filelist2 = setdiff(filelist, files_done); %1:4009 before 2010
batch_volume( in_dir, filelist2, out_dir );