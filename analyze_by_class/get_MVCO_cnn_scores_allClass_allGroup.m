% this script pulls CNN score data from sosiknas1 for CNN class(es) and 
% groups of classes of interest 

% uses the much-improved dylan_get_cnn_score_table2.m for wrangling

% important note: all files in manual_list will not be included in score
% tables because bins with a "bleach damaged" TAG are removed!!!

% written by D. Catlett 

clear; close all;

%% wrangle groups
%% IMPORTANT: GROUPS NEED TO GO FROM BROADEST --> SMALLEST!! 
% the function overwrites score tables of individual classes included in
% multiple groups. So the table for Guinardia delicatula will be written
% 3x, and to ensure you get ALL of the available matchup data the
% "guinardia" group should be placed AFTER protists and diatoms...

% set up groups ("NanoFlagCocco" will be added below):
groups = {'protist_tricho', 'Detritus', 'IFCBArtifact', 'metazoan', ...
    'Diatom_noDetritus', 'Dinoflagellate', 'Ciliate', 'Other_phyto', ...
    'ditylum', 'guinardia'};

group_file = '\\sosiknas1\training_sets\IFCB\config\IFCB_classlist_type.csv';

group_tab = readtable(group_file);
% add in a combined nano with Nano, flagellate, and cocco's:
group_tab.NanoFlagCocco = zeros(size(group_tab,1),1);
group_tab.NanoFlagCocco(group_tab.Nano == 1 | group_tab.flagellate == 1 | group_tab.Coccolithophore == 1) = 1;
groups = cat(2, groups, {'NanoFlagCocco'});
group_tab = group_tab(:, cat(2, {'CNN_classlist'}, groups(~ismember(groups, {'guinardia','ditylum'}))));

% groups designated in IFCB_classlist_type:
classXgroup = cell(length(groups),1); % class names for each group
for i = 1:length(groups)

    gg = groups{i};

    if strcmp(gg, 'guinardia')
        classXgroup{i} = {'Guinardia delicatula', 'Guinardia striata', ...
            'Guinardia flaccida', 'Guinardia delicatulaTAGinternal parasite'};
    elseif strcmp(gg, 'ditylum')
        classXgroup{i} = {'Ditylum brightwellii'};
    else
        idx = find(table2array(group_tab(:, gg)) == 1);
        cc = group_tab.CNN_classlist(idx);
        cc = strrep(cc, '_TAG_', 'TAG');
        cc = strrep(cc, '_', ' ');
        classXgroup{i} = cc;
    end
end

%% specify some other things...

% path to the CNN results you want to use:
cnn_result_path = '\\sosiknas1\IFCB_products\MVCO\class\v3\20220209_Jan2022_NES_2.4';

% specify manual annotations to look at:
man_path = '\\sosiknas1\IFCB_products\MVCO\Manual_fromClass\manual_list.mat';
load(man_path);

% training set roi id's for this classifier:
trainlist_path = '\\sosiknas1\training_sets\IFCB\MODELS\20220209_Jan2022_NES_2.4\';

% where you want to write the outputs:
out_path_start = ['\\sosiknas1\Lab_data\dylan_working\cnn_score_data_byClass\'];
% out_path_end = ['_CNN_score_data_20230201.mat'];

%% prep for classes that include TAG's:

% path to tag-roi-table
tagtab_path = '\\sosiknas1\IFCB_products\mvco\summary\manual_tag_roi_table.mat';

% load a random class file to get class labels:
raw = load_class_scores([cnn_result_path, '\D2010\D2010_346\IFCB5_2010_346_004200_class.h5']);
class2tag = raw.class_labels;
keepTAGs = class2tag(contains(class2tag, 'TAG'));

%% parse manual_list to match groups:
% convert manual list to a table
manual_list = cat(2, array2table(manual_list(2:end, 1), "VariableNames", "file"), ...
    array2table(cell2mat(manual_list(2:end, 2:12)), "VariableNames", manual_list(1,2:end-1)));

im_special = {'Ciliate', 'Diatom', 'ditylum', 'guinardia'}; % theyre specail

allc = repmat(manual_list.("all categories"), 1, ...
    sum(~contains(groups, im_special)));
new_manual_list = array2table(allc, "VariableNames", ...
    groups(~contains(groups, im_special)));
new_manual_list.Diatom_noDetritus = manual_list.diatoms == 1 | manual_list.("all categories") == 1;
new_manual_list.Ciliate = manual_list.ciliates == 1 | manual_list.("all categories") == 1;
new_manual_list.ditylum = manual_list.ditylum == 1 | manual_list.("all categories") == 1;
new_manual_list.guinardia = manual_list.guinardia == 1 | manual_list.("all categories") == 1;
new_manual_list = cat(2, manual_list(: , ["file"]), new_manual_list);

%% call your function:

get_cnn_score_table2(cnn_result_path, new_manual_list, ...
        trainlist_path, out_path_start, groups, classXgroup, keepTAGs, tagtab_path);



