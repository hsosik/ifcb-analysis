%% 4-22-15 Scut, crypto, dun culture


%green and red trigger, no stain
adcdata_orange=load('/Users/markmiller/Documents/Experiments/IFCB_14/Crypto_Dun_samples/D20150422T160723_IFCB014.adc');
roi_ind=find(adcdata_orange(:,14)>0);

figure
plot(adcdata_orange(roi_ind,8),adcdata_orange(roi_ind,9),'*b')
set(gca, 'xscale','log','yscale','log')
xlabel('green fl')
ylabel('chl')
title('green and red trigger, no stain')

%%
adcdata_orange=load('/Users/markmiller/Documents/Experiments/IFCB_14/Crypto_Dun_samples/D20150422T162733_IFCB014.adc');
roi_ind=find(adcdata_orange(:,14)>0);

figure
plot(adcdata_orange(roi_ind,8),adcdata_orange(roi_ind,9),'*b')
set(gca, 'xscale','log','yscale','log')
xlabel('green fl')
ylabel('chl')
title('green and red trigger, stain')

%%
%570SP added to PMTB

adcdata_orange=load('/Users/markmiller/Documents/Experiments/IFCB_14/Crypto_Dun_samples/D20150422T172724_IFCB014.adc');
roi_ind=find(adcdata_orange(:,14)>0);

figure
plot(adcdata_orange(roi_ind,8),adcdata_orange(roi_ind,9),'*b')
set(gca, 'xscale','log','yscale','log')
xlabel('orange fl')
ylabel('chl')
title(' red trigger, orange settings')

%%
%crypto and dun, green settings, no stain

adcdata_orange=load('/Users/markmiller/Documents/Experiments/IFCB_14/Crypto_Dun_samples/D20150428T172741_IFCB014.adc');
roi_ind=find(adcdata_orange(:,14)>0);

figure
plot(adcdata_orange(roi_ind,8),adcdata_orange(roi_ind,9),'*b')
set(gca, 'xscale','log','yscale','log')
xlabel('green fl')
ylabel('chl')
title(' red and green trigger, no stain')

%%
%crypto and dun, green settings, stain

adcdata_orange=load('/Users/markmiller/Documents/Experiments/IFCB_14/Crypto_Dun_samples/D20150428T173551_IFCB014.adc');
roi_ind=find(adcdata_orange(:,14)>0);

figure
plot(adcdata_orange(roi_ind,8),adcdata_orange(roi_ind,9),'*b')
set(gca, 'xscale','log','yscale','log')
xlabel('green fl')
ylabel('chl')
title(' red and green trigger, stain')

%%
%scut and dun, green settings, no stain, no RC box on PMTB

adcdata_orange=load('/Users/markmiller/Documents/Experiments/IFCB_14/Crypto_Dun_samples/D20150428T175646_IFCB014.adc');
roi_ind=find(adcdata_orange(:,14)>0);

figure
plot(adcdata_orange(roi_ind,8),adcdata_orange(roi_ind,9),'*b')
set(gca, 'xscale','log','yscale','log')
xlabel('green fl')
ylabel('chl')
title(' red and green trigger, no stain')
xlim([0.01 10])

%%
%scut and dun, green settings, stain, no RC box on PMTB

adcdata_orange=load('/Users/markmiller/Documents/Experiments/IFCB_14/Crypto_Dun_samples/D20150428T180158_IFCB014.adc');
roi_ind=find(adcdata_orange(:,14)>0);

figure
plot(adcdata_orange(roi_ind,8),adcdata_orange(roi_ind,9),'*b')
set(gca, 'xscale','log','yscale','log')
xlabel('green fl')
ylabel('chl')
title(' red and green trigger, stain')
xlim([0.01 10])

%%
%scut and MORE dun, green settings, stain, no RC box on PMTB

adcdata_orange=load('/Users/markmiller/Documents/Experiments/IFCB_14/Crypto_Dun_samples/D20150428T180715_IFCB014.adc');
roi_ind=find(adcdata_orange(:,14)>0);

figure
plot(adcdata_orange(roi_ind,8),adcdata_orange(roi_ind,9),'*b')
set(gca, 'xscale','log','yscale','log')
xlabel('green fl')
ylabel('chl')
title(' red and green trigger, stain')
xlim([0.01 10])

%%
%scut and MORE dun, green settings, stain, no RC box on PMTB or PMTC

adcdata_orange=load('/Users/markmiller/Documents/Experiments/IFCB_14/Crypto_Dun_samples/D20150428T181424_IFCB014.adc');
roi_ind=find(adcdata_orange(:,14)>0);

figure
plot(adcdata_orange(roi_ind,8),adcdata_orange(roi_ind,9),'*b')
set(gca, 'xscale','log','yscale','log')
xlabel('green fl')
ylabel('chl')
title(' red and green trigger, stain')
xlim([0.01 10])

%%
%MVCO files, stain, green settings, green and chl trigger

adcdata_orange=load('/Users/markmiller/Documents/Experiments/MVCO_Samples/MVCO_4-27-15/D20150428T012122_IFCB014.adc');
roi_ind=find(adcdata_orange(:,14)>0);
crypto_ind=[147 121 514 684 879 1160]';

figure
plot(adcdata_orange(roi_ind,4),adcdata_orange(roi_ind,5),'*b')
hold on
plot(adcdata_orange(crypto_ind,4),adcdata_orange(crypto_ind,5),'*g','markersize',15);
set(gca, 'xscale','log','yscale','log')
xlabel('green fl')
ylabel('chl')
title(' red and green trigger, stain')
%xlim([0.01 10])

%%
%scut, dun, crypto, green settings, no stain, no RC box on PMTB or PMTC,
%triggering on ONLY GREEN

adcdata_orange=load('/Users/markmiller/Documents/Experiments/IFCB_14/Crypto_Dun_samples/D20150429T150258_IFCB014.adc');
roi_ind=find(adcdata_orange(:,14)>0);

figure
plot(adcdata_orange(roi_ind,8),adcdata_orange(roi_ind,9),'*b')
set(gca, 'xscale','log','yscale','log')
xlabel('green fl')
ylabel('chl')
title('green trigger, no stain')
xlim([0.01 10])

%scut, dun, crypto, green settings, no stain, no RC box on PMTB or PMTC,
%triggering on ONLY SCATTERING

adcdata_orange=load('/Users/markmiller/Documents/Experiments/IFCB_14/Crypto_Dun_samples/D20150429T150706_IFCB014.adc');
roi_ind=find(adcdata_orange(:,14)>0);

figure
plot(adcdata_orange(roi_ind,8),adcdata_orange(roi_ind,9),'*b')
set(gca, 'xscale','log','yscale','log')
xlabel('green fl')
ylabel('chl')
title('ssc trigger, no stain')
xlim([0.01 10])

%scut, dun, crypto, green settings, no stain, added back RC box on PMTC,
%triggering on ONLY SCATTERING 

adcdata_orange=load('/Users/markmiller/Documents/Experiments/IFCB_14/Crypto_Dun_samples/D20150429T153408_IFCB014.adc');
roi_ind=find(adcdata_orange(:,14)>0);

figure
plot(adcdata_orange(roi_ind,8),adcdata_orange(roi_ind,9),'*b')
set(gca, 'xscale','log','yscale','log')
xlabel('green fl')
ylabel('chl')
title('ssc trigger, no stain, RC box back')
xlim([0.01 10])
%%
%scut, dun, crypto, green settings, stain, no RC box on PMTC or B,
%triggering on ONLY CHL

adcdata_orange=load('/Users/markmiller/Documents/Experiments/IFCB_14/Crypto_Dun_samples/D20150429T152003_IFCB014.adc');
roi_ind=find(adcdata_orange(:,14)>0);

figure
plot(adcdata_orange(roi_ind,8),adcdata_orange(roi_ind,9),'*b')
set(gca, 'xscale','log','yscale','log')
xlabel('green fl')
ylabel('chl')
title('chl trigger, stain, ')
xlim([0.01 10])
%%

%scut, dun, crypto, green settings, stain, no RC box on PMTC or B,
%triggering on ONLY CHL aand GREEN


adcdata_orange=load('/Users/markmiller/Documents/Experiments/IFCB_14/Crypto_Dun_samples/D20150429T152458_IFCB014.adc');
roi_ind=find(adcdata_orange(:,14)>0);

figure
plot(adcdata_orange(roi_ind,8),adcdata_orange(roi_ind,9),'*b')
set(gca, 'xscale','log','yscale','log')
xlabel('green fl')
ylabel('chl')
title('green and chl trigger, stain, ')
xlim([0.01 10])







