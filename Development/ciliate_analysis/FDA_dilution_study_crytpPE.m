


load '/Users/markmiller/Documents/Experiments/IFCB_14/FDA_dilution_study/4-25-14/Manual_fromClass/D20140425T152802_IFCB014.mat'
adcdata=load ('/Users/markmiller/Documents/Experiments/IFCB_14/FDA_dilution_study/4-25-14/D20140425T152802_IFCB014.adc');

crypto_roi_ind=find(~isnan(classlist(:,4)));
crypto_orange=adcdata(crypto_roi_ind,4);
crypto_red=adcdata(crypto_roi_ind,5);

figure
loglog(crypto_orange,crypto_red,'r*');
hold on
xlabel('PE Fluorescence')
ylabel('Chlorophyll Fluorescence')



load '/Users/markmiller/Documents/Experiments/IFCB_14/FDA_dilution_study/4-27-14/Manual_fromClass/D20140427T134935_IFCB014.mat'
adcdata=load ('/Users/markmiller/Documents/Experiments/IFCB_14/FDA_dilution_study/4-27-14/D20140427T134935_IFCB014.adc');

crypto_roi_ind=find(classlist(:,2)==30);
crypto_orange=adcdata(crypto_roi_ind,4);
crypto_red=adcdata(crypto_roi_ind,5);

loglog(crypto_orange,crypto_red,'b*');

load '/Users/markmiller/Documents/Experiments/IFCB_14/FDA_dilution_study/4-28-14/Manual_fromClass/D20140428T163055_IFCB014.mat'
adcdata=load ('/Users/markmiller/Documents/Experiments/IFCB_14/FDA_dilution_study/4-28-14/D20140428T163055_IFCB014.adc');

crypto_roi_ind=find(classlist(:,2)==30);
crypto_orange=adcdata(crypto_roi_ind,4);
crypto_red=adcdata(crypto_roi_ind,5);

loglog(crypto_orange,crypto_red,'g*');

load '/Users/markmiller/Documents/Experiments/IFCB_14/FDA_dilution_study/4-29-14/Manual_fromClass/D20140429T124057_IFCB014.mat'
adcdata=load ('/Users/markmiller/Documents/Experiments/IFCB_14/FDA_dilution_study/4-29-14/D20140429T124057_IFCB014.adc');

crypto_roi_ind=find(classlist(:,2)==30);
crypto_orange=adcdata(crypto_roi_ind,4);
crypto_red=adcdata(crypto_roi_ind,5);

loglog(crypto_orange,crypto_red,'k*');


load '/Users/markmiller/Documents/Experiments/IFCB_14/FDA_dilution_study/4-24-14/Manual_fromClass/D20140424T151759_IFCB014.mat'
adcdata=load ('/Users/markmiller/Documents/Experiments/IFCB_14/FDA_dilution_study/4-24-14/D20140424T151759_IFCB014.adc');

crypto_roi_ind=find(classlist(:,2)==30);
crypto_orange=adcdata(crypto_roi_ind,4);
crypto_red=adcdata(crypto_roi_ind,5);

loglog(crypto_orange,crypto_red,'c*');