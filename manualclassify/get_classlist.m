function [ classlist, sub_col, list_titles] = get_classlist( manualfilename, classfilename, pick_mode, class2use, class2use_sub, classstr, classnum_default, total_roi );
%function [ classlist, sub_col, list_titles] = get_classlist( manualfilename, classfilename, pick_mode, class2use, class2use_sub, classstr, classnum_default, total_roi );
%For Imaging FlowCytobot roi picking; Use with manual_classify scripts;
%Loads existing or sets up new matrix for identification results;
%Heidi M. Sosik, Woods Hole Oceanographic Institution, 31 May 2009
%6 January 2010, modified to omit save line (no longer creates result file even if no roi categories are changed)
%11 November 2011, modified to fix bug with class2use_sub being replaced by value loaded from manual result file 
%containing (problem in cases with more than one subdivide); add class2use_sub_in to keep input value
%12 November 2011; further edit to "overlap" case to prevent manual assignment to another category 
%from being over-ruled by the subdivide category

%INPUTS:
%manualfilename - mat filename (with path) for manual results
%classfilename - mat filename (with path) for SVM automated classifer results
%pick_mode - string label specifying type of identification:
%   'raw_roi' = pick classes from scartch
%   'correct_or_subdivide' = manual correction of classes and/or subdivision of a class
%class2use - cell array of main classes
%class2use_sub - cell array of classes for sub-categories
%classstr - category label for starting class for case of "subdivide"
%classnum_default - class number from class2use_pick2 (sub) for ROI default
%total_roi - number of ROIs in file
%
%OUTPUTS:
%classlist - matrix of class identity results
%sub_col - column number for results in classlist matrix for "subdivide" case
%list_titles - cell array of text explaining columns of classlist
    %fix columns for classlist
manual_col = 2;
auto_col = 3;
sub_col = [];
class2use_in = class2use;
class2use_sub_in = class2use_sub;
if exist([manualfilename], 'file')  %~isempty(tempdir)
    load([manualfilename])
    class2use_sub = class2use_sub_in; %make sure any loaded class2use_sub is overwritten
    if length(class2use_in) < length(class2use_manual),
        disp('Existing class2use_manual does not match class2use for ROI picking. You must remap the classes in result file first or change your picking categories.') 
        classlist = [];
        return
    elseif ~isequal(class2use_manual, class2use_in(1:length(class2use_manual)))
        disp('Existing class2use_manual does not match class2use for ROI picking. You must remap the classes in result file first or change your picking categories.') 
        classlist = [];
        return
    end;
    clear class2use_in
    %if strncmp(pick_mode, 'subdiv',6),
    if ~isempty(classnum_default) && ~isempty(classstr),
        sub_col = strmatch(classstr, list_titles, 'exact');
        if isempty(sub_col), %start a new one
            sub_col = size(classlist,2) + 1;
            list_titles(sub_col) = {classstr};
            classlist(:,sub_col) = NaN;
        end;
        classnum = strmatch(classstr, class2use_manual); %default class number from original list
        classlist((classlist(:,manual_col) == classnum & isnan(classlist(:,sub_col))),sub_col) = 2; %classnum_default; %find any new additions to manual start category
        classlist(classlist(:,auto_col) == classnum & isnan(classlist(:,manual_col)) & isnan(classlist(:,sub_col)),sub_col) = classnum_default; %set default from auto
        [overlap, ind_sub, ind] = intersect(class2use_sub, class2use);
        for count1 = 1:length(overlap), %set any overlap categories from previous in sub_col, if not already marked in sub_col
            %classlist(classlist(:,auto_col) == ind(count1) & isnan(classlist(:,sub_col)), sub_col) = ind_sub(count1); %set to new class number in subcol
            classlist(classlist(:,auto_col) == ind(count1) & (isnan(classlist(:,manual_col)) | classlist(:,manual_col) == ind(count1)) & isnan(classlist(:,sub_col)), sub_col) = ind_sub(count1); %11/12/11 Heidi, don't mark in sub_col if manual set to another category
        end;
    end;
    %save(manualfilename, 'list_titles', 'class2use*', 'classlist', '-append'); %make sure initial file has proper list_titles    
else 
    clear class2use_in
    classlist = NaN(total_roi,auto_col); %start with auto_col width, grow to sub_col later if needed
    classlist(:,1) = 1:total_roi;
    list_titles = {'roi number' 'manual' 'SVM-auto'};
    switch pick_mode
        case 'raw_roi' %pick classes from scratch
            classlist(:,manual_col) = classnum_default; %strmatch(classstr, class2use, 'exact');
        case 'correct_or_subdivide'  %make subcategories starting with an automated class
            if exist(classfilename),
                load(classfilename) %load SVM results
                classlist(:,auto_col)  = PreLabels(:,1);
            end;
            if ~isempty(classnum_default),               
                classlist(:,sub_col) = NaN;
                classnum = strmatch(classstr, class2use); %default class number from original list
                sub_col = 4; %first one
                classlist(:,sub_col) = NaN;
                list_titles(sub_col) = {classstr};            
                classlist(classlist(:,auto_col) == classnum, sub_col) = classnum_default; %set to default new class
                [overlap, ind_sub, ind] = intersect(class2use_sub, class2use);
                for count1 = 1:length(overlap),
                    classlist(classlist(:,auto_col) == ind(count1), sub_col) = ind_sub(count1); %set to new class number in subcol
                end;
            end;
%        case 'subdivide_from_manual'  %make subcategories starting with an automated class
%            sub_col = 4; %first one
%            classnum = strmatch(classstr, class2use); %default class number from original list
%            classlist(classlist(:,auto_col) == classnum, sub_col) = classnum_default; %set to default new class
%            [overlap, ind_sub, ind] = intersect(class2use_sub, class2use);
%            for count1 = 1:length(overlap),
%                classlist(classlist(:,auto_col) == ind(count1), sub_col) = ind_sub(count1); %set to new class number in subcol
%            end;
    end;
%    save(manualfilename, 'list_titles', 'class2use*', 'classlist'); %make sure initial file has proper list_titles    
end;
