%get training features from pre-computed class feature files
feapath_base = '\\sosiknas1\Lab_data\VPR\NBP1201NewTrain201502\features\';
outpath = '\\sosiknas1\Lab_data\VPR\NBP1201NewTrain201502\classifier\';
maxn = 174; %maximum number of images per class to include in training set
minn = 30; %minimum number for class to be included in classifier
%class2skip = {'other'}; %{'other'}; 
class2skip = {'unknown'}; 

manual_files = dir([feapath_base '*fea_v2.csv']);
manual_files = {manual_files.name}';
fea_files = regexprep(manual_files, '.mat', '_fea_v2.csv');
class2use = regexprep(fea_files, '_fea_v2.csv', '');
%this presumes all the files have the same class to use
%class2use = load([manualpath manual_files{end}], 'class2use_manual');
%class2use = class2use.class2use_manual;

fea_all = [];% nan(5000*length(manual_files), 235);
class_all = [];% nan(5000*length(manual_files), 1);
for filecount = 1:length(class2use), %looping over the classes
    %feapath=[feapath_base manual_files{filecount}(2:5) '/'];
    disp(['file ' num2str(filecount) ' of ' num2str(length(class2use)) ': ' class2use{filecount}])
    %manual_temp = load([manualpath manual_files{filecount}]);
    
    fea_temp = importdata([feapath_base fea_files{filecount}]); %import data from the feature files
    
    %ind_nan=isnan(manual_temp.classlist(fea_temp.data(:,1),2));
    class_all = [class_all; ones(size(fea_temp.data,1),1)*filecount];%This assume you have only manual annotations not classifier pre classified classes
    fea_all = [fea_all; fea_temp.data];

end;

featitles = fea_temp.textdata;
[~,i] = setdiff(featitles, {'FilledArea' 'summedFilledArea' 'Area' 'ConvexArea' 'MajorAxisLength' 'MinorAxisLength' 'Perimeter', 'roi_number'}');
featitles = featitles(i);
roinum = fea_all(:,1);
fea_all = fea_all(:,i);

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
        roinum(ii(shuffle_ind)) = [];
        ii = find(class_all == classcount);
        n(classcount) = maxn;
    end;
    if n(classcount) < minn,
        class_all(ii) = [];
        fea_all(ii,:) = [];
        roinum(ii) = [];
        n(classcount) = 0;
    end;
end;

for classcount = 1:length(class2skip),
    ind = strmatch(class2skip(classcount),class2use);
    ii = find(class_all == ind);
    class_all(ii) = [];
    fea_all(ii,:) = [];
    roinum(ii) = [];
end;

train = fea_all;
class_vector = class_all;
%targets = cellstr([char(files_all) repmat('_', length(class_vector),1) num2str(roinum, '%05.0f')]);
targets = cellstr([char(class2use(class_all)) repmat('_', length(class_all),1) num2str(roinum, '%05.0f')]);
nclass = n;

datestring = datestr(now, 'ddmmmyyyy');

%save([outpath 'RossSea_TrainSet_withother_' datestring], 'train', 'class_vector', 'targets', 'class2use', 'nclass', 'featitles');
save([outpath 'RossSea_TrainSet_' datestring], 'train', 'class_vector', 'targets', 'class2use', 'nclass', 'featitles');

