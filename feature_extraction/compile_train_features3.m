%load output %load result file produced by batch_features_train.m
%outdir = 'C:\work\IFCB\ifcb_data_MVCO_jun06\train_04Nov2011_fromWebServices\';
outdir = 'C:\work\IFCB3LisaCampbell\Training_images_PNG\';
maxn = 300;
temp = dir([outdir '*.mat']);
classes = {temp.name};
for i = 1:length(classes),
    classes(i) = {classes{i}(1:end-4)};
end;

%classes = fieldnames(output);
%skip some classes that are empty or not properly annotated
%classes = setdiff(classes, {'config' 'Eucampia_groenlandica' 'Tropidoneis' 'dino10' 'roundCell' 'other' 'flagellate' 'crypto'});
class_vector = [];
targets = [];
for classcount = 1:length(classes),
    class = char(classes(classcount));
    load([outdir char(classes(classcount))])
    
    [ feature_mat, featitles ] = format_features( out );
    [ feature_mat, featitles ] = add_derived_features( feature_mat, featitles);
    if classcount == length(classes) | classcount == 1 ,
        [~,i] = setdiff(featitles, {'FilledArea' 'summedFilledArea' 'Area' 'ConvexArea' 'MajorAxisLength' 'MinorAxisLength' 'Perimeter'}');
       % i = sort(i);
        featitles = featitles(i);
    end;
    feamat{classcount} = feature_mat(i,:);
    n = [out.features.numBlobs];
    n_class(classcount) = length(n);
    
    t_temp = out.targets;
    if maxn < n_class(classcount),
        ind = randi(n_class(classcount),maxn,1);
        feamat{classcount} = feamat{classcount}(:,ind);
        t_temp = t_temp(ind);
    end;
    class_vector = [class_vector repmat(classcount,1,min(maxn,n_class(classcount)))];
    targets = [targets; t_temp'];
end;

train = cell2mat(feamat)';

save compiled_train_tamu train class_vector classes targets featitles

clear t_temp classcount i n maxn temp output outdir out class ind feature_mat

return

colorset = colormap;

figure, hold on
for i = 1:length(feamat),
    plot(feamat{i}(36,:),feamat{i}(19,:), '.', 'color', colorset(i,:))
end;
set(gca, 'xscale', 'log', 'yscale', 'log')
figure, hold on
for i = 1:length(feamat),
    plot3(feamat{i}(5,:),feamat{i}(36,:),feamat{i}(37,:), '.', 'color', colorset(i,:))
end;
set(gca, 'xscale', 'log', 'yscale', 'log', 'zscale', 'log')
