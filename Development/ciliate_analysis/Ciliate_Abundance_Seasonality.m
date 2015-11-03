



[ciliate_all_N10_20_week, ciliate_all_N10_20weekstd, mdate_wkmat, yd_wk] =ydmat2weeklymat(N10_20ciliate_all_mat, yearlist);
[smoothclimatology_ciliate_all10_20_weekly_N, std_ciliate_all10_20_weekly_N] = smoothed_climatology(ciliate_all_N10_20_week, 1);

[ciliate_all_N20_30_week, ciliate_all_N20_30weekstd, mdate_wkmat, yd_wk] =ydmat2weeklymat(N20_30ciliate_all_mat, yearlist);
[smoothclimatology_ciliate_all20_30_weekly_N, std_ciliate_all20_30_weekly_N] = smoothed_climatology(ciliate_all_N20_30_week, 1);

[ciliate_all_N30_40_week, ciliate_all_N30_40weekstd, mdate_wkmat, yd_wk] =ydmat2weeklymat(N30_40ciliate_all_mat, yearlist);
[smoothclimatology_ciliate_all30_40_weekly_N, std_ciliate_all30_40_weekly_N] = smoothed_climatology(ciliate_all_N30_40_week, 1);

[ciliate_all_N40_inf_week, ciliate_all_N40_infweekstd, mdate_wkmat, yd_wk] =ydmat2weeklymat(N40_infciliate_all_mat, yearlist);
[smoothclimatology_ciliate_all40_inf_weekly_N, std_ciliate_all40_inf_weekly_N] = smoothed_climatology(ciliate_all_N40_inf_week, 1);

handle2 = figure; %four subplots of ciliate total biovolume in each size class
set(handle2, 'position', [1 1 1067 525], 'PaperPosition', [0.25 2.5 8 6])
h1 = subplot(2,2,1);
plot(yd_wk +7, ciliate_all_N10_20_week, '*')
hold on
plot(yd_wk+7, smoothclimatology_ciliate_all10_20_weekly_N, '-r', 'linewidth', 2)
plot(yd_wk+7, (smoothclimatology_ciliate_all10_20_weekly_N+std_ciliate_all10_20_weekly_N), '-b', 'linewidth', 2)
plot(yd_wk+7, (smoothclimatology_ciliate_all10_20_weekly_N-std_ciliate_all10_20_weekly_N), '-b', 'linewidth', 2)
ylabel('biovolume ( \mum^3)/ ml', 'fontsize', 14)
th = text(30, 18000, 'A.  10-20 \mum', 'fontsize', 10);
datetick ('x', 3)
%ylim([-900 20000])
set(h1, 'fontsize', 14, 'position', [0.127 0.609 0.335 0.331])
%set(h1, 'ytick', [0:1*10^4:2*10^4])
%set(h1, 'yticklabel', [0 1 2])
title('x 10^4', 'fontsize', 14, 'position', [26.293 20062.201 17.321])

h2 = subplot(2,2,2);
plot(yd_wk+7,ciliate_all_N20_30_week, '*')
hold on
plot(yd_wk+7, smoothclimatology_ciliate_all20_30_weekly_N, '-r', 'linewidth', 2)
plot(yd_wk+7, (smoothclimatology_ciliate_all20_30_weekly_N+std_ciliate_all20_30_weekly_N), '-b', 'linewidth', 2)
plot(yd_wk+7, (smoothclimatology_ciliate_all20_30_weekly_N-std_ciliate_all20_30_weekly_N), '-b', 'linewidth', 2)
ylabel('biovolume ( \mum^3)/ ml', 'fontsize', 14)
%ylim([-3000 70000])
th = text(30, 60000, 'B.  20-30 \mum', 'fontsize', 10);
datetick ('x', 3)
set(h2, 'fontsize', 14, 'position', [0.57 0.609 0.335 0.331])

h3 = subplot(2,2,3);
plot(yd_wk+7,ciliate_all_N30_40_week, '*')
hold on
plot(yd_wk+7, smoothclimatology_ciliate_all30_40_weekly_N, '-r', 'linewidth', 2)
plot(yd_wk+7, (smoothclimatology_ciliate_all30_40_weekly_N+std_ciliate_all30_40_weekly_N), '-b', 'linewidth', 2)
plot(yd_wk+7, (smoothclimatology_ciliate_all30_40_weekly_N-std_ciliate_all30_40_weekly_N), '-b', 'linewidth', 2)
ylabel('biovolume ( \mum^3)/ ml', 'fontsize', 14)
datetick ('x', 3)
%set(gca,'fontsize',14)
%ylim([-3000 40000])
th = text(30, 35000, 'C.  30-40 \mum', 'fontsize', 10);
set(h3, 'fontsize', 14, 'position', [0.127 0.162 0.335 0.331])
%set(h3, 'ytick', [0:1*10^4:4*10^4])

h4 = subplot(2,2,4);
plot(yd_wk+7,ciliate_all_N40_inf_week, '*')
hold on
plot(yd_wk+7, smoothclimatology_ciliate_all40_inf_weekly_N, '-r', 'linewidth', 2)
plot(yd_wk+7, (smoothclimatology_ciliate_all40_inf_weekly_N+std_ciliate_all40_inf_weekly_N), '-b', 'linewidth', 2)
plot(yd_wk+7, (smoothclimatology_ciliate_all40_inf_weekly_N-std_ciliate_all40_inf_weekly_N), '-b', 'linewidth', 2)
ylabel('biovolume ( \mum^3)/ ml', 'fontsize', 14)
datetick ('x', 3)
handle= legend('2006', '2007', '2008', '2009', '2010', '2011', '2012');
rect= [0.2092 0.0212 0.6392 0.057];
set(handle, 'fontsize', 14, 'Orientation', 'horizontal')
set(handle, 'Position', rect);
%set(gca,'fontsize',14)
%ylim([-30000 250000])
th = text(30, 200000, 'D.  40-180 \mum', 'fontsize', 10);
set(h4, 'fontsize', 14, 'position', [0.57 0.162 0.335 0.331])
%set(h4, 'ytick', [0:1*10^5:3*10^5])

[ciliate_all_N_fraction10_20_week, ciliate_all_N_fraction10_20weekstd, mdate_wkmat, yd_wk]=ydmat2weeklymat(ciliate_all_N_fraction10_20, yearlist);
[smoothclimatology_ciliate_all_fraction10_20_weekly_N, std_ciliate_all_fraction10_20_weekly_N] = smoothed_climatology(ciliate_all_N_fraction10_20_week, 1);
[ciliate_all_N_fraction20_30_week, ciliate_all_N_fraction20_30weekstd, mdate_wkmat, yd_wk]=ydmat2weeklymat(ciliate_all_N_fraction20_30, yearlist);
[smoothclimatology_ciliate_all_fraction20_30_weekly_N, std_ciliate_all_fraction20_30_weekly_N] = smoothed_climatology(ciliate_all_N_fraction20_30_week, 1);
[ciliate_all_N_fraction30_40_week, ciliate_all_N_fraction30_40weekstd, mdate_wkmat, yd_wk]=ydmat2weeklymat(ciliate_all_N_fraction30_40, yearlist);
[smoothclimatology_ciliate_all_fraction30_40_weekly_N, std_ciliate_all_fraction30_40_weekly_N] = smoothed_climatology(ciliate_all_N_fraction30_40_week, 1);
[ciliate_all_N_fraction40_inf_week, ciliate_all_N_fraction40_infweekstd, mdate_wkmat, yd_wk]=ydmat2weeklymat(ciliate_all_N_fraction40_inf, yearlist);
[smoothclimatology_ciliate_all_fraction40_inf_weekly_N, std_ciliate_all_fraction40_inf_weekly_N] = smoothed_climatology(ciliate_all_N_fraction40_inf_week, 1);


figure  %stacked bar of ciliate size fractions
bar(yd_wk+7, [(smoothclimatology_ciliate_all_fraction10_20_weekly_N)',(smoothclimatology_ciliate_all_fraction20_30_weekly_N)', (smoothclimatology_ciliate_all_fraction30_40_weekly_N)', (smoothclimatology_ciliate_all_fraction40_inf_weekly_N)'], 'stacked')
%title('All Ciliate Fraction - bi-weekly bins')
ylabel('fraction of biovolume', 'fontsize', 14)
datetick ('x', 3)
xlim([0 370]);
legend( '10-20', '20-30', '30-40', '40-180')
set(gca,'fontsize',14)

handle2 = figure; %four subplots of ciliate total biovolume in each size class
set(handle2, 'position', [1 1 1067 525], 'PaperPosition', [0.25 2.5 8 6])
h1 = subplot(2,2,1);
plot(yd_wk +7, ciliate_all_N_fraction10_20_week, '*')
hold on
plot(yd_wk+7, smoothclimatology_ciliate_all_fraction10_20_weekly_N, '-r', 'linewidth', 2)
plot(yd_wk+7, (smoothclimatology_ciliate_all_fraction10_20_weekly_N+std_ciliate_all_fraction10_20_weekly_N), '-b', 'linewidth', 2)
plot(yd_wk+7, (smoothclimatology_ciliate_all_fraction10_20_weekly_N-std_ciliate_all_fraction10_20_weekly_N), '-b', 'linewidth', 2)
ylabel('biovolume ( \mum^3)/ ml', 'fontsize', 14)
th = text(30, 18000, 'A.  10-20 \mum', 'fontsize', 10);
datetick ('x', 3)
%ylim([-900 20000])
set(h1, 'fontsize', 14, 'position', [0.127 0.609 0.335 0.331])
%set(h1, 'ytick', [0:1*10^4:2*10^4])
%set(h1, 'yticklabel', [0 1 2])
title('x 10^4', 'fontsize', 14, 'position', [26.293 20062.201 17.321])

h2 = subplot(2,2,2);
plot(yd_wk+7,ciliate_all_N_fraction20_30_week, '*')
hold on
plot(yd_wk+7, smoothclimatology_ciliate_all_fraction20_30_weekly_N, '-r', 'linewidth', 2)
plot(yd_wk+7, (smoothclimatology_ciliate_all_fraction20_30_weekly_N+std_ciliate_all_fraction20_30_weekly_N), '-b', 'linewidth', 2)
plot(yd_wk+7, (smoothclimatology_ciliate_all_fraction20_30_weekly_N-std_ciliate_all_fraction20_30_weekly_N), '-b', 'linewidth', 2)
ylabel('biovolume ( \mum^3)/ ml', 'fontsize', 14)
%ylim([-3000 70000])
th = text(30, 60000, 'B.  20-30 \mum', 'fontsize', 10);
datetick ('x', 3)
set(h2, 'fontsize', 14, 'position', [0.57 0.609 0.335 0.331])

h3 = subplot(2,2,3);
plot(yd_wk+7,ciliate_all_N_fraction30_40_week, '*')
hold on
plot(yd_wk+7, smoothclimatology_ciliate_all_fraction30_40_weekly_N, '-r', 'linewidth', 2)
plot(yd_wk+7, (smoothclimatology_ciliate_all_fraction30_40_weekly_N+std_ciliate_all_fraction30_40_weekly_N), '-b', 'linewidth', 2)
plot(yd_wk+7, (smoothclimatology_ciliate_all_fraction30_40_weekly_N-std_ciliate_all_fraction30_40_weekly_N), '-b', 'linewidth', 2)
ylabel('biovolume ( \mum^3)/ ml', 'fontsize', 14)
datetick ('x', 3)
%set(gca,'fontsize',14)
%ylim([-3000 40000])
th = text(30, 35000, 'C.  30-40 \mum', 'fontsize', 10);
set(h3, 'fontsize', 14, 'position', [0.127 0.162 0.335 0.331])
%set(h3, 'ytick', [0:1*10^4:4*10^4])

h4 = subplot(2,2,4);
plot(yd_wk+7,ciliate_all_N_fraction40_inf_week, '*')
hold on
plot(yd_wk+7, smoothclimatology_ciliate_all_fraction40_inf_weekly_N, '-r', 'linewidth', 2)
plot(yd_wk+7, (smoothclimatology_ciliate_all_fraction40_inf_weekly_N+std_ciliate_all_fraction40_inf_weekly_N), '-b', 'linewidth', 2)
plot(yd_wk+7, (smoothclimatology_ciliate_all_fraction40_inf_weekly_N-std_ciliate_all_fraction40_inf_weekly_N), '-b', 'linewidth', 2)
ylabel('biovolume ( \mum^3)/ ml', 'fontsize', 14)
datetick ('x', 3)
handle= legend('2006', '2007', '2008', '2009', '2010', '2011', '2012');
rect= [0.2092 0.0212 0.6392 0.057];
set(handle, 'fontsize', 14, 'Orientation', 'horizontal')
set(handle, 'Position', rect);
%set(gca,'fontsize',14)
%ylim([-30000 250000])
th = text(30, 200000, 'D.  40-180 \mum', 'fontsize', 10);
set(h4, 'fontsize', 14, 'position', [0.57 0.162 0.335 0.331])
%set(h4, 'ytick', [0:1*10^5:3*10^5])





