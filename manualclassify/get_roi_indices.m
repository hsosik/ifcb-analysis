function [ roi_ind ] = get_roi_indices( classlist, classnum, pick_mode );
%function [ roi_ind ] = get_roi_indices( classlist, classnum, pick_mode );
%For Imaging FlowCytobot roi picking; Use with manual_classify scripts;
%Finds the indices for ROIs corresponding to a particular class
%Heidi M. Sosik, Woods Hole Oceanographic Institution, 31 May 2009

%INPUTS:
%classlist - matrix of class identity results
%classnum - category number being selected
%pick_mode - string label specifying type of identification:
%   'raw_roi' = pick classes from scartch
%   'correct_auto' = manual correction of automated classes
%   'subdivide' = separate an automated class into subcategories
%sub_col - column number for results in classlist matrix for "subdivide" case
%viewset - value of 1 for case of main class2use from an automated
%           classifire; value of 2 for case of a "subdivide" set
%
%OUTPUTS:
%roi_ind - list of indices corresponding to selected ROIs
%
%April 2015 revised to eliminate subdivide functionality

switch pick_mode
    case 'raw_roi'
        roi_ind = classlist(classlist(:,2) == classnum,1);       
    case 'correct_classifier'
        roi_ind = classlist(classlist(:,2) == classnum | (isnan(classlist(:,2)) & classlist(:,3) == classnum),1);        
end

