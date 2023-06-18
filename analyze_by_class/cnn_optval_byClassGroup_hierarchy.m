% makes grouped score tables and does opt thresh calculations for subgroups 
% of classes. subgroups are members of groups defined previously (in
% cnn_optval_byClassGroup2.m)

clear; close all;

% designate your primary group:
groups1 = {'protist_tricho', 'Detritus', 'IFCBArtifact', 'metazoan'}; % primary groups used 
primary_group = 'protist_tricho'; % group to analyze here

% and subgroups ("NanoFlagCocco" will be added below):
subgroups = {'Diatom_noDetritus', 'Dinoflagellate', 'Ciliate', 'Other_phyto'};

% load the manual list:
load('\\sosiknas1\IFCB_products\MVCO\Manual_fromClass\manual_list.mat')
% make it pretty:
manual_list = array2table(manual_list(2:end, :), "VariableNames", cat(2, {'file'}, manual_list(1,2:end)));

% load a score table to get all the classes:
metavar = {'file', 'roi', 'trainset_flag', 'mano_anno', 'multi_mano_flag', 'other_mano_annos'};

% group file:
group_file = '\\sosiknas1\training_sets\IFCB\config\IFCB_classlist_type.csv';

group_tab = readtable(group_file);
% add in a combined nano with Nano, flagellate, and cocco's:
group_tab.NanoFlagCocco = zeros(size(group_tab,1),1);
group_tab.NanoFlagCocco(group_tab.Nano == 1 | group_tab.flagellate == 1 | group_tab.Coccolithophore == 1) = 1;
subgroups = cat(2, subgroups, {'NanoFlagCocco'});
group_tab_primary = group_tab(:, cat(2, {'CNN_classlist'}, groups1));
group_tab = group_tab(:, cat(2, {'CNN_classlist'}, subgroups));

% groups designated in IFCB_classlist_type:
classXgroup = cell(length(subgroups),1); % class names for each group
for i = 1:length(subgroups)
    gg = subgroups{i};
    idx = find(table2array(group_tab(:, gg)) == 1);
    cc = group_tab.CNN_classlist(idx);
    cc = strrep(cc, '_TAG_', 'TAG');
    cc = strrep(cc, '_', ' ');
    classXgroup{i} = cc;
end

% and for primary groups:
classXgroup1 = cell(length(groups1),1);
for i = 1:length(groups1)
    gg = groups1{i};
    idx = find(table2array(group_tab_primary(:, gg)) == 1);
    cc = group_tab_primary.CNN_classlist(idx);
    cc = strrep(cc, '_TAG_', 'TAG');
    cc = strrep(cc, '_', ' ');
    classXgroup1{i} = cc;
end

% path to modified grouping score tables:
modsco_path_out = ['\\sosiknas1\Lab_data\dylan_working\cnn_score_data_byClass\', primary_group, '\'];
modsco_path_2 = [primary_group, '_CNN_score_data_20230417.mat'];

% threshold values to test:
thresh = 0:0.01:0.99;

% statistic to optimize thresholding to:
optimize2 = 'prec-rec';

% number of roi's at which to discard training set roi's for calculations
n_val_roi = 100;

%% primary group calculations:

% first grab primary group score table:
load([modsco_path_out, modsco_path_2])
% make a logical indicating roi's that are classified to primary_group:
% ...and grouperize your score table:
colz = ismember(all_score_tab.Properties.VariableNames, ...
    setdiff(all_score_tab.Properties.VariableNames, metavar));
scores = grouperize_cnn_score_table(all_score_tab(: , colz), 'sum', group_tab_primary);

cxg = classXgroup1{ismember(groups1, primary_group)};
cxg = strrep(cxg, ' ', '_');
cxg = strrep(cxg, 'TAG', '_TAG_');
all_score_tab.mano_anno(ismember(all_score_tab.mano_anno, cxg)) = {primary_group};
man =  all_score_tab.mano_anno;

% convert class and man to numeric code (index in scores):
target_idx = find(ismember(scores.Properties.VariableNames, primary_group));
mannum = zeros(length(man),1);
mannum(ismember(man, primary_group)) = target_idx;

scomat = table2array(scores); % score matrix
[~, topclassidx] = max(scomat, [], 2); % col index of top class in scomat
topclassidx_lin = sub2ind(size(scomat), (1:size(scomat,1)).', topclassidx);
topclasssco = scomat(topclassidx_lin);

% need classifications with primary group's "optthresh":
load([modsco_path_out, primary_group, '_adhoc_stat_table_groupsum.mat'])
tester = abs(stat_table.precision - stat_table.recall);
tt = min(stat_table.threshold(tester == min(tester))); % load opt thresh for primary group here
primary_roi_idx = topclassidx == target_idx & topclasssco > tt; 
hierarchy = table; 
hierarchy.file = all_score_tab.file; hierarchy.roi = all_score_tab.roi;
hierarchy.hierarchy = primary_roi_idx;

%% move forward:
% first make subgroup score tables:
for i = 1:length(subgroups)

    target = subgroups{i};
    
    outp1 = [strrep(modsco_path_out, [primary_group '\'], ''), target, '\', target, strrep(modsco_path_2, primary_group, '')];

    load(outp1);

    % trim all_score_tab and roict_table to match primary group:
    all_score_tab = innerjoin(all_score_tab, hierarchy,...
            "Keys", ["file", "roi"]);
    roict_table = unique(innerjoin(roict_table, hierarchy(:, "file"), "Keys", "file"), "rows");

    if size(all_score_tab, 1) > n_val_roi

        tmp = all_score_tab(all_score_tab.trainset_flag == 0, :);
        if size(tmp,1) < n_val_roi
            % dont remove training set
        else
            % remove training set:
            all_score_tab(all_score_tab.trainset_flag == 1, :) = [];
            roict_table.roict = roict_table.roict - roict_table.train_counts;
            roict_table.train_counts = [];
        end
        
        colz = ismember(all_score_tab.Properties.VariableNames, ...
            setdiff(all_score_tab.Properties.VariableNames, metavar));
        scomat = grouperize_cnn_score_table(all_score_tab(: , colz), 'sum', group_tab);

        cxg = classXgroup{i};
        cxg = strrep(cxg, ' ', '_'); cxg = strrep(cxg, 'TAG', '_TAG_');
        all_score_tab.mano_anno(ismember(all_score_tab.mano_anno, cxg)) = {target};
   
        [tmpopt, stat_table, allcnn_counts, man_counts, binid] = optimize_CNN_thresholding(scomat, ...
            all_score_tab.mano_anno, target, all_score_tab.file, ...
            'adhoc', thresh, optimize2, roict_table, all_score_tab.hierarchy);
        
        % save the table of statistics vs. threshold value just in case:
        pp = [strrep(modsco_path_out, [primary_group, '\'], ''), target, '\', target, '_adhoc_stat_table_groupsum.mat'];
        save(pp, "stat_table", '-v7.3');
        
        pp = [strrep(modsco_path_out, [primary_group, '\'], ''), target, '\', target, '_adhoc_count_data_groupsum.mat'];
        save(pp, "allcnn_counts", "man_counts", "binid", '-v7.3');
        
        disp(['results saved to ' pp]);

    else
        disp(['no score table found for ', target]);
    end
  
    disp(['group ', num2str(i), ' of ', ...
        num2str(length(subgroups)), ' is done']);
end



