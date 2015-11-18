pngdir = '\\sosiknas1\Lab_data\VPR\NBP1201\VPR8_train_27Oct2015\'; %output from export train - where the training images are located
savedir = '\\sosiknas1\Lab_data\VPR\NBP1201\classifiers\';
feapath_base = '\\sosiknas1\Lab_data\VPR\NBP1201\vpr8\features\'
maxn = 400; %USER select
minn = 20; %minimum number for inclusion
outstring = 'NBP1201_train_vpr8_27Oct2015'; %e.g., 'MVCO_train_Aug2015'

%find the class names from the subdirs
temp = dir(pngdir);
temp = temp([temp.isdir]);
classes = setdiff({temp([temp.isdir]).name}, {'.' '..'}); 

%skip some classes that are empty or not properly annotated
classes = setdiff(classes, {'unknown'});
%class_vector = [];
%targets = [];
%feature_mat = [];
%classes = classes(1);

fea_all = [];% nan(5000*length(manual_files), 235);
class_all = [];% nan(5000*length(manual_files), 1);
files_all = [];
targets_all = [];
for classcount = 1:length(classes)
    disp(classes{classcount});
    roilist = dir([pngdir char(classes(classcount)) filesep '*.tif']);
    target_list = regexprep({roilist.name}', '.tif', '');
    filelist = char({roilist.name}'); filelist = cellstr(filelist(:,1:end-4)); %adjusted by EP to accomodate VPR filenames
    unqfilelist = unique(filelist);
    flist = [];
    fea_mat = [];
    for filecount = 1:length(unqfilelist)
        feaname = [unqfilelist{filecount} '_fea_v3.csv']; %changed from fea_V2 to fea_V3 for vpr feature files
        %feapath = regexprep(feapath_base, 'xxxx', feaname(7:10)); %part to adjust for vpr file names
        feapath = feapath_base;
        [ feadata, featitles ] = get_fea_file([feapath feaname(12:18) '_fea_v3.csv']);
        ind = find(ismember(filelist, unqfilelist{filecount}));
        temp = char(target_list{ind});
        roinum = str2num(temp(:,end-9:end)); %%part to adjust for vpr data
        [~,fea_ind] = intersect(feadata(:,1), roinum);
        fea_mat(ind,:) = feadata(fea_ind,:);
    end
    fea_all = [fea_all; fea_mat];
    class_all = [class_all; repmat(classcount,length(roilist),1)];
    n(classcount) = length(roilist);    
    targets_all = [targets_all; target_list];
end

clear *temp

for classcount = 1:length(classes),
    ii = find(class_all == classcount);
    n(classcount) = size(ii,1);
    n2del = n(classcount)-maxn;
    if n2del > 0,
        shuffle_ind = randperm(n(classcount));
        shuffle_ind = shuffle_ind(1:n2del);
        class_all(ii(shuffle_ind)) = [];
        fea_all(ii(shuffle_ind),:) = [];        
        targets_all(ii(shuffle_ind)) = [];
        ii = find(class_all == classcount);
        n(classcount) = maxn;
    end;
    if n(classcount) < minn,
        class_all(ii) = [];
        fea_all(ii,:) = [];
        targets_all(ii) = [];
        n(classcount) = 0;
    end;
end;

train = fea_all;
class_vector = class_all;
targets = targets_all;
nclass = n;
class2use = classes;

datestring = datestr(now, 'ddmmmyyyy');

save([savedir outstring datestring], 'train', 'class_vector', 'targets', 'class2use', 'nclass', 'featitles');

