function [ roi_ind ] = get_roi_indices( classlist, classnum, pick_mode );
%function [ roi_ind ] = get_roi_indices( classlist, classnum, pick_mode );
%For Imaging FlowCytobot roi picking; Use with manual_classify scripts;
%Finds the indices for ROIs corresponding to a particular class
%Heidi M. Sosik, Woods Hole Oceanographic Institution, 31 May 2009
%April 2015, revised to remove subdivide functionality and recast for manual_classify_4_1
%ultimately when everyone stops using pre manual_classify_5_0, decimate the
%switch / case structure here - which is now already effectively disabled
%to work consistently with manual_classify_5_0 (one version is OK since
%default classlist will always have a third (auto) column

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
        %roi_ind = classlist(classlist(:,2) == classnum | (isnan(classlist(:,2)) & classlist(:,3) == classnum),1);
        roi_ind = find(classlist(:,2) == classnum | (isnan(classlist(:,2)) & classlist(:,3) == classnum)); %case to work for VPR also
    case {'correct_classifier', 'correct'}
        %roi_ind = classlist(classlist(:,2) == classnum | (isnan(classlist(:,2)) & classlist(:,3) == classnum),1);
        roi_ind = find(classlist(:,2) == classnum | (isnan(classlist(:,2)) & classlist(:,3) == classnum)); %case to work for VPR also
end

