
D20140625T171533_IFCB014.mat
D20140625T174003_IFCB014.mat
D20140625T180352_IFCB014.mat
D20140625T182654_IFCB014.mat
D20140625T184754_IFCB014.mat
D20140625T190931_IFCB014.mat
D20140625T193227_IFCB014.mat
D20140625T195910_IFCB014.mat

IFCB_14_adcdata=load('/Users/markmiller/Documents/Experiments/MVCO_Samples/MVCO_6-25-14/D20140625T195910_IFCB014.adc');
load '/Users/markmiller/Documents/Experiments/MVCO_Samples/MVCO_6-25-14/Manual_fromClass/D20140625T195910_IFCB014.mat'

IFCB_14_ciliate_roi_ind=find(~isnan(classlist(:,4)));

figure
plot(IFCB_14_adcdata(2:end,1),log10(IFCB_14_adcdata(2:end,9)),'.','markersize',20)
hold on
plot(IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,1),log10(IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,9)),'r.','markersize',20)
title('IFCB 14 CHL-cruise')
%%
load '/Users/markmiller/Documents/Experiments/MVCO_Samples/MVCO_6-25-14/Manual_fromClass/D20140625T174003_IFCB014.mat'
adcdata=load('/Users/markmiller/Documents/Experiments/MVCO_Samples/MVCO_6-25-14/D20140625T174003_IFCB014.adc');

ciliate_roi_ind=find(~isnan(classlist(:,4)));
other_roi_ind=find(classlist(:,2)==46);
gyro_roi_ind=find(classlist(:,2)==36);

figure
loglog(adcdata(other_roi_ind(2:end),3),adcdata(other_roi_ind(2:end),4),'.','markersize',20)
hold on
loglog(adcdata(ciliate_roi_ind,3),adcdata(ciliate_roi_ind,4),'m.','markersize',30)
loglog(adcdata(gyro_roi_ind(2:end),3),adcdata(gyro_roi_ind(2:end),4),'c.','markersize',30)
ylim([0.0008 1])
xlim([0.001 1])
ylabel('Chlorophyll Fluorescence','fontsize',24,'fontname','arial')
xlabel('Green Fluorescence','fontsize',24,'fontname','arial')
set(gca,'fontsize',24,'fontname','arial')

%%