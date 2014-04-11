classifierName = 'C:\work\IFCB\ifcb_data_MVCO_jun06\Manual_fromClass\summary\Tara_Trees_10Apr2014';
yr = 2013;
%out_dir = ['\\queenrose\g_work_ifcb1\ifcb_data_mvco_jun06\class' num2str(yr) '_v1\'];
out_dir = ['C:\work\IFCB\temp\class\'];
%in_dir = 'http://demi.whoi.edu/mvco/';
%in_dir = 'http://ifcb-data.whoi.edu/mvco/';
%for V2 web services, set fea_dir = in_dir;
%fea_dir = 'E:\IFCB010_OkeanosExplorerAug2013\data\features\features2013_v2';
%in_dir = 'http://ifcb-data.whoi.edu/mvco/';
in_dir = 'http://ifcb-data.whoi.edu/TaraOceansPolarCircle_IFCB013/';
fea_dir = in_dir;
filelist = [];
for day = 238, %225:250,

%for day = 157:157,

    filelist = [filelist list_day(datestr(datenum(yr,0,day),29), in_dir)];
end;
if ~exist(out_dir),
    mkdir(out_dir)
end;
filelist = filelist(46:end);
filelist = regexprep(filelist, in_dir, '')';
files_done = dir([out_dir 'D*class_v1.mat']);
files_done = char(files_done.name);
files_done = cellstr(files_done(:,1:end-13));
filelist2 = setdiff(filelist, files_done);
disp(['processing ' num2str(length(filelist2)) ' files'])
if isequal(in_dir, fea_dir),
    filelist2 = strcat(filelist2,'_features.csv');
else
    filelist2 = strcat(filelist2,'_fea_v2.csv');  %USER specify v1 or v2 features as appropriate
end;
batch_classify( fea_dir, filelist2, out_dir, classifierName );
