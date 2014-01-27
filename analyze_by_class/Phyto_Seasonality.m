




[ciliate_all_biovol_fraction0_10_week, ciliate_all_biovol_fraction0_10weekstd, mdate_wkmat, yd_wk] =ydmat2weeklymat(ciliate_all_biovol_fraction0_10, yearlist);
%[ciliate_all_biovol0_10_week, ciliate_all_biovol0_10weekstd, mdate_wkmat, yd_wk] =ydmat2weeklymat(biovol0_10ciliate_all_mat, yearlist);
%ciliate_all_biovol_fraction0_10_weekmean= nanmean(ciliate_all_biovol_fraction0_10_week, 2);
[smoothclimatology_ciliate_all_fraction0_10_weekly, std_ciliate_all_fraction0_10_weekly] = smoothed_climatology(ciliate_all_biovol_fraction0_10_week, 1);
%[smoothclimatology_ciliate_all0_10_weekly, std_ciliate_all0_10_weekly] = smoothed_climatology(ciliate_all_biovol0_10_week, 10);

figure
plot(yd_wk,ciliate_all_biovol_fraction0_10_week, '*')
%plot(yd_wk,ciliate_all_biovol0_10_week, '*r')
hold on
plot(yd_wk, smoothclimatology_ciliate_all_fraction0_10_weekly, '-r')
%plot(yd_wk, smoothclimatology_ciliate_all0_10_weekly, '-r')
plot(yd_wk, (smoothclimatology_ciliate_all_fraction0_10_weekly+std_ciliate_all_fraction0_10_weekly), '-b')
%plot(yd_wk, (smoothclimatology_ciliate_all0_10_weekly+std_ciliate0_10_weekly), '-b')
plot(yd_wk, (smoothclimatology_ciliate_all_fraction0_10_weekly-std_ciliate_all_fraction0_10_weekly), '-b')
%plot(yd_wk, (smoothclimatology_ciliate_all0_10_weekly-std_ciliate0_10_weekly), '-b')
title('0-10 fraction weekly')
%title('0-10 fraction bi-weekly')
%title('0-10 weekly total biovolume')
datetick ('x', 3)



%[phyto_biovol_fraction10_20_week, phyto_biovol_fraction10_20weekstd, mdate_wkmat, yd_wk]=ydmat2weeklymat(phyto_biovol_fraction10_20, yearlist);
[phyto_biovol40_inf_week, phyto_biovol40_infweekstd, mdate_wkmat, yd_wk] =ydmat2weeklymat(biovol40_infphyto_mat, yearlist);
%ciliate_all_biovol_fraction10_20_weekmean= nanmean(ciliate_all_biovol_fraction10_20_week, 2);
%[smoothclimatology_phyto_fraction10_20_weekly, std_phtyo_fraction10_20_weekly] = smoothed_climatology(phyto_biovol_fraction10_20_week, 1);
[smoothclimatology_phyto40_inf_weekly, std_phyto40_inf_weekly] = smoothed_climatology(phyto_biovol40_inf_week, 1);

figure
%plot(yd_wk,phyto_biovol_fraction10_20_week, '*')
plot(yd_wk,phyto_biovol40_inf_week, '*')
hold on
%plot(yd_wk, smoothclimatology_phyto_fraction10_20_weekly, '-r')
plot(yd_wk, smoothclimatology_phyto40_inf_weekly, '-r')
%plot(yd_wk, (smoothclimatology_phyto_fraction10_20_weekly+std_phtyo_fraction10_20_weekly), '-b')
plot(yd_wk, (smoothclimatology_phyto40_inf_weekly+std_phyto40_inf_weekly), '-b')
%plot(yd_wk, (smoothclimatology_phyto_fraction10_20_weekly-std_phtyo_fraction10_20_weekly), '-b')
plot(yd_wk, (smoothclimatology_phyto40_inf_weekly-std_phyto40_inf_weekly), '-b')
%title('10-20 fraction weekly')
%title('10-20 fraction bi-weekly')
title('12-20 weekly total biovolume')
datetick ('x', 3)


[ciliate_all_biovol_fraction20_30_week, ciliate_all_biovol_fraction20_30weekstd]=ydmat2weeklymat(ciliate_all_biovol_fraction20_30, yearlist);
%[ciliate_all_biovol20_30_week, ciliate_all_biovol20_30weekstd, mdate_wkmat, yd_wk] =ydmat2weeklymat(biovol20_30ciliate_all_mat, yearlist);
%ciliate_all_biovol_fraction20_30_weekmean= nanmean(ciliate_all_biovol_fraction20_30_week, 2);
[smoothclimatology_ciliate_all_fraction20_30_weekly, std_ciliate_all_fraction20_30_weekly] = smoothed_climatology(ciliate_all_biovol_fraction20_30_week, 1);
%[smoothclimatology_ciliate_all20_30_weekly, std_ciliate_all20_30_weekly] = smoothed_climatology(ciliate_all_biovol20_30_week, 10);

figure
plot(yd_wk,ciliate_all_biovol_fraction20_30_week, '*')
%plot(yd_wk,ciliate_all_biovol20_30_week, '*r')
hold on
plot(yd_wk, smoothclimatology_ciliate_all_fraction20_30_weekly, '-r')
%plot(yd_wk, smoothclimatology_ciliate_all20_30_weekly, '-r')
plot(yd_wk, (smoothclimatology_ciliate_all_fraction20_30_weekly+std_ciliate_all_fraction20_30_weekly), '-b')
%plot(yd_wk, (smoothclimatology_ciliate_all20_30_weekly+std_ciliate_all20_30_weekly), '-b')
plot(yd_wk, (smoothclimatology_ciliate_all_fraction20_30_weekly-std_ciliate_all_fraction20_30_weekly), '-b')
%plot(yd_wk, (smoothclimatology_ciliate_all20_30_weekly-std_ciliate_all20_30_weekly), '-b')
title('20-30 fraction weekly')
%title('20-30 fraction bi-weekly')
%title('20-30 weekly total biovolume')
datetick ('x', 3)


[ciliate_all_biovol_fraction30_40_week, ciliate_all_biovol_fraction30_40weekstd, mdate_wkmat, yd_wk]=ydmat2weeklymat(ciliate_all_biovol_fraction30_40, yearlist);
%[ciliate_all_biovol30_40_week, ciliate_all_biovol30_40weekstd, mdate_wkmat, yd_wk] =ydmat2weeklymat(biovol30_40ciliate_all_mat, yearlist);
%ciliate_all_biovol_fraction30_40_weekmean= nanmean(ciliate_all_biovol_fraction30_40_week, 2);
[smoothclimatology_ciliate_all_fraction30_40_weekly, std_ciliate_all_fraction30_40_weekly] = smoothed_climatology(ciliate_all_biovol_fraction30_40_week, 1);
%[smoothclimatology_ciliate_all30_40_weekly, std_ciliate_all30_40_weekly] = smoothed_climatology(ciliate_all_biovol30_40_week, 10);
figure
plot(yd_wk,ciliate_all_biovol_fraction30_40_week, '*')
%plot(yd_wk,ciliate_all_biovol30_40_week, '*r')
hold on
plot(yd_wk, smoothclimatology_ciliate_all_fraction30_40_weekly, '-r')
%plot(yd_wk, smoothclimatology_ciliate_all30_40_weekly, '-r')
plot(yd_wk, (smoothclimatology_ciliate_all_fraction30_40_weekly+std_ciliate_all_fraction30_40_weekly), '-b')
%plot(yd_wk, (smoothclimatology_ciliate_all30_40_weekly+std_ciliate30_40_weekly), '-b')
plot(yd_wk, (smoothclimatology_ciliate_all_fraction30_40_weekly-std_ciliate_all_fraction30_40_weekly), '-b')
%plot(yd_wk, (smoothclimatology_ciliate_all30_40_weekly-std_ciliate_all30_40_weekly), '-b')
%plot(yd_wk, ciliate_all_biovol_fraction30_40_weekmean, '-k')
title('30-40 fraction weekly')
%title('30-40 fraction bi-weekly')
%title('30-40 weekly total biovolume')
datetick ('x', 3)


[ciliate_all_biovol_fraction40_inf_week, ciliate_all_biovol_fraction40_infweekstd]=ydmat2weeklymat(ciliate_all_biovol_fraction40_inf, yearlist);
%[ciliate_all_biovol40_inf_week, ciliate_all_biovol40_infweekstd, mdate_wkmat, yd_wk] =ydmat2weeklymat(biovol40_infciliate_all_mat, yearlist);
%ciliate_all_biovol_fraction40_inf_weekmean= nanmean(ciliate_all_biovol_fraction40_inf_week, 2);
[smoothclimatology_ciliate_all_fraction40_inf_weekly, std_ciliate_all_fraction40_inf_weekly] = smoothed_climatology(ciliate_all_biovol_fraction40_inf_week, 1);
%[smoothclimatology_ciliate_all40_inf_weekly, std_ciliate_all40_inf_weekly] = smoothed_climatology(ciliate_all_biovol40_inf_week, 10);

figure
plot(yd_wk,ciliate_all_biovol_fraction40_inf_week, '*')
%plot(yd_wk,ciliate_all_biovol40_inf_week, '*r')
hold on
plot(yd_wk, smoothclimatology_ciliate_all_fraction40_inf_weekly, '-r')
%plot(yd_wk, smoothclimatology_ciliate_all40_inf_weekly, '-r')
plot(yd_wk, (smoothclimatology_ciliate_all_fraction40_inf_weekly+std_ciliate_all_fraction40_inf_weekly), '-b')
%plot(yd_wk, (smoothclimatology_ciliate_all40_inf_weekly+std_ciliate40_inf_weekly), '-b')
plot(yd_wk, (smoothclimatology_ciliate_all_fraction40_inf_weekly-std_ciliate_all_fraction40_inf_weekly), '-b')
%plot(yd_wk, (smoothclimatology_ciliate_all40_inf_weekly-std_ciliate40_inf_weekly), '-b')
title('40-inf fraction weekly')
%title('40-inf fraction bi-weekly')
%title('40-inf weekly total biovolume')
datetick ('x', 3)

t= nanmean(ciliate_all_biovol_fraction0_10_week, 2);
t_2=nanmean(ciliate_all_biovol_fraction10_20_week, 2);
t_3=nanmean(ciliate_all_biovol_fraction20_30_week, 2);
t_4=nanmean(ciliate_all_biovol_fraction30_40_week, 2);
t_5=nanmean(ciliate_all_biovol_fraction40_inf_week, 2);
figure
bar(yd_wk, [t, t_2, t_3, t_4, t_5], 'stacked')
title('All Ciliate Biovol Fraction- bi-weekly bins')
datetick ('x', 3)
xlim([0 370]);
legend('0-10', '10-20', '20-30', '30-40', '40-inf')

r= nanmean(ciliate_all_biovol0_10_week, 2);
r_2=nanmean(ciliate_all_biovol10_20_week, 2);
r_3=nanmean(ciliate_all_biovol20_30_week, 2);
r_4=nanmean(ciliate_all_biovol30_40_week, 2);
r_5=nanmean(ciliate_all_biovol40_inf_week, 2);
figure
bar(yd_wk, [r, r_2, r_3, r_4, r_5], 'stacked')
title('All Ciliate Total Biovol - bi-weekly bins')
datetick ('x', 3)
xlim([0 370]);
legend('0-10', '10-20', '20-30', '30-40', '40-inf')