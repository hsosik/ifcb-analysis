%p = '\\sosiknas1\IFCB_products\MVCO\Manual_fromClass\train_fromcsv_Sep2017\IFCB CNN project\11-30-17\planton_10 dataset lists\';
p = '\\sosiknas1\IFCB_products\MVCO\Manual_fromClass\train_fromcsv_Sep2017_new\splits\';
pfea = '\\sosiknas1\IFCB_products\MVCO\Manual_fromClass\train_fromcsv_Sep2017_new\features_v3\';
%pfea = '\\sosiknas1\IFCB_products\MVCO\Manual_fromClass\train_fromcsv_Sep2017_new\features_v2\';


class2use = dir([p]);
class2use(~[class2use.isdir]) = [];
class2use = {class2use.name}; % get the class names
class2use(strmatch('.', class2use)) = []; %get rid of . and ..

train = [];
validation = train;
test = train;
train_class_vector = train;
validation_class_vector = train;
test_class_vector = train;
train_targets = train;
validation_targets = train;
test_targets = train;
missing = [];
for count = 1:length(class2use)
    disp(class2use(count))
    train_targets{count} = importdata(fullfile(p, class2use{count}, 'train.csv'));
    validation_targets{count} = importdata(fullfile(p, class2use{count}, 'validation.csv'));
    test_targets{count} = importdata(fullfile(p, class2use{count}, 'test.csv'));
    train_class_vector{count} = repmat(class2use(count), length(train_targets{count}),1);
    validation_class_vector{count} = repmat(class2use(count), length(validation_targets{count}),1);
    test_class_vector{count} = repmat(class2use(count), length(test_targets{count}),1); 
end;

for set = 1:3
    switch set
        case 1
            targets = train_targets;
            class_vector = train_class_vector;
            fileout = 'train_features_v3';
        case 2
            targets = test_targets;
            class_vector = test_class_vector;
            fileout = 'test_features_v3';
        case 3
            targets = validation_targets;
            class_vector = validation_class_vector;       
            fileout = 'validation_features_v3';
    end
    
    class_vector = cat(1,class_vector{:});
    targets = cat(1,targets{:});
    features = NaN(length(class_vector),241);  %HARD coded for current raw v3 features; FIX later
    %features = NaN(length(class_vector),236);  %HARD coded for current raw v2 features; FIX later
    
    for count = 1:length(class2use)
        feaclass = load([pfea class2use{count}]);
        ii = strmatch(class2use(count), class_vector, 'exact');
        [~,iia,iib] = intersect(targets(ii), feaclass.pid);
        features(ii(iia),:) = feaclass.fea(iib,:);
        if length(iib) ~= length(ii)
            disp('PROBLEM: some targets are missing from feature compilation')
            keyboard
        end
    end
    if 1 %v3
        featitles = feaclass.featitles3;
        [~,i] = setdiff(featitles, {'Area' 'ConvexArea' 'MajorAxisLength' 'MinorAxisLength' 'Perimeter', 'roi_number'}');
        featitles = featitles(i);
        features = features(:,i);
        [~,i] = setdiff(featitles, {'shapehist_kurtosis_normEqD' 'shapehist_mean_normEqD' 'shapehist_median_normEqD' 'shapehist_skewness_normEqD'...
            'H90' 'H90_over_Hflip' 'H90_over_H180' 'H180' 'Hflip' 'Hflip_over_H180'}');
        featitles = featitles(i);
        features = features(:,i);
        a = strmatch('B90', featitles); b = strmatch('B180', featitles); c = strmatch('Bflip', featitles);
        featitles = [featitles 'B90_over_B180' 'B90_over_Bflip' 'Bflip_over_B180'];
        temp = [features(:,a)./features(:,b) features(:,a)./features(:,c) features(:,c)./features(:,b)];
        temp(isnan(temp)) = 0; %reassign to zero for cases of no blob
        features = [features temp];
        clear i a b c 
    else %v2
        featitles = feaclass.featitles2;
        [~,i] = setdiff(featitles, {'FilledArea' 'summedFilledArea' 'Area' 'ConvexArea' 'MajorAxisLength' 'MinorAxisLength' 'Perimeter', 'roi_number', 'FeretDiameter'}');
        featitles = featitles(i);
        features = features(:,i);
    end
    
    save([p fileout], 'features', 'featitles', 'targets', 'class_vector', 'class2use')
end


%dlmwrite('v3_bins_missing', char(missing), 'delimiter', '')
