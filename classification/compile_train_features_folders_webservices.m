function [  ] = compile_train_features_folders_webservices( exported_img_base_path , url_bases, maxn, minn, varargin )
% function [  ] = compile_train_features_folders_webservices( exported_img_base_path , url_bases, maxn, minn, class2skip, class2group)
% class2skip and class2merge are optional inputs
%For example:
% compile_train_features_folders_webservices( '\\sosiknas1\IFCB_products\MVCO\MVCO_train_Aug2015_tempset_forGobler\' , {'MVCO' 'http://ifcb-data.whoi.edu/mvco/'}, 100 , 30, {'spore' 'bad'}, {{'mix' 'crypto' 'flagellate' 'Heterocapsa_rotundata' 'Pyramimonas'} {'dino30' 'Heterocapsa_triquetra'}})
%Example inputs:
    %base path location for the example images (under this should be folders by class, then project)
%exported_img_base_path = '\\sosiknas1\IFCB_products\MVCO\MVCO_train_Aug2015_tempset_forGobler\'; 
    % pairs of project folder names and associated IFCB Dashboard URLs, include
%url_bases = [{'MVCO' 'http://ifcb-data.whoi.edu/mvco/'}; {'IFCB101_BigelowFeb2017' 'http://ifcb-data.whoi.edu/IFCB101_BigelowFeb2017'}] 
%maxn = 100; %maximum number of images per class to include
%minn = 30; %minimum number for inclusion
%Optional inputs;
%class2skip = {'other'}; % for multiple use: {'myclass1' 'myclass2'}
%class2skip = {}; %for case to skip none and include class2merge
%class2group = {{'class1a' 'class1b'} {'class2a' 'class2b' 'class2c'}}; %use nested cells for multiple groups of 2 or more classes 

if ~(exported_img_base_path(end)== filesep)
    exported_img_base_path = [exported_img_base_path filesep];
end

class2skip = []; %initialize
class2group = {[]};
if length(varargin) >= 1
    class2skip = varargin{1};
end
if length(varargin) > 1
    class2group = varargin(2);
end

if length(class2group{1}) > 1 && ischar(class2group{1}{1}) %input of one group without outer cell 
    class2group = {class2group};
end

%find the class names from the subdirs
temp = dir(exported_img_base_path);
temp = temp([temp.isdir]);
class2use = setdiff({temp([temp.isdir]).name}, {'.' '..'}); 

projects = url_bases(:,1);
project_urls = url_bases(:,2);
targets = [];
class_all = [];
for classnum = 1:length(class2use)
    for projnum = 1:length(projects)
        p = [exported_img_base_path class2use{classnum} filesep projects{projnum} filesep];
        temp = dir([p '*.png']);
        targets = [targets; cellstr([repmat(project_urls{projnum}, length(temp),1) char({temp.name}')])];
        class_all = [class_all; repmat(classnum,length(temp),1)];
    end
end

[n, class_all, varargout] = handle_train_maxn( class2use, maxn, class_all, targets );
targets = varargout{1};

[ n, class_all, varargout ] = handle_train_class2skip( class2use, class2skip, n, class_all, targets );
targets = varargout{1};

[ n, class_all, class2use, varargout ] = handle_train_class2group( class2use, class2group, maxn, n, class_all, targets );
targets = varargout{1};

[ n, class_all, varargout ] = handle_train_minn( minn, n, class_all, targets );
targets = varargout{1};


[~, featitles] = roi_features(targets{1}); %assume all have same fea_titles
[fea2use] = setdiff(featitles, {'FilledArea' 'summedFilledArea' 'summedBiovolume' 'Area' 'ConvexArea' 'MajorAxisLength' 'MinorAxisLength' 'Perimeter' 'roi_number' 'FeretDiameter' 'summedFeretDiameter'}');

[ train ] = get_features_roilist_webservices( targets, fea2use );

featitles = fea2use;

class_vector = class_all;
nclass = n;

datestring = datestr(now, 'ddmmmyyyy');

save([exported_img_base_path 'UserExample_Train_' datestring], 'train', 'class_vector', 'targets', 'class2use', 'nclass', 'featitles');
disp('Training set feature file stored here:')
disp([exported_img_base_path 'UserExample_Train_' datestring])
end
