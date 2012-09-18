%load output %load result file produced by batch_features_train.m
outdir = 'G:\Rob\SaltPond\training_set\'; %location of training set feature files
temp = dir([outdir '*.mat']);
classes = {temp.name};
for i = 1:length(classes),
    classes(i) = {classes{i}(1:end-4)};
end;

%classes = fieldnames(output);
%skip some classes that are empty or not properly annotated
classes = setdiff(classes, {'Odontella' 'Cochlodinium'});
maxn = 300;
class_vector = [];
targets = [];
for classcount = 1:length(classes),
    class = char(classes(classcount));
    disp(classes(classcount))
    load([outdir char(classes(classcount))])
    if ~isempty(out.targets),
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
            ind = randi(n_class(classcount),maxn,1); %THIS IS WRONG!!!
            feamat{classcount} = feamat{classcount}(:,ind);
            t_temp = t_temp(ind);
        end;
        class_vector = [class_vector repmat(classcount,1,min(maxn,n_class(classcount)))];
        targets = [targets; t_temp'];
    end;
end;

train = cell2mat(feamat)';

%featitles = fieldnames(output_largest.(class).features);
%nring = size(Rings,1); nwedge = size(Wedges,1); nhog = size(HOG,1);
%featitles = [featitles; cellstr([repmat('Wedge:',nwedge,1) num2str((1:nwedge)')]); cellstr([repmat('Ring:',nring,1) num2str((1:nring)')]); cellstr([repmat('HOG:',nhog,1) num2str((1:nhog)')])];
%train(isnan(train)) = 0;

%clear temp s_largest classcount i largest_ind field s_temp n temp list fields class ind nhog nring nwedge 
%clear outdir ans HOG Rings Wedges maxn out n_class t_temp
%clear output output_largest n_rot fieldstemp

clear t_temp classcount i n maxn temp output outdir out class ind feature_mat

save('compiled_train_saltpond', 'train', 'class_vector', 'classes', 'targets')

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
