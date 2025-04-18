% loops over stat tables generated by cnn_optval_byClass, 
% cnn_optval_byClassGroup2, cnn_optval_byClassGroup_hierarchy to create a
% table of statistic (rows) X CNN class (column) X optimal threshold value
% (values) for use in biovolume_summary_allHDF2.m.

clear; close all;

group2use = {'protist_tricho', 'Detritus', 'IFCBArtifact', 'metazoan', ...
    'Diatom_noDetritus', 'Dinoflagellate', 'Ciliate', 'NanoFlagCocco', 'Other_phyto'};

load('\\sosiknas1\Lab_data\dylan_working\cnn_score_data_byClass\Guinardia_delicatula\Guinardia_delicatula_CNN_score_data_20230417.mat')
% grab the class names:
metavar = {'file', 'roi', 'trainset_flag', 'mano_anno', 'multi_mano_flag', 'other_mano_annos'};
class2use = all_score_tab.Properties.VariableNames(~ismember(all_score_tab.Properties.VariableNames, metavar));

n_val_roi = 100; % a class must have this many non-training roi's available
% for validation to be assigned an opt-thresh
prdiff = 0.3; % a class must have abs(precision - recall) < than this, to 
% be assigned an opt-thresh

where_stat_tab = '\\sosiknas1\Lab_data\dylan_working\cnn_score_data_byClass\';
class_stat_path_end = '_adhoc_stat_table.mat';
group_stat_path_end = '_adhoc_stat_table_groupsum.mat';
sco_path_end = '_CNN_score_data_20230417.mat';

% read in a stat table to get statistics:
load([where_stat_tab, 'Guinardia_delicatula\Guinardia_delicatula_adhoc_stat_table.mat'])
statz = stat_table.Properties.VariableNames(2:end)'; % 2:end to avoid "threshold" variable
statz(ismember(statz, 'FP_rate')) = {'fpr'};
% add a precision - recall stat:
statz = cat(1, statz, {'prec-rec', 'linreg_composite',...
    'linreg_composite_std', 'linreg_composite_std2'}');

optXstatXtax = table;
tax = cat(2, group2use, class2use);
for i = 1:length(tax)

    cc = tax{i};
    sco_path = [where_stat_tab, cc, '\',cc, sco_path_end];

    if ismember(cc, group2use)
        stat_path = [where_stat_tab, cc, '\',cc, group_stat_path_end];
    else
        stat_path = [where_stat_tab, cc, '\',cc, class_stat_path_end];
    end
    optXstat = nan(length(statz), 1); % for storing opt X stat. remains nan if < 100

    if exist(stat_path, 'file')
        % groups assumed to have enough
        if ~ismember(cc, group2use)
             % load scores and check number of rois available for validation:
            load(sco_path);
            all_score_tab(all_score_tab.trainset_flag == 1 , :) = [];
            all_score_tab(~ismember(all_score_tab.mano_anno, cc) , :) = [];

            load(stat_path, 'stat_table');
            prtest = min(abs(stat_table.precision - stat_table.recall));
            if size(all_score_tab,1) > n_val_roi && prtest < prdiff
                for j = 1:length(statz)
                    statj = statz{j};
                    optj = optimize_my_stat_tab(stat_table, statj);
                    if isempty(optj)
                        % do nothing
                    else
                        optXstat(j) = min(optj); % use min optimal threshold if more than 1
                    end
                end
            else
                optXstat = nan(length(statz), 1);
            end
        else
            % groups..
            load(stat_path, 'stat_table');
            prtest = min(abs(stat_table.precision - stat_table.recall));
            if prtest < prdiff
                for j = 1:length(statz)
                    statj = statz{j};
                    optj = optimize_my_stat_tab(stat_table, statj);
                    if isempty(optj)
                        % do nothing
                    else
                        optXstat(j) = min(optj); % use min optimal threshold if more than 1
                    end
                end
            else
                optXstat = nan(length(statz), 1);
            end
        end
        
        optXstatXtax(:, cc) = array2table(optXstat);
    end
end
% set row names:
optXstatXtax.Properties.RowNames = statz;

% split classes and groups:
optXstatXclass = optXstatXtax(:, ismember(optXstatXtax.Properties.VariableNames, class2use));
optXstatXgroup = optXstatXtax(:, ismember(optXstatXtax.Properties.VariableNames, group2use));

save([where_stat_tab, 'opt_threshXstatisticXclass.mat'] , 'optXstatXclass');
save([where_stat_tab, 'opt_threshXstatisticXgroup.mat'] , 'optXstatXgroup');
