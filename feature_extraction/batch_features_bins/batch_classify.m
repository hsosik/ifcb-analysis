feature_path = '\\queenrose\g_work_ifcb1\ifcb_data_mvco_jun06\features2012_v0\';
%feature_path = '\\queenrose\ifcb_data_mvco_jun06\train_04Nov2011_fromWebServices\';

class_path = '\\queenrose\g_work_ifcb1\ifcb_data_mvco_jun06\class2012_tbv0\';
filelist = dir([feature_path 'IFCB*.mat']);
load trees_compact_24Mar2012
load class2use_MVCOmanual3
nclass = length(class2use);
class2use_auto = class2use;
class2use_manual = class2use;
class2use_sub4 = { 'not_ciliate'    'ciliate_mix'    'tintinnid'    'Myrionecta'    'Laboea'};
list_titles = {'roi number'    'manual'    'Trees-auto' 'ciliate'}; 
ciliate_classnum = strmatch('ciliate', class2use, 'exact');

for filecount = 1:length(filelist),
    filename = filelist(filecount).name;
    disp(['load ' filename])
    if ~exist([class_path filename], 'file'), 
        load([feature_path filename])
        t = char(out.pid);
        roi_num = str2num(t(:,end-4:end));
        disp('format features')
        [ feature_mat, featitles ] = format_features( out );
        [ feature_mat, featitles ] = add_derived_features( feature_mat, featitles);
        if filecount == 1,
            [~,i] = setdiff(featitles, {'FilledArea' 'summedFilledArea' 'Area' 'ConvexArea' 'MajorAxisLength' 'MinorAxisLength' 'Perimeter'}');
            featitles = featitles(i);
        end;
        feature_mat = feature_mat(i,:)';
        disp('classifying...')
        Y = predict(tb_24Mar2012,feature_mat);
        numrois = roi_num(end);
        classlist = NaN(numrois,4);
        classlist(:,1) = 1:numrois;
        for ii = 1:nclass,
            %need to use roi_num convention to match expected input for
            %previous manual_classify etc.
            classlist(roi_num(strmatch(class2use(ii), Y, 'exact')),3) = ii; 
        end;
        for ii = 1:length(class2use_sub4),
            %need to use roi_num convention to match expected input for
            %previous manual_classify etc.
            ind = strmatch(class2use_sub4(ii), Y, 'exact');
            classlist(roi_num(ind),4) = ii; 
            classlist(roi_num(ind),3) = ciliate_classnum;  
        end;
        disp('save results')
        save([class_path filename], 'classlist', 'class2use_auto', 'class2use_manual', 'list_titles') 
    else
        disp('already done')
    end;
end;
