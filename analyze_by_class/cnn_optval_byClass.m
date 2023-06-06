% this script loops over the score tables of all CNN classes to 
% do optimization and validation of thresholding 
% it saves stat tables showing CNN-human match-up statistics across
% different CNN score threshold values, and count data across different CNN
% score thresholds

clear; close all;

%% set some things up:
% load a score table to get all the classes:
load('\\sosiknas1\Lab_data\dylan_working\cnn_score_data_byClass\Acanthoica quattrospina\Acanthoica quattrospina_CNN_score_data_20221013.mat')
% grab the class names:
metavar = {'file', 'roi', 'trainset_flag', 'mano_anno', 'multi_mano_flag', 'other_mano_annos'};
class2opt = all_score_tab.Properties.VariableNames(~ismember(all_score_tab.Properties.VariableNames, metavar));
opt_thresh = array2table(zeros(1 , length(class2opt)), 'VariableNames', class2opt); % for storing optimal threshold values

% a G. del only run:
% class2opt = {'Guinardia_delicatula', 'Guinardia_delicatula_TAG_internal_parasite'}; % for a test run
% class2opt = {'Guinardia_delicatula_TAG_internal_parasite'}; % for a test run

% path to score tables:
sco_path = '\\sosiknas1\Lab_data\dylan_working\cnn_score_data_byClass\';
sco_path_end = '_CNN_score_data_wtag_20230417.mat';
sco_path_end2 = '_CNN_score_data_20230417.mat';

% threshold values to test:
thresh = 0:0.01:0.99;

% statistic to optimize thresholding to:
optimize2 = 'prec-rec';

%% calculations:
for i = 1:length(class2opt)
    target = class2opt{i};
    target2 = target;
   
    pp = [sco_path, target2, '\', target2, sco_path_end];

    if ~exist(pp, 'file')  
        % swap in the non-tagged tab if tag tab doesn't exist
        % this should never happen for TAG classes so...
        pp = [sco_path, target2, '\', target2, sco_path_end2];
    end

    if exist(pp, 'file')
        load(pp);

        roict_table.train_counts(isnan(roict_table.train_counts)) = 0;
        
        % remove training set:
        all_score_tab(all_score_tab.trainset_flag == 1, :) = [];
        roict_table.roict = roict_table.roict - roict_table.train_counts;
        roict_table.train_counts = [];

        if size(all_score_tab, 1) > 0
    
            scomat = all_score_tab(: , ~ismember(all_score_tab.Properties.VariableNames, metavar));
            
            [tmpopt, stat_table, allcnn_counts, man_counts, binid] = optimize_CNN_thresholding(scomat, ...
                all_score_tab.mano_anno, target2, all_score_tab.file, ...
                'adhoc', thresh, optimize2, roict_table, 0);
    
            % weird work-around for Bacteriastrum, which has precision and
            % recall of 0 (because very litte mvco validation data...)
            if isempty(tmpopt)
                opt_thresh(:, target2) = array2table(0);
            else
                opt_thresh(:, target2) = array2table(min(tmpopt));
            end
    
            % save the table of statistics vs. threshold value just in case:
            pp = [sco_path, target2, '\', target2, '_adhoc_stat_table.mat'];
            save(pp, "stat_table");
            
            pp = [sco_path, target2, '\', target2, '_adhoc_count_data.mat'];
            save(pp, "allcnn_counts", "man_counts", "binid");

            % doing a multiple threshold run for G. del analysis:
%             [~, stat_table, allcnn_counts, man_counts] = optimize_CNN_thresholding(scomat, ...
%                 all_score_tab.mano_anno, target2, all_score_tab.file, ...
%                 'multi', thresh, optimize2, roict_table);
%             pp = [sco_path, target, '\', target, '_multi_stat_table.mat'];
%             save(pp, "stat_table");
%             
%             pp = [sco_path, target, '\', target, '_multi_count_data.mat'];
%             save(pp, "allcnn_counts", "man_counts");

        end
    else
        disp(['no score table found for ', target]);
    end

    disp(['class ', num2str(i), ' of ', ...
        num2str(length(class2opt)), ' is done']);
end


