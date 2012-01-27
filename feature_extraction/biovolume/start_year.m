%basedir = '\\demi\ifcbold\G\IFCB\ifcb_data_MVCO_jun06\';  %%USER set, roi files, adc files
basedir = '\\demi\ifcbnew\';  %%USER set, roi files, adc files
daylist = dir([basedir 'IFCB5_2011_35*']); 
%daylist = dir([basedir 'IFCB*']); 
daylist = daylist([daylist.isdir]);
t = char(daylist.name); ind = find(t(:,10) ~= '2'); %skip 2012
daylist = daylist(ind); clear t ind
t = char(daylist.name); ind = strmatch('2010_222', t(:,7:14)); %skip a day %2010_082?, 2010_222
daylist(ind) = []; clear t ind
t = char(daylist.name); ind = strmatch('2010_082', t(:,7:14)); %skip a day %2010_082?, 2010_222
daylist(ind) = []; clear t ind
t = char(daylist.name); ind = strmatch('2010_091', t(:,7:14)); %skip a day %2010_082?, 2010_222
daylist(ind) = []; clear t ind
t = char(daylist.name); ind = strmatch('2010_167', t(:,7:14)); %skip a day %2010_082?, 2010_222
daylist(ind) = []; clear t ind
t = char(daylist.name); ind = strmatch('2010_168', t(:,7:14)); %skip a day %2010_082?, 2010_222
daylist(ind) = []; clear t ind
t = char(daylist.name); ind = strmatch('2010_169', t(:,7:14)); %skip a day %2010_082?, 2010_222
daylist(ind) = []; clear t ind
t = char(daylist.name); ind = strmatch('2010_093', t(:,7:14)); %skip a day %2010_082?, 2010_222
daylist(ind) = []; clear t ind
t = char(daylist.name); ind = strmatch('2010_283', t(:,7:14)); %skip a day %2010_082?, 2010_222
daylist(ind) = []; clear t ind
t = char(daylist.name); ind = strmatch('2010_153', t(:,7:14)); %skip a day %2010_082?, 2010_222
daylist(ind) = []; clear t ind
t = char(daylist.name); ind = strmatch('2010_152', t(:,7:14)); %skip a day %2010_082?, 2010_222
daylist(ind) = []; clear t ind
t = char(daylist.name); ind = strmatch('2010_322', t(:,7:14)); %skip a day %2010_082?, 2010_222
daylist(ind) = []; clear t ind
t = char(daylist.name); ind = strmatch('2011_298', t(:,7:14)); %skip a day %2010_082?, 2010_222
daylist(ind) = []; clear t ind
t = char(daylist.name); ind = strmatch('2011_215', t(:,7:14)); %skip a day %2010_082?, 2010_222
daylist(ind) = []; clear t ind
t = char(daylist.name); ind = strmatch('2010_094', t(:,7:14)); %skip a day %2010_082?, 2010_222
daylist(ind) = []; clear t ind
t = char(daylist.name); ind = strmatch('2010_318', t(:,7:14)); %skip a day %2010_082?, 2010_222
daylist(ind) = []; clear t ind
t = char(daylist.name); ind = strmatch('2011_315', t(:,7:14)); %skip a day %2010_082?, 2010_222
daylist(ind) = []; clear t ind

filelist = [];
num2do = 18;%30
for count = 1:length(daylist),
    disp(daylist(count).name)
    filestemp = dir([basedir daylist(count).name '\IFCB*.roi']);
    filestemp = filestemp([filestemp.bytes] > 2);
    filelist = [filelist; filestemp(1:min([length(filestemp),num2do]))];
end;
filelist = {filelist.name}';
filelist = regexprep(filelist,'.roi','');

out_dir = '\\Queenrose\ifcb12\ifcb_data_mvco_jun06\biovolume\'; %G-drive share
out_dir_all = {'\\Queenrose\ifcb12\ifcb_data_mvco_jun06\biovolume\biovolume2006\'...
    '\\Queenrose\ifcb12\ifcb_data_mvco_jun06\biovolume\biovolume2007\'...
    '\\Queenrose\ifcb12\ifcb_data_mvco_jun06\biovolume\biovolume2008\'...
    '\\Queenrose\ifcb12\ifcb_data_mvco_jun06\biovolume\biovolume2009\'...
    '\\Queenrose\ifcb12\ifcb_data_mvco_jun06\biovolume\biovolume2010\'...
    '\\Queenrose\ifcb12\ifcb_data_mvco_jun06\biovolume\biovolume2011\'};
in_dir = 'http://ifcb-data.whoi.edu/test/';
%files_done = dir([out_dir 'IFCB*.mat']);
files_done = dir([out_dir 'IFCB*.mat']);
for count = 1:length(out_dir_all),
    temp = dir([out_dir_all{count} 'IFCB*.mat']);
    files_done = [files_done; temp];
end;
files_done = char(files_done.name);
files_done = cellstr(files_done(:,1:end-4));
filelist2 = setdiff(filelist, files_done); %1:4009 before 2010
disp(['processing ' num2str(length(filelist2)) ' files'])
batch_volume( in_dir, filelist2, out_dir );