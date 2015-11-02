

%cruise bead file

adcdata=load('/Volumes/IFCB_data/IFCB014_PiscesNov2014/data/D20141118T215821_IFCB014.adc');

%adc_data
%7 = peak scatter
%8 = peak green/orange
%9 = peak chlorophyll

% figure
% plot(adcdata(2:end,7),log10(adcdata(2:end,9)),'.','markersize',20)


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

plot(green, chl, '*','markersize', 10)
%plot(green(high_green_ind), chl(high_green_ind), 'g*','markersize', 4)
hold on
%plot(x, m*x+b, '-k');
%xlim([0.0017 1])
% ylim([0.0035 0.9])
axis square
ylabel('Chlorophyll fluorescence', 'fontsize', 24, 'fontname', 'arial');
xlabel('FDA fluorescence','fontsize', 24, 'fontname', 'arial');
set(gca, 'FontSize',24);
title('cruise bead')

%%%%%%%%%
%%

adcdata=load('/Volumes/IFCB_data/IFCB014_PiscesNov2014/data/D20141103T230230_IFCB014.adc');


%adc_data
%7 = peak scatter
%8 = peak green/orange
%9 = peak chlorophyll

% figure
% plot(adcdata(2:end,7),log10(adcdata(2:end,9)),'.','markersize',20)


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

plot(green, chl, '*','markersize', 10)
%plot(green(high_green_ind), chl(high_green_ind), 'g*','markersize', 4)
hold on
%plot(x, m*x+b, '-k');
%xlim([0.0017 1])
% ylim([0.0035 0.9])
axis square
ylabel('Chlorophyll fluorescence', 'fontsize', 24, 'fontname', 'arial');
xlabel('FDA fluorescence','fontsize', 24, 'fontname', 'arial');
set(gca, 'FontSize',24);
title('cruise Scut')

%%

%488nm bead file

adcdata=load('/Volumes/data/D20141222T154144_IFCB014.adc');


%adc_data
%7 = peak scatter
%8 = peak green/orange
%9 = peak chlorophyll

figure
plot(adcdata(2:end,8),log10(adcdata(2:end,9)),'.','markersize',20)


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

plot(green, chl, '*','markersize', 10)
%plot(green(high_green_ind), chl(high_green_ind), 'g*','markersize', 4)
hold on
%plot(x, m*x+b, '-k');
%xlim([0.0017 1])
% ylim([0.0035 0.9])
axis square
ylabel('Chlorophyll fluorescence', 'fontsize', 24, 'fontname', 'arial');
xlabel('FDA fluorescence','fontsize', 24, 'fontname', 'arial');
set(gca, 'FontSize',24);
title('488 bead')

%%

%488nm stained scut file

adcdata=load('/Volumes/data/D20141222T161148_IFCB014.adc');


%adc_data
%7 = peak scatter
%8 = peak green/orange
%9 = peak chlorophyll

% figure
% plot(adcdata(2:end,7),log10(adcdata(2:end,9)),'.','markersize',20)


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

plot(green, chl, '*','markersize', 10)
%plot(green(high_green_ind), chl(high_green_ind), 'g*','markersize', 4)
hold on
%plot(x, m*x+b, '-k');
%xlim([0.0017 1])
% ylim([0.0035 0.9])
axis square
ylabel('Chlorophyll fluorescence', 'fontsize', 24, 'fontname', 'arial');
xlabel('FDA fluorescence','fontsize', 24, 'fontname', 'arial');
set(gca, 'FontSize',24);
title('488 Scut')
