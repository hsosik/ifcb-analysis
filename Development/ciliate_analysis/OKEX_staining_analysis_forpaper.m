

load '/Volumes/IFCB_products/IFCB010_OkeanosExplorerAug2013/Manual_fromClass/summary/count_manual_19Jan2014.mat'
ciliate_classcount_IFCB10=classcount(9:73,72:92);
gyro_classcount_IFCB10_total=classcount(9:73,36);
ciliate_classcount_IFCB10_total=sum(ciliate_classcount_IFCB10,2);
ciliate_bin_perml_IFCB10=sum(ciliate_classcount_IFCB10_total)/sum(ml_analyzed(9:73));
gyro_bin_perml_IFCB10=sum(gyro_classcount_IFCB10_total)/sum(ml_analyzed(9:73));
[IFCB10_ci] = poisson_count_ci(sum(ciliate_classcount_IFCB10_total), 0.95);
IFCB10_ci_ml=IFCB10_ci/sum(ml_analyzed(9:73));
[IFCB10_ci_gyro] = poisson_count_ci(sum(gyro_classcount_IFCB10_total), 0.95);
IFCB10_ci_ml_gyro=IFCB10_ci_gyro/sum(ml_analyzed(9:73));

load '/Users/markmiller/Documents/Experiments/OKEX_Cruise/summary_old/alt_summary_old/count_manual_highhigh_green05Feb2014.mat'
ciliate_classcount_high_green=classcount_lowgreen(2:16,72:92);
ciliate_classcount_high_green_total=sum(ciliate_classcount_high_green,2);
ciliate_bin_perml_high_green=sum(ciliate_classcount_high_green_total)/sum(ml_analyzed_lowgreen(2:16));
[high_green_ci] = poisson_count_ci(sum(ciliate_classcount_high_green_total), 0.95);
high_green_ci_ml=high_green_ci/sum(ml_analyzed_lowgreen(2:16));

gyro_classcount_high_green_total=classcount_lowgreen(2:16,36);
gyro_bin_perml_high_green=sum(gyro_classcount_high_green_total)/sum(ml_analyzed_lowgreen(2:16));
[high_green_ci_gyro] = poisson_count_ci(sum(gyro_classcount_high_green_total), 0.95);
high_green_ci_ml_gyro=high_green_ci_gyro/sum(ml_analyzed_lowgreen(2:16));

load '/Users/markmiller/Documents/Experiments/OKEX_Cruise/summary_old/alt_summary_old/count_manual_lowlow2_green05Feb2014.mat'
ciliate_classcount_low_green=classcount_lowgreen(2:16,72:92);
ciliate_classcount_low_green_total=sum(ciliate_classcount_low_green,2);
ciliate_bin_perml_low_green=sum(ciliate_classcount_low_green_total)/sum(ml_analyzed_lowgreen(2:16));
[low_green_ci] = poisson_count_ci(sum(ciliate_classcount_low_green_total), 0.95);
low_green_ci_ml=low_green_ci/sum(ml_analyzed_lowgreen(2:16));

gyro_classcount_low_green_total=classcount_lowgreen(2:16,36);
gyro_bin_perml_low_green=sum(gyro_classcount_low_green_total)/sum(ml_analyzed_lowgreen(2:16));
[low_green_ci_gyro] = poisson_count_ci(sum(gyro_classcount_low_green_total), 0.95);
low_green_ci_ml_gyro=low_green_ci_gyro/sum(ml_analyzed_lowgreen(2:16));

% lower=[IFCB10_ci_ml(1) low_green_ci_ml(1) high_green_ci_ml(1)];
% upper=[IFCB10_ci_ml(2) low_green_ci_ml(2) high_green_ci_ml(2)];

lower=[IFCB10_ci_ml(1) low_green_ci_ml(1) high_green_ci_ml(1) IFCB10_ci_ml_gyro(1)  low_green_ci_ml_gyro(1)  high_green_ci_ml_gyro(1)];
upper=[IFCB10_ci_ml(2) low_green_ci_ml(2) high_green_ci_ml(2) IFCB10_ci_ml_gyro(2)  low_green_ci_ml_gyro(2)  high_green_ci_ml_gyro(2)];
 

lower=[ciliate_bin_perml_IFCB10-IFCB10_ci_ml(1) ciliate_bin_perml_low_green-low_green_ci_ml(1) ciliate_bin_perml_high_green-high_green_ci_ml(1) gyro_bin_perml_IFCB10-IFCB10_ci_ml_gyro(1) gyro_bin_perml_low_green-low_green_ci_ml_gyro(1) gyro_bin_perml_high_green-high_green_ci_ml_gyro(1)];
upper=[IFCB10_ci_ml(2)-ciliate_bin_perml_IFCB10 low_green_ci_ml(2)-ciliate_bin_perml_low_green high_green_ci_ml(2)-ciliate_bin_perml_high_green IFCB10_ci_ml_gyro(2)-gyro_bin_perml_IFCB10 low_green_ci_ml_gyro(2)-gyro_bin_perml_low_green high_green_ci_ml_gyro(2)-gyro_bin_perml_high_green];



% xaxis=[1 2];
% red = [0.448 0.5195]';
% green = [0 1.2507]';
% points=[0.448 0.5195 1.7702];
% xaxis_2=[1 2 2];

xaxis=[1 2 3 4];
red = [0.448 0.3848 0.1706 0.0495]';
green = [0 1.2507 0 0.3463]';
points=[0.448 0.3848 1.6355 0.1706 0.0577 0.4040];
xaxis_2=[1 2 2 3 4 4];


% Create a stacked bar chart using the bar function
figure;
bar1= bar(xaxis, [red green], 0.8, 'stack');
hold on
plot(xaxis_2, points, '.k', 'markersize', 0.1);
errorbar(xaxis_2, points, lower, upper, 'r', 'Marker', 'none', 'LineStyle', 'none', 'Linewidth', 0.5 , 'color' ,[0 0 0]);
set(bar1(1),'FaceColor',[0 0 1]);
set(bar1(2),'FaceColor',[0 1 0]);
ylabel('Cell concentration (cell mL^{-1})\bf', 'fontsize',16, 'fontname', 'Times New Roman');
set(gca,'xticklabel',{'IFCB','IFCB-S'}, 'fontsize', 16, 'fontname', 'Times New Roman');
axis square
title('Ciliate mix        Gyrodinoid','fontsize', 16, 'fontname', 'Times New Roman')
legend('High chl fluorescence', 'Low chl fluorescence')

%%

load '/Volumes/IFCB014_OkeanosExplorerAug2013/data/continuous/Manual_fromClass/D20130825T161009_IFCB014.mat'
adcdata=load ('/Volumes/IFCB014_OkeanosExplorerAug2013/data/continuous/D20130825T161009_IFCB014.adc');
% use IFCB 14  D20130825T161009_IFCB014
%Lysotracker_analysis
%refline(0.020, 0.0033)
chl = adcdata(:,5); green = adcdata(:,4); scattering = adcdata(:,3);

%OLD CURVED LINE
% low_green_ind = find(green < ((chl-0.0033)/0.020));%low green
% high_green_ind = find(green >= ((chl-0.0033)/0.020));
% ciliate_roi_ind=find(~isnan(classlist(:,4)));
% gyro_roi_ind=find(classlist(:,3)==36);
% 
% ciliate_high_green=find(green >= ((chl-0.0033)/0.020) & ~isnan(classlist(:,4)));
% gyro_high_green=find(green >= ((chl-0.0033)/0.020) & classlist(:,3)==36);

low_green_ind = find(chl >= 0.0019);%low green %middle 0.0038
high_green_ind = find(chl < 0.0019);
ciliate_roi_ind=find(~isnan(classlist(:,4)));
gyro_roi_ind=find(classlist(:,3)==36);

ciliate_high_green=find((chl < 0.0019) & ~isnan(classlist(:,4)));
gyro_high_green=find((chl < 0.0019) & classlist(:,3)==36);


figure1 = figure;

% Create axes
axes1 = axes('Parent',figure1,'YScale','log','YMinorTick','on',...
    'XScale','log',...
    'XMinorTick','on',...
    'PlotBoxAspectRatio',[1 1 1],...
    'FontSize',14);
box(axes1,'on');
hold(axes1,'all');
hold on

m = 0.020; b = 0.0033;  x = 0.0001:0.01:2;
%plot((adcdata(:,4)),(adcdata(:,5)), '*', 'markersize', 1);
plot(green(low_green_ind), chl(low_green_ind), '*','markersize', 2)
plot(green(high_green_ind), chl(high_green_ind), 'g*','markersize', 4)
hold on
plot(x, m*x+b, '-k');
xlim([0.0016 0.3])
ylim([0.0025 0.11])
axis square
ylabel('Chlorophyll fluorescence', 'fontsize', 24, 'fontname', 'arial');
xlabel('FDA fluorescence','fontsize', 24, 'fontname', 'arial');
set(gca, 'FontSize',24);

%%

figure2 = figure;

% Create axes
axes1 = axes('Parent',figure2,'YScale','log','YMinorTick','on',...
    'XScale','log',...
    'XMinorTick','on',...
    'PlotBoxAspectRatio',[1 1 1],...
    'FontSize',14);
box(axes1,'on');
hold(axes1,'all');
hold on

%m = 0.020; b = 0.0033;  x = 0.0001:0.01:2; %curved lined
m = 0; b = 0.0037;  x = 0.0001:0.01:2;
plot((adcdata(:,4)),(adcdata(:,5)), '.', 'markersize',10);
hold on
%plot(green(low_green_ind), chl(low_green_ind), '*','markersize', 2)
plot(green(ciliate_roi_ind), chl(ciliate_roi_ind), 'r.','markersize', 30)
plot(green(gyro_roi_ind), chl(gyro_roi_ind), 'c.','markersize', 30)
plot(green(ciliate_high_green), chl(ciliate_high_green), 'g.','markersize', 30)
plot(green(gyro_high_green), chl(gyro_high_green), 'm.','markersize', 30)
plot(green(high_green_ind(7:11)), chl(high_green_ind(7:11)), 'g.','markersize', 30)
hold on
%plot(x, m*x+b, '-k');%curved line
plot(x, 10.^b.*x.^m, '-k');
xlim([0.0016 0.3])
ylim([0.0025 0.11])
axis square
ylabel('Chlorophyll fluorescence', 'fontsize', 24, 'fontname', 'arial');
xlabel('FDA fluorescence','fontsize', 24, 'fontname', 'arial');
set(gca, 'FontSize',24);
%  figure
% plot((adcdata(:,4)),(adcdata(:,5)), '*', 'markersize', 1);
% hold on
% m = 0.03; b = 0.0033;  x = 0.0001:0.01:0.2;
% plot(x, m*x+b, '-r');
% xlim([0 0.2]);
% ylim([0 0.03]);


%refline(0.03, .0033)
%%
figure3 = figure;

% Create axes
axes1 = axes('Parent',figure3,'YScale','log','YMinorTick','on',...
    'XScale','log',...
    'XMinorTick','on',...
    'PlotBoxAspectRatio',[1 1 1],...
    'FontSize',14);
box(axes1,'on');
hold(axes1,'all');
hold on

%m = 0.020; b = 0.0033;  x = 0.0001:0.01:2;
plot(adcdata(:,3),(adcdata(:,5)./adcdata(:,4)), '.', 'markersize',10);
hold on
%plot(green(ciliate_high_green), chl(ciliate_high_green), 'g.','markersize', 30)
%plot(green(high_green_ind(7:11)), chl(high_green_ind(7:11)), 'g.','markersize', 30)
plot(scattering(high_green_ind(7:11)), chl(high_green_ind(7:11))./green(high_green_ind(7:11)), 'g.','markersize', 30)
plot(scattering(ciliate_high_green), chl(ciliate_high_green)./green(ciliate_high_green), 'g.','markersize', 30)
hold on
%plot(x, m*x+b, '-k');
% xlim([0.0016 0.3])
% ylim([0.0025 0.11])
axis square
ylabel('Chlorophyll: Green fluorescence', 'fontsize', 24, 'fontname', 'arial');
xlabel('SSC','fontsize', 24, 'fontname', 'arial');
set(gca, 'FontSize',24);
%%

figure4 = figure;

% Create axes
axes1 = axes('Parent',figure4,'YScale','log','YMinorTick','on',...
    'XScale','log',...
    'XMinorTick','on',...
    'PlotBoxAspectRatio',[1 1 1],...
    'FontSize',14);
box(axes1,'on');
hold(axes1,'all');
hold on

%m = 0.020; b = 0.0033;  x = 0.0001:0.01:2;
plot(adcdata(:,3), adcdata(:,4), '.', 'markersize',10);
hold on
%plot(green(ciliate_high_green), chl(ciliate_high_green), 'g.','markersize', 30)
%plot(green(high_green_ind(7:11)), chl(high_green_ind(7:11)), 'g.','markersize', 30)
plot(scattering(ciliate_roi_ind), green(ciliate_roi_ind), 'r.','markersize', 30)
plot(scattering(high_green_ind(7:11)), green(high_green_ind(7:11)), 'g.','markersize', 30)
plot(scattering(ciliate_high_green), green(ciliate_high_green), 'g.','markersize', 30)
hold on
%plot(x, m*x+b, '-k');
% xlim([0.0016 0.3])
% ylim([0.0025 0.11])
axis square
ylabel('Green fluorescence', 'fontsize', 24, 'fontname', 'arial');
xlabel('SSC','fontsize', 24, 'fontname', 'arial');
set(gca, 'FontSize',24);
xlim([0.001 10])


%export_png_from_ROIlist('/Volumes/IFCB014_OkeanosExplorerAug2013/data/continuous//D20130825T161009_IFCB014.roi', [489 1391 380 1303 1149 1257 1383 3693 41 57 198 187 50 98 184 201 94 95 234 398 245 421 266 571 642 616 543 620 631 769 309 694 681 676 721 971 948 990 1062 953 954 979 1217 1122 1664 1592 1881 2149 2065 2026 2020 2062 2240 2570 2548 3143 3207 3575 5883])





