pngdir = '\\sosiknas1\IFCB_products\MVCO\MVCO_train_Aug2015\'; %output from export train - where the training images are located
savedir = '\\sosiknas1\IFCB_products\MVCO\classifiers\';
feapath_base = '\\sosiknas1\IFCB_products\MVCO\features\featuresxxxx_v2\'
maxn = 500; %USER select
minn = 0; %minimum number for inclusion
outstring = 'MVCO_train_Aug2015'; %e.g., 'MVCO_train_Aug2015'

%find the class names from the subdirs
temp = dir(pngdir);
temp = temp([temp.isdir]);
classes = setdiff({temp([temp.isdir]).name}, {'.' '..'}); 

fea_all = [];% nan(5000*length(manual_files), 235);
class_all = [];% nan(5000*length(manual_files), 1);
files_all = [];
targets_all = [];
for classcount = 1:length(classes)
    class = char(classes(classcount));
    disp(class)
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
        if exist('fea2use', 'var')
            [~,fea2use_ind] = intersect(featitles,fea2use);
            %fea2use_ind = sort(fea2use_ind);
            if ~isequal(featitles(fea2use_ind), fea2use) %error checking
                disp(feaname)
                disp('problem: features do not match previous')
                return
            end
        else %first time so create fea2use; CONSIDER which features to exclude...
            [fea2use,fea2use_ind] = setdiff(featitles, {'roi_number' 'FilledArea' 'summedFilledArea' 'summedBiovolume' 'Area' 'ConvexArea' 'MajorAxisLength' 'MinorAxisLength' 'Perimeter' 'FeretDiameter'}');
            %[fea2use_ind,s] = sort(fea2use_ind);
            %fea2use = fea2use(s);
        end
        ind = find(ismember(filelist, unqfilelist{filecount}));
        temp = char(target_list{ind});
        roinum = str2num(temp(:,end-4:end));
        [~,fea_ind] = intersect(feadata(:,1), roinum);
        fea_mat(ind,:) = feadata(fea_ind,fea2use_ind);
    end
    fea_all = [fea_all; fea_mat];
    class_all = [class_all; repmat(classcount,length(roilist),1)];
    n(classcount) = length(roilist);    
    targets_all = [targets_all; target_list];
end
featitles = fea2use;

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
        targets_all(ii(shuffle_ind),:) = [];
        %files_all(ii(shuffle_ind)) = [];
        %roinum(ii(shuffle_ind)) = [];
        ii = find(class_all == classcount);
        n(classcount) = maxn;
    end;
    if n(classcount) < minn,
        class_all(ii) = [];
        fea_all(ii,:) = [];
        targets_all(ii,:) = [];
        %files_all(ii) = [];
        %roinum(ii) = [];
        n(classcount) = 0;
    end;
end;

% for classcount = 1:length(class2skip),
%     ind = strmatch(class2skip(classcount),classes);
%     ii = find(class_all == ind);
%     class_all(ii) = [];
%     fea_all(ii,:) = [];
%     targets_all(ii,:) = [];
%     %files_all(ii) = [];
%     %roinum(ii) = [];
% end;

train = fea_all;
class_vector = class_all;
targets = targets_all;
%targets = cellstr([char(files_all) repmat('_', length(class_vector),1) num2str(roinum, '%05.0f')]);
nclass = n;
class2use = classes;

datestring = datestr(now, 'ddmmmyyyy');

save([savedir outstring '_' datestring], 'train', 'class_vector', 'targets', 'class2use', 'nclass', 'featitles');


