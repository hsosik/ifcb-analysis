function [  ] = start_feav1_to_feav2

%feapath = '\\queenrose\g_work_ifcb1\ifcb_data_mvco_jun06\features2007_v1\';
%biovolpath = '\\queenrose\g_work_ifcb1\ifcb_data_mvco_jun06\biovolume\biovolume2007\';
feapath = 'G:\work\IFCB1\ifcb_data_mvco_jun06\features2012_v1\';
biovolpath = 'G:\work\IFCB1\ifcb_data_mvco_jun06\biovolume\biovolume2012\'; %IFCB1_2009_165_234136_fea_v2.csv, 10330

%feapath = 'C:\work\IFCB\ifcb_data_MVCO_jun06\features2006_v1\';
%biovolpath = 'C:\work\IFCB\ifcb_data_MVCO_jun06\biovolume\biovolume2006\';

feapathv2 = regexprep(feapath, 'v1', 'v2');
if ~exist(feapathv2, 'dir'),
    mkdir(feapathv2);
end;
feafiles = dir([feapath '*.csv']);
%bad:   IFCB1_2010_004_111622_fea_v1
%       IFCB1_2010_137_045006_fea_v1, 10808, fewer biovols than features
%IFCB1_2012_273_120501, more biovols than features
%IFCB1_2012_273_12212, more biovols than features
%IFCB1_2012_273_120501, 5005
%IFCB1_2012_284_051904, 5586
for ii = 6131:length(feafiles),
    disp(ii)
    file_in = feafiles(ii).name;
    file_out = regexprep(file_in, 'v1', 'v2');
    
    t = importdata([feapath file_in], ',');
    %feahdrs = t.colheaders;
    feahdrs = t.textdata;
    feadata = t.data;
    
    %add Biovolume column
    featitles = [feahdrs(1:2) 'Biovolume' feahdrs(3:end)];
    biovol = load([biovolpath file_in(1:21)]);
    feature_mat = [feadata(:,1:2) biovol.targets.Biovolume feadata(:,3:end)];
    if size(feature_mat,2) < length(featitles),
        feature_mat(:,size(feature_mat,2):length(featitles)) = NaN;
    end;
    
    disp(['SAVING ' file_out])
   
    %ds = dataset([feature_mat featitles]);
    %export(ds, 'file', [feapathv2 file_out], 'delimiter', ',');
    csvwrite_with_headers( [feapathv2 file_out], feature_mat, featitles );
end;