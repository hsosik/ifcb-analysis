figure
th1= subplot(5,1,1);
plot(yd_wk+7, smoothclimatology_T_ifcb, '-b', 'LineWidth', 2, 'color',[0.0431372549019608 0.517647058823529 0.780392156862745]);
xlim([0 370])
ylabel('Temperature ( \circC)', 'fontsize', 14)
set(gca,'fontsize',14)
datetick ('x', 3)
set(th1, 'XTickLabel', '')
set(th1, 'ylim', [0 22])


th2 = subplot(5,1,2);
bar(yd_wk+7, 10.^log_smoothclimatology_ciliate_all10_20_weekly, 'FaceColor',[0.0431372549019608 0.517647058823529 0.780392156862745])
datetick ('x', 3)
%ylabel('fraction of biovolume', 'fontsize', 12)
%set(gca,'fontsize',12)
hold on
errorbar(yd_wk+7, 10.^log_smoothclimatology_ciliate_all10_20_weekly,10.^(log_smoothclimatology_ciliate_all10_20_weekly-log_std_ciliate_all10_20_weekly),10.^(log_smoothclimatology_ciliate_all10_20_weekly+log_std_ciliate_all10_20_weekly), 'LineWidth',1,'Color',[0 0 0]);
ylim([-900 15000])
set(th2, 'XTickLabel', '', 'tickdir', 'out', 'fontsize', 14)
set(th2, 'yticklabel', [0 1 2])
set(th2, 'ytick', [0:1*10^4:2*10^4])
title('x 10^4', 'fontsize', 14)

th3 = subplot(5,1,3);
bar(yd_wk+7, 10.^log_smoothclimatology_ciliate_all20_30_weekly, 'FaceColor',[0.0431372549019608 0.517647058823529 0.780392156862745]) %'-r')
datetick ('x', 3)
%ylabel('fraction of biovolume', 'fontsize', 12)
%set(gca,'fontsize',12)
hold on
errorbar(yd_wk+7, 10.^log_smoothclimatology_ciliate_all20_30_weekly,10.^(log_smoothclimatology_ciliate_all20_30_weekly-log_std_ciliate_all20_30_weekly),10.^(log_smoothclimatology_ciliate_all20_30_weekly+log_std_ciliate_all20_30_weekly), 'LineWidth',1,'Color',[0 0 0]);
ylim([-3000 40000])
set(th3, 'XTickLabel', '', 'fontsize', 14) 
set(th3, 'tickdir', 'out')
%set(th3, 'ytick', [0:4*10^4])
%'tickdir', 'out', 'fontsize', 14, 'ytick', [0:4*10^4])


th4 = subplot(5,1,4);
bar(yd_wk+7, 10.^log_smoothclimatology_ciliate_all30_40_weekly_C, 'FaceColor',[0.0431372549019608 0.517647058823529 0.780392156862745]) %'-r'
datetick ('x', 3)
%ylabel('fraction of biovolume', 'fontsize', 12)
%set(gca,'fontsize',12)
hold on
errorbar(yd_wk+7, 10.^log_smoothclimatology_ciliate_all30_40_weekly_C,10.^(log_smoothclimatology_ciliate_all30_40_weekly_C-log_std_ciliate_all30_40_weekly_C),10.^(log_smoothclimatology_ciliate_all30_40_weekly_C+log_std_ciliate_all30_40_weekly_C), 'LineWidth',1,'Color',[0 0 0]);
ylim([-3000 25000])
set(th4, 'XTickLabel', '', 'tickdir', 'out', 'fontsize', 14)
%set(th4, 'yticklabel', [0:2*10^4])

th5 = subplot(5,1,5);
bar(yd_wk+7, 10.^log_smoothclimatology_ciliate_all40_inf_weekly_C, 'FaceColor',[0.0431372549019608 0.517647058823529 0.780392156862745]) %'-r')
datetick ('x', 3)
ylabel('biovolume ( \mum^3 mL^-1)', 'fontsize', 14)
%set(gca,'fontsize',12)
hold on
errorbar(yd_wk+7, 10.^log_smoothclimatology_ciliate_all40_inf_weekly_C,10.^(log_smoothclimatology_ciliate_all40_inf_weekly_C-log_std_ciliate_all40_inf_weekly_C),10.^(log_smoothclimatology_ciliate_all40_inf_weekly_C+log_std_ciliate_all40_inf_weekly_C), 'LineWidth',1,'Color',[0 0 0]);
ylim([-30000 150000])
set(th5, 'ytick',[0:1*10^5:3*10^5], 'tickdir', 'out', 'fontsize', 14)
set(th2, 'tickdir', 'out', 'fontsize', 14)


a = 10.^log_smoothclimatology_ciliate_all10_20_weekly; 
a1 = 10.^log_smoothclimatology_ciliate_all20_30_weekly;
a2 = (10.^log_smoothclimatology_ciliate_all30_40_weekly_C)-C;
a3 = (10.^log_smoothclimatology_ciliate_all40_inf_weekly_C)-C;
b = smoothclimatology_T_ifcb; 
[RHO,PVAL] = corr(a',b','Type','Spearman');
[RHO1,PVAL1] = corr(a1',b','Type','Spearman');
[RHO2,PVAL2] = corr(a2',b','Type','Spearman');
[RHO3,PVAL3] = corr(a3',b','Type','Spearman');

% figure
% plotyy(yd_wk +7,ciliate_all_biovol10_20_week, '*b', yd_wk,Total_all_sizeclass1_mat_week, '*r' )
% %plotyy(yd_wk,ciliate_all_biovol10_20_week, '*')
% hold on
% %plot(yd_wk, smoothclimatology_ciliate_all_fraction10_20_weekly, '-r')
% %plot(yd_wk+7, smoothclimatology_ciliate_all10_20_weekly, '-r')
% %plot(yd_wk, (smoothclimatology_ciliate_all_fraction10_20_weekly+std_ciliate_all_fraction10_20_weekly), '-b')
% plot(yd_wk+7, (smoothclimatology_ciliate_all10_20_weekly+std_ciliate_all10_20_weekly), '-b')
% %plot(yd_wk, (smoothclimatology_ciliate_all_fraction10_20_weekly-std_ciliate_all_fraction10_20_weekly), '-b')
% %plot(yd_wk+7, (smoothclimatology_ciliate_all10_20_weekly-std_ciliate_all10_20_weekly), '-b')
% %title('10-20 fraction weekly')
% %title('10-20 fraction bi-weekly')
% plot(yd_wk+7,Total_all_sizeclass1_mat_week, '*r')
% hold on
% plot(yd_wk+7, smoothclimatology_Total_all_sizeclass1_mat_week, '-r')
% ylabel('biovolume (\mum{3})/ml', 'fontsize', 14)
% set(gca,'fontsize',14)
% title('10-20 weekly total biovolume')
% datetick ('x', 3)
% %ylim([-900 20000])
% %legend('2006', '2007', '2008', '2009', '2010', '2011', '2012');

figure
subplot1= subplot(2,2,1);
x = (yd_wk+7);
y1 = 10.^log_smoothclimatology_ciliate_all10_20_weekly;
y2 =smoothclimatology_Total_all_sizeclass1_mat_week;
[AX,H1,H2] = plotyy(x,y1,x,y2,'plot');
%set(get(AX(1),'Ylabel'),'string', 'biovolume (\mum{3})/ml', 'fontsize', 14) 
%set(get(AX(2),'Ylabel'),'String','biovolume (\mum{3})/ml', 'fontsize', 14)
%set(gca'fontsize',14)
set(AX(1), 'xlim', [0 366])
set(AX(2), 'xlim', [0 366])
datetick('x',3)
set(AX(2), 'xTickLabel','')% delete the x-tick labels
set(AX(2), 'xtick', []);
%legend ('Ciliate 10-20(\mum)', 'Phytoplankton Size Class 1')
%set(AX(1), 'xTickLabel','')
set(AX(1), 'ytick', [0 2000 4000 6000 8000])
set(AX(2), 'ytick', [0 100000 200000])
set(subplot1, 'fontsize', 14)

%xl= get(AX(1), 'xlim');
%set(AX(2), 'xlim', xl, 'xtick', []);



subplot2 = subplot(2,2,2);
x = (yd_wk+7);
y1 = 10.^log_smoothclimatology_ciliate_all20_30_weekly;
y2 =smoothclimatology_Total_all_sizeclass2_mat_week;
[AX,H1,H2] = plotyy(x,y1,x,y2,'plot');
%set(get(AX(1),'Ylabel'),'string', 'biovolume (\mum{3})/ml', 'fontsize', 14) 
%set(get(AX(2),'Ylabel'),'String','biovolume (\mum{3})/ml', 'fontsize', 14)
%set(gca,'fontsize',14)
set(AX(1), 'xlim', [0 366])
set(AX(2), 'xlim', [0 366])
datetick('x',3)
set(AX(2), 'xTickLabel','')% delete the x-tick labels
set(AX(2), 'xtick', []); % delete the x-tick labels
%legend ('Ciliate 20-30(\mum)', 'Phytoplankton Size Class 2')
% xl= get(AX(1), 'xlim');
% set(AX(2), 'xlim', xl, 'xtick', []);
%set(AX(1), 'xTickLabel','')
set(subplot2, 'fontsize', 14)

subplot3 = subplot(2,2,3);
x = (yd_wk+7);
y1 = (10.^log_smoothclimatology_ciliate_all30_40_weekly_C)-C;
y2 =smoothclimatology_Total_all_sizeclass3_mat_week;
[AX,H1,H2] = plotyy(x,y1,x,y2,'plot');
%set(get(AX(1),'Ylabel'),'string', 'biovolume (\mum{3})/ml', 'fontsize', 14) 
%set(get(AX(2),'Ylabel'),'String','biovolume (\mum{3})/ml', 'fontsize', 14)
set(AX(1), 'xlim', [0 366])
set(AX(2), 'xlim', [0 366])
datetick('x',3)
set(AX(2), 'xTickLabel','')% delete the x-tick labels
set(AX(2), 'xtick', []); % delete the x-tick labels
%legend ('Ciliate 30-40(\mum)', 'Phytoplankton Size Class 3')
% xl= get(AX(1), 'xlim');
% set(AX(2), 'xlim', xl, 'xtick', []);
%set(AX(1), 'xTickLabel','')
set(subplot3, 'fontsize', 14)

subplot4= subplot(2,2,4)
x = (yd_wk+7);
y1 = (10.^log_smoothclimatology_ciliate_all40_inf_weekly_C)-C;
y2 =smoothclimatology_Total_all_sizeclass4_mat_week;
[AX,H1,H2] = plotyy(x,y1,x,y2,'plot');
set(get(AX(1),'Ylabel'),'string', 'biovolume ( \mum^3 mL^-1)', 'fontsize', 14) 
set(get(AX(2),'Ylabel'),'String','biovolume ( \mum^3 mL^-1)', 'fontsize', 14)
set(AX(1), 'xlim', [0 366])
set(AX(2), 'xlim', [0 366])
datetick('x',3)
set(AX(2), 'xTickLabel','')% delete the x-tick labels
set(AX(2), 'xtick', []); % delete the x-tick labels
%legend ('Ciliate 40-inf(\mum)', 'Phytoplankton Size Class 4')
% xl= get(AX(1), 'xlim');
% set(AX(2), 'xlim', xl, 'xtick', []);
set(subplot4, 'fontsize', 14)

% figure
% x = (yd_wk+7);
% y1 = smoothclimatology_ciliate_all40_inf_weekly;
% y2 =smoothclimatology_Total_all_sizeclass5_mat_week;
% [AX,H1,H2] = plotyy(x,y1,x,y2,'plot');
% set(get(AX(1),'Ylabel'),'string', 'biovolume (\mum{3})/ml', 'fontsize', 14) 
% set(get(AX(2),'Ylabel'),'String','biovolume (\mum{3})/ml', 'fontsize', 14)
% set(gca,'fontsize',14)
% set(AX, 'xTickLabel','') % delete the x-tick labels
% datetick ('x', 3)
% legend ('Ciliate 40-inf(\mum)', 'Phytoplankton Size Class 4')

figure
x = (yd_wk+7);
y1 = (10.^log_smoothclimatology_ciliate_all40_inf_weekly_C)-C;
y2 = smoothclimatology_Large_Total;
[AX,H1,H2] = plotyy(x,y1,x,y2);
set(get(AX(1),'Ylabel'),'string', 'biovolume ( \mum^3 mL^-1', 'fontsize', 14) 
set(get(AX(2),'Ylabel'),'String','biovolume ( \mum^3 mL^-1', 'fontsize', 14)
set(gca,'fontsize',14)
set(AX, 'xTickLabel','') % delete the x-tick labels
datetick ('x', 3)
%legend ('Ciliate 40-180(\mum)', 'Phytoplankton Size Class 5')
set(AX(1), 'xlim', [0 367], 'fontsize', 14)
set(AX(2), 'xlim', [0 367], 'fontsize', 14)
set(AX(2), 'xTickLabel','')% delete the x-tick labels
set(AX(2), 'xtick', []);


C=400;
b4 = smoothclimatology_Total_all_sizeclass1_mat_week;
b5 = smoothclimatology_Total_all_sizeclass2_mat_week;
b6 = smoothclimatology_Total_all_sizeclass3_mat_week;
b7 = smoothclimatology_Total_all_sizeclass4_mat_week;
b8 = smoothclimatology_Large_Total;
a4 = 10.^log_smoothclimatology_ciliate_all10_20_weekly;
a5 = 10.^log_smoothclimatology_ciliate_all20_30_weekly;
a6 = (10.^log_smoothclimatology_ciliate_all30_40_weekly_C)-C;
a7 = (10.^log_smoothclimatology_ciliate_all40_inf_weekly_C)-C;
[RHO4,PVAL4] = corr(a4',b4','Type','Spearman');
[RHO5,PVAL5] = corr(a5',b5','Type','Spearman');
[RHO6,PVAL6] = corr(a6',b6','Type','Spearman');
[RHO7,PVAL7] = corr(a7',b7','Type','Spearman');
[RHO8,PVAL8] = corr(a7',b8','Type','Spearman');

C=400;
[log_smoothclimatology_ciliate_all30_40_weekly_C, log_std_ciliate_all30_40_weekly_C] = smoothed_climatology(log10(ciliate_all_biovol30_40_week+ C), 1);
[log_smoothclimatology_ciliate_all40_inf_weekly_C, log_std_ciliate_all40_inf_weekly_C] = smoothed_climatology(log10(ciliate_all_biovol40_inf_week + C), 1);

handle2 = figure; %four subplots of ciliate total biovolume in each size class
set(handle2, 'position', [1 1 1067 525], 'PaperPosition', [0.25 2.5 8 6])
h1 = subplot(2,2,1);
plot(yd_wk +7, ciliate_all_biovol10_20_week, '*')
hold on
plot (yd_wk +7, 10.^(log_smoothclimatology_ciliate_all10_20_weekly), '-r', 'linewidth', 2)
plot(yd_wk +7, 10.^(log_smoothclimatology_ciliate_all10_20_weekly + log_std_ciliate_all10_20_weekly), '-b', 'linewidth', 2)
plot(yd_wk +7, 10.^(log_smoothclimatology_ciliate_all10_20_weekly - log_std_ciliate_all10_20_weekly), '-b', 'linewidth', 2)
ylabel('biovolume ( \mum^3 mL^-1)', 'fontsize', 14)
th = text(30, 18000, 'A.  10-20 \mum', 'fontsize', 10);
datetick ('x', 3)
ylim([-900 20000])
set(h1, 'fontsize', 14, 'position', [0.127 0.609 0.335 0.331])
set(h1, 'ytick', [0:1*10^4:2*10^4])
set(h1, 'yticklabel', [0 1 2])
title('x 10^4', 'fontsize', 14, 'position', [26.293 20062.201 17.321])

h2 = subplot(2,2,2);
plot(yd_wk+7,ciliate_all_biovol20_30_week, '*')
hold on
plot (yd_wk +7, 10.^(log_smoothclimatology_ciliate_all20_30_weekly), '-r', 'linewidth', 2)
plot(yd_wk +7, 10.^(log_smoothclimatology_ciliate_all20_30_weekly + log_std_ciliate_all20_30_weekly), '-b', 'linewidth', 2)
plot(yd_wk +7, 10.^(log_smoothclimatology_ciliate_all20_30_weekly - log_std_ciliate_all20_30_weekly), '-b', 'linewidth', 2)
ylabel('biovolume ( \mum^3 mL^-1)', 'fontsize', 14)
ylim([-3000 70000])
th = text(30, 60000, 'B.  20-30 \mum', 'fontsize', 10);
datetick ('x', 3)
set(h2, 'fontsize', 14, 'position', [0.57 0.609 0.335 0.331])

h3 = subplot(2,2,3);
plot(yd_wk+7,ciliate_all_biovol30_40_week, '*')
hold on
plot (yd_wk +7, 10.^(log_smoothclimatology_ciliate_all30_40_weekly_C)-C, '-r', 'linewidth', 2)
plot(yd_wk +7, 10.^(log_smoothclimatology_ciliate_all30_40_weekly_C + log_std_ciliate_all30_40_weekly_C)-C, '-b', 'linewidth', 2)
plot(yd_wk +7, 10.^(log_smoothclimatology_ciliate_all30_40_weekly_C - log_std_ciliate_all30_40_weekly_C)-C, '-b', 'linewidth', 2)
ylabel('biovolume ( \mum^3 mL^-1)', 'fontsize', 14)
datetick ('x', 3)
%set(gca,'fontsize',14)
ylim([-3000 40000])
th = text(30, 35000, 'C.  30-40 \mum', 'fontsize', 10);
set(h3, 'fontsize', 14, 'position', [0.127 0.162 0.335 0.331])
set(h3, 'ytick', [0:1*10^4:4*10^4])

h4 = subplot(2,2,4);
plot(yd_wk+7,ciliate_all_biovol40_inf_week, '*')
hold on
plot (yd_wk +7, 10.^(log_smoothclimatology_ciliate_all40_inf_weekly_C)-C, '-r', 'linewidth', 2)
plot(yd_wk +7, 10.^(log_smoothclimatology_ciliate_all40_inf_weekly_C + log_std_ciliate_all40_inf_weekly_C)-C, '-b', 'linewidth', 2)
plot(yd_wk +7, 10.^(log_smoothclimatology_ciliate_all40_inf_weekly_C - log_std_ciliate_all40_inf_weekly_C)-C, '-b', 'linewidth', 2)
ylabel('biovolume ( \mum^3 mL^-1)', 'fontsize', 14)
datetick ('x', 3)
handle= legend('2006', '2007', '2008', '2009', '2010', '2011', '2012');
rect= [0.2092 0.0212 0.6392 0.057];
set(handle, 'fontsize', 14, 'Orientation', 'horizontal')
set(handle, 'Position', rect);
%set(gca,'fontsize',14)
ylim([-30000 250000])
th = text(30, 200000, 'D.  40-180 \mum', 'fontsize', 10);
set(h4, 'fontsize', 14, 'position', [0.57 0.162 0.335 0.331])
set(h4, 'ytick', [0:1*10^5:3*10^5])

figure  %stacked bar of ciliate size fractions
bar(yd_wk+7, [(smoothclimatology_ciliate_all_fraction10_20_weekly)',(smoothclimatology_ciliate_all_fraction20_30_weekly)', (smoothclimatology_ciliate_all_fraction30_40_weekly)', (smoothclimatology_ciliate_all_fraction40_inf_weekly)'], 'stacked')
%title('All Ciliate Fraction - bi-weekly bins')
ylabel('fraction of biovolume', 'fontsize', 14)
datetick ('x', 3)
xlim([0 370]);
legend( '10-20', '20-30', '30-40', '40-180')
set(gca,'fontsize',14)

figure
subplot(2,2,1)
plot(yd_wk+7, 10.^log_smoothclimatology_ciliate_all10_20_weekly, '-r', 'linewidth', 2)
hold on
plot(yd_wk+7, 10.^log_std_ciliate_all10_20_weekly, '-b', 'linewidth', 2)
ylabel('biovolume ( \mum^3)', 'fontsize', 14)
set(gca,'fontsize',14)
%title('10-20 weekly mean and std')
legend('mean', 'std');
datetick ('x', 3)
th = text(30, 5500, 'A.  10-20 \mum', 'fontsize', 12);

subplot(2,2,2)
plot(yd_wk+7, 10.^log_smoothclimatology_ciliate_all20_30_weekly, '-r', 'linewidth', 2)
hold on
plot(yd_wk+7, 10.^log_std_ciliate_all20_30_weekly, '-b', 'linewidth', 2)
%ylabel('biovolume (\mum{3})', 'fontsize', 14)
set(gca,'fontsize',14)
%title('20-30 weekly mean and std')
%legend('mean', 'std');
datetick ('x', 3)
th = text(30, 18000, 'B.  20-30 \mum', 'fontsize', 12);

subplot(2,2,3)
plot(yd_wk+7, (10.^log_smoothclimatology_ciliate_all30_40_weekly_C)-C, '-r', 'linewidth', 2)
hold on
plot(yd_wk+7, (10.^log_std_ciliate_all30_40_weekly_C)-C, '-b', 'linewidth', 2)
%ylabel('biovolume (\mum{3})', 'fontsize', 14)
set(gca,'fontsize',14)
%title('30-40 weekly mean and std')
%legend('mean', 'std');
datetick ('x', 3)
th = text(30, 13000, 'C.  30-40 \mum', 'fontsize', 12);

subplot(2,2,4)
plot(yd_wk+7, 10.^(log_smoothclimatology_ciliate_all40_inf_weekly_C)-C, '-r', 'linewidth', 2)
hold on
plot(yd_wk+7, 10.^(log_std_ciliate_all40_inf_weekly_C)-C, '-b', 'linewidth', 2)
%ylabel('biovolume (\mum{3})', 'fontsize', 14)
set(gca,'fontsize',14)
%title('40-inf weekly mean and std')
%legend('mean', 'std');
datetick ('x', 3)
th = text(30, 80000, 'D.  40-180 \mum', 'fontsize', 12);