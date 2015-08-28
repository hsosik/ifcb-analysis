%ALT
%July
adcdata=load('/Users/markmiller/Documents/Experiments/IFCB_14/Microscopy_vs_Imager/7-2-14/D20140702T135601_IFCB014.adc');
%load '/Users/markmiller/Documents/IFCB14_Pisces/data/Manual_fromClass/D20141103T230846_IFCB014.mat'
% use IFCB 14  D20130825T161009_IFCB014
%Lysotracker_analysis
%refline(0.020, 0.0033)
chl = adcdata(:,5); green = adcdata(:,4); scattering = adcdata(:,3);

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

plot(green, chl, '*','markersize', 2)
%plot(green(high_green_ind), chl(high_green_ind), 'g*','markersize', 4)
hold on
%plot(x, m*x+b, '-k');
xlim([0.0017 1])
% ylim([0.0035 0.9])
axis square
ylabel('Chlorophyll fluorescence', 'fontsize', 24, 'fontname', 'arial');
xlabel('FDA fluorescence','fontsize', 24, 'fontname', 'arial');
set(gca, 'FontSize',24);

chl = adcdata(:,9); green = adcdata(:,8); scattering = adcdata(:,7);

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

plot(green, chl, '*','markersize', 2)
hold on
% plot(green(661), chl(661), 'r*','markersize', 10)
% plot(green(496), chl(496), 'r*','markersize', 10)
% plot(green(837), chl(837), 'g*','markersize', 10)
hold on
%plot(x, m*x+b, '-k');
% xlim([0.0017 0.1])
% ylim([0.0045 0.9])

axis square
ylabel('Chlorophyll fluorescence', 'fontsize', 24, 'fontname', 'arial');
xlabel('FDA fluorescence','fontsize', 24, 'fontname', 'arial');
set(gca, 'FontSize',24);
%%

%ALT
%September
adcdata=load('/Users/markmiller/Documents/Experiments/D20141018T025314_IFCB014.adc');
%load '/Users/markmiller/Documents/IFCB14_Pisces/data/Manual_fromClass/D20141103T230846_IFCB014.mat'
% use IFCB 14  D20130825T161009_IFCB014
%Lysotracker_analysis
%refline(0.020, 0.0033)
chl = adcdata(:,5); green = adcdata(:,4); scattering = adcdata(:,3);

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

plot(green, chl, '*','markersize', 2)
%plot(green(high_green_ind), chl(high_green_ind), 'g*','markersize', 4)
hold on
%plot(x, m*x+b, '-k');
xlim([0.0017 0.1])
ylim([0.0035 0.9])
axis square
ylabel('Chlorophyll fluorescence', 'fontsize', 24, 'fontname', 'arial');
xlabel('FDA fluorescence','fontsize', 24, 'fontname', 'arial');
set(gca, 'FontSize',24);

chl = adcdata(:,9); green = adcdata(:,8); scattering = adcdata(:,7);

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

plot(green, chl, '*','markersize', 2)
hold on
% plot(green(661), chl(661), 'r*','markersize', 10)
% plot(green(496), chl(496), 'r*','markersize', 10)
% plot(green(837), chl(837), 'g*','markersize', 10)
hold on
%plot(x, m*x+b, '-k');
% xlim([0.0017 0.1])
% ylim([0.0045 0.9])

axis square
ylabel('Chlorophyll fluorescence', 'fontsize', 24, 'fontname', 'arial');
xlabel('FDA fluorescence','fontsize', 24, 'fontname', 'arial');
set(gca, 'FontSize',24);
%%
%ALT
%September
adcdata=load('/Volumes/IFCB_data/IFCB14_Dock/data/D20140930T214444_IFCB014.adc');
%load '/Users/markmiller/Documents/IFCB14_Pisces/data/Manual_fromClass/D20141103T230846_IFCB014.mat'
% use IFCB 14  D20130825T161009_IFCB014
%Lysotracker_analysis
%refline(0.020, 0.0033)
chl = adcdata(:,5); green = adcdata(:,4); scattering = adcdata(:,3);

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

plot(green, chl, '*','markersize', 2)
%plot(green(high_green_ind), chl(high_green_ind), 'g*','markersize', 4)
hold on
%plot(x, m*x+b, '-k');
xlim([0.0017 0.1])
ylim([0.0035 0.9])
axis square
ylabel('Chlorophyll fluorescence', 'fontsize', 24, 'fontname', 'arial');
xlabel('FDA fluorescence','fontsize', 24, 'fontname', 'arial');
set(gca, 'FontSize',24);

chl = adcdata(:,9); green = adcdata(:,8); scattering = adcdata(:,7);

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

plot(green, chl, '*','markersize', 2)
hold on
% plot(green(661), chl(661), 'r*','markersize', 10)
% plot(green(496), chl(496), 'r*','markersize', 10)
% plot(green(837), chl(837), 'g*','markersize', 10)
hold on
%plot(x, m*x+b, '-k');
% xlim([0.0017 0.1])
% ylim([0.0045 0.9])

axis square
ylabel('Chlorophyll fluorescence', 'fontsize', 24, 'fontname', 'arial');
xlabel('FDA fluorescence','fontsize', 24, 'fontname', 'arial');
set(gca, 'FontSize',24);
%%
%ALT
%SCUT
adcdata=load('/Users/markmiller/Documents/IFCB14_Pisces/data/D20141103T230846_IFCB014.adc');
%load '/Users/markmiller/Documents/IFCB14_Pisces/data/Manual_fromClass/D20141103T230846_IFCB014.mat'
% use IFCB 14  D20130825T161009_IFCB014
%Lysotracker_analysis
%refline(0.020, 0.0033)
chl = adcdata(:,5); green = adcdata(:,4); scattering = adcdata(:,3);

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

plot(green, chl, '*','markersize', 2)
%plot(green(high_green_ind), chl(high_green_ind), 'g*','markersize', 4)
hold on
%plot(x, m*x+b, '-k');
xlim([0.0017 0.1])
ylim([0.0035 0.9])
axis square
ylabel('Chlorophyll fluorescence', 'fontsize', 24, 'fontname', 'arial');
xlabel('FDA fluorescence','fontsize', 24, 'fontname', 'arial');
set(gca, 'FontSize',24);

chl = adcdata(:,9); green = adcdata(:,8); scattering = adcdata(:,7);

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

plot(green, chl, '*','markersize', 2)
hold on
% plot(green(661), chl(661), 'r*','markersize', 10)
% plot(green(496), chl(496), 'r*','markersize', 10)
% plot(green(837), chl(837), 'g*','markersize', 10)
hold on
%plot(x, m*x+b, '-k');
% xlim([0.0017 0.1])
% ylim([0.0045 0.9])

axis square
ylabel('Chlorophyll fluorescence', 'fontsize', 24, 'fontname', 'arial');
xlabel('FDA fluorescence','fontsize', 24, 'fontname', 'arial');
set(gca, 'FontSize',24);
%%
%Normal
adcdata=load('/Users/markmiller/Documents/IFCB14_Pisces/data/D20141105T134155_IFCB014.adc');
load '/Users/markmiller/Documents/IFCB14_Pisces/data/Manual_fromClass/D20141105T134155_IFCB014.mat'
% use IFCB 14  D20130825T161009_IFCB014
%Lysotracker_analysis
%refline(0.020, 0.0033)
chl = adcdata(:,5); green = adcdata(:,4); scattering = adcdata(:,3);

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

plot(green, chl, '*','markersize', 2)
%plot(green(high_green_ind), chl(high_green_ind), 'g*','markersize', 4)
hold on
%plot(x, m*x+b, '-k');
xlim([0.0016 0.3])
ylim([0.0025 0.11])
axis square
ylabel('Chlorophyll fluorescence', 'fontsize', 24, 'fontname', 'arial');
xlabel('FDA fluorescence','fontsize', 24, 'fontname', 'arial');
set(gca, 'FontSize',24);

%%
%Alt sample
adcdata=load('/Users/markmiller/Documents/IFCB14_Pisces/data/D20141105T140534_IFCB014.adc');
load '/Users/markmiller/Documents/IFCB14_Pisces/data/Manual_fromClass/D20141105T140534_IFCB014.mat'
% use IFCB 14  D20130825T161009_IFCB014
%Lysotracker_analysis
%refline(0.020, 0.0033)
chl = adcdata(:,5); green = adcdata(:,4); scattering = adcdata(:,3);

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

plot(green, chl, '*','markersize', 2)
%plot(green(high_green_ind), chl(high_green_ind), 'g*','markersize', 4)
hold on
%plot(x, m*x+b, '-k');
xlim([0.0017 0.1])
ylim([0.0035 0.9])
axis square
ylabel('Chlorophyll fluorescence', 'fontsize', 24, 'fontname', 'arial');
xlabel('FDA fluorescence','fontsize', 24, 'fontname', 'arial');
set(gca, 'FontSize',24);

%% Alt Sample Cruise
adcdata=load('/Users/markmiller/Documents/IFCB14_Pisces/data/D20141106T163526_IFCB014.adc');
load '/Users/markmiller/Documents/IFCB14_Pisces/data/Manual_fromClass/D20141106T163526_IFCB014.mat'
% use IFCB 14  D20130825T161009_IFCB014
%Lysotracker_analysis
%refline(0.020, 0.0033)
chl = adcdata(:,5); green = adcdata(:,4); scattering = adcdata(:,3);

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

plot(green, chl, '*','markersize', 2)
hold on
plot(green(661), chl(661), 'r*','markersize', 10)
plot(green(496), chl(496), 'r*','markersize', 10)
plot(green(837), chl(837), 'g*','markersize', 10)
hold on
%plot(x, m*x+b, '-k');
xlim([0.0017 0.1])
ylim([0.0045 0.9])

axis square
ylabel('Chlorophyll fluorescence', 'fontsize', 24, 'fontname', 'arial');
xlabel('FDA fluorescence','fontsize', 24, 'fontname', 'arial');
set(gca, 'FontSize',24);

%% Alt Sample Cruise
%PEAK SIGNALS
adcdata=load('/Users/markmiller/Documents/IFCB14_Pisces/data/D20141106T163526_IFCB014.adc');
load '/Users/markmiller/Documents/IFCB14_Pisces/data/Manual_fromClass/D20141106T163526_IFCB014.mat'
% use IFCB 14  D20130825T161009_IFCB014
%Lysotracker_analysis
%refline(0.020, 0.0033)
chl = adcdata(:,9); green = adcdata(:,8); scattering = adcdata(:,7);

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

plot(green, chl, '*','markersize', 2)
hold on
plot(green(661), chl(661), 'r*','markersize', 10)
plot(green(496), chl(496), 'r*','markersize', 10)
plot(green(837), chl(837), 'g*','markersize', 10)
hold on
%plot(x, m*x+b, '-k');
% xlim([0.0017 0.1])
% ylim([0.0045 0.9])

axis square
ylabel('Chlorophyll fluorescence', 'fontsize', 24, 'fontname', 'arial');
xlabel('FDA fluorescence','fontsize', 24, 'fontname', 'arial');
set(gca, 'FontSize',24);