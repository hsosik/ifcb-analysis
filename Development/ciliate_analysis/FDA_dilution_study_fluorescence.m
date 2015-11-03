%%
%looking at signals of all cells in sample
%10% stain
load '/Users/markmiller/Documents/Experiments/IFCB_14/FDA_dilution_study/4-28-14/Manual_fromClass/D20140428T170509_IFCB014.mat'
adcdata=load ('/Users/markmiller/Documents/Experiments/IFCB_14/FDA_dilution_study/4-28-14/D20140428T170509_IFCB014.adc');

figure
loglog(adcdata(:,4),adcdata(:,5),'r*');
hold on

load '/Users/markmiller/Documents/Experiments/IFCB_14/FDA_dilution_study/4-28-14/Manual_fromClass/D20140428T180050_IFCB014.mat'
adcdata=load ('/Users/markmiller/Documents/Experiments/IFCB_14/FDA_dilution_study/4-28-14/D20140428T180050_IFCB014.adc');


loglog(adcdata(:,4),adcdata(:,5),'r*');


%25%stain
load '/Users/markmiller/Documents/Experiments/IFCB_14/FDA_dilution_study/4-29-14/Manual_fromClass/D20140429T130531_IFCB014.mat'
adcdata=load ('/Users/markmiller/Documents/Experiments/IFCB_14/FDA_dilution_study/4-29-14/D20140429T130531_IFCB014.adc');


loglog(adcdata(:,4),adcdata(:,5),'b*');

load '/Users/markmiller/Documents/Experiments/IFCB_14/FDA_dilution_study/4-29-14/Manual_fromClass/D20140429T140527_IFCB014.mat'
adcdata=load ('/Users/markmiller/Documents/Experiments/IFCB_14/FDA_dilution_study/4-29-14/D20140429T140527_IFCB014.adc');


loglog(adcdata(:,4),adcdata(:,5),'b*');

%50% stain
load '/Users/markmiller/Documents/Experiments/IFCB_14/FDA_dilution_study/4-29-14/Manual_fromClass/D20140429T152859_IFCB014.mat'
adcdata=load ('/Users/markmiller/Documents/Experiments/IFCB_14/FDA_dilution_study/4-29-14/D20140429T152859_IFCB014.adc');


loglog(adcdata(:,4),adcdata(:,5),'k*');

load '/Users/markmiller/Documents/Experiments/IFCB_14/FDA_dilution_study/4-29-14/Manual_fromClass/D20140429T162119_IFCB014.mat'
adcdata=load ('/Users/markmiller/Documents/Experiments/IFCB_14/FDA_dilution_study/4-29-14/D20140429T162119_IFCB014.adc');

loglog(adcdata(:,4),adcdata(:,5),'k*');
%100%stain
load '/Users/markmiller/Documents/Experiments/IFCB_14/FDA_dilution_study/4-29-14/Manual_fromClass/D20140429T172018_IFCB014.mat'
adcdata=load ('/Users/markmiller/Documents/Experiments/IFCB_14/FDA_dilution_study/4-29-14/D20140429T172018_IFCB014.adc');

loglog(adcdata(:,4),adcdata(:,5),'g*');

load '/Users/markmiller/Documents/Experiments/IFCB_14/FDA_dilution_study/4-29-14/Manual_fromClass/D20140429T181424_IFCB014.mat'
adcdata=load ('/Users/markmiller/Documents/Experiments/IFCB_14/FDA_dilution_study/4-29-14/D20140429T181424_IFCB014.adc');

loglog(adcdata(:,4),adcdata(:,5),'g*');

legend('10%',' ', '25%',' ', '50%',' ', '100%',' ')
xlabel('FDA fluorescence')
ylabel('chlorophyll fluorescence')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%10% stain
load '/Users/markmiller/Documents/Experiments/IFCB_14/FDA_dilution_study/4-28-14/Manual_fromClass/D20140428T170509_IFCB014.mat'
adcdata=load ('/Users/markmiller/Documents/Experiments/IFCB_14/FDA_dilution_study/4-28-14/D20140428T170509_IFCB014.adc');

ciliate_roi_ind=find(~isnan(classlist(:,4)));
ciliate_green=adcdata(ciliate_roi_ind,4);
ciliate_red=adcdata(ciliate_roi_ind,5);
ciliate_ssc=adcdata(ciliate_roi_ind,3);

figure
loglog(ciliate_green,ciliate_red,'r*');
hold on

load '/Users/markmiller/Documents/Experiments/IFCB_14/FDA_dilution_study/4-28-14/Manual_fromClass/D20140428T180050_IFCB014.mat'
adcdata=load ('/Users/markmiller/Documents/Experiments/IFCB_14/FDA_dilution_study/4-28-14/D20140428T180050_IFCB014.adc');

ciliate_roi_ind=find(~isnan(classlist(:,4)));
ciliate_green=adcdata(ciliate_roi_ind,4);
ciliate_red=adcdata(ciliate_roi_ind,5);
ciliate_ssc=adcdata(ciliate_roi_ind,3);

loglog(ciliate_green,ciliate_red,'r*');


%25%stain
load '/Users/markmiller/Documents/Experiments/IFCB_14/FDA_dilution_study/4-29-14/Manual_fromClass/D20140429T130531_IFCB014.mat'
adcdata=load ('/Users/markmiller/Documents/Experiments/IFCB_14/FDA_dilution_study/4-29-14/D20140429T130531_IFCB014.adc');

ciliate_roi_ind=find(~isnan(classlist(:,4)));
ciliate_green=adcdata(ciliate_roi_ind,4);
ciliate_red=adcdata(ciliate_roi_ind,5);

loglog(ciliate_green,ciliate_red,'b*');

load '/Users/markmiller/Documents/Experiments/IFCB_14/FDA_dilution_study/4-29-14/Manual_fromClass/D20140429T140527_IFCB014.mat'
adcdata=load ('/Users/markmiller/Documents/Experiments/IFCB_14/FDA_dilution_study/4-29-14/D20140429T140527_IFCB014.adc');

ciliate_roi_ind=find(~isnan(classlist(:,4)));
ciliate_green=adcdata(ciliate_roi_ind,4);
ciliate_red=adcdata(ciliate_roi_ind,5);

loglog(ciliate_green,ciliate_red,'b*');

%50% stain
load '/Users/markmiller/Documents/Experiments/IFCB_14/FDA_dilution_study/4-29-14/Manual_fromClass/D20140429T152859_IFCB014.mat'
adcdata=load ('/Users/markmiller/Documents/Experiments/IFCB_14/FDA_dilution_study/4-29-14/D20140429T152859_IFCB014.adc');

ciliate_roi_ind=find(~isnan(classlist(:,4)));
ciliate_green=adcdata(ciliate_roi_ind,4);
ciliate_red=adcdata(ciliate_roi_ind,5);

loglog(ciliate_green,ciliate_red,'k*');

load '/Users/markmiller/Documents/Experiments/IFCB_14/FDA_dilution_study/4-29-14/Manual_fromClass/D20140429T162119_IFCB014.mat'
adcdata=load ('/Users/markmiller/Documents/Experiments/IFCB_14/FDA_dilution_study/4-29-14/D20140429T162119_IFCB014.adc');

ciliate_roi_ind=find(~isnan(classlist(:,4)));
ciliate_green=adcdata(ciliate_roi_ind,4);
ciliate_red=adcdata(ciliate_roi_ind,5);

loglog(ciliate_green,ciliate_red,'k*');

%100%stain
load '/Users/markmiller/Documents/Experiments/IFCB_14/FDA_dilution_study/4-29-14/Manual_fromClass/D20140429T172018_IFCB014.mat'
adcdata=load ('/Users/markmiller/Documents/Experiments/IFCB_14/FDA_dilution_study/4-29-14/D20140429T172018_IFCB014.adc');

ciliate_roi_ind=find(~isnan(classlist(:,4)));
ciliate_green=adcdata(ciliate_roi_ind,4);
ciliate_red=adcdata(ciliate_roi_ind,5);

loglog(ciliate_green,ciliate_red,'g*');

load '/Users/markmiller/Documents/Experiments/IFCB_14/FDA_dilution_study/4-29-14/Manual_fromClass/D20140429T181424_IFCB014.mat'
adcdata=load ('/Users/markmiller/Documents/Experiments/IFCB_14/FDA_dilution_study/4-29-14/D20140429T181424_IFCB014.adc');

ciliate_roi_ind=find(~isnan(classlist(:,4)));
ciliate_green=adcdata(ciliate_roi_ind,4);
ciliate_red=adcdata(ciliate_roi_ind,5);

loglog(ciliate_green,ciliate_red,'g*');

legend('10%',' ', '25%',' ', '50%',' ', '100%',' ')
xlabel('FDA fluorescence')
ylabel('chlorophyll fluorescence')

%%
%looking at scattering versus chlorophyll

%8-28-14
%10% stain
load '/Users/markmiller/Documents/Experiments/IFCB_14/FDA_dilution_study/4-28-14/Manual_fromClass/D20140428T170509_IFCB014.mat'
adcdata=load ('/Users/markmiller/Documents/Experiments/IFCB_14/FDA_dilution_study/4-28-14/D20140428T170509_IFCB014.adc');

ciliate_roi_ind=find(~isnan(classlist(:,4)));
ciliate_green=adcdata(ciliate_roi_ind,4);
ciliate_red=adcdata(ciliate_roi_ind,5);
ciliate_ssc=adcdata(ciliate_roi_ind,3);

figure
subplot(1,2,1)
loglog(ciliate_ssc,ciliate_red,'r*');
hold on

load '/Users/markmiller/Documents/Experiments/IFCB_14/FDA_dilution_study/4-28-14/Manual_fromClass/D20140428T180050_IFCB014.mat'
adcdata=load ('/Users/markmiller/Documents/Experiments/IFCB_14/FDA_dilution_study/4-28-14/D20140428T180050_IFCB014.adc');

ciliate_roi_ind=find(~isnan(classlist(:,4)));
ciliate_green=adcdata(ciliate_roi_ind,4);
ciliate_red=adcdata(ciliate_roi_ind,5);
ciliate_ssc=adcdata(ciliate_roi_ind,3);

loglog(ciliate_ssc,ciliate_red,'r*');
xlabel('Scattering')
ylabel('Chlorophyll fluorescence')
title('10% stained ciliates')
xlim([0.05 5])


%no stain
load '/Users/markmiller/Documents/Experiments/IFCB_14/FDA_dilution_study/4-28-14/Manual_fromClass/D20140428T163055_IFCB014.mat'
adcdata=load ('/Users/markmiller/Documents/Experiments/IFCB_14/FDA_dilution_study/4-28-14/D20140428T163055_IFCB014.adc');

ciliate_roi_ind=find(~isnan(classlist(:,4)));
ciliate_green=adcdata(ciliate_roi_ind,4);
ciliate_red=adcdata(ciliate_roi_ind,5);
ciliate_ssc=adcdata(ciliate_roi_ind,3);

subplot(1,2,2)
loglog(ciliate_ssc,ciliate_red,'r*');
hold on

load '/Users/markmiller/Documents/Experiments/IFCB_14/FDA_dilution_study/4-28-14/Manual_fromClass/D20140428T173543_IFCB014.mat'
adcdata=load ('/Users/markmiller/Documents/Experiments/IFCB_14/FDA_dilution_study/4-28-14/D20140428T173543_IFCB014.adc');

ciliate_roi_ind=find(~isnan(classlist(:,4)));
ciliate_green=adcdata(ciliate_roi_ind,4);
ciliate_red=adcdata(ciliate_roi_ind,5);
ciliate_ssc=adcdata(ciliate_roi_ind,3);

loglog(ciliate_ssc,ciliate_red,'r*');
xlabel('Scattering')
ylabel('Chlorophyll fluorescence')
title('unstained ciliates')
xlim([0.05 5])

%%

%25% stain
load '/Users/markmiller/Documents/Experiments/IFCB_14/FDA_dilution_study/4-29-14/Manual_fromClass/D20140429T130531_IFCB014.mat'
adcdata=load ('/Users/markmiller/Documents/Experiments/IFCB_14/FDA_dilution_study/4-29-14/D20140429T130531_IFCB014.adc');

ciliate_roi_ind=find(~isnan(classlist(:,4)));
ciliate_green=adcdata(ciliate_roi_ind,4);
ciliate_red=adcdata(ciliate_roi_ind,5);
ciliate_ssc=adcdata(ciliate_roi_ind,3);

figure
subplot(1,2,1)
loglog(ciliate_ssc,ciliate_red,'r*');
hold on

load '/Users/markmiller/Documents/Experiments/IFCB_14/FDA_dilution_study/4-29-14/Manual_fromClass/D20140429T140527_IFCB014.mat'
adcdata=load ('/Users/markmiller/Documents/Experiments/IFCB_14/FDA_dilution_study/4-29-14/D20140429T140527_IFCB014.adc');

ciliate_roi_ind=find(~isnan(classlist(:,4)));
ciliate_green=adcdata(ciliate_roi_ind,4);
ciliate_red=adcdata(ciliate_roi_ind,5);
ciliate_ssc=adcdata(ciliate_roi_ind,3);

loglog(ciliate_ssc,ciliate_red,'r*');
xlabel('Scattering')
ylabel('Chlorophyll fluorescence')
title('25% stained ciliates')
xlim([0.05 5])
ylim([0.01 10])

%no stain
load '/Users/markmiller/Documents/Experiments/IFCB_14/FDA_dilution_study/4-29-14/Manual_fromClass/D20140429T124057_IFCB014.mat'
adcdata=load ('/Users/markmiller/Documents/Experiments/IFCB_14/FDA_dilution_study/4-29-14/D20140429T124057_IFCB014.adc');

ciliate_roi_ind=find(~isnan(classlist(:,4)));
ciliate_green=adcdata(ciliate_roi_ind,4);
ciliate_red=adcdata(ciliate_roi_ind,5);
ciliate_ssc=adcdata(ciliate_roi_ind,3);

subplot(1,2,2)
loglog(ciliate_ssc,ciliate_red,'r*');
hold on

load '/Users/markmiller/Documents/Experiments/IFCB_14/FDA_dilution_study/4-29-14/Manual_fromClass/D20140429T133326_IFCB014.mat'
adcdata=load ('/Users/markmiller/Documents/Experiments/IFCB_14/FDA_dilution_study/4-29-14/D20140429T133326_IFCB014.adc');

ciliate_roi_ind=find(~isnan(classlist(:,4)));
ciliate_green=adcdata(ciliate_roi_ind,4);
ciliate_red=adcdata(ciliate_roi_ind,5);
ciliate_ssc=adcdata(ciliate_roi_ind,3);

loglog(ciliate_ssc,ciliate_red,'r*');
xlabel('Scattering')
ylabel('Chlorophyll fluorescence')
title('unstained ciliates')
xlim([0.05 5])
ylim([0.01 10])

%%
%50% stained

load '/Users/markmiller/Documents/Experiments/IFCB_14/FDA_dilution_study/4-29-14/Manual_fromClass/D20140429T152859_IFCB014.mat'
adcdata=load ('/Users/markmiller/Documents/Experiments/IFCB_14/FDA_dilution_study/4-29-14/D20140429T152859_IFCB014.adc');

ciliate_roi_ind=find(~isnan(classlist(:,4)));
ciliate_green=adcdata(ciliate_roi_ind,4);
ciliate_red=adcdata(ciliate_roi_ind,5);
ciliate_ssc=adcdata(ciliate_roi_ind,3);

figure
subplot(1,2,1)
loglog(ciliate_ssc,ciliate_red,'r*');
hold on

load '/Users/markmiller/Documents/Experiments/IFCB_14/FDA_dilution_study/4-29-14/Manual_fromClass/D20140429T162119_IFCB014.mat'
adcdata=load ('/Users/markmiller/Documents/Experiments/IFCB_14/FDA_dilution_study/4-29-14/D20140429T162119_IFCB014.adc');

ciliate_roi_ind=find(~isnan(classlist(:,4)));
ciliate_green=adcdata(ciliate_roi_ind,4);
ciliate_red=adcdata(ciliate_roi_ind,5);
ciliate_ssc=adcdata(ciliate_roi_ind,3);

loglog(ciliate_ssc,ciliate_red,'r*');
xlabel('Scattering')
ylabel('Chlorophyll fluorescence')
title('50% stained ciliates')
xlim([0.05 5])
ylim([0.01 10])

%no stain
load '/Users/markmiller/Documents/Experiments/IFCB_14/FDA_dilution_study/4-29-14/Manual_fromClass/D20140429T155608_IFCB014.mat'
adcdata=load ('/Users/markmiller/Documents/Experiments/IFCB_14/FDA_dilution_study/4-29-14/D20140429T155608_IFCB014.adc');

ciliate_roi_ind=find(~isnan(classlist(:,4)));
ciliate_green=adcdata(ciliate_roi_ind,4);
ciliate_red=adcdata(ciliate_roi_ind,5);
ciliate_ssc=adcdata(ciliate_roi_ind,3);

subplot(1,2,2)
loglog(ciliate_ssc,ciliate_red,'r*');
hold on

load '/Users/markmiller/Documents/Experiments/IFCB_14/FDA_dilution_study/4-29-14/Manual_fromClass/D20140429T150541_IFCB014.mat'
adcdata=load ('/Users/markmiller/Documents/Experiments/IFCB_14/FDA_dilution_study/4-29-14/D20140429T150541_IFCB014.adc');

ciliate_roi_ind=find(~isnan(classlist(:,4)));
ciliate_green=adcdata(ciliate_roi_ind,4);
ciliate_red=adcdata(ciliate_roi_ind,5);
ciliate_ssc=adcdata(ciliate_roi_ind,3);

loglog(ciliate_ssc,ciliate_red,'r*');
xlabel('Scattering')
ylabel('Chlorophyll fluorescence')
title('unstained ciliates')
xlim([0.05 5])
ylim([0.01 10])

%%

%100% stained

load '/Users/markmiller/Documents/Experiments/IFCB_14/FDA_dilution_study/4-29-14/Manual_fromClass/D20140429T172018_IFCB014.mat'
adcdata=load ('/Users/markmiller/Documents/Experiments/IFCB_14/FDA_dilution_study/4-29-14/D20140429T172018_IFCB014.adc');

ciliate_roi_ind=find(~isnan(classlist(:,4)));
ciliate_green=adcdata(ciliate_roi_ind,4);
ciliate_red=adcdata(ciliate_roi_ind,5);
ciliate_ssc=adcdata(ciliate_roi_ind,3);

figure
subplot(1,2,1)
loglog(ciliate_ssc,ciliate_red,'r*');
hold on

load '/Users/markmiller/Documents/Experiments/IFCB_14/FDA_dilution_study/4-29-14/Manual_fromClass/D20140429T181424_IFCB014.mat'
adcdata=load ('/Users/markmiller/Documents/Experiments/IFCB_14/FDA_dilution_study/4-29-14/D20140429T181424_IFCB014.adc');

ciliate_roi_ind=find(~isnan(classlist(:,4)));
ciliate_green=adcdata(ciliate_roi_ind,4);
ciliate_red=adcdata(ciliate_roi_ind,5);
ciliate_ssc=adcdata(ciliate_roi_ind,3);

loglog(ciliate_ssc,ciliate_red,'r*');
xlabel('Scattering')
ylabel('Chlorophyll fluorescence')
title('100% stained ciliates')
xlim([0.05 5])
ylim([0.01 10])

%no stain
load '/Users/markmiller/Documents/Experiments/IFCB_14/FDA_dilution_study/4-29-14/Manual_fromClass/D20140429T165227_IFCB014.mat'
adcdata=load ('/Users/markmiller/Documents/Experiments/IFCB_14/FDA_dilution_study/4-29-14/D20140429T165227_IFCB014.adc');

ciliate_roi_ind=find(~isnan(classlist(:,4)));
ciliate_green=adcdata(ciliate_roi_ind,4);
ciliate_red=adcdata(ciliate_roi_ind,5);
ciliate_ssc=adcdata(ciliate_roi_ind,3);

subplot(1,2,2)
loglog(ciliate_ssc,ciliate_red,'r*');
hold on

load '/Users/markmiller/Documents/Experiments/IFCB_14/FDA_dilution_study/4-29-14/Manual_fromClass/D20140429T174920_IFCB014.mat'
adcdata=load ('/Users/markmiller/Documents/Experiments/IFCB_14/FDA_dilution_study/4-29-14/D20140429T174920_IFCB014.adc');

ciliate_roi_ind=find(~isnan(classlist(:,4)));
ciliate_green=adcdata(ciliate_roi_ind,4);
ciliate_red=adcdata(ciliate_roi_ind,5);
ciliate_ssc=adcdata(ciliate_roi_ind,3);

loglog(ciliate_ssc,ciliate_red,'r*');
xlabel('Scattering')
ylabel('Chlorophyll fluorescence')
title('unstained ciliates')
xlim([0.05 5])
ylim([0.01 10])
