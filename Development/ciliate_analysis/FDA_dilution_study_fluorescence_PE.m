
%4-25-14
load '/Users/markmiller/Documents/Experiments/IFCB_14/FDA_dilution_study/4-25-14/Manual_fromClass/D20140425T152802_IFCB014.mat'
adcdata=load ('/Users/markmiller/Documents/Experiments/IFCB_14/FDA_dilution_study/4-25-14/D20140425T152802_IFCB014.adc');

ciliate_roi_ind=find(~isnan(classlist(:,4)));
ciliate_green=adcdata(ciliate_roi_ind,4);
ciliate_red=adcdata(ciliate_roi_ind,5);

figure
loglog(ciliate_green,ciliate_red,'r*');
hold on

load '/Users/markmiller/Documents/Experiments/IFCB_14/FDA_dilution_study/4-25-14/Manual_fromClass/D20140425T162233_IFCB014.mat'
adcdata=load ('/Users/markmiller/Documents/Experiments/IFCB_14/FDA_dilution_study/4-25-14/D20140425T162233_IFCB014.adc');

ciliate_roi_ind=find(~isnan(classlist(:,4)));
ciliate_green=adcdata(ciliate_roi_ind,4);
ciliate_red=adcdata(ciliate_roi_ind,5);

loglog(ciliate_green,ciliate_red,'r*');


load '/Users/markmiller/Documents/Experiments/IFCB_14/FDA_dilution_study/4-25-14/Manual_fromClass/D20140425T171939_IFCB014.mat'
adcdata=load ('/Users/markmiller/Documents/Experiments/IFCB_14/FDA_dilution_study/4-25-14/D20140425T171939_IFCB014.adc');

ciliate_roi_ind=find(~isnan(classlist(:,4)));
ciliate_green=adcdata(ciliate_roi_ind,4);
ciliate_red=adcdata(ciliate_roi_ind,5);

loglog(ciliate_green,ciliate_red,'r*');

load '/Users/markmiller/Documents/Experiments/IFCB_14/FDA_dilution_study/4-25-14/Manual_fromClass/D20140425T184116_IFCB014.mat'
adcdata=load ('/Users/markmiller/Documents/Experiments/IFCB_14/FDA_dilution_study/4-25-14/D20140425T184116_IFCB014.adc');

ciliate_roi_ind=find(~isnan(classlist(:,4)));
ciliate_green=adcdata(ciliate_roi_ind,4);
ciliate_red=adcdata(ciliate_roi_ind,5);

loglog(ciliate_green,ciliate_red,'r*');

%4-27-14
load '/Users/markmiller/Documents/Experiments/IFCB_14/FDA_dilution_study/4-27-14/Manual_fromClass/D20140427T134935_IFCB014.mat'
adcdata=load ('/Users/markmiller/Documents/Experiments/IFCB_14/FDA_dilution_study/4-27-14/D20140427T134935_IFCB014.adc');

ciliate_roi_ind=find(~isnan(classlist(:,4)));
ciliate_green=adcdata(ciliate_roi_ind,4);
ciliate_red=adcdata(ciliate_roi_ind,5);

loglog(ciliate_green,ciliate_red,'b*');

load '/Users/markmiller/Documents/Experiments/IFCB_14/FDA_dilution_study/4-27-14/Manual_fromClass/D20140427T144044_IFCB014.mat'
adcdata=load ('/Users/markmiller/Documents/Experiments/IFCB_14/FDA_dilution_study/4-27-14/D20140427T144044_IFCB014.adc');

ciliate_roi_ind=find(~isnan(classlist(:,4)));
ciliate_green=adcdata(ciliate_roi_ind,4);
ciliate_red=adcdata(ciliate_roi_ind,5);

loglog(ciliate_green,ciliate_red,'b*');

load '/Users/markmiller/Documents/Experiments/IFCB_14/FDA_dilution_study/4-27-14/Manual_fromClass/D20140427T153309_IFCB014.mat'
adcdata=load ('/Users/markmiller/Documents/Experiments/IFCB_14/FDA_dilution_study/4-27-14/D20140427T153309_IFCB014.adc');

ciliate_roi_ind=find(~isnan(classlist(:,4)));
ciliate_green=adcdata(ciliate_roi_ind,4);
ciliate_red=adcdata(ciliate_roi_ind,5);

loglog(ciliate_green,ciliate_red,'b*');

load '/Users/markmiller/Documents/Experiments/IFCB_14/FDA_dilution_study/4-27-14/Manual_fromClass/D20140427T162425_IFCB014.mat'
adcdata=load ('/Users/markmiller/Documents/Experiments/IFCB_14/FDA_dilution_study/4-27-14/D20140427T162425_IFCB014.adc');

ciliate_roi_ind=find(~isnan(classlist(:,4)));
ciliate_green=adcdata(ciliate_roi_ind,4);
ciliate_red=adcdata(ciliate_roi_ind,5);

loglog(ciliate_green,ciliate_red,'b*');

%4-28-14

load '/Users/markmiller/Documents/Experiments/IFCB_14/FDA_dilution_study/4-28-14/Manual_fromClass/D20140428T163055_IFCB014.mat'
adcdata=load ('/Users/markmiller/Documents/Experiments/IFCB_14/FDA_dilution_study/4-28-14/D20140428T163055_IFCB014.adc');

ciliate_roi_ind=find(~isnan(classlist(:,4)));
ciliate_green=adcdata(ciliate_roi_ind,4);
ciliate_red=adcdata(ciliate_roi_ind,5);

loglog(ciliate_green,ciliate_red,'g*');

load '/Users/markmiller/Documents/Experiments/IFCB_14/FDA_dilution_study/4-28-14/Manual_fromClass/D20140428T173543_IFCB014.mat'
adcdata=load ('/Users/markmiller/Documents/Experiments/IFCB_14/FDA_dilution_study/4-28-14/D20140428T173543_IFCB014.adc');

ciliate_roi_ind=find(~isnan(classlist(:,4)));
ciliate_green=adcdata(ciliate_roi_ind,4);
ciliate_red=adcdata(ciliate_roi_ind,5);

loglog(ciliate_green,ciliate_red,'g*');

%4-29-14

load '/Users/markmiller/Documents/Experiments/IFCB_14/FDA_dilution_study/4-29-14/Manual_fromClass/D20140429T124057_IFCB014.mat'
adcdata=load ('/Users/markmiller/Documents/Experiments/IFCB_14/FDA_dilution_study/4-29-14/D20140429T124057_IFCB014.adc');

ciliate_roi_ind=find(~isnan(classlist(:,4)));
ciliate_green=adcdata(ciliate_roi_ind,4);
ciliate_red=adcdata(ciliate_roi_ind,5);

loglog(ciliate_green,ciliate_red,'k*');

load '/Users/markmiller/Documents/Experiments/IFCB_14/FDA_dilution_study/4-29-14/Manual_fromClass/D20140429T133326_IFCB014.mat'
adcdata=load ('/Users/markmiller/Documents/Experiments/IFCB_14/FDA_dilution_study/4-29-14/D20140429T133326_IFCB014.adc');

ciliate_roi_ind=find(~isnan(classlist(:,4)));
ciliate_green=adcdata(ciliate_roi_ind,4);
ciliate_red=adcdata(ciliate_roi_ind,5);

loglog(ciliate_green,ciliate_red,'k*');

load '/Users/markmiller/Documents/Experiments/IFCB_14/FDA_dilution_study/4-29-14/Manual_fromClass/D20140429T150541_IFCB014.mat'
adcdata=load ('/Users/markmiller/Documents/Experiments/IFCB_14/FDA_dilution_study/4-29-14/D20140429T150541_IFCB014.adc');

ciliate_roi_ind=find(~isnan(classlist(:,4)));
ciliate_green=adcdata(ciliate_roi_ind,4);
ciliate_red=adcdata(ciliate_roi_ind,5);

loglog(ciliate_green,ciliate_red,'k*');

load '/Users/markmiller/Documents/Experiments/IFCB_14/FDA_dilution_study/4-29-14/Manual_fromClass/D20140429T155608_IFCB014.mat'
adcdata=load ('/Users/markmiller/Documents/Experiments/IFCB_14/FDA_dilution_study/4-29-14/D20140429T155608_IFCB014.adc');

ciliate_roi_ind=find(~isnan(classlist(:,4)));
ciliate_green=adcdata(ciliate_roi_ind,4);
ciliate_red=adcdata(ciliate_roi_ind,5);

loglog(ciliate_green,ciliate_red,'k*');

load '/Users/markmiller/Documents/Experiments/IFCB_14/FDA_dilution_study/4-29-14/Manual_fromClass/D20140429T165227_IFCB014.mat'
adcdata=load ('/Users/markmiller/Documents/Experiments/IFCB_14/FDA_dilution_study/4-29-14/D20140429T165227_IFCB014.adc');

ciliate_roi_ind=find(~isnan(classlist(:,4)));
ciliate_green=adcdata(ciliate_roi_ind,4);
ciliate_red=adcdata(ciliate_roi_ind,5);

loglog(ciliate_green,ciliate_red,'k*');

load '/Users/markmiller/Documents/Experiments/IFCB_14/FDA_dilution_study/4-29-14/Manual_fromClass/D20140429T174920_IFCB014.mat'
adcdata=load ('/Users/markmiller/Documents/Experiments/IFCB_14/FDA_dilution_study/4-29-14/D20140429T174920_IFCB014.adc');

ciliate_roi_ind=find(~isnan(classlist(:,4)));
ciliate_green=adcdata(ciliate_roi_ind,4);
ciliate_red=adcdata(ciliate_roi_ind,5);

loglog(ciliate_green,ciliate_red,'k*');

xlabel('PE Fluorescence')
ylabel('Chlorophyll Fluorescence')

%4-24-14

load '/Users/markmiller/Documents/Experiments/IFCB_14/FDA_dilution_study/4-24-14/Manual_fromClass/D20140424T151759_IFCB014.mat'
adcdata=load ('/Users/markmiller/Documents/Experiments/IFCB_14/FDA_dilution_study/4-24-14/D20140424T151759_IFCB014.adc');

ciliate_roi_ind=find(~isnan(classlist(:,4)));
ciliate_green=adcdata(ciliate_roi_ind,4);
ciliate_red=adcdata(ciliate_roi_ind,5);

loglog(ciliate_green,ciliate_red,'c*');

load '/Users/markmiller/Documents/Experiments/IFCB_14/FDA_dilution_study/4-24-14/Manual_fromClass/D20140424T181020_IFCB014.mat'
adcdata=load ('/Users/markmiller/Documents/Experiments/IFCB_14/FDA_dilution_study/4-24-14/D20140424T181020_IFCB014.adc');

ciliate_roi_ind=find(~isnan(classlist(:,4)));
ciliate_green=adcdata(ciliate_roi_ind,4);
ciliate_red=adcdata(ciliate_roi_ind,5);

loglog(ciliate_green,ciliate_red,'c*');

load '/Users/markmiller/Documents/Experiments/IFCB_14/FDA_dilution_study/4-24-14/Manual_fromClass/D20140424T193524_IFCB014.mat'
adcdata=load ('/Users/markmiller/Documents/Experiments/IFCB_14/FDA_dilution_study/4-24-14/D20140424T193524_IFCB014.adc');

ciliate_roi_ind=find(~isnan(classlist(:,4)));
ciliate_green=adcdata(ciliate_roi_ind,4);
ciliate_red=adcdata(ciliate_roi_ind,5);

loglog(ciliate_green,ciliate_red,'c*');

%%
%2-17
load '/Volumes/IFCB14_Dock/data/Manual_fromClass/Non_Mixing_2-17-14/D20140217T143145_IFCB014.mat'
adcdata=load ('/Volumes/IFCB14_Dock/data/D20140217T143145_IFCB014.adc');

ciliate_roi_ind=find(~isnan(classlist(:,4)));
ciliate_green=adcdata(ciliate_roi_ind,4);
ciliate_red=adcdata(ciliate_roi_ind,5);

loglog(ciliate_green,ciliate_red,'m*');

load '/Volumes/IFCB14_Dock/data/Manual_fromClass/Non_Mixing_2-17-14/D20140217T152138_IFCB014.mat'
adcdata=load ('/Volumes/IFCB14_Dock/data/D20140217T152138_IFCB014.adc');

ciliate_roi_ind=find(~isnan(classlist(:,4)));
ciliate_green=adcdata(ciliate_roi_ind,4);
ciliate_red=adcdata(ciliate_roi_ind,5);

loglog(ciliate_green,ciliate_red,'m*');

load '/Volumes/IFCB14_Dock/data/Manual_fromClass/Non_Mixing_2-17-14/D20140217T161130_IFCB014.mat'
adcdata=load ('/Volumes/IFCB14_Dock/data/D20140217T161130_IFCB014.adc');

ciliate_roi_ind=find(~isnan(classlist(:,4)));
ciliate_green=adcdata(ciliate_roi_ind,4);
ciliate_red=adcdata(ciliate_roi_ind,5);

loglog(ciliate_green,ciliate_red,'m*');

load '/Volumes/IFCB14_Dock/data/Manual_fromClass/Non_Mixing_2-17-14/D20140217T175115_IFCB014.mat'
adcdata=load ('/Volumes/IFCB14_Dock/data/D20140217T175115_IFCB014.adc');

ciliate_roi_ind=find(~isnan(classlist(:,4)));
ciliate_green=adcdata(ciliate_roi_ind,4);
ciliate_red=adcdata(ciliate_roi_ind,5);

loglog(ciliate_green,ciliate_red,'m*');


load '/Volumes/IFCB14_Dock/data/Manual_fromClass/Non_Mixing_2-17-14/D20140217T170122_IFCB014.mat'
adcdata=load ('/Volumes/IFCB14_Dock/data/D20140217T170122_IFCB014.adc');

ciliate_roi_ind=find(~isnan(classlist(:,4)));
ciliate_green=adcdata(ciliate_roi_ind,4);
ciliate_red=adcdata(ciliate_roi_ind,5);

loglog(ciliate_green,ciliate_red,'m*');

load '/Volumes/IFCB14_Dock/data/Manual_fromClass/Non_Mixing_2-17-14/D20140217T184107_IFCB014.mat'
adcdata=load ('/Volumes/IFCB14_Dock/data/D20140217T184107_IFCB014.adc');
ciliate_roi_ind=find(~isnan(classlist(:,4)));
ciliate_green=adcdata(ciliate_roi_ind,4);
ciliate_red=adcdata(ciliate_roi_ind,5);

loglog(ciliate_green,ciliate_red,'m*');





