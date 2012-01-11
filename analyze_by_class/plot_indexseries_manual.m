function [ ] = plot_indexseries_manual( countfile )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
load(countfile)
[matdate_bin, classcount_bin, ml_analyzed_mat_bin] = make_day_bins(matdate,classcount, ml_analyzed_mat);
save([countfile '_day'], 'matdate_bin', 'classcount_bin', 'ml_analyzed_mat_bin', 'class2use')
maxsubplots = 5;
classind = find(nansum(classcount));
make_indexseries_figs(class2use(classind),classcount(:,classind)./ml_analyzed_mat(:,classind),maxsubplots); 
%make_time_figs(class2use(classind),matdate_bin, classcount_bin(:,classind)./ml_analyzed_mat_bin(:,classind),maxsubplots); 

