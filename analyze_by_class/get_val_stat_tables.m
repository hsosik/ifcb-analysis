function [val_stat_table] = get_val_stat_tables(stat_path, classes2get, groups2get, optthresh_class, optthresh_group)
% creates a table summarizing precision, recall, and f1 for each class and
% group specified. Does so by looping over stat tables in class and group 
% sub-directories within stat_path.
% returns statistics for no threshold and optthreshold CNN score threshold
% values
% INPUTS:
% (1) stat_path is a string with the path to parent directory where stat
% tables are kept. Use
% '\\sosiknas1\Lab_data\dylan_working\cnn_score_data_byClass\' at time of 
% writing.
% (2) classes2get is a cell array of class names
% (3) groups2get is a cell array of group names
% (4) optthresh_class is a vector of optthresh values for each entry in
% classes2get
% (5) optthresh_group is a vector of optthresh values for each entry in
% groups2get

if size(classes2get, 1) ~= 1
    classes2get = classes2get';
end
if size(groups2get, 1) ~= 1
    groups2get = groups2get';
end
if size(optthresh_class, 1) ~= 1
    optthresh_class = optthresh_class';
end
if size(optthresh_group, 1) ~= 1
    optthresh_group = optthresh_group';
end

tax2get = cat(2, classes2get, groups2get);
optthresh = cat(2, optthresh_class, optthresh_group);

prec = nan(2, length(tax2get)); % first row no thresh, 2nd optthresh
rec = prec;
f1 = prec;
for i = 1:length(tax2get)
    tt = tax2get{i};

    pp = [stat_path, tt, '\', tt, '_adhoc_stat_table.mat'];
    pp2 = [stat_path, tt, '\', tt, '_adhoc_stat_table_groupsum.mat'];
    if exist(pp, 'file')
        load(pp, "stat_table");
    
        prec(1, i) = stat_table.precision(stat_table.threshold == 0);
    
        rec(1, i) = stat_table.recall(stat_table.threshold == 0);
    
        f1(1, i) = stat_table.f1(stat_table.threshold == 0);
    
        if isnan(optthresh(i))
            % leave nan's there
        else
            prec(2, i) = stat_table.precision(stat_table.threshold == optthresh(i));
            rec(2, i) = stat_table.recall(stat_table.threshold == optthresh(i));
            f1(2, i) = stat_table.f1(stat_table.threshold == optthresh(i));
        end
    elseif exist(pp2, 'file')
        load(pp2, "stat_table");
    
        prec(1, i) = stat_table.precision(stat_table.threshold == 0);
    
        rec(1, i) = stat_table.recall(stat_table.threshold == 0);
    
        f1(1, i) = stat_table.f1(stat_table.threshold == 0);
    
        if isnan(optthresh(i))
            % leave nan's there
        else
            prec(2, i) = stat_table.precision(stat_table.threshold == optthresh(i));
            rec(2, i) = stat_table.recall(stat_table.threshold == optthresh(i));
            f1(2, i) = stat_table.f1(stat_table.threshold == optthresh(i));
        end
    end

end

rn = {'no_thresh_precision', 'opt_thresh_precision', 'no_thresh_recall',...
    'opt_thresh_recall', 'no_thresh_f1', 'opt_thresh_f1'};
val_stat_table = array2table([prec; rec; f1], ...
    "RowNames", rn, "VariableNames", tax2get);

end