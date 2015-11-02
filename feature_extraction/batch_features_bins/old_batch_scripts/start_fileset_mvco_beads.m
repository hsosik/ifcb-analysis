addpath('/home/hsosik/ifcbcode/webservice_tools/');
addpath('/home/hsosik/ifcbcode/feature_extraction/');
addpath('/home/hsosik/ifcbcode/dipum_toolbox_2.0.1/');
addpath('/home/hsosik/ifcbcode/feature_extraction/biovolume/');
out_dir = '/mnt/queenrose/ifcb_data_mvco_jun06/features_beads_v2/';
in_dir = 'http://demi.whoi.edu/mvco_beads/'; %USER web services to access data
filelist = [];
yr = 2006;
for day = 1:366,
    filelist = [filelist list_day(datestr(datenum(yr,0,day),29), in_dir)];
end;
disp(filelist(end))
filelist = regexprep(filelist, in_dir, '')';
files_done = dir([out_dir 'IFCB*fea_v2.csv']);
files_done = char(files_done.name);
files_done = cellstr(files_done(:,1:end-11));
filelist2 = setdiff(filelist, files_done); 
disp(['processing ' num2str(length(filelist2)) ' files'])
batch_features( in_dir, filelist2, out_dir );
