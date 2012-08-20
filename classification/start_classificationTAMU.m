%resultpath = '\\raspberry\d_work\IFCB1\ifcb_data_mvco_jun06\Manual_fromClass\';
%filelist = get_filelist_manual([resultpath 'manual_list'],2,[2006:2012], 'all'); %manual_list, column to use, year to find
%feafilestr = '_fea_v1';
%[ filelist, feafiles ] = resolve_MVCOfeafiles( filelist, feafilestr );

feapath = '\\queenrose\test\features\2012\'; %USER where are your feature files
classpath = 'c:\work\test\classTB\2012\'; %USER where to write your class files

if ~exist(classpath, 'dir'),
    mkdir(classpath)
end;

filelist = dir([feapath '*.csv']);
filelist = {filelist.name}';
filesdone = dir([classpath '*.mat']);
filesdone = {filesdone.name}';
f1 = regexprep(filelist, '_fea_v1.csv', '');
f2 = regexprep(filesdone, '_class_v1.mat', '');
[~,i1] = setdiff(f1,f2);
feafiles = filelist(i1); clear f1 f2 i1 filesdone filelist

classifierName = 'TAMU_trees_20Aug2012';

if ~isempty(feafiles),
    header = textread([feapath feafiles{1}], '%s',235, 'delimiter', ',');
    [~,feaorder] = setdiff(header, {'FilledArea' 'summedFilledArea' 'Area' 'ConvexArea' 'MajorAxisLength' 'MinorAxisLength' 'Perimeter', 'roi_number'});
    featitles_file = header(feaorder);
    num2dostr = num2str(length(feafiles));
    for filecount = 1:length(feafiles),
        [~,classfile] = fileparts(feafiles{filecount});
        disp(['classifying ' classfile ': '  num2str(filecount) ' of ' num2dostr])
        classfile = regexprep(classfile, 'fea', 'class');
        apply_TBclassifier([feapath feafiles{filecount}], feaorder, classifierName, [classpath classfile]);
    end;
else
    disp('no files to process')
end;
