function [  ] = start_feav1_to_feav2

feapath = '\\queenrose\g_work_ifcb1\ifcb_data_mvco_jun06\features2006_v1\';
biovolpath = '\\queenrose\g_work_ifcb1\ifcb_data_mvco_jun06\biovolume\biovolume2006\';

%feapath = 'C:\work\IFCB\ifcb_data_MVCO_jun06\features2006_v1\';
%biovolpath = 'C:\work\IFCB\ifcb_data_MVCO_jun06\biovolume\biovolume2006\';

feapathv2 = regexprep(feapath, 'v1', 'v2');
if ~exist(feapathv2, 'dir'),
    mkdir(feapathv2);
end;
feafiles = dir([feapath '*.csv']);

for ii = 1:length(feafiles),
    
    file_in = feafiles(ii).name;
    file_out = regexprep(file_in, 'v1', 'v2');
    
    t = importdata([feapath file_in], ','); 
    feahdrs = t.colheaders;
    feadata = t.data;
    
    %add Biovolume column
    featitles = [feahdrs(1:2) 'Biovolume' feahdrs(3:end)];
    biovol = load([biovolpath file_in(1:21)]);
    feature_mat = [feadata(:,1:2) biovol.targets.Biovolume feadata(:,3:end)];
    
    disp(['SAVING ' file_out])
   
    ds = dataset([feature_mat featitles]);
    export(ds, 'file', [feapathv2 file_out], 'delimiter', ',');
    
end;
