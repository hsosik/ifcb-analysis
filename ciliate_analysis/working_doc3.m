

load '/Volumes/IFCB010_OkeanosExplorerAug2013/data/Manual_fromClass/summary/count_manual_19Jan2014.mat'
ciliate_classcount_IFCB10=classcount(9:73,72:92);
ciliate_classcount_IFCB10_total=sum(ciliate_classcount_IFCB10,2);
ciliate_bin_perml_IFCB10=sum(ciliate_classcount_IFCB10_total)/sum(ml_analyzed(9:73));
[IFCB10_ci] = poisson_count_ci(sum(ciliate_classcount_IFCB10_total), 0.95);
IFCB10_ci_ml=IFCB10_ci/sum(ml_analyzed(9:73));

load '/Volumes/IFCB014_OkeanosExplorerAug2013/data/Manual_fromClass/summary_old/alt_summary_old/count_manual_highhigh2_green05Feb2014.mat'
ciliate_classcount_high_green=classcount(2:16,72:92);
ciliate_classcount_high_green_total=sum(ciliate_classcount_high_green,2);
ciliate_bin_perml_high_green=sum(ciliate_classcount_high_green_total)/sum(ml_analyzed(2:16));
[high_green_ci] = poisson_count_ci(sum(ciliate_classcount_high_green_total), 0.95);
high_green_ci_ml=high_green_ci/sum(ml_analyzed(2:16));

load '/Volumes/IFCB014_OkeanosExplorerAug2013/data/Manual_fromClass/summary_old/alt_summary_old/count_manual_lowlow2_green05Feb2014.mat'
ciliate_classcount_low_green=classcount(2:16,72:92);
ciliate_classcount_low_green_total=sum(ciliate_classcount_low_green,2);
ciliate_bin_perml_low_green=sum(ciliate_classcount_low_green_total)/sum(ml_analyzed(2:16));
[low_green_ci] = poisson_count_ci(sum(ciliate_classcount_low_green_total), 0.95);
low_green_ci_ml=low_green_ci/sum(ml_analyzed(2:16));

lower=[IFCB10_ci_ml(1) low_green_ci_ml(1) high_green_ci_ml(1)];
upper=[IFCB10_ci_ml(2) low_green_ci_ml(2) high_green_ci_ml(2)];
 

xaxis=[1 2];
red = [0.448 0.5195]';
green = [0 1.2507]';
points=[0.448 0.5195 1.7702];
xaxis_2=[1 2 2];


% Create a stacked bar chart using the bar function
figure;
bar1= bar(xaxis, [red green], 0.5, 'stack');
hold on
plot(xaxis_2, points, '.k', 'markersize', 0.1);
errorbar(xaxis_2, points, lower, upper, 'r', 'Marker', 'none', 'LineStyle', 'none', 'Linewidth', 1 , 'color' ,[0 0 0]);
set(bar1(1),'FaceColor',[0 0 1]);
set(bar1(2),'FaceColor',[0 1 0]);
ylabel('Ciliate abundance (cell mL^{-1})\bf', 'fontsize',24, 'fontname', 'Times New Roman');
set(gca,'xticklabel',{'Traditional IFCB','Staining IFCB'}, 'fontsize', 24, 'fontname', 'Times New Roman');
axis square

%%

load '/Volumes/IFCB014_OkeanosExplorerAug2013/data/continuous/Manual_fromClass/D20130825T161009_IFCB014.mat'
adcdata=load ('/Volumes/IFCB014_OkeanosExplorerAug2013/data/continuous/D20130825T161009_IFCB014.adc');
% use IFCB 14  D20130825T161009_IFCB014
%Lysotracker_analysis
%refline(0.020, 0.0033)
chl = adcdata(:,5); green = adcdata(:,4);
low_green_ind = find(green < ((chl-0.0033)/0.020));%low green
high_green_ind = find(green >= ((chl-0.0033)/0.020));
ciliate_roi_ind=find(~isnan(classlist(:,4)));

ciliate_high_green=find(green >= ((chl-0.0033)/0.020) & ~isnan(classlist(:,4)));




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

m = 0.020; b = 0.0033;  x = 0.0001:0.01:2;
plot((adcdata(:,4)),(adcdata(:,5)), '.', 'markersize',10);
hold on
%plot(green(low_green_ind), chl(low_green_ind), '*','markersize', 2)
plot(green(ciliate_high_green), chl(ciliate_high_green), 'g.','markersize', 30)
plot(green(high_green_ind(7:11)), chl(high_green_ind(7:11)), 'g.','markersize', 30)
hold on
plot(x, m*x+b, '-k');
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


