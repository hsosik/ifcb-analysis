




%[ciliate_biovol_fraction0_10_week, ciliate_biovol_fraction0_10weekstd, mdate_wkmat, yd_wk] =ydmat2weeklymat(ciliate_biovol_fraction0_10, yearlist);
[ciliate_biovol0_10_week, ciliate_biovol0_10weekstd, mdate_wkmat, yd_wk] =ydmat2weeklymat(biovol0_10ciliate_mat, yearlist);
%ciliate_biovol_fraction0_10_weekmean= nanmean(ciliate_biovol_fraction0_10_week, 2);
%[smoothclimatology_ciliate_fraction0_10_weekly, std_ciliate_fraction0_10_weekly] = smoothed_climatology(ciliate_biovol_fraction0_10_week, 10);
[smoothclimatology_ciliate0_10_weekly, std_ciliate0_10_weekly] = smoothed_climatology(ciliate_biovol0_10_week, 1);

figure
%plot(yd_wk,ciliate_biovol_fraction0_10_week, '*r')
plot(yd_wk,ciliate_biovol0_10_week, '*')
hold on
%plot(yd_wk, smoothclimatology_ciliate_fraction0_10_weekly, '-r')
plot(yd_wk, smoothclimatology_ciliate0_10_weekly, '-r')
%plot(yd_wk, (smoothclimatology_ciliate_fraction0_10_weekly+std_ciliate_fraction0_10_weekly), '-b')
plot(yd_wk, (smoothclimatology_ciliate0_10_weekly+std_ciliate0_10_weekly), '-b')
%plot(yd_wk, (smoothclimatology_ciliate_fraction0_10_weekly-std_ciliate_fraction0_10_weekly), '-b')
plot(yd_wk, (smoothclimatology_ciliate0_10_weekly-std_ciliate0_10_weekly), '-b')
%title('0-10 fraction weekly')
title('0-10 fraction bi-weekly')
title('0-10 weekly total biovolume')
datetick ('x', 3)



%[ciliate_biovol_fraction10_20_week, ciliate_biovol_fraction10_20weekstd, mdate_wkmat, yd_wk]=ydmat2weeklymat(ciliate_biovol_fraction10_20, yearlist);
[ciliate_biovol10_20_week, ciliate_biovol10_20weekstd, mdate_wkmat, yd_wk] =ydmat2weeklymat(biovol10_20ciliate_mat, yearlist);
%ciliate_biovol_fraction10_20_weekmean= nanmean(ciliate_biovol_fraction10_20_week, 2);
%[smoothclimatology_ciliate_fraction10_20_weekly, std_ciliate_fraction10_20_weekly] = smoothed_climatology(ciliate_biovol_fraction10_20_week, 10);
[smoothclimatology_ciliate10_20_weekly, std_ciliate10_20_weekly] = smoothed_climatology(ciliate_biovol10_20_week, 1);

figure
%plot(yd_wk,ciliate_biovol_fraction10_20_week, '*r')
plot(yd_wk,ciliate_biovol10_20_week, '*')
hold on
%plot(yd_wk, smoothclimatology_ciliate_fraction10_20_weekly, '-r')
plot(yd_wk, smoothclimatology_ciliate10_20_weekly, '-r')
%plot(yd_wk, (smoothclimatology_ciliate_fraction10_20_weekly+std_ciliate_fraction10_20_weekly), '-b')
plot(yd_wk, (smoothclimatology_ciliate10_20_weekly+std_ciliate10_20_weekly), '-b')
%plot(yd_wk, (smoothclimatology_ciliate_fraction10_20_weekly-std_ciliate_fraction10_20_weekly), '-b')
plot(yd_wk, (smoothclimatology_ciliate10_20_weekly-std_ciliate10_20_weekly), '-b')
%title('10-20 fraction weekly')
title('10-20 fraction bi-weekly')
title('10-20 weekly total biovolume')
datetick ('x', 3)

%[ciliate_biovol_fraction20_30_week, ciliate_biovol_fraction20_30weekstd]=ydmat2weeklymat(ciliate_biovol_fraction20_30, yearlist);
[ciliate_biovol20_30_week, ciliate_biovol20_30weekstd, mdate_wkmat, yd_wk] =ydmat2weeklymat(biovol20_30ciliate_mat, yearlist);
%ciliate_biovol_fraction20_30_weekmean= nanmean(ciliate_biovol_fraction20_30_week, 2);
%[smoothclimatology_ciliate_fraction20_30_weekly, std_ciliate_fraction20_30_weekly] = smoothed_climatology(ciliate_biovol_fraction20_30_week, 10);
[smoothclimatology_ciliate20_30_weekly, std_ciliate20_30_weekly] = smoothed_climatology(ciliate_biovol20_30_week, 1);
figure
%plot(yd_wk,ciliate_biovol_fraction20_30_week, '*r')
plot(yd_wk,ciliate_biovol20_30_week, '*')
hold on
%plot(yd_wk, smoothclimatology_ciliate_fraction20_30_weekly, '-r')
plot(yd_wk, smoothclimatology_ciliate20_30_weekly, '-r')
%plot(yd_wk, (smoothclimatology_ciliate_fraction20_30_weekly+std_ciliate_fraction20_30_weekly), '-b')
plot(yd_wk, (smoothclimatology_ciliate20_30_weekly+std_ciliate20_30_weekly), '-b')
%plot(yd_wk, (smoothclimatology_ciliate_fraction20_30_weekly-std_ciliate_fraction20_30_weekly), '-b')
plot(yd_wk, (smoothclimatology_ciliate20_30_weekly-std_ciliate20_30_weekly), '-b')
%title('20-30 fraction weekly')
%title('20-30 fraction bi-weekly')
title('20-30 weekly total biovolume')
datetick ('x', 3)


%[ciliate_biovol_fraction30_40_week, ciliate_biovol_fraction30_40weekstd, mdate_wkmat, yd_wk]=ydmat2weeklymat(ciliate_biovol_fraction30_40, yearlist);
[ciliate_biovol30_40_week, ciliate_biovol30_40weekstd, mdate_wkmat, yd_wk] =ydmat2weeklymat(biovol30_40ciliate_mat, yearlist);
%ciliate_biovol_fraction30_40_weekmean= nanmean(ciliate_biovol_fraction30_40_week, 2);
%[smoothclimatology_ciliate_fraction30_40_weekly, std_ciliate_fraction30_40_weekly] = smoothed_climatology(ciliate_biovol_fraction30_40_week, 10);
[smoothclimatology_ciliate30_40_weekly, std_ciliate30_40_weekly] = smoothed_climatology(ciliate_biovol30_40_week, 1);

figure
%plot(yd_wk,ciliate_biovol_fraction30_40_week, '*r')
plot(yd_wk,ciliate_biovol30_40_week, '*')
hold on
%plot(yd_wk, smoothclimatology_ciliate_fraction30_40_weekly, '-r')
plot(yd_wk, smoothclimatology_ciliate30_40_weekly, '-r')
%plot(yd_wk, (smoothclimatology_ciliate_fraction30_40_weekly+std_ciliate_fraction30_40_weekly), '-b')
plot(yd_wk, (smoothclimatology_ciliate30_40_weekly+std_ciliate30_40_weekly), '-b')
%plot(yd_wk, (smoothclimatology_ciliate_fraction30_40_weekly-std_ciliate_fraction30_40_weekly), '-b')
plot(yd_wk, (smoothclimatology_ciliate30_40_weekly-std_ciliate30_40_weekly), '-b')
%plot(yd_wk, ciliate_biovol_fraction30_40_weekmean, '-k')
%title('30-40 fraction weekly')
%title('30-40 fraction bi-weekly')
title('30-40 weekly total biovolume')
datetick ('x', 3)


%[ciliate_biovol_fraction40_inf_week, ciliate_biovol_fraction40_infweekstd]=ydmat2weeklymat(ciliate_biovol_fraction40_inf, yearlist);
[ciliate_biovol40_inf_week, ciliate_biovol40_infweekstd, mdate_wkmat, yd_wk] =ydmat2weeklymat(biovol40_infciliate_mat, yearlist);
%ciliate_biovol_fraction40_inf_weekmean= nanmean(ciliate_biovol_fraction40_inf_week, 2);
%[smoothclimatology_ciliate_fraction40_inf_weekly, std_ciliate_fraction40_inf_weekly] = smoothed_climatology(ciliate_biovol_fraction40_inf_week, 10);
[smoothclimatology_ciliate40_inf_weekly, std_ciliate40_inf_weekly] = smoothed_climatology(ciliate_biovol40_inf_week, 1);

figure
%plot(yd_wk,ciliate_biovol_fraction40_inf_week, '*r')
plot(yd_wk,ciliate_biovol40_inf_week, '*')
hold on
%plot(yd_wk, smoothclimatology_ciliate_fraction40_inf_weekly, '-r')
plot(yd_wk, smoothclimatology_ciliate40_inf_weekly, '-r')
%plot(yd_wk, (smoothclimatology_ciliate_fraction40_inf_weekly+std_ciliate_fraction40_inf_weekly), '-b')
plot(yd_wk, (smoothclimatology_ciliate40_inf_weekly+std_ciliate40_inf_weekly), '-b')
%plot(yd_wk, (smoothclimatology_ciliate_fraction40_inf_weekly-std_ciliate_fraction40_inf_weekly), '-b')
plot(yd_wk, (smoothclimatology_ciliate40_inf_weekly-std_ciliate40_inf_weekly), '-b')
%title('40-inf fraction weekly')
title('40-inf fraction bi-weekly')
title('40-inf weekly total biovolume')
datetick ('x', 3)


