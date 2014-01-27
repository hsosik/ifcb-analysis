FCB_size_budget

year_list=2006:2012;

Ciliate_Prey_sizeclass



[Total_all_sizeclass1_mat_week, Total_all_sizeclass1_mat_weekstd, mdate_wkmat, yd_wk] =ydmat2weeklymat(Total_all_sizeclass1_mat, year_list);
[smoothclimatology_Total_all_sizeclass1_mat_week, std_Total_all_sizeclass1_mat_week] = smoothed_climatology(Total_all_sizeclass1_mat_week, 1);

figure   %less than 3 microns
plot(yd_wk,Total_all_sizeclass1_mat_week, '*')
hold on
plot(yd_wk, smoothclimatology_Total_all_sizeclass1_mat_week, '-r')
plot(yd_wk, (smoothclimatology_Total_all_sizeclass1_mat_week+std_Total_all_sizeclass1_mat_week), '-b')
plot(yd_wk, (smoothclimatology_Total_all_sizeclass1_mat_week-std_Total_all_sizeclass1_mat_week), '-b')
title('Size Class 1 - 2week bins')
datetick ('x', 3)
legend('2006', '2007', '2008', '2009', '2010', '2011', '2012');

[Total_all_sizeclass2_mat_week, Total_all_sizeclass2_mat_weekstd, mdate_wkmat, yd_wk] =ydmat2weeklymat(Total_all_sizeclass2_mat, year_list);
[smoothclimatology_Total_all_sizeclass2_mat_week, std_Total_all_sizeclass2_mat_week] = smoothed_climatology(Total_all_sizeclass2_mat_week, 1);

figure %1.5-6 microns
plot(yd_wk,Total_all_sizeclass2_mat_week, '*')
hold on
plot(yd_wk, smoothclimatology_Total_all_sizeclass2_mat_week, '-r')
plot(yd_wk, (smoothclimatology_Total_all_sizeclass2_mat_week+std_Total_all_sizeclass2_mat_week), '-b')
plot(yd_wk, (smoothclimatology_Total_all_sizeclass2_mat_week-std_Total_all_sizeclass2_mat_week), '-b')
title('Size Class 2 - 2week bins')
datetick ('x', 3)
legend('2006', '2007', '2008', '2009', '2010', '2011', '2012');

[Total_all_sizeclass3_mat_week, Total_all_sizeclass3_mat_weekstd, mdate_wkmat, yd_wk] =ydmat2weeklymat(Total_all_sizeclass3_mat, year_list);
[smoothclimatology_Total_all_sizeclass3_mat_week, std_Total_all_sizeclass3_mat_week] = smoothed_climatology(Total_all_sizeclass3_mat_week, 1);

figure %2-9 microns
plot(yd_wk,Total_all_sizeclass3_mat_week, '*')
hold on
plot(yd_wk, smoothclimatology_Total_all_sizeclass3_mat_week, '-r')
plot(yd_wk, (smoothclimatology_Total_all_sizeclass3_mat_week+std_Total_all_sizeclass3_mat_week), '-b')
plot(yd_wk, (smoothclimatology_Total_all_sizeclass3_mat_week-std_Total_all_sizeclass3_mat_week), '-b')
title('Size Class 3 - 2week bins')
datetick ('x', 3)
legend('2006', '2007', '2008', '2009', '2010', '2011', '2012');

[Total_all_sizeclass4_mat_week, Total_all_sizeclass4_mat_weekstd, mdate_wkmat, yd_wk] =ydmat2weeklymat(Total_all_sizeclass4_mat_added, year_list);
[smoothclimatology_Total_all_sizeclass4_mat_week, std_Total_all_sizeclass4_mat_week] = smoothed_climatology(Total_all_sizeclass4_mat_week, 1);

figure %4-12 microns
plot(yd_wk,Total_all_sizeclass4_mat_week, '*')
hold on
plot(yd_wk, smoothclimatology_Total_all_sizeclass4_mat_week, '-r')
plot(yd_wk, (smoothclimatology_Total_all_sizeclass4_mat_week+std_Total_all_sizeclass4_mat_week), '-b')
plot(yd_wk, (smoothclimatology_Total_all_sizeclass4_mat_week-std_Total_all_sizeclass4_mat_week), '-b')
title('Size Class 4 - 2week bins')
datetick ('x', 3)
legend('2006', '2007', '2008', '2009', '2010', '2011', '2012');


[Total_all_sizeclass5_mat_week, Total_all_sizeclass5_mat_weekstd, mdate_wkmat, yd_wk] =ydmat2weeklymat(biovol20_30phyto_mat, year_list);
[smoothclimatology_Total_all_sizeclass5_mat_week, std_Total_all_sizeclass5_mat_week] = smoothed_climatology(Total_all_sizeclass5_mat_week, 1);

figure %12-24 microns
plot(yd_wk,Total_all_sizeclass5_mat_week, '*')
hold on
plot(yd_wk, smoothclimatology_Total_all_sizeclass5_mat_week, '-r')
plot(yd_wk, (smoothclimatology_Total_all_sizeclass5_mat_week+std_Total_all_sizeclass5_mat_week), '-b')
plot(yd_wk, (smoothclimatology_Total_all_sizeclass5_mat_week-std_Total_all_sizeclass5_mat_week), '-b')
title('Size Class 5 - 2week bins')
datetick ('x', 3)
legend('2006', '2007', '2008', '2009', '2010', '2011', '2012');

[Total_all_sizeclass6_mat_week, Total_all_sizeclass6_mat_weekstd, mdate_wkmat, yd_wk] =ydmat2weeklymat(biovol30_40phyto_mat, year_list);
[smoothclimatology_Total_all_sizeclass6_mat_week, std_Total_all_sizeclass6_mat_week] = smoothed_climatology(Total_all_sizeclass6_mat_week, 1);

figure %24-80 microns
plot(yd_wk,Total_all_sizeclass6_mat_week, '*')
hold on
plot(yd_wk, smoothclimatology_Total_all_sizeclass6_mat_week, '-r')
plot(yd_wk, (smoothclimatology_Total_all_sizeclass6_mat_week+std_Total_all_sizeclass6_mat_week), '-b')
plot(yd_wk, (smoothclimatology_Total_all_sizeclass6_mat_week-std_Total_all_sizeclass6_mat_week), '-b')
title('Size Class 6 - 2week bins')
datetick ('x', 3)
legend('2006', '2007', '2008', '2009', '2010', '2011', '2012');

Large_Total= Total_all_sizeclass6_mat_week +Total_all_sizeclass5_mat_week;
[smoothclimatology_Large_Total, std_Large_Total] = smoothed_climatology(Large_Total, 1);

figure %12-80 microns
plot(yd_wk, Large_Total, '*')
hold on
plot(yd_wk, smoothclimatology_Large_Total, '-r')
plot(yd_wk, (smoothclimatology_Large_Total + std_Large_Total), '-b')
plot(yd_wk, (smoothclimatology_Large_Total - std_Large_Total), '-b')
title('Size Class Large - 2week bins')
datetick ('x', 3)
legend('2006', '2007', '2008', '2009', '2010', '2011', '2012');



% Sizeclass1_mean = nanmean(Total_all_sizeclass1_mat,2);
% Sizeclass1_anom = Total_all_sizeclass1_mat - repmat(Sizeclass1_mean,1,length(year_list));
% Sizeclass2_mean = nanmean(Total_all_sizeclass2_mat,2);
% Sizeclass2_anom = Total_all_sizeclass2_mat - repmat(Sizeclass2_mean,1,length(year_list));
% Sizeclass3_mean = nanmean(Total_all_sizeclass3_mat,2);
% Sizeclass3_anom = Total_all_sizeclass3_mat - repmat(Sizeclass3_mean,1,length(year_list));
% Sizeclass4_mean = nanmean(Total_all_sizeclass4_mat,2);
% Sizeclass4_anom = Total_all_sizeclass4_mat - repmat(Sizeclass4_mean,1,length(year_list));
% phyto12_20_mean = nanmean(biovol40_infphyto_mat,2);
% phyto12_20_anom = biovol40_infphyto_mat - repmat(phyto12_20_mean,1,length(year_list));


% xanom = Sizeclass4_anom;
% yanom = phyto12_20_anom;
% subplotwidth = 4;
% month_bins = (1:12)';
% [r,slope,n,p,r_sig,slope_sig] = anomaly_corr(xanom, yanom, yd, month_bins, subplotwidth, year_list);
% set(gcf,'position',[405 80 900 585])


% t= nanmean(ciliate_all_biovol_fraction0_10_week, 2);
% t_2=nanmean(ciliate_all_biovol_fraction10_20_week, 2);
% t_3=nanmean(ciliate_all_biovol_fraction20_30_week, 2);
% t_4=nanmean(ciliate_all_biovol_fraction30_40_week, 2);
% t_5=nanmean(ciliate_all_biovol_fraction40_inf_week, 2);
% figure
% bar(yd_wk, [t, t_2, t_3, t_4, t_5], 'stacked')
% title('All Ciliate Biovol Fraction- bi-weekly bins')
% datetick ('x', 3)
% xlim([0 370]);
% legend('0-10', '10-20', '20-30', '30-40', '40-inf')
% 
% r= nanmean(ciliate_all_biovol0_10_week, 2);
% r_2=nanmean(ciliate_all_biovol10_20_week, 2);
% r_3=nanmean(ciliate_all_biovol20_30_week, 2);
% r_4=nanmean(ciliate_all_biovol30_40_week, 2);
% r_5=nanmean(ciliate_all_biovol40_inf_week, 2);
% figure
% bar(yd_wk, [r, r_2, r_3, r_4, r_5], 'stacked')
% title('All Ciliate Total Biovol - bi-weekly bins')
% datetick ('x', 3)
% xlim([0 370]);
% legend('0-10', '10-20', '20-30', '30-40', '40-inf')

clear Total_2006_sizeclass1 Total_2007_sizeclass1 Total_2008_sizeclass1 Total_2009_sizeclass1 Total_2010_sizeclass1 Total_2011_sizeclass1 Total_2012_sizeclass1
clear Total_2006_sizeclass2 Total_2007_sizeclass2 Total_2008_sizeclass2 Total_2009_sizeclass2 Total_2010_sizeclass2 Total_2011_sizeclass2 Total_2012_sizeclass2
clear Total_2006_sizeclass3 Total_2007_sizeclass3 Total_2008_sizeclass3 Total_2009_sizeclass3 Total_2010_sizeclass3 Total_2011_sizeclass3 Total_2012_sizeclass3
clear Total_2006_sizeclass4 Total_2007_sizeclass4 Total_2008_sizeclass4 Total_2009_sizeclass4 Total_2010_sizeclass4 Total_2011_sizeclass4 Total_2012_sizeclass4
clear Total_2006_sizeclass5 Total_2007_sizeclass5 Total_2008_sizeclass5 Total_2009_sizeclass5 Total_2010_sizeclass5 Total_2011_sizeclass5 Total_2012_sizeclass5
clear Total_all_sizeclass1 Total_all_sizeclass2 Total_all_sizeclass3 Total_all_sizeclass4 Total_all_sizeclass5
clear sizeclass* ans Total_all_mdate Sizeclass*