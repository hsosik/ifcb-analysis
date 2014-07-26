%%
load '/Users/markmiller/Documents/Experiments/IFCB_14/Microscopy_vs_Imager/5-11-14/Manual_fromClass/D20140511T124604_IFCB014.mat'
adcdata=load('/Users/markmiller/Documents/Experiments/IFCB_14/Microscopy_vs_Imager/5-11-14/D20140511T124604_IFCB014.adc');

ciliate_roi_ind=find(~isnan(classlist(:,4)));
other_roi_ind=find(classlist(:,2)==46);
gyro_roi_ind=find(classlist(:,2)==36);

figure
loglog(adcdata(ciliate_roi_ind,4),adcdata(ciliate_roi_ind,5),'m.','markersize',20)
hold on
loglog(adcdata(other_roi_ind(2:end),4),adcdata(other_roi_ind(2:end),5),'.','markersize',20)
loglog(adcdata(gyro_roi_ind(2:end),4),adcdata(gyro_roi_ind(2:end),5),'c.','markersize',20)
ylim([0.003 10])
xlim([0.002 1])
ylabel('Chlorophyll Fluorescence','fontsize',24,'fontname','arial')
xlabel('PE Fluorescence','fontsize',24,'fontname','arial')
set(gca,'fontsize',24,'fontname','arial')
%%
load '/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/mixing_staining/1-18-14/results/normal/D20140118T105650_IFCB014.mat'
adcdata=load('/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/mixing_staining/1-18-14/D20140118T105650_IFCB014.adc');


ciliate_roi_ind=find(~isnan(classlist(:,4)));
other_roi_ind=find(classlist(:,2)==46);

figure
loglog(adcdata(ciliate_roi_ind,4),adcdata(ciliate_roi_ind,5),'r.')
hold on
loglog(adcdata(other_roi_ind(2:end),4),adcdata(other_roi_ind(2:end),5),'.')
ylim([0.003 10])
xlim([0.002 1])

%%
load '/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/mixing_staining/1-18-14/results/normal/D20140118T055745_IFCB014.mat'
adcdata=load('/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/mixing_staining/1-18-14/D20140118T055745_IFCB014.adc');


ciliate_roi_ind=find(~isnan(classlist(:,4)));
other_roi_ind=find(classlist(:,2)==46);
gyro_roi_ind=find(classlist(:,2)==36);

figure
loglog(adcdata(ciliate_roi_ind,4),adcdata(ciliate_roi_ind,5),'m.','markersize',20)
hold on
loglog(adcdata(other_roi_ind(2:end),4),adcdata(other_roi_ind(2:end),5),'.','markersize',20)
loglog(adcdata(gyro_roi_ind(2:end),4),adcdata(gyro_roi_ind(2:end),5),'c.','markersize',20)
ylim([0.003 10])
xlim([0.002 1])
ylabel('Chlorophyll Fluorescence','fontsize',24,'fontname','arial')
xlabel('PE Fluorescence','fontsize',24,'fontname','arial')
set(gca,'fontsize',24,'fontname','arial')

%%
load '/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/Dinos_stained_unstained/2-1-14/Manual_fromClass/D20140201T061221_IFCB014.mat'

%load '/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/Dinos_stained_unstained/2-1-14/Alt/D20140201T161044_IFCB014.mat'
%adcdata=load ('/Volumes/IFCB14_Dock/data/D20140201T161044_IFCB014.adc');

adcdata=load ('/Volumes/IFCB14_Dock/data/D20140201T061221_IFCB014.adc');

gyro_roi_ind=find(classlist(:,2)==36);

figure
loglog(adcdata(2:end,4),adcdata(2:end,5),'.','markersize',20)
hold on
loglog(adcdata(gyro_roi_ind,4),adcdata(gyro_roi_ind,5),'g.','markersize',20)
hold on

ylim([0.003 10])
xlim([0.002 1])
ylabel('Chlorophyll Fluorescence','fontsize',24,'fontname','arial')
xlabel('Green Fluorescence','fontsize',24,'fontname','arial')
set(gca,'fontsize',24,'fontname','arial')

%%
adcdata=load('/Volumes/IFCB014_OkeanosExplorerAug2013/data/continuous/D20130825T175150_IFCB014.adc')
load '/Volumes/IFCB014_OkeanosExplorerAug2013/data/continuous/Manual_fromClass/D20130825T175150_IFCB014.mat'

ciliate_roi_ind=find(~isnan(classlist(:,4)));

figure
loglog(adcdata(2:end,4),adcdata(2:end,5),'.','markersize',20)
hold on
loglog(adcdata(ciliate_roi_ind,4),adcdata(ciliate_roi_ind,5),'m.','markersize',30)

ylim([0.003 0.3])
xlim([0.002 1])
ylabel('Chlorophyll Fluorescence','fontsize',24,'fontname','arial')
xlabel('PE Fluorescence','fontsize',24,'fontname','arial')
set(gca,'fontsize',24,'fontname','arial')

%%
adcdata=load('/Volumes/IFCB014_OkeanosExplorerAug2013/data/continuous/D20130825T181604_IFCB014.adc')
load '/Volumes/IFCB014_OkeanosExplorerAug2013/data/continuous/Manual_fromClass/D20130825T181604_IFCB014.mat'

ciliate_roi_ind=find(~isnan(classlist(:,4)));

figure
loglog(adcdata(2:end,4),adcdata(2:end,5),'.','markersize',20)
hold on
loglog(adcdata(ciliate_roi_ind,4),adcdata(ciliate_roi_ind,5),'r.','markersize',20)

ylim([0.003 0.3])
xlim([0.002 1])
ylabel('Chlorophyll Fluorescence','fontsize',18,'fontname','arial')
xlabel('PE Fluorescence','fontsize',18,'fontname','arial')
set(gca,'fontsize',18,'fontname','arial')

%%
