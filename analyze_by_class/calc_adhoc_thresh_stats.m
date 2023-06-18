function [r2, m, b, prec, pdet, f1, fpr, acc, allcnn_counts, manct, binid] = calc_adhoc_thresh_stats(man, target, scores, threshold, binid, roict_table)
% this is a helper function that calculates statistics for adhoc
% thresholding approach. see optimize_CNN_thresholding.m
% written by D. Catlett
% 
% INPUTS:
% 1) man = a table or cell array of human/"true" class labels
% 2) target = a string indicating the target class to compute validation
% statistics for
% 3) scores = table with classes as variable names and corresponding CNN 
% scores across all roi's (rows)
% 4) threshold = a scalar or vector of cnn score threshold(s) to apply in 
% calculations 
% 5) binid = cell array of bin ids for each row of scores
% 6) roict_table = roi count table output by dylan_get_cnn_score_table2

if istable(man)
    man = table2cell(man);
end

if istable(binid)
    binid = table2cell(binid);
end

% get total rois for calculation of true negatives:
totrois = sum(roict_table.roict);

% convert class and man to numeric code (index in scores):
target_idx = find(ismember(scores.Properties.VariableNames, target));
mannum = zeros(length(man),1);
mannum(ismember(man, target)) = target_idx;

scomat = table2array(scores); % score matrix
[~, topclassidx] = max(scomat, [], 2); % col index of top class in scomat
topclassidx_lin = sub2ind(size(scomat), (1:size(scomat,1)).', topclassidx);
topclasssco = scomat(topclassidx_lin);
target_sco = scomat(:, target_idx);

ubins = unique(roict_table.file);

% initialize your variables:
manct = nan(length(ubins), 1); 
allcnn_counts = nan(length(ubins), 1);
r2 = nan(length(threshold), 1);
m = r2; b = r2;
% target_rois = cell(length(threshold), 1);
tp = nan(length(threshold), 1); 
un = tp; mis = tp; fn = tp; fp = tp; tn = tp;
% tp2 = tp; fp2 = tp; target_count_diff = tp; % these are for checking threshold classification approach
for i = 1:length(threshold)
    tt = threshold(i);

    % flag if multiple wins:
%     ttt = repmat(tt, size(scomat));
%     win = (scomat > ttt);
%     ind = find(sum(win')>1);
%     if ~isempty(ind)
%         error('its your worst nightmare, you can''t find the opt thresh!!!')
%     end

    % true positives:
    tpidx = topclassidx == target_idx & mannum == target_idx & topclasssco > tt; % where the top CNN class = manual and score above tt
    tp(i) = sum(tpidx); 

    % a 2nd tp where the assignment doesn't need to be top-scoring:
%     tpidx2 = mannum == target_idx & target_sco > tt;
%     tp2(i) = sum(tpidx2);

    % false positives:
    fpidx = topclassidx == target_idx & mannum ~= target_idx & topclasssco > tt; % where top CNN class ~= manual and score above tt
    fp(i) = sum(fpidx);

    % a 2nd fp where the assignment doesn't need to be top-scoring:
%     fpidx2 = mannum ~= target_idx & target_sco > tt;
%     fp2(i) = sum(fpidx2);

    % target count diff is the difference in tp2+fp2 and tp+fp:
%     target_count_diff(i) = (tp(i) + fp(i)) - (tp2(i) + fp2(i));

    % store target rois (tps and fps) (new addition Dec. 2022):
%     roi_str = cellstr(num2str(roiid));
%     roi_str = cellfun(@(x) strrep(x, ' ', '0'), roi_str, 'UniformOutput', false);   
%     target_rois{i} = cat(1, strcat(binid(tpidx), '_', roi_str(tpidx)), strcat(binid(fpidx), '_', roi_str(fpidx)));

    % false negatives:
    % misclassification errors (where the top-scoring class was not the 
    % target and the score was high enough):
    misidx = topclassidx ~= target_idx & mannum == target_idx & topclasssco > tt; % where top CNN class ~= manual
    mis(i) = sum(misidx); % total misclassifications at this threshold

    % unclassification errors (where the top-scoring class was the target
    % but the score wasn't high enough)
%     unidx = topclassidx == target_idx & mannum == target_idx &
%     topclasssco <= tt; oops! top scoring doesn't matter for unclassified.
    unidx = mannum == target_idx & topclasssco <= tt; 
    un(i) = sum(unidx); % unknown false negative is where top score was this class but didn't meet threshold

    fn(i) = mis(i) + un(i);
    if fn(i) + tp(i) ~= sum(mannum == target_idx)
        error('calculations are off. its not you, its me');
    end

    % true negatives are the total rois in the data set minus tp, fn, and
    % fp:
    tn(i) = totrois - (fn(i) + tp(i) + fp(i)); 

    % get counts per bin:
    for j = 1:length(ubins)
        scoidx = ismember(binid, ubins{j}); % index of bin j in scores
        
        % manual (reducing repetition with i = 1...)
        if i == 1
            if all(~scoidx) 
                manct(j,1) = 0;
            else
                manct(j,1) = sum(mannum(scoidx) == target_idx);
            end
        end

        % CNN:
        if all(~scoidx) 
            % if they're all missing set both counts to 0
            allcnn_counts(j, i) = 0;
        else
            ctidx = find(topclassidx(scoidx) == target_idx & topclasssco(scoidx) > tt);
            allcnn_counts(j, i) = length(ctidx);
        end
    end
    
    linmdl = fitlm(manct, allcnn_counts(:,i));
    r2(i) = linmdl.Rsquared.Ordinary;
    m(i) = linmdl.Coefficients.Estimate(2);
    b(i) = linmdl.Coefficients.Estimate(1);
end

pdet = tp ./ (tp + fn); % prob of detection/recall/true positive rate
prec = tp ./ (tp + fp); % precision
fpr = fp ./ (fp + tn); % false positive rate
acc = ( tp + tn ) ./ ( tp + fp + tn + fn ); % accuracy
f1 = (2 .* prec .* pdet) ./ (prec + pdet) ;
binid = ubins;
