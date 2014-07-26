%%
load '/Users/markmiller/Documents/Experiments/IFCB_9/Dock_Samples/5-15-13/data/Manual_fromClass/D20130515T172101_IFCB009.mat'
adcdata=load('/Users/markmiller/Documents/Experiments/IFCB_9/Dock_Samples/5-15-13/data/D20130515T172101_IFCB009.adc');

ciliate_roi_ind=find(~isnan(classlist(:,4)));
other_roi_ind=find(classlist(:,2)==46);
gyro_roi_ind=find(classlist(:,2)==36);

figure
loglog(adcdata(ciliate_roi_ind,3),adcdata(ciliate_roi_ind,4),'m.','markersize',30)
hold on
loglog(adcdata(other_roi_ind(2:end),3),adcdata(other_roi_ind(2:end),4),'.','markersize',20)
loglog(adcdata(gyro_roi_ind(2:end),3),adcdata(gyro_roi_ind(2:end),4),'c.','markersize',30)
ylim([0.0008 1])
xlim([0.001 1])
ylabel('Chlorophyll Fluorescence','fontsize',24,'fontname','arial')
xlabel('Green Fluorescence','fontsize',24,'fontname','arial')
set(gca,'fontsize',24,'fontname','arial')
%%
load '/Users/markmiller/Documents/Experiments/IFCB_9/Dock_Samples/5-15-13/data/Manual_fromClass/D20130515T173426_IFCB009.mat'
adcdata=load('/Users/markmiller/Documents/Experiments/IFCB_9/Dock_Samples/5-15-13/data/D20130515T173426_IFCB009.adc');

ciliate_roi_ind=find(~isnan(classlist(:,4)));
other_roi_ind=find(classlist(:,2)==46);
gyro_roi_ind=find(classlist(:,2)==36);

figure
loglog(adcdata(ciliate_roi_ind,3),adcdata(ciliate_roi_ind,4),'m.','markersize',30)
hold on
loglog(adcdata(other_roi_ind(2:end),3),adcdata(other_roi_ind(2:end),4),'.','markersize',20)
loglog(adcdata(gyro_roi_ind(2:end),3),adcdata(gyro_roi_ind(2:end),4),'c.','markersize',30)
ylim([0.0008 1])
xlim([0.001 1])
ylabel('Chlorophyll Fluorescence','fontsize',24,'fontname','arial')
xlabel('Green Fluorescence','fontsize',24,'fontname','arial')
set(gca,'fontsize',24,'fontname','arial')

%%
load '/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/Dinos_stained_unstained/2-1-14/Manual_fromClass/D20140201T061221_IFCB014.mat'

%load '/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/Dinos_stained_unstained/2-1-14/Alt/D20140201T161044_IFCB014.mat'
%adcdata=load ('/Volumes/IFCB14_Dock/data/D20140201T161044_IFCB014.adc');

adcdata=load ('/Volumes/IFCB14_Dock/data/D20140201T061221_IFCB014.adc');

gyro_roi_ind=find(classlist(:,2)==36);
ciliate_roi_ind=find(~isnan(classlist(:,4)));

figure
loglog(adcdata(2:end,4),adcdata(2:end,5),'.','markersize',20)
hold on
loglog(adcdata(gyro_roi_ind,4),adcdata(gyro_roi_ind,5),'c.','markersize',30)
loglog(adcdata(ciliate_roi_ind,4),adcdata(ciliate_roi_ind,5),'m.','markersize',30)
hold on

ylim([0.003 10])
xlim([0.002 1])
ylabel('Chlorophyll Fluorescence','fontsize',24,'fontname','arial')
xlabel('Green Fluorescence','fontsize',24,'fontname','arial')
set(gca,'fontsize',24,'fontname','arial')

