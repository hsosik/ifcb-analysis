function [opt_thresh, stat_table, allcnn_counts, manct, binid] = optimize_CNN_thresholding(scores, man, target, binid, ...
    thresh_approach, thresh, optimize2, roict_table, hierarchy)
% this function estimates an optimum CNN score threshold value for a 
% particular image class based on minimizing or maximizing some evaluation
% statistic (see optimize_my_stat_tab.m for currently available statistics). You
% can do this by performing calculations on the whole data set you provide,
% or by cross-validation where a mean optimum threshold value is calculated
% after optimizing on random subsets of the input data. 
% 
% INPUTS:
% 
% 1) scores = roi X class table of CNN scoress with variable names
% corresponding to image classes included in the CNN
% 
% 2) man = roi X 1 cell array or table of manual annotations for 
% corresponding rows/rois in scores
% 
% 3) target = string indicating the class (one of the variable names in
% scores) you'd like to target for the optimization 
% 
% 4) binid = roi X 1 cell array of the corresponding bin id for each roi
% 
% 5) thresh_approach [not useful; must be 'adhoc']
% previously one of the following: 'top', 'adhoc', 'multi'. 'top'
% classifies each roi as the class with the highest score. 'adhoc' requires
% that the highest score be > the value(s) in thresh. 'multi' requires that
% the highest score be > one thresh value (primary threshold) and all other
% scores be < a second thresh value (secondary threshold). 
% 
% 6) thresh = a vector or matrix of the score threshold values you'd like 
% to test. Set to 0 if thresh_approach is 'top'. If thresh_approach is
% 'adhoc', should be a vector. If thresh_approach is 'multi', one dimension
% should have length = 2, where the first row/column is the primary 
% threshold and the second row/column is the secondary threshold (see
% thresh_approach description). If neither dimension is length 2, all 
% combinations of the values provided will be assessed by doing the 
% following: 
% [p,q] = meshgrid(thresh, thresh);
% thresh = [p(:) q(:)];
% 
% 7) optimize2 = a string indicating what statistic you'd like to optimize 
% to. See optimize_my_stat_tab.m for details of what's available.
% 
% 8) roict_table = a unique(binid) X 3 table with fields file (matching 
% those in binid), roict that provides the total number of roi's sampled
% in each bin, and train_counts that provides the number of CNN training 
% roi's in each bin. This is needed for statistics reliant on true 
% negatives
% 
% OUTPUT VARIABLES:
% 
% 1) opt_thresh = the optimized threshold value(s). If cross-validations are
% performed, this is the mode of the optimum threshold values determined 
% across all cross-validations 
% 
% 2) stat_table = a table of statistics including bin x bin linear regression
% statistics and mean and median (absolute) errors, and classifier
% precision and recall, for each value of threshold. 
% 
% 3-5) allcnn_counts, manct, binid = see calc_adhoc_thresh_stats.m. 
% 
%
% written by D. Catlett

% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
% THE FUNCTION:

% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
% pre-processing:

% account for thresh_approach:
if strcmp(thresh_approach, 'top')
    % top by definition has a threshold of 0.
    thresh = 0;
elseif strcmp(thresh_approach, 'multi')
    % ensure that it's an n x 2 matrix always
    if size(thresh,1) ~= 2 && size(thresh,2) ~= 2
        warning('you specified the multi thresh_approach without providing two thresholds. SHAME. Jk its fine I''ll do it for you.')
        [p,q] = meshgrid(thresh, thresh);
        thresh = [p(:) q(:)];
        
        % remove where secondary threshold == 0 as this is not a realistic
        % criterion and it results in undefined eval stats:
        thresh(thresh(:,2) == 0, :) = [];
    elseif size(thresh_approach,1) == 2 && size(thresh,2) ~= 2
        thresh = thresh';
        thresh(thresh(:,2) == 0, :) = [];
    else
        thresh(thresh(:,2) == 0, :) = [];
    end
end


% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
% calculations:

if strcmp(thresh_approach, 'top') || strcmp(thresh_approach, 'adhoc')
    if hierarchy == 0
        % run adhoc fcn:
        [r2, m, b, prec, pdet, f1, fpr, acc, allcnn_counts, manct, binid] = calc_adhoc_thresh_stats(man, target, scores, thresh, binid, roict_table);
    else
        % run adhoc hierarchy fcn:
        [r2, m, b, prec, pdet, f1, fpr, acc, allcnn_counts, manct, binid] = calc_adhoc_thresh_stats_hierarchy(man, target, scores, thresh, binid, roict_table, hierarchy);
    end
elseif strcmp(thresh_approach, 'multi')
    % run multi-threshold fcn:
    [r2, m, b, prec, pdet, f1, fpr, acc, allcnn_counts, manct] = calc_multi_thresh_stats(man, target, scores, thresh, binid, roict_table);
end

% calculate mean/median (absolute) errors:
err = allcnn_counts - manct;
meanerr = mean(err)';
medianerr = median(err)';
mean_abs_err = mean(abs(err))';
median_abs_err = median(abs(err))';

% "table" all your statistics:
if strcmp(thresh_approach, 'adhoc') || strcmp(thresh_approach, 'top')
    % I'm not sure this will always work but I think it will.
    if size(thresh,1) < size(thresh,2)
        thresh = thresh';
    end

    stat_table = table(thresh, r2, m, b, prec, pdet, f1, acc, fpr, meanerr, ...
        medianerr, mean_abs_err, median_abs_err,  'VariableNames', ...
        {'threshold', 'r2', 'slope', 'yint', 'precision', 'recall', 'f1', 'accuracy', 'FP_rate',...
        'mean_error', 'median_error', 'mean_abs_error', 'median_abs_error'});
elseif strcmp(thresh_approach, 'multi')
    stat_table = table(thresh(:,1), thresh(:,2), r2, m, b, prec, pdet, f1, acc, fpr, meanerr, ...
        medianerr, mean_abs_err, median_abs_err, 'VariableNames', ...
        {'primary_threshold', 'secondary_threshold', 'r2', 'slope', 'yint', 'precision', 'recall', 'f1', ...
         'accuracy', 'FP_rate','mean_error', 'median_error', 'mean_abs_error', 'median_abs_error'});
end
% feed the optimizer to find the optimized threshold value:
opt_thresh = optimize_my_stat_tab(stat_table, optimize2);


