function [opt_thresh] = optimize_my_stat_tab(thresh_stat_table, optimize2)
% this is a helper function that finds the optimum threshold parameters 
% based on pre-calculated statistics. see optimize_CNN_thresholding.m
% written by D. Catlett
% 
% INPUTS:
% 1) thresh_stat_table = a table. one field should be "threshold" and 
% include threshold values, or for multi approaches "primary_" and 
% "secondary_threshold". Other fields should include statistics that 
% illustrate the performance of classifier at each threshold values. 
% Currently supported are: 
% linear regression statistics (r2, slope, yint), precision, recall, f1 
% statistic (harmonic mean of precision and recall), and mean or median 
% error and absolute error.
%  
% 2) optimize2 = one of the following:
% (1) 'linreg_composite' = finds optimum threshold based on getting all 3
% linear regression statistics (r2, slope, yint) as close as possible to
% their optimum values (r2 = 1, slope = 1, yint = 0). In other words it
% minimizes this expression: (1-r2) + abs(1-slope) + abs(yint)
% (1a) 'linreg_composite_std' = normalizes linear regression statistics prior 
% to compositing. So it's (1-r2)/sum(1-r2), abs(yint)/sum(abs(yint)), and 
% abs(1-slope)/sum(abs(1-slope))) that's minimized. 
% (1b) 'linreg_composite_std2' = normalizes linear regression statistics prior 
% to compositing. So it's (1-r2)/sum(1-r2), abs(yint)/sum(abs(yint)), and 
% abs(1-slope) that's minimized. 
% (2) 'r2' = optimum threshold value is that which gives max(r2)
% (3) 'slope' = optimum threshold value is that which gives
% min(abs(1-slope))
% (4) 'yint' = optimum threshold value is that which gives min(abs(yint))
% (5) 'precision' = optimum threshold value is that which gives
% max(precision)
% (6) 'recall' = optimum threshold value is that which gives max(recall)
% (7) 'f1' = optimum threshold value is that which gives max(f1), where f1
% is 2 * ( (precision * recall) / (precision + recall) )
% (8) 'prec_rec_composite' = optimum threshold value is that which gives 
% max(recall + precision).. this may give you the same answer as f1.. not
% sure.
% (9) 'mean_error' = optimum threshold value is that which gives
% min(mean_error). You can swap mean for median here and/or write
% 'mean_abs_error' to do absolute error, and again swap mean for median in
% that scenario as well.
% (10) 'accuracy' = optimum threshold value is that which gives
% max(accuracy). accuracy = (tp + tn) ./ (tp + tn + fp + fn)
% (11) 'fpr' = optimum threshold value is that which gives min(fpr), where
% fpr is the false positive rate. 
% (12) prec-rec = optimum threshold is that which minimizes the difference
% between precision and recall

thresh = table2array(thresh_stat_table(: , ...
    contains(thresh_stat_table.Properties.VariableNames, 'threshold')));

if strcmp(optimize2, 'linreg_composite')

    r2 = thresh_stat_table.r2;
    slope = thresh_stat_table.slope;
    yint = thresh_stat_table.yint;
    optstat = (1-r2) + abs(1-slope) + abs(yint);
    opt_thresh = thresh(optstat == min(optstat),:);

elseif strcmp(optimize2, 'linreg_composite_std') && size(thresh,1) > 1

    r2 = thresh_stat_table.r2;
    slope = thresh_stat_table.slope;
    yint = thresh_stat_table.yint;
    optstat = (1-r2) + (abs(1-slope) ./ sum(abs(1-slope))) + ( abs(yint) ./ sum(abs(yint)) );
    opt_thresh = thresh(optstat == min(optstat),:);

elseif strcmp(optimize2, 'linreg_composite_std2') && size(thresh,1) > 1

    r2 = thresh_stat_table.r2;
    slope = thresh_stat_table.slope;
    yint = thresh_stat_table.yint;
    optstat = (1-r2) + abs(1-slope) + ( abs(yint) ./ sum(abs(yint)) );
    opt_thresh = thresh(optstat == min(optstat),:);

elseif contains(optimize2, 'linreg_composite_std') && size(thresh,1) == 1

    warning('stats only available for one threshold combo. optimizing to linreg_composite and NOT linreg_composite_std');
    r2 = thresh_stat_table.r2;
    slope = thresh_stat_table.slope;
    yint = thresh_stat_table.yint;
    optstat = (1-r2) + abs(1-slope) + abs(yint);
    opt_thresh = thresh(optstat == min(optstat),:);

elseif strcmp(optimize2, 'r2')

    r2 = thresh_stat_table.r2;
    opt_thresh = thresh(r2 == max(r2),:);

elseif strcmp(optimize2, 'slope')

    slope = thresh_stat_table.slope;
    optstat = abs(1-slope);
    opt_thresh = thresh(optstat == min(optstat),:);

elseif strcmp(optimize2, 'yint')

    yint = thresh_stat_table.yint;
    optstat = abs(yint);
    opt_thresh = thresh(optstat == min(optstat),:);

elseif strcmp(optimize2, 'precision')

    precision = thresh_stat_table.precision;
    opt_thresh = thresh(precision == max(precision),:);

elseif strcmp(optimize2, 'recall')

    recall = thresh_stat_table.recall;
    opt_thresh = thresh(recall == max(recall),:);

elseif strcmp(optimize2, 'f1')

    precision = thresh_stat_table.precision;
    recall = thresh_stat_table.recall;
    optstat = 2 .* ( (precision .* recall) ./ (precision + recall) );
    opt_thresh = thresh(optstat == max(optstat),:);

elseif strcmp(optimize2, 'prec-rec')

     precision = thresh_stat_table.precision;
    recall = thresh_stat_table.recall;
    optstat = abs(precision-recall);
    opt_thresh = thresh(optstat == min(optstat),:);

elseif strcmp(optimize2, 'prec_rec_composite')

    precision = thresh_stat_table.precision;
    recall = thresh_stat_table.recall;
    optstat = precision + recall;
    opt_thresh = thresh(optstat == max(optstat),:);

elseif strcmp(optimize2, 'mean_error')

    optstat = abs(thresh_stat_table.mean_error);
    opt_thresh = thresh(optstat == min(optstat),:);

elseif strcmp(optimize2, 'median_error')

    optstat = abs(thresh_stat_table.median_error);
    opt_thresh = thresh(optstat == min(optstat),:);
    
elseif strcmp(optimize2, 'mean_abs_error')

    optstat = thresh_stat_table.mean_abs_error;
    opt_thresh = thresh(optstat == min(optstat),:);

elseif strcmp(optimize2, 'median_abs_error')

    optstat = thresh_stat_table.median_abs_error;
    opt_thresh = thresh(optstat == min(optstat),:);

elseif strcmp(optimize2, 'accuracy')

    optstat = thresh_stat_table.accuracy;
    opt_thresh = thresh(optstat == max(optstat),:);

elseif strcmp(optimize2, 'fpr')

    optstat = thresh_stat_table.FP_rate;
    opt_thresh = thresh(optstat == min(optstat),:);    
    
else

    error('no valid optimization statistic provided')
end

