function [ ] = plot_timeseries_manual( countfile , daybin_flag)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
load(countfile)
maxsubplots = 5;
classind = find(nansum(classcount));
if daybin_flag,
    [matdate_bin, classcount_bin, ml_analyzed_mat_bin] = make_day_bins(matdate,classcount, ml_analyzed_mat);
    %save([countfile '_day'], 'matdate_bin', 'classcount_bin', 'ml_analyzed_mat_bin', 'class2use')
    make_time_figs(class2use(classind),matdate_bin, classcount_bin(:,classind)./ml_analyzed_mat_bin(:,classind),maxsubplots); 
else
    make_time_figs(class2use(classind),matdate, classcount(:,classind)./ml_analyzed_mat(:,classind),maxsubplots);    
end;


