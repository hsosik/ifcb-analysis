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

figure
plot(adcdata_orange(:,8),adcdata_orange(:,9),'*b')
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
adcdata_orange=load('/Users/markmiller/Documents/Experiments/IFCB_14/Crypto_Scut_samples/D20150413T145824_IFCB014.adc');

figure
plot(adcdata_orange(:,4),adcdata_orange(:,5),'*b')
%plot(adcdata_orange(:,8),adcdata_orange(:,9),'*b')
set(gca, 'xscale','log','yscale','log')
xlabel('orange fl')
ylabel('chl')
title('orange trigger')
%%
%Trig C= 0.15
%CHL trigger only
adcdata_ssc=load('/Users/markmiller/Documents/Experiments/IFCB_14/Crypto_Scut_samples/D20150413T150429_IFCB014.adc');

figure
plot(adcdata_orange(:,4),adcdata_orange(:,5),'*b')
%plot(adcdata_orange(:,8),adcdata_orange(:,9),'*b')
set(gca, 'xscale','log','yscale','log')
xlabel('orange fl')
ylabel('roi position')
title('ssc trigger')

