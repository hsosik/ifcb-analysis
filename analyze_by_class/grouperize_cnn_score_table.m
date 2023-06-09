function [group_score_tab] = grouperize_cnn_score_table(score_tab, maxorsum, group_tab)
% makes a "group score table" that takes the sum or max of cnn scores
% across groups of classes designated in group_tab
% INPUTS:
% 1) score_tab is a table of CNN scores (classes are variables, rois are rows) 
% assumes score tab has classnames as variable names
%
% 2) maxorsum can be 'max' or 'sum' to indicate which operation should be 
% used to compute a group score
%
% 3) group_tab is a table with a CNN_classlist variable with class names, 
% and group names as other variables that are 1 where class i belongs to
% each group
%
% OUTPUTS:
% 1) group_score_tab is a table of CNN scores for each group included in
% group_tab

scomat = table2array(score_tab);
class_labels = score_tab.Properties.VariableNames;
scomat_group = [];
other_idx = [];
group_labels = group_tab.Properties.VariableNames(~ismember(group_tab.Properties.VariableNames, 'CNN_classlist'));
for i = 1:length(group_labels)
    cc = group_tab.CNN_classlist(group_tab.(group_labels{i}) == 1); % classes in this group
    idx = find(ismember(class_labels, cc));
    if strcmp(maxorsum, 'max')
        grpsco = max(scomat(:,idx), [], 2);
    elseif strcmp(maxorsum, 'sum')
        grpsco = sum(scomat(:,idx),2);
    end
    scomat_group = [scomat_group, grpsco];

    % if you want an "othre" group for classes not explicitly included in
    % any group:
%     idx = find(~ismember(class_labels, cc));
%     if i == 1
%         other_idx = idx;
%     else
%         other_idx = intersect(other_idx, idx);
%     end

end
% if you want an "othre" group for classes not explicitly included in
% any group:
% scomat_group = [scomat_group, sum(scomat(:, other_idx),2)];
% group_labels = cat(2, group_labels, {'other'}); %Heidi

group_score_tab = array2table(scomat_group, "VariableNames", group_labels);
