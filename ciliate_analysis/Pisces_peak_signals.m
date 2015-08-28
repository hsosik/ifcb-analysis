%% Plotting ciliate chlorophyll on green settings under normal PMTs

IFCB_14_adcdata=load('/Users/markmiller/Documents/IFCB14_Pisces/data/D20141109T163332_IFCB014.adc');
load '/Users/markmiller/Documents/IFCB14_Pisces/data/Manual_fromClass/D20141109T163332_IFCB014.mat'

IFCB_14_ciliate_roi_ind=find(classlist(:,3)>=70 | classlist(:,2)>=70);

%adc_data
%7 = peak scatter
%8 = peak green/orange
%9 = peak chlorophyll

figure
plot(IFCB_14_adcdata(2:end,1),log10(IFCB_14_adcdata(2:end,9)),'.','markersize',20)
hold on
plot(IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,1),log10(IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,9)),'r.','markersize',20)
title('IFCB 14 CHL-Green settings')

%% Plotting ciliate green on green settings under normal PMTs

IFCB_14_adcdata=load('/Users/markmiller/Documents/IFCB14_Pisces/data/D20141109T163332_IFCB014.adc');
load '/Users/markmiller/Documents/IFCB14_Pisces/data/Manual_fromClass/D20141109T163332_IFCB014.mat'

IFCB_14_ciliate_roi_ind=find(classlist(:,3)>=70 | classlist(:,2)>=70);

figure
plot(IFCB_14_adcdata(2:end,1),log10(IFCB_14_adcdata(2:end,8)),'.','markersize',20)
hold on
plot(IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,1),log10(IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,8)),'r.','markersize',20)
title('IFCB 14 Green-Green settings')

%% Plotting ciliate chlorophyll on orange settings under normal PMTs


IFCB_14_adcdata=load('/Users/markmiller/Documents/IFCB14_Pisces/data/D20141109T165949_IFCB014.adc');
load '/Users/markmiller/Documents/IFCB14_Pisces/data/Manual_fromClass/D20141109T165949_IFCB014.mat'

IFCB_14_ciliate_roi_ind=find(classlist(:,3)>=70 | classlist(:,2)>=70);

figure
plot(IFCB_14_adcdata(2:end,1),log10(IFCB_14_adcdata(2:end,9)),'.','markersize',20)
hold on
plot(IFCB_14_adcdata(IFCB_14_ciliate_roi_ind(1:8),1),log10(IFCB_14_adcdata(IFCB_14_ciliate_roi_ind(1:8),9)),'r.','markersize',20)
title('IFCB 14 CHL-Orange settings')

%% Plotting ciliate orange on orange settings under normal PMTs

IFCB_14_adcdata=load('/Users/markmiller/Documents/IFCB14_Pisces/data/D20141109T165949_IFCB014.adc');
load '/Users/markmiller/Documents/IFCB14_Pisces/data/Manual_fromClass/D20141109T165949_IFCB014.mat'

IFCB_14_ciliate_roi_ind=find(classlist(:,3)>=70 | classlist(:,2)>=70);

figure
plot(IFCB_14_adcdata(2:end,1),log10(IFCB_14_adcdata(2:end,8)),'.','markersize',20)
hold on
plot(IFCB_14_adcdata(IFCB_14_ciliate_roi_ind(1:8),1),log10(IFCB_14_adcdata(IFCB_14_ciliate_roi_ind(1:8),8)),'r.','markersize',20)
title('IFCB 14 Orange-Orange settings')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Plotting ciliate chlorophyll on green settings under sensitive PMTs

IFCB_14_adcdata=load('/Users/markmiller/Documents/IFCB14_Pisces/data/D20141109T181325_IFCB014.adc');
load '/Users/markmiller/Documents/IFCB14_Pisces/data/Manual_fromClass/D20141109T181325_IFCB014.mat'

IFCB_14_ciliate_roi_ind=find(classlist(:,3)>=70 | classlist(:,2)>=70);
%adc_data
%7 = peak scatter
%8 = peak green/orange
%9 = peak chlorophyll

figure
plot(IFCB_14_adcdata(2:end,1),log10(IFCB_14_adcdata(2:end,9)),'.','markersize',20)
hold on
plot(IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,1),log10(IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,9)),'r.','markersize',20)
title('IFCB 14 CHL-Green settings-high sensitivity')

%% Plotting ciliate green on green settings under sensitive PMTs

IFCB_14_adcdata=load('/Users/markmiller/Documents/IFCB14_Pisces/data/D20141109T181325_IFCB014.adc');
load '/Users/markmiller/Documents/IFCB14_Pisces/data/Manual_fromClass/D20141109T181325_IFCB014.mat'

IFCB_14_ciliate_roi_ind=find(classlist(:,3)>=70 | classlist(:,2)>=70);

figure
plot(IFCB_14_adcdata(2:end,1),log10(IFCB_14_adcdata(2:end,8)),'.','markersize',20)
hold on
plot(IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,1),log10(IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,8)),'r.','markersize',20)
title('IFCB 14 Green-Green settings-high sensitivity')

