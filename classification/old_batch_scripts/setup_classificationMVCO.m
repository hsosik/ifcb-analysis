%resultpath = '\\raspberry\d_work\IFCB1\ifcb_data_mvco_jun06\Manual_fromClass\';
%filelist = get_filelist_manual([resultpath 'manual_list'],2,[2006:2012], 'all'); %manual_list, column to use, year to find
%feafilestr = '_fea_v1';
%[ filelist, feafiles ] = resolve_MVCOfeafiles( filelist, feafilestr );

feapath = '\\queenrose\g_work_ifcb1\ifcb_data_mvco_jun06\features2013_v2\';
filelist = dir([feapath '*.csv']);
filelist = {filelist.name}';
filesdone = dir('\\queenrose\g_work_ifcb1\ifcb_data_mvco_jun06\class2013_v1\*.mat');
filesdone = {filesdone.name}';
f1 = regexprep(filelist, '_fea_v2.csv', '');
f2 = regexprep(filesdone, '_class_v1.mat', '');
[~,i1] = setdiff(f1,f2);
feafiles = filelist(i1); clear f1 f2 i1 filesdone

classifierName = 'MVCO_trees_25Jun2012';

%header = textread([feapath feafiles{1}], '%s',236, 'delimiter', ',');
temp = importdata([feapath feafiles{1}], ','); header = temp.colheaders; clear temp
[~,feaorder] = setdiff(header, {'FilledArea' 'summedFilledArea' 'Area' 'ConvexArea' 'MajorAxisLength' 'MinorAxisLength' 'Perimeter', 'roi_number', 'Biovolume', 'summedBiovolume'});
featitles_file = header(feaorder);
num2dostr = num2str(length(feafiles));
for filecount = 1:length(feafiles),
    disp(['classifying ' num2str(filecount) ' of ' num2dostr])
    apply_TBclassifierMVCO([feapath feafiles{filecount}], feaorder, classifierName);
end;
