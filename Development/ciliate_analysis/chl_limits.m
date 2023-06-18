load '/Users/markmiller/Documents/Experiments/IFCB_14/Chl_limits/9-29-14/Manual_fromClass/summary/count_manual_29Sep2014.mat'

Ciliate_mix_classcount_perml=classcount(:,73)./ml_analyzed;
Mesodinium_classcount_perml=classcount(:,78)./ml_analyzed;
%Pleuronema_classcount_perml=classcount(17:22,78)./ml_analyzed(17:22);
Laboea_classcount_perml=classcount(:,76)./ml_analyzed;
Tontonia_classcount_perml=classcount(:,92)./ml_analyzed;
Tintinnid_classcount_perml=classcount(:,91)./ml_analyzed;

all_ciliate_classcount=sum(classcount(:,73:93),2);
all_ciliate_classcount_perml=all_ciliate_classcount./ml_analyzed;
[all_ciliate_ci] = poisson_count_ci(all_ciliate_classcount, 0.95);
lower_all_ciliate_ci_ml=all_ciliate_ci(:,1)./ml_analyzed;
upper_all_ciliate_ci_ml=all_ciliate_ci(:,2)./ml_analyzed;

lower=[all_ciliate_classcount_perml-lower_all_ciliate_ci_ml];
upper=[upper_all_ciliate_ci_ml-all_ciliate_classcount_perml];

figure
bar(1:8,[Ciliate_mix_classcount_perml Mesodinium_classcount_perml Laboea_classcount_perml Tontonia_classcount_perml Tintinnid_classcount_perml],0.5,'stack');
hold on
plot(1:8, all_ciliate_classcount_perml, '.k', 'markersize', 0.1);
errorbar(1:8, all_ciliate_classcount_perml, lower, upper, 'r', 'Marker', 'none', 'LineStyle', 'none', 'Linewidth', 1 , 'color' ,[0 0 0]);
ylabel('Ciliates (mL^{-1})', 'fontsize', 12, 'fontname', 'arial');
set(gca,'xticklabel',{'no stain','stain','no stain','stain','no stain','stain','no stain','stain'}, 'fontsize', 12, 'fontname', 'arial');
%axis square
title('Automated staining 5-9-14')
legend('Ciliate_mix', 'Mesodinium','Laboea','Tontonia', 'tintinnid');

%% NO STAIN, ALT SETTINGS, CHL TRIGGER ONLY

load '/Users/markmiller/Documents/Experiments/IFCB_14/Chl_limits/9-29-14/Manual_fromClass/D20140929T212316_IFCB014.mat'
adcdata=load ('/Users/markmiller/Documents/Experiments/IFCB_14/Chl_limits/9-29-14/D20140929T212316_IFCB014.adc');
% use IFCB 14  D20130825T161009_IFCB014
%Lysotracker_analysis
%refline(0.020, 0.0033)
chl = adcdata(:,5); green = adcdata(:,4); scattering = adcdata(:,3);



low_green_ind = find(chl >= 0.0038);%low green
high_green_ind = find(chl < 0.0038);
ciliate_roi_ind=find(~isnan(classlist(:,4)));
gyro_roi_ind=find(classlist(:,3)==36);

ciliate_high_green=find((chl < 0.0038) & ~isnan(classlist(:,4)));
gyro_high_green=find((chl < 0.0038) & classlist(:,3)==36);


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

%% STAIN, ALT SETTINGS, CHL % GREEN TRIGGER ONLY

load '/Users/markmiller/Documents/Experiments/IFCB_14/Chl_limits/9-29-14/Manual_fromClass/D20140929T214512_IFCB014.mat'
adcdata=load ('/Users/markmiller/Documents/Experiments/IFCB_14/Chl_limits/9-29-14/D20140929T214512_IFCB014.adc');
% use IFCB 14  D20130825T161009_IFCB014
%Lysotracker_analysis
%refline(0.020, 0.0033)
chl = adcdata(:,5); green = adcdata(:,4); scattering = adcdata(:,3);

low_green_ind = find(chl >= 0.0038);%low green
high_green_ind = find(chl < 0.0038);
ciliate_roi_ind=find(~isnan(classlist(:,4)));
gyro_roi_ind=find(classlist(:,3)==36);

ciliate_high_green=find((chl < 0.0038) & ~isnan(classlist(:,4)));
gyro_high_green=find((chl < 0.0038) & classlist(:,3)==36);


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


%% NO STAIN, ALT SETTINGS, CHL TRIGGER ONLY

adcdata=load ('/Users/markmiller/Documents/Experiments/IFCB_14/Chl_limits/9-29-14/D20140929T212316_IFCB014.adc');
load '/Users/markmiller/Documents/Experiments/IFCB_14/Chl_limits/9-29-14/Manual_fromClass/D20140929T212316_IFCB014.mat'
load '/Users/markmiller/Documents/Experiments/IFCB_14/Chl_limits/9-29-14/Manual_fromClass/summary/count_manual_29Sep2014.mat';

IFCB_14_ciliate_roi_ind=find(~isnan(classlist(:,4)));

figure
plot(log10(adcdata(2:end,7)),log10(adcdata(2:end,9)),'.','markersize',20)
hold on
plot(log10(adcdata(IFCB_14_ciliate_roi_ind,7)),log10(adcdata(IFCB_14_ciliate_roi_ind,9)),'r.','markersize',20)
title('No stain, Alt settings, Chl trigger')
ylabel('Chl fluorescence')
%xlabel('roi number')
xlabel('scattering')


figure
plot(adcdata(2:end,7),adcdata(2:end,9),'.','markersize',20)
hold on
plot((adcdata(IFCB_14_ciliate_roi_ind,7)),(adcdata(IFCB_14_ciliate_roi_ind,9)),'r.','markersize',20)
title('No stain, Alt settings, Chl trigger')
ylabel('Chl fluorescence')
%xlabel('roi number')
xlabel('scattering')



%% STAIN, ALT SETTINGS, CHL % GREEN TRIGGER ONLY

load '/Users/markmiller/Documents/Experiments/IFCB_14/Chl_limits/9-29-14/Manual_fromClass/D20140929T214512_IFCB014.mat'
adcdata=load ('/Users/markmiller/Documents/Experiments/IFCB_14/Chl_limits/9-29-14/D20140929T214512_IFCB014.adc');
load '/Users/markmiller/Documents/Experiments/IFCB_14/Chl_limits/9-29-14/Manual_fromClass/summary/count_manual_29Sep2014.mat';

IFCB_14_ciliate_roi_ind=find(~isnan(classlist(:,4)));

figure
plot(adcdata(2:end,1),log10(adcdata(2:end,9)),'.','markersize',20)
hold on
plot(adcdata(IFCB_14_ciliate_roi_ind,1),log10(adcdata(IFCB_14_ciliate_roi_ind,9)),'r.','markersize',20)
title('IFCB 14 CHL-cruise')
title('Stain, Alt settings, Chl and Green trigger')
ylabel('Chl fluorescence')
xlabel('roi number')


