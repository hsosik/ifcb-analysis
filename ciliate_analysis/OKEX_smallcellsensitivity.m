%% CHLOROPHYLL FROM STANDARD IFCB

IFCB_14_adcdata=load('/Volumes/IFCB014_OkeanosExplorerAug2013/data/continuous/D20130825T175150_IFCB014.adc');
load '/Volumes/IFCB014_OkeanosExplorerAug2013/data/continuous/Manual_fromClass/D20130825T175150_IFCB014.mat'
load '/Volumes/IFCB014_OkeanosExplorerAug2013/data/continuous/Manual_fromClass/summary/count_manual_08May2014.mat';

IFCB_14_ciliate_roi_ind=find(~isnan(classlist(:,4)));

figure
plot(IFCB_14_adcdata(2:end,1),log10(IFCB_14_adcdata(2:end,9)),'.','markersize',20)
hold on
plot(IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,1),log10(IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,9)),'r.','markersize',20)
title('IFCB 14 CHL-cruise')


%16 and 17 in adcdata are roi width and height
diambins=[0:50:35000];
hist_counts=histc(IFCB_14_adcdata(:,16).*IFCB_14_adcdata(:,17),diambins);
figure
plot(diambins,(hist_counts/ml_analyzed(46)))
ylabel('cells/ml')
xlabel('roi area')
title('IFCB 14 cruise-normal sample')

%% GREEN FLUORESCENCE FROM ALT SAMPLE

IFCB_14_adcdata=load('/Volumes/IFCB014_OkeanosExplorerAug2013/data/continuous/D20130825T172524_IFCB014.adc');
load '/Volumes/IFCB014_OkeanosExplorerAug2013/data/continuous/Manual_fromClass/D20130825T172524_IFCB014.mat'

IFCB_14_ciliate_roi_ind=find(~isnan(classlist(:,4)));
ind_1=find(IFCB_14_adcdata(2:end,8)>0.011);
ind_2=find(IFCB_14_adcdata(2:end,9)>0.0115);

figure
%plot(IFCB_14_adcdata(2:end,1),log10(IFCB_14_adcdata(2:end,9)),'.','markersize',20)
plot(IFCB_14_adcdata(2:end,7),(IFCB_14_adcdata(2:end,8)),'.','markersize',20)
hold on
%plot(IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,1),log10(IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,9)),'r.','markersize',20)
plot(IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,7),(IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,8)),'r.','markersize',20)
title('IFCB 14 green-cruise')

diambins=[0:50:35000];
hist_counts=histc(IFCB_14_adcdata(:,16).*IFCB_14_adcdata(:,17),diambins);
figure
plot(diambins,(hist_counts/ml_analyzed(45)))
ylabel('cells/ml')
xlabel('roi area')
title('IFCB 14 cruise-alt sample')

%% IDENTIFYING CHLOROPHYLL THRESHOLD
IFCB_14_adcdata=load('/Volumes/IFCB014_OkeanosExplorerAug2013/data/continuous/D20130825T172524_IFCB014.adc');
load '/Volumes/IFCB014_OkeanosExplorerAug2013/data/continuous/Manual_fromClass/D20130825T172524_IFCB014.mat'

IFCB_14_ciliate_roi_ind=find(~isnan(classlist(:,4)));
% ind_1=find(IFCB_14_adcdata(2:end,8)>0.011);
% ind_2=find(IFCB_14_adcdata(2:end,8) <= 0.011);
ind_1=find(IFCB_14_adcdata(:,9) > 0.012);
ind_2=find(IFCB_14_adcdata(:,9) <= 0.012);
ciliate_ind1=find(IFCB_14_adcdata(:,9) > 0.012 & ~isnan(classlist(:,4)));
ciliate_ind2=find(IFCB_14_adcdata(:,9) <= 0.012 & ~isnan(classlist(:,4)));
%%  LOOKING AT WHERE CELLS WITH CHLOROPHYLL ABOVE OR BELOW THRESHOLD APPEAR
figure
plot(IFCB_14_adcdata(ind_1(2:end),1),(IFCB_14_adcdata(ind_1(2:end),9)),'c.','markersize',20)
hold on
plot(IFCB_14_adcdata(ind_2(2:end),1),(IFCB_14_adcdata(ind_2(2:end),9)),'.','markersize',20)
plot(IFCB_14_adcdata(ciliate_ind1,1),(IFCB_14_adcdata(ciliate_ind1,9)),'r.','markersize',20)
plot(IFCB_14_adcdata(ciliate_ind2,1),(IFCB_14_adcdata(ciliate_ind2,9)),'m.','markersize',20)
title('IFCB 14 chl-cruise')

figure
%plot(IFCB_14_adcdata(2:end,1),(IFCB_14_adcdata(2:end,8)),'.','markersize',20)
plot(IFCB_14_adcdata(ind_1,1),(IFCB_14_adcdata(ind_1,8)),'c.','markersize',20)
hold on
plot(IFCB_14_adcdata(ind_2,1),(IFCB_14_adcdata(ind_2,8)),'.','markersize',20)
%plot(IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,1),(IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,8)),'r.','markersize',20)
plot(IFCB_14_adcdata(ciliate_ind1,1),(IFCB_14_adcdata(ciliate_ind1,8)),'r.','markersize',20)
plot(IFCB_14_adcdata(ciliate_ind2,1),(IFCB_14_adcdata(ciliate_ind2,8)),'m.','markersize',20)
%plot(IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,1),log10(IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,8)),'r.','markersize',20)
title('IFCB 14 green-cruise')
%%
figure 
plot(IFCB_14_adcdata(ind_1(2:end),7),(IFCB_14_adcdata(ind_1(2:end),8)),'c.','markersize',20)
hold on
plot(IFCB_14_adcdata(ind_2(2:end),7),(IFCB_14_adcdata(ind_2(2:end),8)),'.','markersize',20)
set(gca, 'yscale','log','xscale','log')
%%
%%
% figure
% plot(IFCB_14_adcdata(2:end,1),(IFCB_14_adcdata(2:end,8)),'.','markersize',20)
% %plot(IFCB_14_adcdata(ind_1,1),(IFCB_14_adcdata(ind_1,8)),'c.','markersize',20)
% hold on
% %plot(IFCB_14_adcdata(ind_2,1),(IFCB_14_adcdata(ind_2,8)),'.','markersize',20)
% %plot(IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,1),(IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,8)),'r.','markersize',20)
% plot(IFCB_14_adcdata(ciliate_ind1,1),(IFCB_14_adcdata(ciliate_ind1,8)),'r.','markersize',20)
% plot(IFCB_14_adcdata(ciliate_ind2,1),(IFCB_14_adcdata(ciliate_ind2,8)),'m.','markersize',20)
% %plot(IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,1),log10(IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,8)),'r.','markersize',20)
% title('IFCB 14 green-cruise')
% 
% diambins=[0:50:35000];
% hist_counts=histc(IFCB_14_adcdata(:,16).*IFCB_14_adcdata(:,17),diambins);
% figure
% plot(diambins,(hist_counts/ml_analyzed(45)))
% ylabel('cells/ml')
% xlabel('roi area')
% title('IFCB 14 cruise-alt sample')
%%

adcdata=load('/Volumes/IFCB010_OkeanosExplorerAug2013/data/D20130825T184622_IFCB010.adc');
load '/Volumes/IFCB010_OkeanosExplorerAug2013/data/Manual_fromClass/D20130825T184622_IFCB010.mat'
load '/Volumes/IFCB010_OkeanosExplorerAug2013/data/Manual_fromClass/summary/count_manual_08May2014.mat';

ciliate_roi_ind=find(~isnan(classlist(:,4)));

figure
plot(adcdata(2:end,1),log10(adcdata(2:end,8)),'.','markersize',20)
hold on
plot(adcdata(ciliate_roi_ind,1),log10(adcdata(ciliate_roi_ind,8)),'r.','markersize',20)
title('IFCB 10 CHL-cruise')

diambins=[0:50:35000];
hist_counts=histc(adcdata(:,16).*adcdata(:,17),diambins);
figure
plot(diambins,(hist_counts/ml_analyzed(59)))
ylabel('cells/ml')
xlabel('roi area')
title('IFCB 10 cruise')

