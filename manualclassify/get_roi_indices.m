function [ roi_ind ] = get_roi_indices( classlist, classnum, pick_mode );
%function [ roi_ind ] = get_roi_indices( classlist, classnum, pick_mode );
%For Imaging FlowCytobot roi picking; Use with manual_classify scripts;
%Finds the indices for ROIs corresponding to a particular class
%Heidi M. Sosik, Woods Hole Oceanographic Institution, 31 May 2009
%April 2015, revised to remove subdivide functionality and recast for manual_classify_4_1

%INPUTS:
%classlist - matrix of class identity results
%classnum - category number being selected
%pick_mode - string label specifying type of identification:
%   'raw_roi' = pick classes from scartch
%   'correct_classifier' = manual correction of automated classes
%
%OUTPUTS:
%roi_ind - list of indices corresponding to selected ROIs

switch pick_mode
    case 'raw_roi'
        roi_ind = classlist(classlist(:,2) == classnum,1);       
    case {'correct_classifier', 'correct'}
        roi_ind = classlist(classlist(:,2) == classnum | (isnan(classlist(:,2)) & classlist(:,3) == classnum),1);        
end

