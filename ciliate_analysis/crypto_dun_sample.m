%adc_data column description
%7 = peak scatter
%8 = peak green/orange
%9 = peak chlorophyll
%14= roi x position
%15= roi y position
%3 = int scatter
%4 = int green/orange
%5 = int chlorophyll

adcdata_orange=load('/Users/markmiller/Documents/Experiments/IFCB_14/interference_filter/D20150402T170022_IFCB014.adc');
roi_ind=find(adcdata_orange(:,14)>0);

figure
plot(adcdata_orange(roi_ind,8),adcdata_orange(roi_ind,9),'*b')
set(gca, 'xscale','log','yscale','log')
xlabel('orange fl')
ylabel('chl')
title('orange trigger')
%%

adcdata_ssc=load('/Users/markmiller/Documents/Experiments/IFCB_14/interference_filter/D20150402T171137_IFCB014.adc');


figure
plot(adcdata_ssc(:,8),adcdata_ssc(:,14),'*b')
set(gca, 'xscale','log','yscale','log')
xlabel('orange fl')
ylabel('roi position')
title('ssc trigger')

%%
%Trig C= 0.12
%Chl trigger only
adcdata_1=load('/Users/markmiller/Documents/Experiments/IFCB_14/Crypto_Dun_samples/D20150413T145824_IFCB014.adc');
roi_ind=find(adcdata_1(:,14)>0);

figure
%plot(adcdata_1(:,4),adcdata_1(:,5),'*b')
plot(adcdata_1(roi_ind,8),adcdata_1(roi_ind,9),'*b')

set(gca, 'xscale','log','yscale','log')
xlabel('orange fl')
ylabel('chl')
title('Trig C = 0.12')
%%
figure
hist(adcdata_1(:,9),1000)
title('Trig C = 0.12')
%%
%Trig C= 0.15
%CHL trigger only
adcdata_2=load('/Users/markmiller/Documents/Experiments/IFCB_14/Crypto_Dun_samples/D20150413T150429_IFCB014.adc');

figure
%plot(adcdata_2(:,4),adcdata_2(:,5),'*b')
plot(adcdata_2(:,8),adcdata_2(:,9),'*b')
set(gca, 'xscale','log','yscale','log')
xlabel('orange fl')
ylabel('roi position')
title('Trig C = 0.15')
%%
figure
hist(adcdata_2(:,9),1000)
title('Trig C = 0.15')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%

%looking at ssc trigger, roi's /sec
load '/Users/markmiller/Documents/Experiments/IFCB_14/Crypto_Dun_samples/Manual_fromClass/summary/count_manual_16Apr2015.mat'

adcdata_ssc1=load('/Users/markmiller/Documents/Experiments/IFCB_14/Crypto_Dun_samples/D20150413T161759_IFCB014.adc');
real_trigger=find(adcdata_ssc1(:,16)>0);
size=length(real_trigger);
%trigger_rate1=size(1)/adcdata_ssc1(end,2);
trigger_rate1=size(1)/ml_analyzed(3);

adcdata_ssc2=load('/Users/markmiller/Documents/Experiments/IFCB_14/Crypto_Dun_samples/D20150413T162229_IFCB014.adc');
real_trigger=find(adcdata_ssc2(:,16)>0);
%trigger_rate2=size(1)/adcdata_ssc1(end,2);
trigger_rate2=size(1)/ml_analyzed(4);

adcdata_ssc3=load('/Users/markmiller/Documents/Experiments/IFCB_14/Crypto_Dun_samples/D20150413T162528_IFCB014.adc');
real_trigger=find(adcdata_ssc3(:,16)>0);
size=length(real_trigger);
%trigger_rate3=size(1)/adcdata_ssc3(end,2);
trigger_rate3=size(1)/ml_analyzed(5);

adcdata_ssc4=load('/Users/markmiller/Documents/Experiments/IFCB_14/Crypto_Dun_samples/D20150413T162849_IFCB014.adc');
real_trigger=find(adcdata_ssc4(:,16)>0);
size=length(real_trigger);
%trigger_rate4=size(1)/adcdata_ssc4(end,2);
trigger_rate4=size(1)/ml_analyzed(6);

adcdata_ssc5=load('/Users/markmiller/Documents/Experiments/IFCB_14/Crypto_Dun_samples/D20150413T163505_IFCB014.adc');
real_trigger=find(adcdata_ssc5(:,16)>0);
size=length(real_trigger);
%trigger_rate5=size(1)/adcdata_ssc5(end,2);
trigger_rate5=size(1)/ml_analyzed(7);

adcdata_ssc6=load('/Users/markmiller/Documents/Experiments/IFCB_14/Crypto_Dun_samples/D20150413T170510_IFCB014.adc');
real_trigger=find(adcdata_ssc6(:,16)>0);
size=length(real_trigger);
%trigger_rate6=size(1)/adcdata_ssc6(end,2);
trigger_rate6=size(1)/ml_analyzed(8);

x=[0.17 0.16 0.15 0.14 0.13 0.12];

figure
bar(x,[trigger_rate6 trigger_rate1 trigger_rate2 trigger_rate3 trigger_rate4 trigger_rate5]);
set(gca,'XTick',[0.12 0.13 0.14 0.15 0.16 0.17]);
xlabel('Trig A')
ylabel('trigger rate')
title('scattering trigger (real rois/ml)')
%%
%looking at ssc trigger, total triggers /sec

adcdata_ssc1=load('/Users/markmiller/Documents/Experiments/IFCB_14/Crypto_Dun_samples/D20150413T161759_IFCB014.adc');
%trigger_rate1=adcdata_ssc1(end,1)/adcdata_ssc1(end,2);
trigger_rate1=adcdata_ssc1(end,1)/ml_analyzed(3);

adcdata_ssc2=load('/Users/markmiller/Documents/Experiments/IFCB_14/Crypto_Dun_samples/D20150413T162229_IFCB014.adc');
%trigger_rate2=adcdata_ssc2(end,1)/adcdata_ssc2(end,2);
trigger_rate2=adcdata_ssc1(end,1)/ml_analyzed(4);

adcdata_ssc3=load('/Users/markmiller/Documents/Experiments/IFCB_14/Crypto_Dun_samples/D20150413T162528_IFCB014.adc');
%trigger_rate3=adcdata_ssc3(end,1)/adcdata_ssc3(end,2);
trigger_rate3=adcdata_ssc1(end,1)/ml_analyzed(5);

adcdata_ssc4=load('/Users/markmiller/Documents/Experiments/IFCB_14/Crypto_Dun_samples/D20150413T162849_IFCB014.adc');
%trigger_rate4=adcdata_ssc4(end,1)/adcdata_ssc4(end,2);
trigger_rate4=adcdata_ssc1(end,1)/ml_analyzed(6);

adcdata_ssc5=load('/Users/markmiller/Documents/Experiments/IFCB_14/Crypto_Dun_samples/D20150413T163505_IFCB014.adc');
%trigger_rate5=adcdata_ssc5(end,1)/adcdata_ssc5(end,2);
trigger_rate5=adcdata_ssc1(end,1)/ml_analyzed(7);

adcdata_ssc6=load('/Users/markmiller/Documents/Experiments/IFCB_14/Crypto_Dun_samples/D20150413T170510_IFCB014.adc');
%trigger_rate6=adcdata_ssc6(end,1)/adcdata_ssc6(end,2);
trigger_rate6=adcdata_ssc1(end,1)/ml_analyzed(8);

x=[0.17 0.16 0.15 0.14 0.13 0.12];

figure
bar(x,[trigger_rate6 trigger_rate1 trigger_rate2 trigger_rate3 trigger_rate4 trigger_rate5]);
set(gca,'XTick',[0.12 0.13 0.14 0.15 0.16 0.17]);
xlabel('Trig A')
ylabel('trigger rate')
title('scattering trigger (all triggers/ml)')

%%

%looking at chl trigger, roi's /sec

adcdata_ssc1=load('/Users/markmiller/Documents/Experiments/IFCB_14/Crypto_Dun_samples/D20150413T172206_IFCB014.adc');
real_trigger=find(adcdata_ssc1(:,16)>0);
size=length(real_trigger);
%trigger_rate1=size(1)/adcdata_ssc1(end,2);
trigger_rate1=size(1)/ml_analyzed(9);

figure
hist(adcdata_ssc1(real_trigger,9),1000)
title('Trig C = 0.2 chl trigger')
ylim([0 20])
xlabel('chl fluorescence')
xlim([0 2])

adcdata_ssc2=load('/Users/markmiller/Documents/Experiments/IFCB_14/Crypto_Dun_samples/D20150413T172643_IFCB014.adc');
real_trigger=find(adcdata_ssc2(:,16)>0);
size=length(real_trigger);
%trigger_rate2=size(1)/adcdata_ssc2(end,2);
trigger_rate2=size(1)/ml_analyzed(10);

adcdata_ssc3=load('/Users/markmiller/Documents/Experiments/IFCB_14/Crypto_Dun_samples/D20150413T173028_IFCB014.adc');
real_trigger=find(adcdata_ssc3(:,16)>0);
size=length(real_trigger);
%trigger_rate3=size(1)/adcdata_ssc3(end,2);
trigger_rate3=size(1)/ml_analyzed(11);

adcdata_ssc4=load('/Users/markmiller/Documents/Experiments/IFCB_14/Crypto_Dun_samples/D20150413T173642_IFCB014.adc');
real_trigger=find(adcdata_ssc4(:,16)>0);
size=length(real_trigger);
%trigger_rate4=size(1)/adcdata_ssc4(end,2);
trigger_rate4=size(1)/ml_analyzed(12);

adcdata_ssc5=load('/Users/markmiller/Documents/Experiments/IFCB_14/Crypto_Dun_samples/D20150413T174003_IFCB014.adc');
real_trigger=find(adcdata_ssc5(:,16)>0);
size=length(real_trigger);
%trigger_rate5=size(1)/adcdata_ssc5(end,2);
trigger_rate5=size(1)/ml_analyzed(13);

figure
hist(adcdata_ssc5(:,9),1000)
title('Trig C = 0.12 chl trigger')
ylim([0 20])
xlabel('chl fluorescence')
xlim([0 2])


adcdata_ssc6=load('/Users/markmiller/Documents/Experiments/IFCB_14/Crypto_Dun_samples/D20150413T174331_IFCB014.adc');
real_trigger=find(adcdata_ssc6(:,16)>0);
size=length(real_trigger);
%trigger_rate6=size(1)/adcdata_ssc6(end,2);
trigger_rate6=size(1)/ml_analyzed(14);

figure
hist(adcdata_ssc6(:,9),1000)
title('Trig C = 0.10 chl trigger')
ylim([0 40])
xlabel('chl fluorescence')


adcdata_ssc7=load('/Users/markmiller/Documents/Experiments/IFCB_14/Crypto_Dun_samples/D20150413T174900_IFCB014.adc');
real_trigger=find(adcdata_ssc7(:,16)>0);
size=length(real_trigger);
%trigger_rate7=size(1)/adcdata_ssc7(end,2);
trigger_rate7=size(1)/ml_analyzed(15);

adcdata_ssc8=load('/Users/markmiller/Documents/Experiments/IFCB_14/Crypto_Dun_samples/D20150413T175329_IFCB014.adc');
real_trigger=find(adcdata_ssc8(:,16)>0);
size=length(real_trigger);
%trigger_rate8=size(1)/adcdata_ssc8(end,2);
trigger_rate8=size(1)/ml_analyzed(16);

figure
hist(adcdata_ssc8(:,9),1000)
title('Trig C = 0.115 chl trigger')
ylim([0 40])
xlabel('chl fluorescence')

adcdata_ssc9=load('/Users/markmiller/Documents/Experiments/IFCB_14/Crypto_Dun_samples/D20150413T175744_IFCB014.adc');
real_trigger=find(adcdata_ssc9(:,16)>0);
size=length(real_trigger);
%trigger_rate9=size(1)/adcdata_ssc9(end,2);
trigger_rate9=size(1)/ml_analyzed(17);

adcdata_ssc10=load('/Users/markmiller/Documents/Experiments/IFCB_14/Crypto_Dun_samples/D20150413T180209_IFCB014.adc');
real_trigger=find(adcdata_ssc10(:,16)>0);
size=length(real_trigger);
%trigger_rate10=size(1)/adcdata_ssc10(end,2);
trigger_rate10=size(1)/ml_analyzed(18);

x=[0.2 0.18 0.16 0.14 0.125 0.13 0.12 0.115 0.11 0.10];

figure
bar(x,[trigger_rate1 trigger_rate2 trigger_rate3 trigger_rate4 trigger_rate10 trigger_rate9 trigger_rate5 trigger_rate8 trigger_rate7 trigger_rate6]);
%set(gca,'XTick',[0.10 0.11 0.115 0.12 0.125 0.13 0. 0.14 0.16 0.18 0.20]);
xlabel('Trig A')
ylabel('trigger rate')
title('scattering trigger (real rois/ml)')

%%
%7 = peak scatter
%8 = peak green/orange
%9 = peak chlorophyll
%14= roi x position
%15= roi y position
%3 = int scatter
%4 = int green/orange
%5 = int chlorophyll

%Trig C= 0.12
%Chl trigger only
% run at normal speed
adcdata_normal=load('/Users/markmiller/Documents/Experiments/IFCB_14/Crypto_Dun_samples/D20150414T180844_IFCB014.adc');
roi_ind=find(adcdata_normal(:,14)>0);

figure
%plot(adcdata_normal(:,4),adcdata_normal(:,5),'*b')
plot(adcdata_normal(roi_ind,8),adcdata_normal(roi_ind,9),'*b')
set(gca, 'xscale','log','yscale','log')
xlabel('orange fl')
ylabel('chl')
title('Trig C = 0.12 normal speed')

figure
hist(adcdata_normal(roi_ind,9),1000)
title('Trig C = 0.12 normal speed (real rois)')
ylim([0 20])
xlim([0 2])

%%
%Trig C= 0.12
%Chl trigger only
% run at half speed

adcdata_half=load('/Users/markmiller/Documents/Experiments/IFCB_14/Crypto_Dun_samples/D20150414T175201_IFCB014.adc');
roi_ind=find(adcdata_half(:,14)>0);

figure
%plot(adcdata_normal(:,4),adcdata_normal(:,5),'*b')
plot(adcdata_half(roi_ind,8),adcdata_half(roi_ind,9),'*b')
set(gca, 'xscale','log','yscale','log')
xlabel('orange fl')
ylabel('chl')
title('Trig C = 0.12 half speed')

figure
hist(adcdata_half(roi_ind,9),1000)
title('Trig C = 0.12 half speed (real rois)')
ylim([0 20])
xlim([0 2])

%%
%Trig C= 0.12
%Chl trigger only
% run at 0.8 speed

adcdata_threequarter=load('/Users/markmiller/Documents/Experiments/IFCB_14/Crypto_Dun_samples/D20150414T181900_IFCB014.adc');
roi_ind=find(adcdata_threequarter(:,14)>0);

figure
%plot(adcdata_threequarter(:,4),adcdata_threequarter(:,5),'*b')
plot(adcdata_threequarter(roi_ind,8),adcdata_threequarter(roi_ind,9),'*b')
set(gca, 'xscale','log','yscale','log')
xlabel('orange fl')
ylabel('chl')
title('Trig C = 0.12 0.8 speed')

figure
hist(adcdata_threequarter(roi_ind,9),1000)
title('Trig C = 0.12 0.8 speed')
ylim([0 20])
xlim([0 2])

%%
%Trig C= 0.12
%Chl trigger only
% run at 0.3 speed

adcdata_quarter=load('/Users/markmiller/Documents/Experiments/IFCB_14/Crypto_Dun_samples/D20150414T182537_IFCB014.adc');
roi_ind=find(adcdata_quarter(:,14)>0);

figure
%plot(adcdata_quarter(:,4),adcdata_quarter(:,5),'*b')
plot(adcdata_quarter(roi_ind,8),adcdata_quarter(roi_ind,9),'*b')
set(gca, 'xscale','log','yscale','log')
xlabel('orange fl')
ylabel('chl')
title('Trig C = 0.12 0.3 speed')

figure
hist(adcdata_quarter(roi_ind,9),1000)
title('Trig C = 0.12 0.3 speed')
ylim([0 20])
xlim([0 2])

%% ADDED SIGNAL SMOOTHER ON PMTC
%Trig C= 0.12
%Chl trigger only
% run at normal speed

adcdata=load('/Users/markmiller/Documents/Experiments/IFCB_14/Crypto_Dun_samples/D20150415T190052_IFCB014.adc');
roi_ind=find(adcdata(:,14)>0);

figure
%plot(adcdata(:,4),adcdata(:,5),'*b')
plot(adcdata(roi_ind,8),adcdata(roi_ind,9),'*b')
set(gca, 'xscale','log','yscale','log')
xlabel('orange fl')
ylabel('chl')
title('Trig C = 0.12 0.3 speed')

figure
hist(adcdata(roi_ind,9),1000)
title('Trig C = 0.12')
ylim([0 20])
xlim([0 2])

%% ADDED SIGNAL SMOOTHER ON PMTC
%Trig C= 0.12
%Chl trigger only
% run at normal speed
%changed pmtc from 0.5 to 0.7

adcdata=load('/Users/markmiller/Documents/Experiments/IFCB_14/Crypto_Dun_samples/D20150415T200114_IFCB014.adc');
roi_ind=find(adcdata(:,14)>0);

figure
%plot(adcdata(:,4),adcdata(:,5),'*b')
plot(adcdata(roi_ind,8),adcdata(roi_ind,9),'*b')
set(gca, 'xscale','log','yscale','log')
xlabel('orange fl')
ylabel('chl')
title('Trig C = 0.12 0.3 speed')

figure
hist(adcdata(roi_ind,9),1000)
title('Trig C = 0.12 chlorophyll')
ylim([0 20])
xlim([0 4])

figure
hist(adcdata(roi_ind,8),1000)
title('Trig C = 0.12 orange')
ylim([0 20])
xlim([0 2])

%% SIGNAL SMOOTHER ON PMTA C and B
%Trig C= 0.12
%Chl trigger only
% run at normal speed
%changed pmtc from 0.5 to 0.7

adcdata=load('/Users/markmiller/Documents/Experiments/IFCB_14/Crypto_Dun_samples/D20150415T201010_IFCB014.adc');
roi_ind=find(adcdata(:,14)>0);

figure
%plot(adcdata(:,4),adcdata(:,5),'*b')
plot(adcdata(roi_ind,8),adcdata(roi_ind,9),'*b')
set(gca, 'xscale','log','yscale','log')
xlabel('orange fl')
ylabel('chl')
title('Trig C = 0.12')

figure
hist(adcdata(roi_ind,9),1000)
title('Trig C = 0.12 chl')
ylim([0 20])
xlim([0 4])

figure
hist(adcdata(roi_ind,8),1000)
title('Trig C = 0.12 orange')
ylim([0 20])
xlim([0 2])

%% SIGNAL SMOOTHER ON PMTA C and B
%Trig C= 0.12
%Chl trigger only
% run at normal speed
%changed pmtb from 0.6 to 0.7

adcdata=load('/Users/markmiller/Documents/Experiments/IFCB_14/Crypto_Dun_samples/D20150415T201426_IFCB014.adc');
roi_ind=find(adcdata(:,14)>0);

figure
%plot(adcdata(:,4),adcdata(:,5),'*b')
plot(adcdata(roi_ind,8),adcdata(roi_ind,9),'*b')
set(gca, 'xscale','log','yscale','log')
xlabel('orange fl')
ylabel('chl')
title('Trig C = 0.12')

figure
hist(adcdata(roi_ind,9),1000)
title('Trig C = 0.12 chl')
ylim([0 20])
xlim([0 4])

figure
hist(adcdata(roi_ind,8),1000)
title('Trig C = 0.12 orange')
ylim([0 20])
xlim([0 2])


%% SIGNAL SMOOTHER ON PMTA C and B
%Trig C= 0.12
%Chl trigger only
% run at normal speed
%changed pmtb and pmtc from 0.6 to 0.7

adcdata=load('/Users/markmiller/Documents/Experiments/IFCB_14/Crypto_Dun_samples/D20150415T202046_IFCB014.adc');
roi_ind=find(adcdata(:,14)>0);

figure
%plot(adcdata(:,4),adcdata(:,5),'*b')
plot(adcdata(roi_ind,8),adcdata(roi_ind,9),'*b')
set(gca, 'xscale','log','yscale','log')
xlabel('orange fl')
ylabel('chl')
title('Trig C = 0.12')

figure
hist(adcdata(roi_ind,9),1000)
title('Trig C = 0.12 chl')
ylim([0 20])
xlim([0 4])

figure
hist(adcdata(roi_ind,8),1000)
title('Trig C = 0.12 orange')
ylim([0 20])
xlim([0 2])


%% SIGNAL SMOOTHER ON PMTA C and B
%Trig C= 0.12
%Chl trigger only
% run at normal speed
%changed pmtb  from 0.7 to 0.75

adcdata=load('/Users/markmiller/Documents/Experiments/IFCB_14/Crypto_Dun_samples/D20150415T202739_IFCB014.adc');

roi_ind=find(adcdata(:,14)>0);


figure
%plot(adcdata(:,4),adcdata(:,5),'*b')
plot(adcdata(roi_ind,8),adcdata(roi_ind,9),'*b')
set(gca, 'xscale','log','yscale','log')
xlabel('orange fl')
ylabel('chl')
title('Trig C = 0.12')

figure
hist(adcdata(roi_ind,9),1000)
title('Trig C = 0.12 chl')
ylim([0 20])
xlim([0 4])


figure
hist(adcdata(roi_ind,8),1000)
title('Trig C = 0.12 orange')
ylim([0 20])
xlim([0 2])

%% SIGNAL SMOOTHER ON PMTA C and B
%Trig C= 0.12
%Chl trigger only
% run at normal speed
%changed pmtb  from 0.7 to 0.75

adcdata=load('/Users/markmiller/Documents/Experiments/IFCB_14/Crypto_Dun_samples/D20150415T203306_IFCB014.adc');

roi_ind=find(adcdata(:,14)>0);


figure
plot(adcdata(roi_ind,4),adcdata(roi_ind,5),'*b')
%plot(adcdata(roi_ind,8),adcdata(roi_ind,9),'*b')
set(gca, 'xscale','log','yscale','log')
xlabel('orange fl')
ylabel('chl')
title('Trig C = 0.12')

figure
hist(adcdata(roi_ind,9),1000)
title('Trig C = 0.12 chl')
ylim([0 20])
xlim([0 4])

figure
hist(adcdata(roi_ind,8),1000)
title('Trig C = 0.12 orange')
ylim([0 20])
xlim([0 2])
