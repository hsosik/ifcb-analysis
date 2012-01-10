resultpath = '\\raspberry\d_work\IFCB1\ifcb_data_mvco_jun06\Manual_fromClass\';
load([resultpath 'manual_list']) %load the manual list detailing annotate mode for each sample file
filelist = manual_list(2:end,1);
filelist = regexprep(filelist,'.mat','');
out_dir = 'C:\work\IFCB\ifcb_data_MVCO_jun06\biovolume2\';
in_dir = 'http://ifcb-data.whoi.edu/mvco/';
batch_volume( in_dir, filelist, out_dir );