function [ classlist, list_titles, newclasslist_flag, default_class_original] = get_classlistTB2( manualfilename, classfilename, pick_mode, class2use, classnum_default, total_roi, x_size );
%function [ classlist, list_titles] = get_classlist( manualfilename, classfilename, pick_mode, class2use, classnum_default, total_roi );
%For Imaging FlowCytobot roi picking; Use with manual_classify scripts;
%Loads existing or sets up new matrix for identification results;
%Heidi M. Sosik, Woods Hole Oceanographic Institution, 31 May 2009
%6 January 2010, modified to omit save line (no longer creates result file even if no roi categories are changed)
%11 November 2011, modified to fix bug with class2use_sub being replaced by value loaded from manual result file
%containing (problem in cases with more than one subdivide); add class2use_sub_in to keep input value
%12 November 2011; further edit to "overlap" case to prevent manual assignment to another category
%from being over-ruled by the subdivide category
%April 2015, revised to remove subdivide functionality and recast for manual_classify_4_1
%May 2015, get_classlistTB2 created from get_classlistTB to handle case of
%combining pre-existing manual result file with classifer output, create
%"archive" copy of col2 in col4 just to be save about overwriting
%classnum_default instances with NaNs

%INPUTS:
%manualfilename - mat filename (with path) for manual results
%classfilename - mat filename (with path) for SVM automated classifer results
%pick_mode - string label specifying type of identification:
%   'raw_roi' = pick classes from scartch
%   'correct_classifier' = manual correction of classes and/or subdivision of a class
%class2use - cell array of main classes
%classnum_default - class number from class2usefor ROI default in case no class from auto classifier
%total_roi - number of ROIs in file
%
%OUTPUTS:
%classlist - matrix of class identity results
%list_titles - cell array of text explaining columns of classlist
%newclasslist_flag - set to true for case of classlist created now
%fix columns for classlist
manual_col = 2;
auto_col = 3;
class2use_in = class2use;
newclasslist_flag = 0; %default to false
old_manual_no_auto = 0;
new_manual = 0;
if exist([manualfilename], 'file')  %~isempty(tempdir)
    load([manualfilename])
    if ~exist('default_class_original', 'var') %handle old cases when default_class_original not saved in manual files
        default_class_original = 'NaN';
    end
    if length(class2use_in) < length(class2use_manual)
        %disp('Existing class2use_manual does not match class2use for ROI picking. You must remap the classes in result file first or change your picking categories.')
        disp('Existing class2use_manual does not match class2use for ROI picking. Your saved results have more classes than in your list of picking categories.')
        classlist = [];
        return
    elseif ~isequal(class2use_manual, class2use_in(1:length(class2use_manual)))
        %disp('Existing class2use_manual does not match class2use for ROI picking. You must remap the classes in result file first or change your picking categories.')
        %classlist = [];
        %return
        ichange = find(~strcmp(class2use_in(1:length(class2use_manual)), class2use_manual));
        for ci = 1:length(ichange)
            disp([class2use_manual{ichange(ci)} ' relabeled ' class2use_in{ichange(ci)}])
        end
    end
    if isempty(find(~isnan(classlist(:,auto_col))))
        old_manual_no_auto = 1;
    end
else   %make new classlist %if isequal(pick_mode, 'raw_roi')
    classlist = NaN(total_roi,auto_col); %start with auto_col width, grow to sub_col later if needed
    classlist(:,1) = 1:total_roi;
    if ~isequal(pick_mode, 'correct')
        classlist(:,manual_col) = classnum_default; %strmatch(classstr, class2use, 'exact');
    end
    list_titles = {'roi number' 'manual' 'auto'};
    newclasslist_flag = 1;
    default_class_original = class2use(classnum_default);
    new_manual = 1;
    if ~isnan(x_size) %NaN is VPR case that doesn't need this
        classlist(x_size == 0,2) = NaN; %mark zero-sized ROIs as NaNs in manual column (needed for raw_roi case where these are put in default class by get_classlistTB
    end
end
clear class2use_in

if isequal(pick_mode, 'correct')
    if old_manual_no_auto
        if size(classlist,2) > 3
            msgbox('This result file already contains information in column 4 of classlist. Classifier import cannot proceed.')
        else
            warn_str =  {['Warning: Classifier import will permanentaly remove existing annotations associated with default class: '...
                class2use{classnum_default}]; 'To skip this step automatically edit your configuration.'};
            [selectedButton,dlgShown]=uigetpref('graphics','merge_man_class_warning','Importing Classifier Output Warning',...
                warn_str, {'OK' 'Skip import'}, 'CheckBoxString', 'Apply to all files in this session. Do not display this warning again.');
            if isequal(lower(selectedButton), lower('OK'))
                list_titles = {'roi number' 'manual' 'auto' 'manual_raw_roi'};
                classlist(:,4) = classlist(:,2);
                classlist((classlist(:,2) == classnum_default),2) = NaN;
            end
        end
    end
    if exist(classfilename, 'file') && (old_manual_no_auto || new_manual)
        load(classfilename) %load classifier results
        %make a temporary class2use that maps back to old names in MVCO classes
        class2use_temp = class2use;
        if ~isempty([strfind(classfilename,'mvco') strfind(classfilename,'MVCO')])
            class2use_temp{strmatch('Ciliate_mix', class2use)} = 'ciliate_mix';
            class2use_temp{strmatch('Tintinnid', class2use)} = 'tintinnid';
            class2use_temp{strmatch('Laboea_strobila', class2use)} = 'Laboea_strobila';
            class2use_temp{strmatch('Mesodinium_sp', class2use)} = 'Myrionecta';
            class2use_temp{strmatch('Guinardia_delicatula', class2use, 'exact')} = 'Guinardia';
        end;
        %new case for TBclassification July 2012, Heidi
        [~,ia] = ismember(TBclass_above_threshold, class2use_temp);
        if ~isempty([strfind(classfilename,'vpr') strfind(classfilename,'VPR')])
            classlist(:,auto_col)  = ia;
        else
            classlist(roinum,auto_col)  = ia;
        end
        classlist(classlist(:,auto_col) == 0,auto_col) = classnum_default;
    else
        disp('No class file found; starting with all ROIs in default class')
    end
end
end
