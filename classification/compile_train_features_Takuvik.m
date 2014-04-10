%get training features from pre-computed bin feature files
manualpath = '/Volumes/TOSHIBA EXT/whoi_data/output_manual_classify/'; % manual annotation files
feapath_base = '/Volumes/TOSHIBA EXT/whoi_data/features/';
%WHne number of instances within classes, it helps getting a welle behaved
%classifier. So try to have evenly distributed number within all classes.
maxn = 100; %maximum number of images per class to include
minn = 30; %minimum number for inclusion
class2skip = {'Other'};

manual_files = dir([manualpath 'D*.mat']);
manual_files = {manual_files.name}';
fea_files = regexprep(manual_files, '.mat', '_fea_v2.csv');
manual_files = regexprep(manual_files, '.mat', '');
%this presumes all the files have the same class to use
class2use = load([manualpath manual_files{end}], 'class2use_manual');
class2use = class2use.class2use_manual;

fea_all = [];% nan(5000*length(manual_files), 235);
class_all = [];% nan(5000*length(manual_files), 1);
files_all = [];
for filecount = 1:length(manual_files), %looping over the manual files
    feapath=[feapath_base manual_files{filecount}(2:5) '/'];
    disp(['file ' num2str(filecount) ' of ' num2str(length(manual_files)) ': ' manual_files{filecount}])
    manual_temp = load([manualpath manual_files{filecount}]);
    
    fea_temp = importdata([feapath fea_files{filecount}]); %import data from the feature files
    
    if ~isequal(manual_temp.class2use_manual, class2use)
        disp('class2use_manual does not match previous files!!!')
        if isequal(manual_temp.class2use_manual, class2use(1:length(manual_temp.class2use_manual))),
            disp('class2use_manual missing entries on end')
        else
            keyboard
        end;
    end;
    %ind_nan=isnan(manual_temp.classlist(fea_temp.data(:,1),2));
    class_all = [class_all; manual_temp.classlist(fea_temp.data(:,1),2)];%This assume you have only manual annotations not classifier pre classified classes
    fea_all = [fea_all; fea_temp.data];
    files_all = [files_all; repmat(manual_files(filecount),size(fea_temp.data,1),1)];

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

datestring = datestr(now, 'ddmmmyyyy');

save([manualpath 'Takuvik_Trees_' datestring], 'train', 'class_vector', 'targets', 'class2use', 'nclass', 'featitles');

