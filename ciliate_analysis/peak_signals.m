%%

IFCB_14_adcdata=load('/Volumes/IFCB014_OkeanosExplorerAug2013/data/continuous/D20130825T175150_IFCB014.adc');
load '/Volumes/IFCB014_OkeanosExplorerAug2013/data/continuous/Manual_fromClass/D20130825T175150_IFCB014.mat'

IFCB_14_ciliate_roi_ind=find(~isnan(classlist(:,4)));

figure
plot(IFCB_14_adcdata(2:end,1),log10(IFCB_14_adcdata(2:end,9)),'.','markersize',20)
hold on
plot(IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,1),log10(IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,9)),'r.','markersize',20)
title('IFCB 14 CHL-cruise')



IFCB_14_adcdata=load('/Volumes/IFCB014_OkeanosExplorerAug2013/data/continuous/D20130825T172524_IFCB014.adc');
load '/Volumes/IFCB014_OkeanosExplorerAug2013/data/continuous/Manual_fromClass/D20130825T172524_IFCB014.mat'

IFCB_14_ciliate_roi_ind=find(~isnan(classlist(:,4)));

figure
plot(IFCB_14_adcdata(2:end,1),log10(IFCB_14_adcdata(2:end,9)),'.','markersize',20)
hold on
plot(IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,1),log10(IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,9)),'r.','markersize',20)
title('IFCB 14 CHL-cruise')
% figure
% plot(IFCB_14_adcdata(2:end,1),IFCB_14_adcdata(2:end,9),'.','markersize',20)
% hold on
% plot(IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,1),IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,8),'r.','markersize',20)
% title('IFCB 14 PE-cruise')


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

IFCB_14_adcdata=load('/Volumes/IFCB014_OkeanosExplorerAug2013/data/continuous/D20130825T175150_IFCB014.adc');
load '/Volumes/IFCB014_OkeanosExplorerAug2013/data/continuous/Manual_fromClass/D20130825T175150_IFCB014.mat'

IFCB_14_ciliate_roi_ind=find(~isnan(classlist(:,4)));


figure
bar(IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,4)./IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,5),0.5)
title('IFCB 14 PE')




