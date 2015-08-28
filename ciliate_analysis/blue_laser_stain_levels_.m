% 01/07/15

%% NO STAIN
adcdata=load('/Users/markmiller/Documents/Experiments/IFCB_14/blue_laser_data/D20150107T144004_IFCB014.adc');

%adc_data
%7 = peak scatter
%8 = peak green/orange
%9 = peak chlorophyll

%3 = int scatter
%4 = int green/orange
%5 = int chlorophyll

chl = adcdata(:,9); green = adcdata(:,8); scattering = adcdata(:,7);

figure1 = figure;
axes1 = axes('Parent',figure1,'YScale','log','YMinorTick','on',...
    'XScale','log',...
    'XMinorTick','on',...
    'PlotBoxAspectRatio',[1 1 1],...
    'FontSize',14);
box(axes1,'on');
hold(axes1,'all');
hold on

plot(green, chl, '*','markersize', 10)
hold on
xlim([0.0017 1])
ylim([0.0035 0.9])
axis square
ylabel('Chlorophyll fluorescence', 'fontsize', 24, 'fontname', 'arial');
xlabel('FDA fluorescence','fontsize', 24, 'fontname', 'arial');
set(gca, 'FontSize',24);
title('no stain')

figure
hist(green(2:end),0:0.01:1)
title('no stain')
set(gca,'xscale','log','xlim',[0.001 5])


%%%%%%%%%

%% 100% less
adcdata=load('/Users/markmiller/Documents/Experiments/IFCB_14/blue_laser_data/D20150107T145141_IFCB014.adc');

%adc_data
%7 = peak scatter
%8 = peak green/orange
%9 = peak chlorophyll

% figure
% plot(adcdata(2:end,7),log10(adcdata(2:end,9)),'.','markersize',20)


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

plot(green, chl, '*','markersize', 10)
%plot(green(high_green_ind), chl(high_green_ind), 'g*','markersize', 4)
hold on
%plot(x, m*x+b, '-k');
xlim([0.0017 1])
ylim([0.0035 0.9])
axis square
ylabel('Chlorophyll fluorescence', 'fontsize', 24, 'fontname', 'arial');
xlabel('FDA fluorescence','fontsize', 24, 'fontname', 'arial');
set(gca, 'FontSize',24);
title('100 fold less')

figure
hist(green(2:end),0:0.01:1)
title('100 fold less')
set(gca,'xscale','log','xlim',[0.001 5])

%%%%%%%%%

%% 50% less
adcdata=load('/Users/markmiller/Documents/Experiments/IFCB_14/blue_laser_data/D20150107T150151_IFCB014.adc');

%adc_data
%7 = peak scatter
%8 = peak green/orange
%9 = peak chlorophyll

% figure
% plot(adcdata(2:end,7),log10(adcdata(2:end,9)),'.','markersize',20)


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

plot(green, chl, '*','markersize', 10)
%plot(green(high_green_ind), chl(high_green_ind), 'g*','markersize', 4)
hold on
%plot(x, m*x+b, '-k');
xlim([0.0017 1])
ylim([0.0035 0.9])
axis square
ylabel('Chlorophyll fluorescence', 'fontsize', 24, 'fontname', 'arial');
xlabel('FDA fluorescence','fontsize', 24, 'fontname', 'arial');
set(gca, 'FontSize',24);
title('50 fold less')

figure
hist(green(2:end),0:0.01:1)
title('50 fold less')
set(gca,'xscale','log','xlim',[0.001 5])

%%%%%%%%%

%% 10% less
adcdata=load('/Users/markmiller/Documents/Experiments/IFCB_14/blue_laser_data/D20150107T151142_IFCB014.adc');

%adc_data
%7 = peak scatter
%8 = peak green/orange
%9 = peak chlorophyll

% figure
% plot(adcdata(2:end,7),log10(adcdata(2:end,9)),'.','markersize',20)


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

plot(green, chl, '*','markersize', 10)
%plot(green(high_green_ind), chl(high_green_ind), 'g*','markersize', 4)
hold on
%plot(x, m*x+b, '-k');
xlim([0.0017 1])
ylim([0.0035 0.9])
axis square
ylabel('Chlorophyll fluorescence', 'fontsize', 24, 'fontname', 'arial');
xlabel('FDA fluorescence','fontsize', 24, 'fontname', 'arial');
set(gca, 'FontSize',24);
title('10 fold less')

figure
hist(green(2:end),0:0.01:1)
title('10 fold less')
set(gca,'xscale','log','xlim',[0.001 5])

%%%%%%%%%

%% normal stain
adcdata=load('/Users/markmiller/Documents/Experiments/IFCB_14/blue_laser_data/D20150107T152446_IFCB014.adc');

%adc_data
%7 = peak scatter
%8 = peak green/orange
%9 = peak chlorophyll

% figure
% plot(adcdata(2:end,7),log10(adcdata(2:end,9)),'.','markersize',20)


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

plot(green, scattering, '*','markersize', 10)
%plot(green(high_green_ind), chl(high_green_ind), 'g*','markersize', 4)
hold on
%plot(x, m*x+b, '-k');
xlim([0.0017 1])
ylim([0.0035 0.9])
axis square
ylabel('Chlorophyll fluorescence', 'fontsize', 24, 'fontname', 'arial');
xlabel('FDA fluorescence','fontsize', 24, 'fontname', 'arial');
set(gca, 'FontSize',24);
title('normal stain')

figure
hist(green(2:end),0:0.01:2.5)
title('normal stain')
set(gca,'xscale','log','xlim',[0.001 5])

%%%%%%%%%

%% NO stain, ssc trigger
adcdata=load('/Users/markmiller/Documents/Experiments/IFCB_14/blue_laser_data/D20150107T162819_IFCB014.adc');

%adc_data
%7 = peak scatter
%8 = peak green/orange
%9 = peak chlorophyll

%3 = int scatter
%4 = int green/orange
%5 = int chlorophyll



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

plot(green, chl, '*','markersize', 10)
%plot(green(high_green_ind), chl(high_green_ind), 'g*','markersize', 4)
hold on
%plot(x, m*x+b, '-k');
xlim([0.0017 1])
ylim([0.0035 0.9])
axis square
ylabel('Chlorophyll fluorescence', 'fontsize', 24, 'fontname', 'arial');
xlabel('FDA fluorescence','fontsize', 24, 'fontname', 'arial');
set(gca, 'FontSize',24);
title('no stain- ssc trigger')

figure
hist(green(2:end),0:0.01:1)
title('no stain- ssc trigger')
set(gca,'xscale','log','xlim',[0.001 5])

%%%%%%%%%

%% regular stain, green trigger, second try
adcdata=load('/Users/markmiller/Documents/Experiments/IFCB_14/blue_laser_data/D20150107T205757_IFCB014.adc');

%adc_data
%7 = peak scatter
%8 = peak green/orange
%9 = peak chlorophyll

%3 = int scatter
%4 = int green/orange
%5 = int chlorophyll



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

plot(green, chl, '*','markersize', 10)
%plot(green(high_green_ind), chl(high_green_ind), 'g*','markersize', 4)
hold on
%plot(x, m*x+b, '-k');
xlim([0.0017 1])
ylim([0.0035 0.9])
axis square
ylabel('Chlorophyll fluorescence', 'fontsize', 24, 'fontname', 'arial');
xlabel('FDA fluorescence','fontsize', 24, 'fontname', 'arial');
set(gca, 'FontSize',24);
title('regular stain- second try')

figure
hist(green(2:end),0:0.01:10)
title('regular stain- second try')
set(gca,'xscale','log','xlim',[0.001 5])
set(gca,'xscale','log','xlim',[0.001 5])

%%%%%%%%%

%% 2 fold stain, try rebinning on log values and plot 
adcdata=load('/Users/markmiller/Documents/Experiments/IFCB_14/blue_laser_data/D20150107T210914_IFCB014.adc');

%adc_data
%7 = peak scatter
%8 = peak green/orange
%9 = peak chlorophyll

%3 = int scatter
%4 = int green/orange
%5 = int chlorophyll



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

plot(green, chl, '*','markersize', 10)
%plot(green(high_green_ind), chl(high_green_ind), 'g*','markersize', 4)
hold on
%plot(x, m*x+b, '-k');
xlim([0.0017 1])

ylim([0.0035 0.9])
axis square
ylabel('Chlorophyll fluorescence', 'fontsize', 24, 'fontname', 'arial');
xlabel('FDA fluorescence','fontsize', 24, 'fontname', 'arial');
set(gca, 'FontSize',24);
title('2 fold stain')

figure
hist(green(2:end),0:0.01:10)
title('2 fold stain')
set(gca,'xscale','log','xlim',[0.001 5])


%%%%%%%%%

%% no stain, 1 debubble, 
adcdata=load('/Users/markmiller/Documents/Experiments/IFCB_14/blue_laser_data/D20150107T211919_IFCB014.adc');

%adc_data
%7 = peak scatter
%8 = peak green/orange
%9 = peak chlorophyll

%3 = int scatter
%4 = int green/orange
%5 = int chlorophyll



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

plot(green, chl, '*','markersize', 10)
%plot(green(high_green_ind), chl(high_green_ind), 'g*','markersize', 4)
hold on
%plot(x, m*x+b, '-k');
xlim([0.0017 1])

ylim([0.0035 0.9])
axis square
ylabel('Chlorophyll fluorescence', 'fontsize', 24, 'fontname', 'arial');
xlabel('FDA fluorescence','fontsize', 24, 'fontname', 'arial');
set(gca, 'FontSize',24);
title('no stain- one debubble')

figure
hist(green(2:end),0:0.01:10)
title('no stain, one debubble')
set(gca,'xscale','log','xlim',[0.001 5])

%%%%%%%%%

%% no stain, 2 debubble, 
adcdata=load('/Users/markmiller/Documents/Experiments/IFCB_14/blue_laser_data/D20150107T212728_IFCB014.adc');

%adc_data
%7 = peak scatter
%8 = peak green/orange
%9 = peak chlorophyll

%3 = int scatter
%4 = int green/orange
%5 = int chlorophyll



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

plot(green, chl, '*','markersize', 10)
%plot(green(high_green_ind), chl(high_green_ind), 'g*','markersize', 4)
hold on
%plot(x, m*x+b, '-k');
xlim([0.0017 1])

ylim([0.0035 0.9])
axis square
ylabel('Chlorophyll fluorescence', 'fontsize', 24, 'fontname', 'arial');
xlabel('FDA fluorescence','fontsize', 24, 'fontname', 'arial');
set(gca, 'FontSize',24);
title('no stain- two debubble')

figure
hist(green(2:end),0:0.01:10)
title('no stain, two debubble')
set(gca,'xscale','log','xlim',[0.001 5])

%%%%%%%%%

%% no stain, 3 debubble, 
adcdata=load('/Users/markmiller/Documents/Experiments/IFCB_14/blue_laser_data/D20150107T213521_IFCB014.adc');

%adc_data
%7 = peak scatter
%8 = peak green/orange
%9 = peak chlorophyll

%3 = int scatter
%4 = int green/orange
%5 = int chlorophyll



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

plot(green, chl, '*','markersize', 10)
%plot(green(high_green_ind), chl(high_green_ind), 'g*','markersize', 4)
hold on
%plot(x, m*x+b, '-k');
xlim([0.0017 1])

ylim([0.0035 0.9])
axis square
ylabel('Chlorophyll fluorescence', 'fontsize', 24, 'fontname', 'arial');
xlabel('FDA fluorescence','fontsize', 24, 'fontname', 'arial');
set(gca, 'FontSize',24);
title('no stain- three debubble')

figure
hist(green(2:end),0:0.01:10)
title('no stain, three debubble')
set(gca,'xscale','log','xlim',[0.001 5])

%%%%%%%%%