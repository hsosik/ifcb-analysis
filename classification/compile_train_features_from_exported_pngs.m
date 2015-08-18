pngdir = '\\sosiknas1\IFCB_products\MVCO\train_04Nov2011_fromWebServices\'; %output from export train - where the training images are located
savedir = '\\sosiknas1\IFCB_products\MVCO\classifiers\';
maxn = 500; %USER select
minn = 20; %minimum number for inclusion
outstring = 'MVCO_train_04Nov2011_fromWebServices'; %e.g., 'MVCO_train_Aug2015'

temp = dir([pngdir '*.mat']);
classes = {temp.name};
for i = 1:length(classes),
    classes(i) = {classes{i}(1:end-4)};
end;

%skip some classes that are empty or not properly annotated
%classes = setdiff(classes, {'Eucampia_groenlandica' 'Tropidoneis' 'dino10' 'roundCell' 'other' 'flagellate' 'crypto' 'ciliate'});
class_vector = [];
targets = [];
for classcount = 1:length(classes),
    class = char(classes(classcount));
    disp(class)
    load([pngdir char(classes(classcount))])
    [ feature_mat, featitles ] = format_features( out );
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
end;

train = cell2mat(feamat)';

datestring = datestr(now, 'ddmmmyyyy');

save([savedir outstring datestring], 'train', 'class_vector', 'classes', 'targets', 'featitles', 'n_class')

clear t_temp classcount i n maxn temp output pngdir out class ind feature_mat outstring savedir datestring minn feamat 
