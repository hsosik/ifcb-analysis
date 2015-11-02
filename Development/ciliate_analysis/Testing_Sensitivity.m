

IFCB_14_adcdata=load('/Users/markmiller/Documents/Experiments/IFCB_14/Testing_sensitivity/D20140711T143621_IFCB014.adc');
load '/Users/markmiller/Documents/Experiments/IFCB_14/Testing_sensitivity/Manual_fromClass/D20140711T143621_IFCB014.mat'

IFCB_14_ciliate_roi_ind=find(~isnan(classlist(:,4)));
proto_ind=find(classlist(:,2)==31);

figure
plot(IFCB_14_adcdata(2:end,1),log10(IFCB_14_adcdata(2:end,9)),'.','markersize',20)
hold on
plot(IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,1),log10(IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,9)),'r.','markersize',20)
plot(IFCB_14_adcdata(proto_ind,1),log10(IFCB_14_adcdata(proto_ind,9)),'g.','markersize',20)

%%

IFCB_14_adcdata=load('/Users/markmiller/Documents/Experiments/IFCB_14/Testing_sensitivity/D20140711T145107_IFCB014.adc');
load '/Users/markmiller/Documents/Experiments/IFCB_14/Testing_sensitivity/Manual_fromClass/D20140711T145107_IFCB014.mat'

IFCB_14_ciliate_roi_ind=find(~isnan(classlist(:,4)));
proto_ind=find(classlist(:,2)==31);

figure
plot(IFCB_14_adcdata(2:end,1),log10(IFCB_14_adcdata(2:end,9)),'.','markersize',20)
hold on
plot(IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,1),log10(IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,9)),'r.','markersize',20)
plot(IFCB_14_adcdata(proto_ind,1),log10(IFCB_14_adcdata(proto_ind,9)),'g.','markersize',20)

%%

IFCB_14_adcdata=load('/Users/markmiller/Documents/Experiments/IFCB_14/Testing_sensitivity/D20140711T150113_IFCB014.adc');
load '/Users/markmiller/Documents/Experiments/IFCB_14/Testing_sensitivity/Manual_fromClass/D20140711T150113_IFCB014.mat'

IFCB_14_ciliate_roi_ind=find(~isnan(classlist(:,4)));
proto_ind=find(classlist(:,2)==31);

figure
plot(IFCB_14_adcdata(2:end,1),log10(IFCB_14_adcdata(2:end,9)),'.','markersize',20)
hold on
plot(IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,1),log10(IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,9)),'r.','markersize',20)
plot(IFCB_14_adcdata(proto_ind,1),log10(IFCB_14_adcdata(proto_ind,9)),'g.','markersize',20)