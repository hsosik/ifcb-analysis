load Tday
Tmean = nanmean(Tday,2);
Tanom = Tday - repmat(Tmean,1,length(yearall));
%Tanom_short= Tanom(:,4:10);


%[~,~,ii] = intersect(year_ifcb,yearall);
[~,~,ii] = intersect(yearlist,yearall);
Tmean_ifcb = nanmean(Tday(:,ii),2);
%Tanom_ifcb = Tday(:,ii) - repmat(Tmean_ifcb,1,length(year_ifcb));
Tanom_ifcb = Tday(:,ii) - repmat(Tmean_ifcb,1,length(yearlist));




% %[ciliate_all_biovol_fraction0_10_week, ciliate_all_biovol_fraction0_10weekstd, mdate_wkmat, yd_wk] =ydmat2weeklymat(ciliate_all_biovol_fraction0_10, yearlist);
% [ciliate_all_biovol0_10_week, ciliate_all_biovol0_10weekstd, mdate_wkmat, yd_wk] =ydmat2weeklymat(biovol0_10ciliate_all_mat, yearlist);
% %ciliate_all_biovol_fraction0_10_weekmean= nanmean(ciliate_all_biovol_fraction0_10_week, 2);
% %[smoothclimatology_ciliate_all_fraction0_10_weekly, std_ciliate_all_fraction0_10_weekly] = smoothed_climatology(ciliate_all_biovol_fraction0_10_week, 1);
% [smoothclimatology_ciliate_all0_10_weekly, std_ciliate_all0_10_weekly] = smoothed_climatology(ciliate_all_biovol0_10_week, 10);
% 
% figure
% plot(yd_wk,ciliate_all_biovol_fraction0_10_week, '*')
% %plot(yd_wk,ciliate_all_biovol0_10_week, '*r')
% hold on
% plot(yd_wk, smoothclimatology_ciliate_all_fraction0_10_weekly, '-r')
% %plot(yd_wk, smoothclimatology_ciliate_all0_10_weekly, '-r')
% plot(yd_wk, (smoothclimatology_ciliate_all_fraction0_10_weekly+std_ciliate_all_fraction0_10_weekly), '-b')
% %plot(yd_wk, (smoothclimatology_ciliate_all0_10_weekly+std_ciliate0_10_weekly), '-b')
% plot(yd_wk, (smoothclimatology_ciliate_all_fraction0_10_weekly-std_ciliate_all_fraction0_10_weekly), '-b')
% %plot(yd_wk, (smoothclimatology_ciliate_all0_10_weekly-std_ciliate0_10_weekly), '-b')
% title('0-10 fraction weekly')
% %title('0-10 fraction bi-weekly')
% %title('0-10 weekly total biovolume')
% datetick ('x', 3)



%[ciliate_all_biovol_fraction10_20_week, ciliate_all_biovol_fraction10_20weekstd, mdate_wkmat, yd_wk]=ydmat2weeklymat(ciliate_all_biovol_fraction10_20, yearlist);
[ciliate_all_biovol10_20_week, ciliate_all_biovol10_20weekstd, mdate_wkmat, yd_wk] =ydmat2weeklymat(biovol10_20ciliate_all_mat, yearlist);
%ciliate_all_biovol_fraction10_20_weekmean= nanmean(ciliate_all_biovol_fraction10_20_week, 2);
%[smoothclimatology_ciliate_all_fraction10_20_weekly, std_ciliate_all_fraction10_20_weekly] = smoothed_climatology(ciliate_all_biovol_fraction10_20_week, 1);
[smoothclimatology_ciliate_all10_20_weekly, std_ciliate_all10_20_weekly] = smoothed_climatology(ciliate_all_biovol10_20_week, 1);
[T_ifcb_week, Tmean_ifcb_weekstd, mdate_wkmat, yd_wk]=ydmat2weeklymat((Tday(:,4:10)), yearlist);
[smoothclimatology_T_ifcb] = smoothed_climatology(T_ifcb_week, 1);


figure
plot(yd_wk +7,ciliate_all_biovol10_20_week, '*')
%plotyy(yd_wk,ciliate_all_biovol10_20_week, '*')
hold on
%plot(yd_wk, smoothclimatology_ciliate_all_fraction10_20_weekly, '-r')
plot(yd_wk+7, smoothclimatology_ciliate_all10_20_weekly, '-r')
%plot(yd_wk, (smoothclimatology_ciliate_all_fraction10_20_weekly+std_ciliate_all_fraction10_20_weekly), '-b')
plot(yd_wk+7, (smoothclimatology_ciliate_all10_20_weekly+std_ciliate_all10_20_weekly), '-b')
%plot(yd_wk, (smoothclimatology_ciliate_all_fraction10_20_weekly-std_ciliate_all_fraction10_20_weekly), '-b')
plot(yd_wk+7, (smoothclimatology_ciliate_all10_20_weekly-std_ciliate_all10_20_weekly), '-b')
%title('10-20 fraction weekly')
%title('10-20 fraction bi-weekly')
ylabel('biovolume (\mum{3})', 'fontsize', 14)
set(gca,'fontsize',14)
title('10-20 weekly total biovolume')
datetick ('x', 3)
ylim([-900 20000])
legend('2006', '2007', '2008', '2009', '2010', '2011', '2012')

mean10_20=nanmean(ciliate_all_biovol10_20_week, 2);
std10_20=nanstd(ciliate_all_biovol10_20_week, 0, 2);

figure
plot(yd_wk +7,ciliate_all_biovol10_20_week, '*')
hold on
plot (yd_wk +7, mean10_20, '-r')
plot(yd_wk +7, mean10_20+std10_20, '-b')
plot(yd_wk +7, mean10_20-std10_20, '-b')
ylabel('biovolume (\mum{3})', 'fontsize', 14)
set(gca,'fontsize',14)
title('10-20 weekly total biovolume')
datetick ('x', 3)
ylim([-900 20000])
legend('2006', '2007', '2008', '2009', '2010', '2011', '2012')



%[ciliate_all_biovol_fraction20_30_week, ciliate_all_biovol_fraction20_30weekstd]=ydmat2weeklymat(ciliate_all_biovol_fraction20_30, yearlist);
[ciliate_all_biovol20_30_week, ciliate_all_biovol20_30weekstd, mdate_wkmat, yd_wk] =ydmat2weeklymat(biovol20_30ciliate_all_mat, yearlist);
%ciliate_all_biovol_fraction20_30_weekmean= nanmean(ciliate_all_biovol_fraction20_30_week, 2);
%[smoothclimatology_ciliate_all_fraction20_30_weekly, std_ciliate_all_fraction20_30_weekly] = smoothed_climatology(ciliate_all_biovol_fraction20_30_week, 1);
[smoothclimatology_ciliate_all20_30_weekly, std_ciliate_all20_30_weekly] = smoothed_climatology(ciliate_all_biovol20_30_week, 1);

figure
%plot(yd_wk,ciliate_all_biovol_fraction20_30_week, '*')
plot(yd_wk+7,ciliate_all_biovol20_30_week, '*')
hold on
%plot(yd_wk, smoothclimatology_ciliate_all_fraction20_30_weekly, '-r')
plot(yd_wk+7, smoothclimatology_ciliate_all20_30_weekly, '-r')
%plot(yd_wk, (smoothclimatology_ciliate_all_fraction20_30_weekly+std_ciliate_all_fraction20_30_weekly), '-b')
plot(yd_wk+7, (smoothclimatology_ciliate_all20_30_weekly+std_ciliate_all20_30_weekly), '-b')
%plot(yd_wk, (smoothclimatology_ciliate_all_fraction20_30_weekly-std_ciliate_all_fraction20_30_weekly), '-b')
plot(yd_wk+7, (smoothclimatology_ciliate_all20_30_weekly-std_ciliate_all20_30_weekly), '-b')
%title('20-30 fraction weekly')
%title('20-30 fraction bi-weekly')
ylabel('biovolume (\mum{3})', 'fontsize', 14)
ylim([-3000 70000])
title('20-30 weekly total biovolume')
datetick ('x', 3)
legend('2006', '2007', '2008', '2009', '2010', '2011', '2012');
set(gca,'fontsize',14)




%[ciliate_all_biovol_fraction30_40_week, ciliate_all_biovol_fraction30_40weekstd, mdate_wkmat, yd_wk]=ydmat2weeklymat(ciliate_all_biovol_fraction30_40, yearlist);
[ciliate_all_biovol30_40_week, ciliate_all_biovol30_40weekstd, mdate_wkmat, yd_wk] =ydmat2weeklymat(biovol30_40ciliate_all_mat, yearlist);
%ciliate_all_biovol_fraction30_40_weekmean= nanmean(ciliate_all_biovol_fraction30_40_week, 2);
%[smoothclimatology_ciliate_all_fraction30_40_weekly, std_ciliate_all_fraction30_40_weekly] = smoothed_climatology(ciliate_all_biovol_fraction30_40_week, 1);
[smoothclimatology_ciliate_all30_40_weekly, std_ciliate_all30_40_weekly] = smoothed_climatology(ciliate_all_biovol30_40_week, 1);

figure
%plot(yd_wk,ciliate_all_biovol_fraction30_40_week, '*')
plot(yd_wk+7,ciliate_all_biovol30_40_week, '*')
hold on
%plot(yd_wk, smoothclimatology_ciliate_all_fraction30_40_weekly, '-r')
plot(yd_wk+7, smoothclimatology_ciliate_all30_40_weekly, '-r')
%plot(yd_wk, (smoothclimatology_ciliate_all_fraction30_40_weekly+std_ciliate_all_fraction30_40_weekly), '-b')
plot(yd_wk+7, (smoothclimatology_ciliate_all30_40_weekly+std_ciliate_all30_40_weekly), '-b')
%plot(yd_wk, (smoothclimatology_ciliate_all_fraction30_40_weekly-std_ciliate_all_fraction30_40_weekly), '-b')
plot(yd_wk+7, (smoothclimatology_ciliate_all30_40_weekly-std_ciliate_all30_40_weekly), '-b')
%plot(yd_wk, ciliate_all_biovol_fraction30_40_weekmean, '-k')
%title('30-40 fraction weekly')
%title('30-40 fraction bi-weekly')
ylabel('biovolume (\mum{3})', 'fontsize', 14)
title('30-40 weekly total biovolume')
datetick ('x', 3)
legend('2006', '2007', '2008', '2009', '2010', '2011', '2012');
set(gca,'fontsize',14)
ylim([-3000 40000])



%[ciliate_all_biovol_fraction40_inf_week, ciliate_all_biovol_fraction40_infweekstd]=ydmat2weeklymat(ciliate_all_biovol_fraction40_inf, yearlist);
[ciliate_all_biovol40_inf_week, ciliate_all_biovol40_infweekstd, mdate_wkmat, yd_wk] =ydmat2weeklymat(biovol40_infciliate_all_mat, yearlist);
%ciliate_all_biovol_fraction40_inf_weekmean= nanmean(ciliate_all_biovol_fraction40_inf_week, 2);
%[smoothclimatology_ciliate_all_fraction40_inf_weekly, std_ciliate_all_fraction40_inf_weekly] = smoothed_climatology(ciliate_all_biovol_fraction40_inf_week, 1);
[smoothclimatology_ciliate_all40_inf_weekly, std_ciliate_all40_inf_weekly] = smoothed_climatology(ciliate_all_biovol40_inf_week, 1);

figure
%plot(yd_wk,ciliate_all_biovol_fraction40_inf_week, '*')
plot(yd_wk+7,ciliate_all_biovol40_inf_week, '*')
hold on
%plot(yd_wk, smoothclimatology_ciliate_all_fraction40_inf_weekly, '-r')
plot(yd_wk+7, smoothclimatology_ciliate_all40_inf_weekly, '-r')
%plot(yd_wk, (smoothclimatology_ciliate_all_fraction40_inf_weekly+std_ciliate_all_fraction40_inf_weekly), '-b')
plot(yd_wk+7, (smoothclimatology_ciliate_all40_inf_weekly+std_ciliate_all40_inf_weekly), '-b')
%plot(yd_wk, (smoothclimatology_ciliate_all_fraction40_inf_weekly-std_ciliate_all_fraction40_inf_weekly), '-b')
plot(yd_wk+7, (smoothclimatology_ciliate_all40_inf_weekly-std_ciliate_all40_inf_weekly), '-b')
%title('40-inf fraction weekly')
%title('40-inf fraction bi-weekly')
ylabel('biovolume (\mum{3})', 'fontsize', 14)
title('40-inf weekly total biovolume')
datetick ('x', 3)
legend('2006', '2007', '2008', '2009', '2010', '2011', '2012');
set(gca,'fontsize',14)
ylim([-30000 250000])


figure
subplot(2,2,1)
plot(yd_wk+7, smoothclimatology_ciliate_all10_20_weekly, '-r', 'linewidth', 2)
hold on
plot(yd_wk+7, std_ciliate_all10_20_weekly, '-b', 'linewidth', 2)
ylabel('biovolume ( \mum^3)', 'fontsize', 14)
set(gca,'fontsize',14)
%title('10-20 weekly mean and std')
legend('mean', 'std');
datetick ('x', 3)
th = text(30, 5500, 'A.  10-20 \mum', 'fontsize', 12);

subplot(2,2,2)
plot(yd_wk+7, smoothclimatology_ciliate_all20_30_weekly, '-r', 'linewidth', 2)
hold on
plot(yd_wk+7, std_ciliate_all20_30_weekly, '-b', 'linewidth', 2)
%ylabel('biovolume (\mum{3})', 'fontsize', 14)
set(gca,'fontsize',14)
%title('20-30 weekly mean and std')
%legend('mean', 'std');
datetick ('x', 3)
th = text(30, 18000, 'B.  20-30 \mum', 'fontsize', 12);

subplot(2,2,3)
plot(yd_wk+7, smoothclimatology_ciliate_all30_40_weekly, '-r', 'linewidth', 2)
hold on
plot(yd_wk+7, std_ciliate_all30_40_weekly, '-b', 'linewidth', 2)
%ylabel('biovolume (\mum{3})', 'fontsize', 14)
set(gca,'fontsize',14)
%title('30-40 weekly mean and std')
%legend('mean', 'std');
datetick ('x', 3)
th = text(30, 13000, 'C.  30-40 \mum', 'fontsize', 12);

subplot(2,2,4)
plot(yd_wk+7, smoothclimatology_ciliate_all40_inf_weekly, '-r', 'linewidth', 2)
hold on
plot(yd_wk+7, std_ciliate_all40_inf_weekly, '-b', 'linewidth', 2)
%ylabel('biovolume (\mum{3})', 'fontsize', 14)
set(gca,'fontsize',14)
%title('40-inf weekly mean and std')
%legend('mean', 'std');
datetick ('x', 3)
th = text(30, 80000, 'D.  40-180 \mum', 'fontsize', 12);

% %t= nanmean(ciliate_all_biovol_fraction0_10_week, 2);
% t_2=nanmean(ciliate_all_biovol_fraction10_20_week, 2);
% t_3=nanmean(ciliate_all_biovol_fraction20_30_week, 2);
% t_4=nanmean(ciliate_all_biovol_fraction30_40_week, 2);
% t_5=nanmean(ciliate_all_biovol_fraction40_inf_week, 2);
figure
bar(yd_wk+7, [(smoothclimatology_ciliate_all10_20_weekly)', (smoothclimatology_ciliate_all20_30_weekly)', (smoothclimatology_ciliate_all30_40_weekly)',(smoothclimatology_ciliate_all40_inf_weekly)'], 'stacked')
title('All Ciliate Biovol bi-weekly bins')
ylabel('biovolume (\mum{3})', 'fontsize', 14)
xlim([0 366]);
datetick ('x', 3)
%datetick('x', 'keeplimits')
legend( '10-20', '20-30', '30-40', '40-inf')
set(gca,'fontsize',14)





[ciliate_all_biovol_fraction10_20_week, ciliate_all_biovol_fraction10_20weekstd, mdate_wkmat, yd_wk]=ydmat2weeklymat(ciliate_all_biovol_fraction10_20, yearlist);
%[ciliate_all_biovol10_20_week, ciliate_all_biovol10_20weekstd, mdate_wkmat, yd_wk] =ydmat2weeklymat(biovol10_20ciliate_all_mat, yearlist);
%ciliate_all_biovol_fraction10_20_weekmean= nanmean(ciliate_all_biovol_fraction10_20_week, 2);
[smoothclimatology_ciliate_all_fraction10_20_weekly, std_ciliate_all_fraction10_20_weekly] = smoothed_climatology(ciliate_all_biovol_fraction10_20_week, 1);
%[smoothclimatology_ciliate_all10_20_weekly, std_ciliate_all10_20_weekly] = smoothed_climatology(ciliate_all_biovol10_20_week, 1);
%[T_ifcb_week, Tmean_ifcb_weekstd, mdate_wkmat, yd_wk]=ydmat2weeklymat((Tday(:,4:10)), yearlist);
%[smoothclimatology_T_ifcb] = smoothed_climatology(T_ifcb_week, 1);

figure
plot(yd_wk+7,ciliate_all_biovol_fraction10_20_week, '*')
%plotyy(yd_wk,ciliate_all_biovol10_20_week, '*')
hold on
plot(yd_wk+7, smoothclimatology_ciliate_all_fraction10_20_weekly, '-r')
%plot(yd_wk, smoothclimatology_ciliate_all10_20_weekly, '-r')
plot(yd_wk+7, (smoothclimatology_ciliate_all_fraction10_20_weekly+std_ciliate_all_fraction10_20_weekly), '-b')
%plot(yd_wk, (smoothclimatology_ciliate_all10_20_weekly+std_ciliate_all10_20_weekly), '-b')
plot(yd_wk+7, (smoothclimatology_ciliate_all_fraction10_20_weekly-std_ciliate_all_fraction10_20_weekly), '-b')
%plot(yd_wk, (smoothclimatology_ciliate_all10_20_weekly-std_ciliate_all10_20_weekly), '-b')
%title('10-20 fraction weekly')
title('10-20 fraction bi-weekly')
ylabel('fraction of biovolume', 'fontsize', 14)
%title('10-20 weekly total biovolume')
datetick ('x', 3)
legend('2006', '2007', '2008', '2009', '2010', '2011', '2012');
set(gca,'fontsize',14)
ylim([-0.05 0.8])

[ciliate_all_biovol_fraction20_30_week, ciliate_all_biovol_fraction20_30weekstd]=ydmat2weeklymat(ciliate_all_biovol_fraction20_30, yearlist);
%[ciliate_all_biovol20_30_week, ciliate_all_biovol20_30weekstd, mdate_wkmat, yd_wk] =ydmat2weeklymat(biovol20_30ciliate_all_mat, yearlist);
%ciliate_all_biovol_fraction20_30_weekmean= nanmean(ciliate_all_biovol_fraction20_30_week, 2);
[smoothclimatology_ciliate_all_fraction20_30_weekly, std_ciliate_all_fraction20_30_weekly] = smoothed_climatology(ciliate_all_biovol_fraction20_30_week, 1);
%[smoothclimatology_ciliate_all20_30_weekly, std_ciliate_all20_30_weekly] = smoothed_climatology(ciliate_all_biovol20_30_week, 1);

figure
plot(yd_wk+7,ciliate_all_biovol_fraction20_30_week, '*')
%plot(yd_wk,ciliate_all_biovol20_30_week, '*')
hold on
plot(yd_wk+7, smoothclimatology_ciliate_all_fraction20_30_weekly, '-r')
%plot(yd_wk, smoothclimatology_ciliate_all20_30_weekly, '-r')
plot(yd_wk+7, (smoothclimatology_ciliate_all_fraction20_30_weekly+std_ciliate_all_fraction20_30_weekly), '-b')
%plot(yd_wk, (smoothclimatology_ciliate_all20_30_weekly+std_ciliate_all20_30_weekly), '-b')
plot(yd_wk+7, (smoothclimatology_ciliate_all_fraction20_30_weekly-std_ciliate_all_fraction20_30_weekly), '-b')
%plot(yd_wk, (smoothclimatology_ciliate_all20_30_weekly-std_ciliate_all20_30_weekly), '-b')
%title('20-30 fraction weekly')
title('20-30 fraction bi-weekly')
ylabel('fraction of biovolume', 'fontsize', 14)
%title('20-30 weekly total biovolume')
datetick ('x', 3)
legend('2006', '2007', '2008', '2009', '2010', '2011', '2012');
set(gca,'fontsize',14)
ylim([0 0.8])

[ciliate_all_biovol_fraction30_40_week, ciliate_all_biovol_fraction30_40weekstd, mdate_wkmat, yd_wk]=ydmat2weeklymat(ciliate_all_biovol_fraction30_40, yearlist);
%[ciliate_all_biovol30_40_week, ciliate_all_biovol30_40weekstd, mdate_wkmat, yd_wk] =ydmat2weeklymat(biovol30_40ciliate_all_mat, yearlist);
%ciliate_all_biovol_fraction30_40_weekmean= nanmean(ciliate_all_biovol_fraction30_40_week, 2);
[smoothclimatology_ciliate_all_fraction30_40_weekly, std_ciliate_all_fraction30_40_weekly] = smoothed_climatology(ciliate_all_biovol_fraction30_40_week, 1);
%[smoothclimatology_ciliate_all30_40_weekly, std_ciliate_all30_40_weekly] = smoothed_climatology(ciliate_all_biovol30_40_week, 1);

figure
plot(yd_wk+7,ciliate_all_biovol_fraction30_40_week, '*')
%plot(yd_wk,ciliate_all_biovol30_40_week, '*')
hold on
plot(yd_wk+7, smoothclimatology_ciliate_all_fraction30_40_weekly, '-r')
%plot(yd_wk, smoothclimatology_ciliate_all30_40_weekly, '-r')
plot(yd_wk+7, (smoothclimatology_ciliate_all_fraction30_40_weekly+std_ciliate_all_fraction30_40_weekly), '-b')
%plot(yd_wk, (smoothclimatology_ciliate_all30_40_weekly+std_ciliate_all30_40_weekly), '-b')
plot(yd_wk+7, (smoothclimatology_ciliate_all_fraction30_40_weekly-std_ciliate_all_fraction30_40_weekly), '-b')
%plot(yd_wk, (smoothclimatology_ciliate_all30_40_weekly-std_ciliate_all30_40_weekly), '-b')
%title('30-40 fraction weekly')
title('30-40 fraction bi-weekly')
ylabel('fraction of biovolume', 'fontsize', 14)
%title('30-40 weekly total biovolume')
datetick ('x', 3)
legend('2006', '2007', '2008', '2009', '2010', '2011', '2012');
set(gca,'fontsize',14)
ylim([-0.05 0.8])

[ciliate_all_biovol_fraction40_inf_week, ciliate_all_biovol_fraction40_infweekstd]=ydmat2weeklymat(ciliate_all_biovol_fraction40_inf, yearlist);
%[ciliate_all_biovol40_inf_week, ciliate_all_biovol40_infweekstd, mdate_wkmat, yd_wk] =ydmat2weeklymat(biovol40_infciliate_all_mat, yearlist);
%ciliate_all_biovol_fraction40_inf_weekmean= nanmean(ciliate_all_biovol_fraction40_inf_week, 2);
[smoothclimatology_ciliate_all_fraction40_inf_weekly, std_ciliate_all_fraction40_inf_weekly] = smoothed_climatology(ciliate_all_biovol_fraction40_inf_week, 1);
%[smoothclimatology_ciliate_all40_inf_weekly, std_ciliate_all40_inf_weekly] = smoothed_climatology(ciliate_all_biovol40_inf_week, 1);

figure
plot(yd_wk+7,ciliate_all_biovol_fraction40_inf_week, '*')
%plot(yd_wk,ciliate_all_biovol40_inf_week, '*')
hold on
plot(yd_wk+7, smoothclimatology_ciliate_all_fraction40_inf_weekly, '-r')
%plot(yd_wk, smoothclimatology_ciliate_all40_inf_weekly, '-r')
plot(yd_wk+7, (smoothclimatology_ciliate_all_fraction40_inf_weekly+std_ciliate_all_fraction40_inf_weekly), '-b')
%plot(yd_wk, (smoothclimatology_ciliate_all40_inf_weekly+std_ciliate_all40_inf_weekly), '-b')
plot(yd_wk+7, (smoothclimatology_ciliate_all_fraction40_inf_weekly-std_ciliate_all_fraction40_inf_weekly), '-b')
%plot(yd_wk, (smoothclimatology_ciliate_all40_inf_weekly-std_ciliate_all40_inf_weekly), '-b')
%title('40-inf fraction weekly')
title('40-inf fraction bi-weekly')
ylabel('fraction of biovolume', 'fontsize', 14)
%title('40-inf weekly total biovolume')
datetick ('x', 3)
legend('2006', '2007', '2008', '2009', '2010', '2011', '2012');
set(gca,'fontsize',14)
ylim([-0.05 1.0])



%r= nanmean(ciliate_all_biovol0_10_week, 2);
% r_2=nanmean(ciliate_all_biovol10_20_week, 2);
% r_3=nanmean(ciliate_all_biovol20_30_week, 2);
% r_4=nanmean(ciliate_all_biovol30_40_week, 2);
% r_5=nanmean(ciliate_all_biovol40_inf_week, 2);
figure
bar(yd_wk+7, [(smoothclimatology_ciliate_all_fraction10_20_weekly)',(smoothclimatology_ciliate_all_fraction20_30_weekly)', (smoothclimatology_ciliate_all_fraction30_40_weekly)', (smoothclimatology_ciliate_all_fraction40_inf_weekly)'], 'stacked')
title('All Ciliate Fraction - bi-weekly bins')
ylabel('fraction of biovolume', 'fontsize', 14)
datetick ('x', 3)
xlim([0 370]);
legend( '10-20', '20-30', '30-40', '40-inf')
set(gca,'fontsize',14)