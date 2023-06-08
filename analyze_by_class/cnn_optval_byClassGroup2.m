% this makes grouped score tables for the protist + tricho, detritus, ifcb
% artifact, and metazoan groups, and then does opt thresh calculations...

clear; close all;

%% set some things up:

% load the manual list:
load('\\sosiknas1\IFCB_products\MVCO\Manual_fromClass\manual_list.mat')
% make it pretty:
manual_list = array2table(manual_list(2:end, :), "VariableNames", cat(2, {'file'}, manual_list(1,2:end)));

% load a score table to get all the classes:
load('\\sosiknas1\Lab_data\dylan_working\cnn_score_data_byClass\Acanthoica quattrospina\Acanthoica quattrospina_CNN_score_data_20221013.mat')
% grab the class names:
metavar = {'file', 'roi', 'trainset_flag', 'mano_anno', 'multi_mano_flag', 'other_mano_annos'};

% group selection:
groups1 = {'protist_tricho', 'Detritus', 'IFCBArtifact', 'metazoan'};

% groups designated in IFCB_classlist_type:
group_file = '\\sosiknas1\training_sets\IFCB\config\IFCB_classlist_type.csv';
group_tab = readtable(group_file);
group_tab = group_tab(:, ismember(group_tab.Properties.VariableNames, groups1) | ...
    ismember(group_tab.Properties.VariableNames, 'CNN_classlist'));
classXgroup = cell(length(groups1),1); % class names for each group
for i = 1:length(groups1)
    gg = groups1{i};
    idx = find(table2array(group_tab(:, gg)) == 1);
    cc = group_tab.CNN_classlist(idx);
    cc = strrep(cc, '_TAG_', 'TAG');
    cc = strrep(cc, '_', ' ');
    classXgroup{i} = cc;
end

% path to modified grouping score tables:
modsco_path_out = '\\sosiknas1\Lab_data\dylan_working\cnn_score_data_byClass\';

% threshold values to test:
thresh = 0:0.01:0.99;

% statistic to optimize thresholding to:
optimize2 = 'prec-rec';

% number of roi's at which to discard training set roi's for calculations
n_val_roi = 100;

%% calculations:
for i = 1:length(groups1)

    target = groups1{i};

    outp1 = [modsco_path_out, target, '\', target, '_CNN_score_data_20230417.mat'];

    load(outp1);
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

        % grouperize your score table:
        colz = ismember(all_score_tab.Properties.VariableNames, ...
            setdiff(all_score_tab.Properties.VariableNames, metavar));
        scomat = grouperize_cnn_score_table(all_score_tab(: , colz), 'sum', group_tab);
        
        cxg = classXgroup{i};
        cxg = strrep(cxg, ' ', '_');
        cxg = strrep(cxg, 'TAG', '_TAG_');
        all_score_tab.mano_anno(ismember(all_score_tab.mano_anno, cxg)) = {target};
           
        [tmpopt, stat_table, allcnn_counts, man_counts, binid] = optimize_CNN_thresholding(scomat, ...
            all_score_tab.mano_anno, target, all_score_tab.file, ...
            'adhoc', thresh, optimize2, roict_table, 0);

        % save the table of statistics vs. threshold value just in case:
        pp = [modsco_path_out, target, '\', target, '_adhoc_stat_table_groupsum.mat'];
        save(pp, "stat_table", '-v7.3');
        
        pp = [modsco_path_out, target, '\', target, '_adhoc_count_data_groupsum.mat'];
        save(pp, "allcnn_counts", "man_counts", "binid", '-v7.3');

        disp(['results saved to ' pp]);

    else
        disp(['no score table found for ', target]);
    end

    disp(['group ', num2str(i), ' of ', ...
        num2str(length(groups1)), 'be done']);
end


