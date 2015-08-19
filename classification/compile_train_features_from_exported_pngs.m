pngdir = '\\sosiknas1\IFCB_products\MVCO\train_04Nov2011_fromWebServices\'; %output from export train - where the training images are located
savedir = '\\sosiknas1\IFCB_products\MVCO\classifiers\';
feapath_base = '\\sosiknas1\IFCB_products\MVCO\features\featuresxxxx_v2\'
maxn = 500; %USER select
minn = 20; %minimum number for inclusion
outstring = 'MVCO_train_04Nov2011_fromWebServices'; %e.g., 'MVCO_train_Aug2015'

%find the class names from the subdirs
temp = dir(pngdir);
temp = temp([temp.isdir]);
classes = setdiff({temp([temp.isdir]).name}, {'.' '..'}); 


%skip some classes that are empty or not properly annotated
%classes = setdiff(classes, {'Eucampia_groenlandica' 'Tropidoneis' 'dino10' 'roundCell' 'other' 'flagellate' 'crypto' 'ciliate'});
%class_vector = [];
%targets = [];
%feature_mat = [];

fea_all = [];% nan(5000*length(manual_files), 235);
class_all = [];% nan(5000*length(manual_files), 1);
files_all = [];
targets_all = [];
for classcount = 1:length(classes)
    class = char(classes(classcount));
    disp(class)
%    load([pngdir char(classes(classcount))])
%    [ feature_mat, featitles ] = format_features( out );
    roilist = dir([pngdir char(classes(classcount)) filesep '*.png']);
    target_list = regexprep({roilist.name}', '.png', '');
    filelist = char({roilist.name}'); filelist = cellstr(filelist(:,1:end-10));
    unqfilelist = unique(filelist);
    flist = [];
    fea_mat = [];
    for filecount = 1:length(unqfilelist)
        feaname = [unqfilelist{filecount} '_fea_v2.csv'];
        feapath = regexprep(feapath_base, 'xxxx', feaname(7:10));
        [ feadata, featitles ] = get_fea_file([feapath feaname]);
        ind = find(ismember(filelist, unqfilelist{filecount}));
        temp = char(target_list{ind});
        roinum = str2num(temp(:,end-4:end));
        [~,fea_ind] = intersect(feadata(:,1), roinum);
        fea_mat(ind,:) = feadata(fea_ind,:);
    end
    fea_all = [fea_all; fea_mat];
    class_all = [class_all; repmat(classcount,length(roilist),1)];
    n(classcount) = length(roilist);    
    targets_all = [targets_all; target_list];
end

clear *temp

for classcount = 1:length(class2use),
    ii = find(class_all == classcount);
    n(classcount) = size(ii,1);
    n2del = n(classcount)-maxn;
    if n2del > 0,
        shuffle_ind = randperm(n(classcount));
        shuffle_ind = shuffle_ind(1:n2del);
        class_all(ii(shuffle_ind)) = [];
        fea_all(ii(shuffle_ind),:) = [];
        files_all(ii(shuffle_ind)) = [];
        roinum(ii(shuffle_ind)) = [];
        ii = find(class_all == classcount);
        n(classcount) = maxn;
    end;
    if n(classcount) < minn,
        class_all(ii) = [];
        fea_all(ii,:) = [];
        files_all(ii) = [];
        roinum(ii) = [];
        n(classcount) = 0;
    end;
end;

for classcount = 1:length(class2skip),
    ind = strmatch(class2skip(classcount),class2use);
    ii = find(class_all == ind);
    class_all(ii) = [];
    fea_all(ii,:) = [];
    files_all(ii) = [];
    roinum(ii) = [];
end;

train = fea_all;
class_vector = class_all;
targets = cellstr([char(files_all) repmat('_', length(class_vector),1) num2str(roinum, '%05.0f')]);
nclass = n;
class2use = classes;

datestring = datestr(now, 'ddmmmyyyy');

save([savedir outstring datestring], 'train', 'class_vector', 'targets', 'class2use', 'nclass', 'featitles');


return
    [ feature_mat, featitles ] = add_derived_features( feature_mat, featitles);
            
    if classcount == length(classes) | classcount == 1 ,
        [~,i] = setdiff(featitles, {'FilledArea' 'summedFilledArea' 'Area' 'ConvexArea' 'MajorAxisLength' 'MinorAxisLength' 'Perimeter' 'FeretDiameter'}');
        featitles = featitles(i);
    end;
    feamat{classcount} = feature_mat(i,:);
    n = [out.features.numBlobs];
    n_class(classcount) = length(n);
    
    t_temp = out.targets;
    if maxn < n_class(classcount),
        ind = randperm(n_class(classcount));
        ind = ind(1:maxn);
        feamat{classcount} = feamat{classcount}(:,ind);
        t_temp = t_temp(ind);
    end;
    if n_class(classcount) < minn,
        class_all(ii) = [];
        fea_all(ii,:) = [];
        files_all(ii) = [];
        roinum(ii) = [];
        n_class(classcount) = 0;
    end;
    
    class_vector = [class_vector repmat(classcount,1,min(maxn,n_class(classcount)))];
    targets = [targets; t_temp'];
   

train = cell2mat(feamat)';

datestring = datestr(now, 'ddmmmyyyy');

save([savedir outstring datestring], 'train', 'class_vector', 'classes', 'targets', 'featitles', 'n_class')

clear t_temp classcount i n maxn temp output pngdir out class ind feature_mat outstring savedir datestring minn feamat 
