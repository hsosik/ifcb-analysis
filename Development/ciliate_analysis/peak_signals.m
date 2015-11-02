%%

IFCB_14_adcdata=load('/Volumes/IFCB_data/IFCB014_OkeanosExplorerAug2013/data/continuous/D20130825T175150_IFCB014.adc');
load '/Volumes/IFCB_data/IFCB014_OkeanosExplorerAug2013/data/continuous/Manual_fromClass/D20130825T175150_IFCB014.mat'
%Normal Sample

IFCB_14_ciliate_roi_ind=find(~isnan(classlist(:,4)));

figure
plot(IFCB_14_adcdata(2:end,1),log10(IFCB_14_adcdata(2:end,9)),'.','markersize',20)
hold on
plot(IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,1),log10(IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,9)),'r.','markersize',20)
title('IFCB 14 CHL-Orange Settings')

%%

IFCB_14_adcdata=load('/Volumes/IFCB_data/IFCB014_OkeanosExplorerAug2013/data/continuous/D20130825T172524_IFCB014.adc');
load '/Volumes/IFCB_data/IFCB014_OkeanosExplorerAug2013/data/continuous/Manual_fromClass/D20130825T172524_IFCB014.mat'
%Alt Sample
IFCB_14_ciliate_roi_ind=find(~isnan(classlist(:,4)));

figure
plot(IFCB_14_adcdata(2:end,1),log10(IFCB_14_adcdata(2:end,8)),'.','markersize',20)
hold on
plot(IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,1),log10(IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,8)),'r.','markersize',20)
title('IFCB 14 Green-Green Settings')
% figure
% plot(IFCB_14_adcdata(2:end,1),IFCB_14_adcdata(2:end,9),'.','markersize',20)
% hold on
% plot(IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,1),IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,8),'r.','markersize',20)
% title('IFCB 14 PE-Green settings')

%%
adcdata=load('/Volumes/IFCB010_OkeanosExplorerAug2013/data/D20130825T184622_IFCB010.adc');
load '/Volumes/IFCB010_OkeanosExplorerAug2013/data/Manual_fromClass/D20130825T184622_IFCB010.mat'

ciliate_roi_ind=find(~isnan(classlist(:,4)));

figure
plot(adcdata(2:end,1),log10(adcdata(2:end,8)),'.','markersize',20)
hold on
plot(adcdata(ciliate_roi_ind,1),log10(adcdata(ciliate_roi_ind,8)),'r.','markersize',20)
title('IFCB 10 CHL-cruise')
%%

load '/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/mixing_staining/1-18-14/results/normal/D20140118T055745_IFCB014.mat'
adcdata=load('/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/mixing_staining/1-18-14/D20140118T055745_IFCB014.adc');

ciliate_roi_ind=find(~isnan(classlist(:,4)));

figure
plot(adcdata(2:end,1),adcdata(2:end,9),'.','markersize',20)
hold on
plot(adcdata(ciliate_roi_ind,1),adcdata(ciliate_roi_ind,9),'r.','markersize',20)
title('IFCB 14 CHL dock-January')

figure
plot(adcdata(2:end,1),adcdata(2:end,8),'.','markersize',20)
hold on
plot(adcdata(ciliate_roi_ind,1),adcdata(ciliate_roi_ind,8),'r.','markersize',20)
title('IFCB 14 PE dock-January')

load '/Users/markmiller/Documents/Experiments/IFCB_14/Microscopy_vs_Imager/5-11-14/Manual_fromClass/D20140511T124604_IFCB014.mat'
adcdata=load('/Users/markmiller/Documents/Experiments/IFCB_14/Microscopy_vs_Imager/5-11-14/D20140511T124604_IFCB014.adc');

ciliate_roi_ind=find(~isnan(classlist(:,4)));

figure
plot(adcdata(2:end,1),adcdata(2:end,9),'.','markersize',20)
hold on
plot(adcdata(ciliate_roi_ind,1),adcdata(ciliate_roi_ind,9),'r.','markersize',20)
title('IFCB 14 CHL dock-May')

figure
plot(adcdata(2:end,1),adcdata(2:end,8),'.','markersize',20)
hold on
plot(adcdata(ciliate_roi_ind,1),adcdata(ciliate_roi_ind,8),'r.','markersize',20)
title('IFCB 14 PE dock-May')

%%
% adcdata=load('/Volumes/IFCB010_OkeanosExplorerAug2013/data/D20130825T180458_IFCB010.adc');
% load '/Volumes/IFCB010_OkeanosExplorerAug2013/data/Manual_fromClass/D20130825T180458_IFCB010.mat'
% 
% ciliate_roi_ind=find(~isnan(classlist(:,4)));
% 
% figure
% plot(adcdata(2:end,1),adcdata(2:end,8),'.','markersize',20)
% hold on
% plot(adcdata(ciliate_roi_ind,1),adcdata(ciliate_roi_ind,8),'r.','markersize',20)
% title('IFCB 10 CHL')

IFCB_14_adcdata=load('/Volumes/IFCB_data/IFCB014_OkeanosExplorerAug2013/data/continuous/D20130825T175150_IFCB014.adc');
load '/Volumes/IFCB_data/IFCB014_OkeanosExplorerAug2013/data/continuous/Manual_fromClass/D20130825T175150_IFCB014.mat'

IFCB_14_ciliate_roi_ind=find(~isnan(classlist(:,4)));


figure
bar(IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,4)./IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,5),0.5)
title('IFCB 14 PE')

%%
%Alt sample
IFCB_14_adcdata=load('/Users/markmiller/Documents/Experiments/IFCB_14/Microscopy_vs_Imager/7-2-14/D20140702T135601_IFCB014.adc');
load '/Users/markmiller/Documents/Experiments/IFCB_14/Microscopy_vs_Imager/7-2-14/Manual_fromClass/D20140702T135601_IFCB014.mat'

ciliate_roi_ind=find(~isnan(classlist(:,4)));

figure
plot(IFCB_14_adcdata(2:end,1),IFCB_14_adcdata(2:end,8),'.','markersize',20)
hold on
plot(IFCB_14_adcdata(ciliate_roi_ind,1),IFCB_14_adcdata(ciliate_roi_ind,8),'r.','markersize',20)
title('IFCB 14 Green dock-July-Green settings')

chl = IFCB_14_adcdata(:,9); green = IFCB_14_adcdata(:,8); scattering = IFCB_14_adcdata(:,7);

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
%plot(green(661), chl(661), 'r*','markersize', 10)
%plot(green(496), chl(496), 'r*','markersize', 10)
%plot(green(837), chl(837), 'g*','markersize', 10)
hold on
%plot(x, m*x+b, '-k');
% xlim([0.0017 0.1])
% ylim([0.0045 0.9])

axis square
ylabel('Chlorophyll fluorescence', 'fontsize', 24, 'fontname', 'arial');
xlabel('FDA fluorescence','fontsize', 24, 'fontname', 'arial');
set(gca, 'FontSize',24);