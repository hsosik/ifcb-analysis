function [  ] = check_images_classifier_from_training_export(class2view_in, train_pngbase, classifier_name, display_metric, threshold_flag,subplotyx)
%function [  ] = check_images_classifier_from_training_export(class2view_in, train_pngbase, classifier_name, display_metric, threshold_flag,subplotyx)
%example1: check_images_classifier_from_training_export([2 5], '\\sosiknas1\IFCB_products\MVCO\train_04Nov2011_fromWebServices\', 'MVCO_trees_25Jun2012', 'false_neg', 0, [3 5])
%example2: check_images_classifier_from_training_export({'Dictyocha' 'Dinophysis'}, '\\sosiknas1\IFCB_products\MVCO\train_04Nov2011_fromWebServices\', 'MVCO_trees_25Jun2012', 'false_neg', 0, [3 5])
% Function to display training set images according to different types of out-of-bag errors made by a random forest classifier created with make_TreeBaggerClassifier.m
%
%Inputs: 
%   class2view_in: list of one or more category to display (vector of class numbers or cell of class labels)
%       example: 2 or 'Cerataulina' or [2 4 5] or {''Cerataulina'' 'Chaetoceros' 'Corethron'} or [] (empty) to step througth all categories in your classifier
%   train_pngbase: directory location for exported image training set used to build and evaluate the classifier (base level above all category subdirectories)
%   classifier_name: string specifying name of classifier file (output from make_TreeBaggerClassifier.m), include full directory structure if not in path    
%   display_metric: string specifying an error type to display, choices: 'true_pos', 'false_pos', 'false_neg'
%   threshold_flag: 0 (default if empty input []) for each ROI in category with highest score; 
%       1 for ROIs placed in category if above 'maxthre' created in make_TreeBaggerClassifier.m, otherwise ROIs in 'unclassified'
%   subplotyx: two element vector specifying how many ROIs to display, [subplot_columns subplot_rows}
%
%Heidi M. Sosik, Woods Hole Oceanographic Institution, July 2015

persistent classifier_info last_classifier_name
last_classifier_name = classifier_name;
if ~isequal(last_classifier_name, classifier_name) || isempty(classifier_info) %save time by not reloading the same classifier between calls to this function
    disp('loading classifier...')
    classifier_info = load(classifier_name);
end;

if isempty(threshold_flag)
   threshold_flag = 0; %default
end

if ~exist([classifier_name '.mat'], 'file') %check for input error
    disp('classifier not found')
    return
end
classes = classifier_info.classes;
%check for image type
t = dir([fullfile(train_pngbase), class2view_in{1} filesep]);
t([t.isdir]) = [];
[~,~,img_ext] = fileparts(t(2).name)

classifier_info.targets = regexprep(classifier_info.targets, img_ext, ''); %make sure not extensions in target list

class2view = 1:length(classes);  %default, step through all classes
if ~isempty(class2view_in) %overwrite default with user input
    if isstr(class2view_in) || iscell(class2view_in) %convert string input to class numbers
        [~,class2view] = intersect(classes, class2view_in); 
    else
        class2view = class2view_in;
    end
end

if isempty(class2view) | max(class2view) > length(classes) %check for input error
    disp('requested class not found')
    return
end

disp('applying classifier...')
[y,TBscores]=oobPredict(classifier_info.b);

[maxscore, winclass] = max(TBscores'); %all rois in classes according to max score
if threshold_flag == 1 %rois in classes if above optimal score threshold (maxthre), otherwise "unclassified"
    [ winclass ] = apply_TBthreshold( classes, TBscores, classifier_info.maxthre );
    temp = strmatch('unclassified', classes); 
    if isempty(temp)
        classes(end+1) = {'unclassified'};
    end
    [~,winclass] = ismember(winclass, classes);
    temp = strmatch('unclassified', classes); 
    ind = find(winclass~=temp);
    maxscore(ind) = TBscores(sub2ind(size(TBscores), ind, winclass(ind)));
elseif threshold_flag ~= 0 %check for input error
    disp('invalid threshold_flag: input 0 for max score (default) or 1 for optimal score threshold')
    return
end;

[~,manual_class_num]=ismember(classifier_info.b.Y',classes); %manual classes from training set

figh = figure;
for count = 1:length(class2view),
    subnum = 0; %initialize the subplot
    classnum = class2view(count); %get the class number from the display list
    disp(classes(classnum)) %write the category label in the command window
    set(figh, 'name', classes{classnum}); %label the figure window with the category label
    switch display_metric %find the images to display for this case
        case 'true_pos'
            ii = find(winclass == classnum & manual_class_num==classnum);
        case 'false_pos'
            ii = find(winclass == classnum & manual_class_num~=classnum);       
        case 'false_neg'
            ii = find(winclass ~= classnum & manual_class_num==classnum);
    end
    [~,ii_sort] = sort(maxscore(ii), 'descend');
    ii = ii(ii_sort);
    if ~isempty(ii),
        for num = 1:length(ii),
            subnum = subnum + 1; %increment the subplot
            subplot(subplotyx(1),subplotyx(2),subnum)
            roi_id = classifier_info.targets{ii(num)}; %get the ROI name
            img_manual_class = classes(manual_class_num(ii(num))); %true category (training set)
            roi_fullfile = [char(fullfile(train_pngbase, img_manual_class, roi_id)) img_ext]; %ROI name with path
            img = imread(roi_fullfile); %read the image
            imshow(img) %plot the image
            switch display_metric %set the ROI title for this case
                case 'true_pos'
                    title({roi_id ; ['; score = ' num2str(maxscore(ii(num)), '%.2f')]}, 'interpreter', 'none', 'fontsize', 8)
                case 'false_pos'
                    title({roi_id ; ['true_class = ' classes{manual_class_num(ii(num))} ' ; score = ' num2str(maxscore(ii(num)), '%.2f')]}, 'interpreter', 'none', 'fontsize', 10)
                case 'false_neg'
                    title({roi_id ; ['auto_class = ' classes{winclass(ii(num))} ' ; score = ' num2str(maxscore(ii(num)), '%.2f')]}, 'interpreter', 'none', 'fontsize', 10)
            end;
            if subnum == min(subplotyx(1)*subplotyx(2),length(ii)),
                pause %pause if the screen is full
                clf %reset for the next screen
                subnum = 0; 
            end;
        end;
    end;
    if subnum > 0
        pause %pause for the last screen
    end
    clf(figh) %clear figure between classes
end;
close(figh) %close the figure at the end
end

