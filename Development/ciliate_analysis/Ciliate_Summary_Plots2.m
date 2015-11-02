mean10_20=nanmean(ciliate_all_biovol10_20_week, 2);
std10_20=nanstd(ciliate_all_biovol10_20_week, 0, 2);
mean20_30=nanmean(ciliate_all_biovol20_30_week, 2);
std20_30=nanstd(ciliate_all_biovol20_30_week, 0, 2);
mean30_40=nanmean(ciliate_all_biovol30_40_week, 2);
std30_40=nanstd(ciliate_all_biovol30_40_week, 0, 2);
mean40_inf=nanmean(ciliate_all_biovol40_inf_week, 2);
std40_inf=nanstd(ciliate_all_biovol40_inf_week, 0, 2);



[log_smoothclimatology_ciliate_all10_20_weekly, log_std_ciliate_all10_20_weekly] = smoothed_climatology(log10(ciliate_all_biovol10_20_week), 1);
[log_smoothclimatology_ciliate_all20_30_weekly, log_std_ciliate_all20_30_weekly] = smoothed_climatology(log10(ciliate_all_biovol20_30_week), 1);
[log_smoothclimatology_ciliate_all30_40_weekly, log_std_ciliate_all30_40_weekly] = smoothed_climatology(log10(ciliate_all_biovol30_40_week), 1);
[log_smoothclimatology_ciliate_all40_inf_weekly, log_std_ciliate_all40_inf_weekly] = smoothed_climatology(log10(ciliate_all_biovol40_inf_week), 1);
C=400;
[log_smoothclimatology_ciliate_all30_40_weekly_C, log_std_ciliate_all30_40_weekly_C] = smoothed_climatology(log10(ciliate_all_biovol30_40_week+ C), 1);
[log_smoothclimatology_ciliate_all40_inf_weekly_C, log_std_ciliate_all40_inf_weekly] = smoothed_climatology(log10(ciliate_all_biovol40_inf_week + C), 1);

figure
plot(yd_wk +7,ciliate_all_biovol30_40_week, '*')
hold on
plot (yd_wk +7, 10.^(log_smoothclimatology_ciliate_all30_40_weekly_C)-C, '-r')
plot(yd_wk +7, 10.^(log_smoothclimatology_ciliate_all30_40_weekly_C + log_std_ciliate_all30_40_weekly_C)-C, '-b')
plot(yd_wk +7, 10.^(log_smoothclimatology_ciliate_all30_40_weekly_C - log_std_ciliate_all30_40_weekly_C)-C, '-b')
ylabel('biovolume (\mum{3})', 'fontsize', 14)
set(gca,'fontsize',14)
title('30-40 ')
datetick ('x', 3)
%ylim([-1200 20000])
%legend('2006', '2007', '2008', '2009', '2010', '2011', '2012')

figure
plot(yd_wk +7,10.^(log_smoothclimatology_ciliate_all30_40_weekly_C)-C, '-r')
hold on
plot(yd_wk +7,10.^(log_smoothclimatology_ciliate_all30_40_weekly), '-r')


figure
plot(yd_wk +7, log_smoothclimatology_ciliate_all10_20_weekly, '-r')
hold on
plot(yd_wk +7, log_std_ciliate_all10_20_weekly, '-b')



figure
subplot(2,2,1)
plot(yd_wk +7,ciliate_all_biovol10_20_week, '*')
hold on
plot (yd_wk +7, mean10_20, '-r')
plot(yd_wk +7, mean10_20+std10_20, '-b')
plot(yd_wk +7, mean10_20-std10_20, '-b')
ylabel('biovolume (\mum{3})', 'fontsize', 14)
set(gca,'fontsize',14)
title('10-20 ')
datetick ('x', 3)
ylim([-1200 20000])
%legend('2006', '2007', '2008', '2009', '2010', '2011', '2012')

subplot(2,2,2)
plot(yd_wk +7,ciliate_all_biovol20_30_week, '*')
hold on
plot (yd_wk +7, mean20_30, '-r')
plot(yd_wk +7, mean20_30+std20_30, '-b')
plot(yd_wk +7, mean20_30-std20_30, '-b')
ylabel('biovolume (\mum{3})', 'fontsize', 14)
set(gca,'fontsize',14)
title('20-30')
datetick ('x', 3)
ylim([-3000 70000])
%legend('2006', '2007', '2008', '2009', '2010', '2011', '2012')

subplot(2,2,3)
plot(yd_wk +7,ciliate_all_biovol30_40_week, '*')
hold on
plot (yd_wk +7, mean30_40, '-r')
plot(yd_wk +7, mean30_40+std30_40, '-b')
plot(yd_wk +7, mean30_40-std30_40, '-b')
ylabel('biovolume (\mum{3})', 'fontsize', 14)
set(gca,'fontsize',14)
title('30-40')
datetick ('x', 3)
ylim([-3000 40000])
%legend('2006', '2007', '2008', '2009', '2010', '2011', '2012')

subplot(2,2,4)
plot(yd_wk +7,ciliate_all_biovol40_inf_week, '*')
hold on
plot (yd_wk +7, mean40_inf, '-r')
plot(yd_wk +7, mean40_inf+std40_inf, '-b')
plot(yd_wk +7, mean40_inf-std40_inf, '-b')
ylabel('biovolume (\mum{3})', 'fontsize', 14)
set(gca,'fontsize',14)
title('40-180 ')
datetick ('x', 3)
ylim([-30000 250000])
handle= legend('2006', '2007', '2008', '2009', '2010', '2011', '2012');
rect= [0.2092 0.0212 0.6392 0.057];
set(handle, 'fontsize', 14, 'Orientation', 'horizontal')
%set(handle, 'Position', rect);


C=400;
figure
subplot(2,2,1)
scatter(smoothclimatology_T_ifcb,10.^log_smoothclimatology_ciliate_all10_20_weekly, '*');
xlabel('Temperature ( \circC)', 'fontsize', 14)
ylabel('biovolume ( \mum^3 mL^-1)', 'fontsize', 14)
set(gca,'fontsize',14)
th = text(2, 5500, 'A.  10-20 \mum', 'fontsize', 12);

subplot(2,2,2)
scatter(smoothclimatology_T_ifcb,10.^log_smoothclimatology_ciliate_all20_30_weekly, '*');
xlabel('Temperature ( \circC)', 'fontsize', 14)
ylabel('biovolume ( \mum^3 mL^-1)', 'fontsize', 14)
set(gca,'fontsize',14)
th = text(2, 13000, 'B.  20-30 \mum', 'fontsize', 12);

subplot(2,2,3)
scatter(smoothclimatology_T_ifcb,(10.^log_smoothclimatology_ciliate_all30_40_weekly_C)-C, '*');
xlabel('Temperature ( \circC)', 'fontsize', 14)
ylabel('biovolume ( \mum^3 mL^-1)', 'fontsize', 14)
set(gca,'fontsize',14)
th = text(2, 8000, 'C.  30-40 \mum', 'fontsize', 12);

subplot(2,2,4)
scatter(smoothclimatology_T_ifcb,(10.^log_smoothclimatology_ciliate_all40_inf_weekly_C)-C, '*');
xlabel('Temperature ( \circC)', 'fontsize', 14)
ylabel('biovolume ( \mum^3 mL^-1)', 'fontsize', 14)
set(gca,'fontsize',14)
th = text(2, 50000, 'D.  40-180 \mum', 'fontsize', 12);

figure
scatter((10.^log_smoothclimatology_ciliate_all40_inf_weekly_C)-C,smoothclimatology_Large_Total, '*');
xlabel('Temperature ( \circC)', 'fontsize', 14)
ylabel('40-180 Biovolume')
set(gca,'fontsize',14)

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



