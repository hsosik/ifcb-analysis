%%
load '/Users/markmiller/Documents/Experiments/IFCB_14/Microscopy_vs_Imager/5-11-14/Manual_fromClass/D20140511T124604_IFCB014.mat'
adcdata=load('/Users/markmiller/Documents/Experiments/IFCB_14/Microscopy_vs_Imager/5-11-14/D20140511T124604_IFCB014.adc');

ciliate_roi_ind=find(~isnan(classlist(:,4)));
other_roi_ind=find(classlist(:,2)==46);
gyro_roi_ind=find(classlist(:,2)==36);

figure
loglog(adcdata(ciliate_roi_ind,4),adcdata(ciliate_roi_ind,5),'r.','markersize',20)
hold on
loglog(adcdata(other_roi_ind(2:end),4),adcdata(other_roi_ind(2:end),5),'.','markersize',20)
loglog(adcdata(gyro_roi_ind(2:end),4),adcdata(gyro_roi_ind(2:end),5),'g.','markersize',20)
ylim([0.003 10])
xlim([0.002 1])
ylabel('Chlorophyll Fluorescence','fontsize',24,'fontname','arial')
xlabel('PE Fluorescence','fontsize',24,'fontname','arial')
set(gca,'fontsize',24,'fontname','arial')

%PE is 4
%CHL is 5
%SSC is 3
%%
ciliate_ratio=adcdata(ciliate_roi_ind,4)./adcdata(ciliate_roi_ind,5);
gyro_ratio=adcdata(gyro_roi_ind,4)./adcdata(gyro_roi_ind,5);
other_ratio=adcdata(other_roi_ind,4)./adcdata(other_roi_ind,5);

figure
loglog(adcdata(other_roi_ind,3),other_ratio,'.b')
hold on
loglog(adcdata(ciliate_roi_ind,3),ciliate_ratio,'.r')
loglog(adcdata(gyro_roi_ind,3),gyro_ratio,'.g')
xlabel('Side Scattering','fontsize',24,'fontname','arial')
ylabel('PE:Chl Fluorescence','fontsize',24,'fontname','arial')
set(gca,'fontsize',24,'fontname','arial')
%%
% diambins=[0:0.5:20];
% 
% figure
% 
% [nb_1,xb_1]=hist(other_ratio,diambins);
% [nb_2,xb_2]=hist(gyro_ratio,diambins);
% [nb_3,xb_3]=hist(ciliate_ratio,diambins);
% subplot(3,1,1)
% bh_1=bar(xb_1,nb_1);
% set(bh_1,'facecolor',[1 1 0]);
% legend('all')
% subplot(3,1,2)
% bh_3=bar(xb_3,nb_3);
% set(bh_3,'facecolor',[1 0 0]);
% legend('ciliate')
% subplot(3,1,3)
% bh_2=bar(xb_2,nb_2);
% set(bh_2,'facecolor',[0 1 0]);
% legend('gyro')

load '/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/Dinos_stained_unstained/2-1-14/Manual_fromClass/D20140201T061221_IFCB014.mat'

%load '/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/Dinos_stained_unstained/2-1-14/Alt/D20140201T161044_IFCB014.mat'
%adcdata=load ('/Volumes/IFCB14_Dock/data/D20140201T161044_IFCB014.adc');

adcdata=load ('/Volumes/IFCB14_Dock/data/D20140201T061221_IFCB014.adc');

ciliate_roi_ind=find(~isnan(classlist(:,4)));
other_roi_ind=find(classlist(:,2)==46);
gyro_roi_ind=find(classlist(:,2)==36);
ciliate_ratio=adcdata(ciliate_roi_ind,4)./adcdata(ciliate_roi_ind,5);
gyro_ratio=adcdata(gyro_roi_ind,4)./adcdata(gyro_roi_ind,5);
other_ratio=adcdata(other_roi_ind,4)./adcdata(other_roi_ind,5);


loglog(adcdata(other_roi_ind,3),other_ratio,'.b')
hold on
loglog(adcdata(ciliate_roi_ind,3),ciliate_ratio,'.r')
loglog(adcdata(gyro_roi_ind,3),gyro_ratio,'.g')
