function [ ] = plot_timeseries_manual( countfile , daybin_flag, str2plot)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
load(countfile)
maxsubplots = 5;
eval(['x = ' str2plot ';'])
if daybin_flag,
    [matdate_bin, x, ml_analyzed_mat_bin] = make_day_bins(matdate,x, ml_analyzed_mat);
    classind = find(nansum(x));
    make_time_figs(class2use(classind),matdate_bin, x(:,classind)./ml_analyzed_mat_bin(:,classind),maxsubplots); 
else
    classind = find(nansum(x));
    make_time_figs(class2use(classind),matdate, x(:,classind)./ml_analyzed_mat(:,classind),maxsubplots);    
end;


