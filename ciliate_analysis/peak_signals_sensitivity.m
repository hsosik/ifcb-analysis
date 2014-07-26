load '/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/Dinos_stained_unstained/2-1-14/Manual_fromClass/D20140201T052229_IFCB014.mat'
IFCB_14_adcdata=load ('/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/Dinos_stained_unstained/2-1-14/D20140201T052229_IFCB014.adc');

ciliate_sensitivity_ind=find(classlist(:,4)==1 & IFCB_14_adcdata(:,9)> 0.012);
mesodinium_sensitivity_ind=find(classlist(:,4)==6 & IFCB_14_adcdata(:,9)> 0.012);
tintinnid_sensitivity_ind=find(classlist(:,4)==19 & IFCB_14_adcdata(:,9)> 0.012);
laboea_sensitivity_ind=find(classlist(:,4)==4 & IFCB_14_adcdata(:,9)> 0.012);
proto_sensitivity_ind=find(classlist(:,2)==31 & IFCB_14_adcdata(:,9)> 0.012);
gyro_sensitivity_ind=find(classlist(:,2)==36 & IFCB_14_adcdata(:,9)> 0.012);

% figure
% plot(IFCB_14_adcdata(2:end,1),(IFCB_14_adcdata(2:end,9)),'.','markersize',20)
% hold on
% plot(IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,1),(IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,9)),'r.','markersize',20)
% title('IFCB 14 CHL-cruise')

%0.012 cutoff


load '/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/Dinos_stained_unstained/2-1-14/Manual_fromClass/D20140201T061221_IFCB014.mat'
IFCB_14_adcdata=load ('/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/Dinos_stained_unstained/2-1-14/D20140201T061221_IFCB014.adc');

ciliate_sensitivity_ind_2=find(classlist(:,4)==1 & IFCB_14_adcdata(:,9)> 0.012);
mesodinium_sensitivity_ind_2=find(classlist(:,4)==6 & IFCB_14_adcdata(:,9)> 0.012);
tintinnid_sensitivity_ind_2=find(classlist(:,4)==19 & IFCB_14_adcdata(:,9)> 0.012);
laboea_sensitivity_ind_2=find(classlist(:,4)==4 & IFCB_14_adcdata(:,9)> 0.012);
proto_sensitivity_ind_2=find(classlist(:,2)==31 & IFCB_14_adcdata(:,9)> 0.012);
gyro_sensitivity_ind_2=find(classlist(:,2)==36 & IFCB_14_adcdata(:,9)> 0.012);

ciliate_sensitivity_ind=[ciliate_sensitivity_ind_2; ciliate_sensitivity_ind];
mesodinium_sensitivity_ind=[mesodinium_sensitivity_ind_2; mesodinium_sensitivity_ind];
tintinnid_sensitivity_ind=[tintinnid_sensitivity_ind_2; tintinnid_sensitivity_ind];
laboea_sensitivity_ind=[laboea_sensitivity_ind_2; laboea_sensitivity_ind];
proto_sensitivity_ind=[proto_sensitivity_ind_2; proto_sensitivity_ind];
gyro_sensitivity_ind=[gyro_sensitivity_ind_2; gyro_sensitivity_ind];

load '/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/Dinos_stained_unstained/2-1-14/Manual_fromClass/D20140201T070213_IFCB014.mat'
IFCB_14_adcdata=load ('/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/Dinos_stained_unstained/2-1-14/D20140201T070213_IFCB014.adc');

ciliate_sensitivity_ind_2=find(classlist(:,4)==1 & IFCB_14_adcdata(:,9)> 0.012);
mesodinium_sensitivity_ind_2=find(classlist(:,4)==6 & IFCB_14_adcdata(:,9)> 0.012);
tintinnid_sensitivity_ind_2=find(classlist(:,4)==19 & IFCB_14_adcdata(:,9)> 0.012);
laboea_sensitivity_ind_2=find(classlist(:,4)==4 & IFCB_14_adcdata(:,9)> 0.012);
proto_sensitivity_ind_2=find(classlist(:,2)==31 & IFCB_14_adcdata(:,9)> 0.012);
gyro_sensitivity_ind_2=find(classlist(:,2)==36 & IFCB_14_adcdata(:,9)> 0.012);

ciliate_sensitivity_ind=[ciliate_sensitivity_ind_2; ciliate_sensitivity_ind];
mesodinium_sensitivity_ind=[mesodinium_sensitivity_ind_2; mesodinium_sensitivity_ind];
tintinnid_sensitivity_ind=[tintinnid_sensitivity_ind_2; tintinnid_sensitivity_ind];
laboea_sensitivity_ind=[laboea_sensitivity_ind_2; laboea_sensitivity_ind];
proto_sensitivity_ind=[proto_sensitivity_ind_2; proto_sensitivity_ind];
gyro_sensitivity_ind=[gyro_sensitivity_ind_2; gyro_sensitivity_ind];

load '/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/Dinos_stained_unstained/2-1-14/Manual_fromClass/D20140201T075205_IFCB014.mat'
IFCB_14_adcdata=load ('/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/Dinos_stained_unstained/2-1-14/D20140201T075205_IFCB014.adc');

ciliate_sensitivity_ind_2=find(classlist(:,4)==1 & IFCB_14_adcdata(:,9)> 0.012);
mesodinium_sensitivity_ind_2=find(classlist(:,4)==6 & IFCB_14_adcdata(:,9)> 0.012);
tintinnid_sensitivity_ind_2=find(classlist(:,4)==19 & IFCB_14_adcdata(:,9)> 0.012);
laboea_sensitivity_ind_2=find(classlist(:,4)==4 & IFCB_14_adcdata(:,9)> 0.012);
proto_sensitivity_ind_2=find(classlist(:,2)==31 & IFCB_14_adcdata(:,9)> 0.012);
gyro_sensitivity_ind_2=find(classlist(:,2)==36 & IFCB_14_adcdata(:,9)> 0.012);

ciliate_sensitivity_ind=[ciliate_sensitivity_ind_2; ciliate_sensitivity_ind];
mesodinium_sensitivity_ind=[mesodinium_sensitivity_ind_2; mesodinium_sensitivity_ind];
tintinnid_sensitivity_ind=[tintinnid_sensitivity_ind_2; tintinnid_sensitivity_ind];
laboea_sensitivity_ind=[laboea_sensitivity_ind_2; laboea_sensitivity_ind];
proto_sensitivity_ind=[proto_sensitivity_ind_2; proto_sensitivity_ind];
gyro_sensitivity_ind=[gyro_sensitivity_ind_2; gyro_sensitivity_ind];

load '/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/Dinos_stained_unstained/2-1-14/Manual_fromClass/D20140201T084157_IFCB014.mat'
IFCB_14_adcdata=load ('/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/Dinos_stained_unstained/2-1-14/D20140201T084157_IFCB014.adc');

ciliate_sensitivity_ind_2=find(classlist(:,4)==1 & IFCB_14_adcdata(:,9)> 0.012);
mesodinium_sensitivity_ind_2=find(classlist(:,4)==6 & IFCB_14_adcdata(:,9)> 0.012);
tintinnid_sensitivity_ind_2=find(classlist(:,4)==19 & IFCB_14_adcdata(:,9)> 0.012);
laboea_sensitivity_ind_2=find(classlist(:,4)==4 & IFCB_14_adcdata(:,9)> 0.012);
proto_sensitivity_ind_2=find(classlist(:,2)==31 & IFCB_14_adcdata(:,9)> 0.012);
gyro_sensitivity_ind_2=find(classlist(:,2)==36 & IFCB_14_adcdata(:,9)> 0.012);

ciliate_sensitivity_ind=[ciliate_sensitivity_ind_2; ciliate_sensitivity_ind];
mesodinium_sensitivity_ind=[mesodinium_sensitivity_ind_2; mesodinium_sensitivity_ind];
tintinnid_sensitivity_ind=[tintinnid_sensitivity_ind_2; tintinnid_sensitivity_ind];
laboea_sensitivity_ind=[laboea_sensitivity_ind_2; laboea_sensitivity_ind];
proto_sensitivity_ind=[proto_sensitivity_ind_2; proto_sensitivity_ind];
gyro_sensitivity_ind=[gyro_sensitivity_ind_2; gyro_sensitivity_ind];

load '/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/Dinos_stained_unstained/2-1-14/Manual_fromClass/D20140201T093148_IFCB014.mat'
IFCB_14_adcdata=load ('/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/Dinos_stained_unstained/2-1-14/D20140201T093148_IFCB014.adc');

ciliate_sensitivity_ind_2=find(classlist(:,4)==1 & IFCB_14_adcdata(:,9)> 0.012);
mesodinium_sensitivity_ind_2=find(classlist(:,4)==6 & IFCB_14_adcdata(:,9)> 0.012);
tintinnid_sensitivity_ind_2=find(classlist(:,4)==19 & IFCB_14_adcdata(:,9)> 0.012);
laboea_sensitivity_ind_2=find(classlist(:,4)==4 & IFCB_14_adcdata(:,9)> 0.012);
proto_sensitivity_ind_2=find(classlist(:,2)==31 & IFCB_14_adcdata(:,9)> 0.012);
gyro_sensitivity_ind_2=find(classlist(:,2)==36 & IFCB_14_adcdata(:,9)> 0.012);

ciliate_sensitivity_ind=[ciliate_sensitivity_ind_2; ciliate_sensitivity_ind];
mesodinium_sensitivity_ind=[mesodinium_sensitivity_ind_2; mesodinium_sensitivity_ind];
tintinnid_sensitivity_ind=[tintinnid_sensitivity_ind_2; tintinnid_sensitivity_ind];
laboea_sensitivity_ind=[laboea_sensitivity_ind_2; laboea_sensitivity_ind];
proto_sensitivity_ind=[proto_sensitivity_ind_2; proto_sensitivity_ind];
gyro_sensitivity_ind=[gyro_sensitivity_ind_2; gyro_sensitivity_ind];

load '/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/Dinos_stained_unstained/2-1-14/Manual_fromClass/D20140201T102140_IFCB014.mat'
IFCB_14_adcdata=load ('/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/Dinos_stained_unstained/2-1-14/D20140201T102140_IFCB014.adc');

ciliate_sensitivity_ind_2=find(classlist(:,4)==1 & IFCB_14_adcdata(:,9)> 0.012);
mesodinium_sensitivity_ind_2=find(classlist(:,4)==6 & IFCB_14_adcdata(:,9)> 0.012);
tintinnid_sensitivity_ind_2=find(classlist(:,4)==19 & IFCB_14_adcdata(:,9)> 0.012);
laboea_sensitivity_ind_2=find(classlist(:,4)==4 & IFCB_14_adcdata(:,9)> 0.012);
proto_sensitivity_ind_2=find(classlist(:,2)==31 & IFCB_14_adcdata(:,9)> 0.012);
gyro_sensitivity_ind_2=find(classlist(:,2)==36 & IFCB_14_adcdata(:,9)> 0.012);

ciliate_sensitivity_ind=[ciliate_sensitivity_ind_2; ciliate_sensitivity_ind];
mesodinium_sensitivity_ind=[mesodinium_sensitivity_ind_2; mesodinium_sensitivity_ind];
tintinnid_sensitivity_ind=[tintinnid_sensitivity_ind_2; tintinnid_sensitivity_ind];
laboea_sensitivity_ind=[laboea_sensitivity_ind_2; laboea_sensitivity_ind];
proto_sensitivity_ind=[proto_sensitivity_ind_2; proto_sensitivity_ind];
gyro_sensitivity_ind=[gyro_sensitivity_ind_2; gyro_sensitivity_ind];

load '/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/Dinos_stained_unstained/2-1-14/Manual_fromClass/D20140201T111133_IFCB014.mat'
IFCB_14_adcdata=load ('/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/Dinos_stained_unstained/2-1-14/D20140201T111133_IFCB014.adc');

ciliate_sensitivity_ind_2=find(classlist(:,4)==1 & IFCB_14_adcdata(:,9)> 0.012);
mesodinium_sensitivity_ind_2=find(classlist(:,4)==6 & IFCB_14_adcdata(:,9)> 0.012);
tintinnid_sensitivity_ind_2=find(classlist(:,4)==19 & IFCB_14_adcdata(:,9)> 0.012);
laboea_sensitivity_ind_2=find(classlist(:,4)==4 & IFCB_14_adcdata(:,9)> 0.012);
proto_sensitivity_ind_2=find(classlist(:,2)==31 & IFCB_14_adcdata(:,9)> 0.012);
gyro_sensitivity_ind_2=find(classlist(:,2)==36 & IFCB_14_adcdata(:,9)> 0.012);

ciliate_sensitivity_ind=[ciliate_sensitivity_ind_2; ciliate_sensitivity_ind];
mesodinium_sensitivity_ind=[mesodinium_sensitivity_ind_2; mesodinium_sensitivity_ind];
tintinnid_sensitivity_ind=[tintinnid_sensitivity_ind_2; tintinnid_sensitivity_ind];
laboea_sensitivity_ind=[laboea_sensitivity_ind_2; laboea_sensitivity_ind];
proto_sensitivity_ind=[proto_sensitivity_ind_2; proto_sensitivity_ind];
gyro_sensitivity_ind=[gyro_sensitivity_ind_2; gyro_sensitivity_ind];

load '/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/Dinos_stained_unstained/2-1-14/Manual_fromClass/D20140201T120124_IFCB014.mat'
IFCB_14_adcdata=load ('/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/Dinos_stained_unstained/2-1-14/D20140201T120124_IFCB014.adc');

ciliate_sensitivity_ind_2=find(classlist(:,4)==1 & IFCB_14_adcdata(:,9)> 0.012);
mesodinium_sensitivity_ind_2=find(classlist(:,4)==6 & IFCB_14_adcdata(:,9)> 0.012);
tintinnid_sensitivity_ind_2=find(classlist(:,4)==19 & IFCB_14_adcdata(:,9)> 0.012);
laboea_sensitivity_ind_2=find(classlist(:,4)==4 & IFCB_14_adcdata(:,9)> 0.012);
proto_sensitivity_ind_2=find(classlist(:,2)==31 & IFCB_14_adcdata(:,9)> 0.012);
gyro_sensitivity_ind_2=find(classlist(:,2)==36 & IFCB_14_adcdata(:,9)> 0.012);

ciliate_sensitivity_ind=[ciliate_sensitivity_ind_2; ciliate_sensitivity_ind];
mesodinium_sensitivity_ind=[mesodinium_sensitivity_ind_2; mesodinium_sensitivity_ind];
tintinnid_sensitivity_ind=[tintinnid_sensitivity_ind_2; tintinnid_sensitivity_ind];
laboea_sensitivity_ind=[laboea_sensitivity_ind_2; laboea_sensitivity_ind];
proto_sensitivity_ind=[proto_sensitivity_ind_2; proto_sensitivity_ind];
gyro_sensitivity_ind=[gyro_sensitivity_ind_2; gyro_sensitivity_ind];

load '/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/Dinos_stained_unstained/2-1-14/Manual_fromClass/D20140201T125116_IFCB014.mat'
IFCB_14_adcdata=load ('/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/Dinos_stained_unstained/2-1-14/D20140201T125116_IFCB014.adc');


ciliate_sensitivity_ind_2=find(classlist(:,4)==1 & IFCB_14_adcdata(:,9)> 0.012);
mesodinium_sensitivity_ind_2=find(classlist(:,4)==6 & IFCB_14_adcdata(:,9)> 0.012);
tintinnid_sensitivity_ind_2=find(classlist(:,4)==19 & IFCB_14_adcdata(:,9)> 0.012);
laboea_sensitivity_ind_2=find(classlist(:,4)==4 & IFCB_14_adcdata(:,9)> 0.012);
proto_sensitivity_ind_2=find(classlist(:,2)==31 & IFCB_14_adcdata(:,9)> 0.012);
gyro_sensitivity_ind_2=find(classlist(:,2)==36 & IFCB_14_adcdata(:,9)> 0.012);

ciliate_sensitivity_ind=[ciliate_sensitivity_ind_2; ciliate_sensitivity_ind];
mesodinium_sensitivity_ind=[mesodinium_sensitivity_ind_2; mesodinium_sensitivity_ind];
tintinnid_sensitivity_ind=[tintinnid_sensitivity_ind_2; tintinnid_sensitivity_ind];
laboea_sensitivity_ind=[laboea_sensitivity_ind_2; laboea_sensitivity_ind];
proto_sensitivity_ind=[proto_sensitivity_ind_2; proto_sensitivity_ind];
gyro_sensitivity_ind=[gyro_sensitivity_ind_2; gyro_sensitivity_ind];


load '/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/Dinos_stained_unstained/2-1-14/Manual_fromClass/D20140201T134108_IFCB014.mat'
IFCB_14_adcdata=load ('/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/Dinos_stained_unstained/2-1-14/D20140201T134108_IFCB014.adc');

ciliate_sensitivity_ind_2=find(classlist(:,4)==1 & IFCB_14_adcdata(:,9)> 0.012);
mesodinium_sensitivity_ind_2=find(classlist(:,4)==6 & IFCB_14_adcdata(:,9)> 0.012);
tintinnid_sensitivity_ind_2=find(classlist(:,4)==19 & IFCB_14_adcdata(:,9)> 0.012);
laboea_sensitivity_ind_2=find(classlist(:,4)==4 & IFCB_14_adcdata(:,9)> 0.012);
proto_sensitivity_ind_2=find(classlist(:,2)==31 & IFCB_14_adcdata(:,9)> 0.012);
gyro_sensitivity_ind_2=find(classlist(:,2)==36 & IFCB_14_adcdata(:,9)> 0.012);

ciliate_sensitivity_ind=[ciliate_sensitivity_ind_2; ciliate_sensitivity_ind];
mesodinium_sensitivity_ind=[mesodinium_sensitivity_ind_2; mesodinium_sensitivity_ind];
tintinnid_sensitivity_ind=[tintinnid_sensitivity_ind_2; tintinnid_sensitivity_ind];
laboea_sensitivity_ind=[laboea_sensitivity_ind_2; laboea_sensitivity_ind];
proto_sensitivity_ind=[proto_sensitivity_ind_2; proto_sensitivity_ind];
gyro_sensitivity_ind=[gyro_sensitivity_ind_2; gyro_sensitivity_ind];

load '/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/Dinos_stained_unstained/2-1-14/Manual_fromClass/D20140201T143100_IFCB014.mat'
IFCB_14_adcdata=load ('/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/Dinos_stained_unstained/2-1-14/D20140201T143100_IFCB014.adc');

ciliate_sensitivity_ind_2=find(classlist(:,4)==1 & IFCB_14_adcdata(:,9)> 0.012);
mesodinium_sensitivity_ind_2=find(classlist(:,4)==6 & IFCB_14_adcdata(:,9)> 0.012);
tintinnid_sensitivity_ind_2=find(classlist(:,4)==19 & IFCB_14_adcdata(:,9)> 0.012);
laboea_sensitivity_ind_2=find(classlist(:,4)==4 & IFCB_14_adcdata(:,9)> 0.012);
proto_sensitivity_ind_2=find(classlist(:,2)==31 & IFCB_14_adcdata(:,9)> 0.012);
gyro_sensitivity_ind_2=find(classlist(:,2)==36 & IFCB_14_adcdata(:,9)> 0.012);

ciliate_sensitivity_ind=[ciliate_sensitivity_ind_2; ciliate_sensitivity_ind];
mesodinium_sensitivity_ind=[mesodinium_sensitivity_ind_2; mesodinium_sensitivity_ind];
tintinnid_sensitivity_ind=[tintinnid_sensitivity_ind_2; tintinnid_sensitivity_ind];
laboea_sensitivity_ind=[laboea_sensitivity_ind_2; laboea_sensitivity_ind];
proto_sensitivity_ind=[proto_sensitivity_ind_2; proto_sensitivity_ind];
gyro_sensitivity_ind=[gyro_sensitivity_ind_2; gyro_sensitivity_ind];

load '/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/Dinos_stained_unstained/2-1-14/Manual_fromClass/D20140201T152052_IFCB014.mat'
IFCB_14_adcdata=load ('/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/Dinos_stained_unstained/2-1-14/D20140201T152052_IFCB014.adc');

ciliate_sensitivity_ind_2=find(classlist(:,4)==1 & IFCB_14_adcdata(:,9)> 0.012);
mesodinium_sensitivity_ind_2=find(classlist(:,4)==6 & IFCB_14_adcdata(:,9)> 0.012);
tintinnid_sensitivity_ind_2=find(classlist(:,4)==19 & IFCB_14_adcdata(:,9)> 0.012);
laboea_sensitivity_ind_2=find(classlist(:,4)==4 & IFCB_14_adcdata(:,9)> 0.012);
proto_sensitivity_ind_2=find(classlist(:,2)==31 & IFCB_14_adcdata(:,9)> 0.012);
gyro_sensitivity_ind_2=find(classlist(:,2)==36 & IFCB_14_adcdata(:,9)> 0.012);

ciliate_sensitivity_ind=[ciliate_sensitivity_ind_2; ciliate_sensitivity_ind];
mesodinium_sensitivity_ind=[mesodinium_sensitivity_ind_2; mesodinium_sensitivity_ind];
tintinnid_sensitivity_ind=[tintinnid_sensitivity_ind_2; tintinnid_sensitivity_ind];
laboea_sensitivity_ind=[laboea_sensitivity_ind_2; laboea_sensitivity_ind];
proto_sensitivity_ind=[proto_sensitivity_ind_2; proto_sensitivity_ind];
gyro_sensitivity_ind=[gyro_sensitivity_ind_2; gyro_sensitivity_ind];

load '/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/Dinos_stained_unstained/2-1-14/Manual_fromClass/D20140201T161044_IFCB014.mat'
IFCB_14_adcdata=load ('/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/Dinos_stained_unstained/2-1-14/D20140201T161044_IFCB014.adc');

ciliate_sensitivity_ind_2=find(classlist(:,4)==1 & IFCB_14_adcdata(:,9)> 0.012);
mesodinium_sensitivity_ind_2=find(classlist(:,4)==6 & IFCB_14_adcdata(:,9)> 0.012);
tintinnid_sensitivity_ind_2=find(classlist(:,4)==19 & IFCB_14_adcdata(:,9)> 0.012);
laboea_sensitivity_ind_2=find(classlist(:,4)==4 & IFCB_14_adcdata(:,9)> 0.012);
proto_sensitivity_ind_2=find(classlist(:,2)==31 & IFCB_14_adcdata(:,9)> 0.012);
gyro_sensitivity_ind_2=find(classlist(:,2)==36 & IFCB_14_adcdata(:,9)> 0.012);

ciliate_sensitivity_ind=[ciliate_sensitivity_ind_2; ciliate_sensitivity_ind];
mesodinium_sensitivity_ind=[mesodinium_sensitivity_ind_2; mesodinium_sensitivity_ind];
tintinnid_sensitivity_ind=[tintinnid_sensitivity_ind_2; tintinnid_sensitivity_ind];
laboea_sensitivity_ind=[laboea_sensitivity_ind_2; laboea_sensitivity_ind];
proto_sensitivity_ind=[proto_sensitivity_ind_2; proto_sensitivity_ind];
gyro_sensitivity_ind=[gyro_sensitivity_ind_2; gyro_sensitivity_ind];


load '/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/Dinos_stained_unstained/2-1-14/Manual_fromClass/D20140201T170036_IFCB014.mat'
IFCB_14_adcdata=load ('/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/Dinos_stained_unstained/2-1-14/D20140201T170036_IFCB014.adc');

ciliate_sensitivity_ind_2=find(classlist(:,4)==1 & IFCB_14_adcdata(:,9)> 0.012);
mesodinium_sensitivity_ind_2=find(classlist(:,4)==6 & IFCB_14_adcdata(:,9)> 0.012);
tintinnid_sensitivity_ind_2=find(classlist(:,4)==19 & IFCB_14_adcdata(:,9)> 0.012);
laboea_sensitivity_ind_2=find(classlist(:,4)==4 & IFCB_14_adcdata(:,9)> 0.012);
proto_sensitivity_ind_2=find(classlist(:,2)==31 & IFCB_14_adcdata(:,9)> 0.012);
gyro_sensitivity_ind_2=find(classlist(:,2)==36 & IFCB_14_adcdata(:,9)> 0.012);

ciliate_sensitivity_ind=[ciliate_sensitivity_ind_2; ciliate_sensitivity_ind];
mesodinium_sensitivity_ind=[mesodinium_sensitivity_ind_2; mesodinium_sensitivity_ind];
tintinnid_sensitivity_ind=[tintinnid_sensitivity_ind_2; tintinnid_sensitivity_ind];
laboea_sensitivity_ind=[laboea_sensitivity_ind_2; laboea_sensitivity_ind];
proto_sensitivity_ind=[proto_sensitivity_ind_2; proto_sensitivity_ind];
gyro_sensitivity_ind=[gyro_sensitivity_ind_2; gyro_sensitivity_ind];

load '/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/Dinos_stained_unstained/2-1-14/Manual_fromClass/D20140201T175027_IFCB014.mat'
IFCB_14_adcdata=load ('/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/Dinos_stained_unstained/2-1-14/D20140201T175027_IFCB014.adc');

ciliate_sensitivity_ind_2=find(classlist(:,4)==1 & IFCB_14_adcdata(:,9)> 0.012);
mesodinium_sensitivity_ind_2=find(classlist(:,4)==6 & IFCB_14_adcdata(:,9)> 0.012);
tintinnid_sensitivity_ind_2=find(classlist(:,4)==19 & IFCB_14_adcdata(:,9)> 0.012);
laboea_sensitivity_ind_2=find(classlist(:,4)==4 & IFCB_14_adcdata(:,9)> 0.012);
proto_sensitivity_ind_2=find(classlist(:,2)==31 & IFCB_14_adcdata(:,9)> 0.012);
gyro_sensitivity_ind_2=find(classlist(:,2)==36 & IFCB_14_adcdata(:,9)> 0.012);

ciliate_sensitivity_ind=[ciliate_sensitivity_ind_2; ciliate_sensitivity_ind];
mesodinium_sensitivity_ind=[mesodinium_sensitivity_ind_2; mesodinium_sensitivity_ind];
tintinnid_sensitivity_ind=[tintinnid_sensitivity_ind_2; tintinnid_sensitivity_ind];
laboea_sensitivity_ind=[laboea_sensitivity_ind_2; laboea_sensitivity_ind];
proto_sensitivity_ind=[proto_sensitivity_ind_2; proto_sensitivity_ind];
gyro_sensitivity_ind=[gyro_sensitivity_ind_2; gyro_sensitivity_ind];

load '/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/Dinos_stained_unstained/2-1-14/Manual_fromClass/D20140201T184019_IFCB014.mat'
IFCB_14_adcdata=load ('/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/Dinos_stained_unstained/2-1-14/D20140201T184019_IFCB014.adc');

ciliate_sensitivity_ind_2=find(classlist(:,4)==1 & IFCB_14_adcdata(:,9)> 0.012);
mesodinium_sensitivity_ind_2=find(classlist(:,4)==6 & IFCB_14_adcdata(:,9)> 0.012);
tintinnid_sensitivity_ind_2=find(classlist(:,4)==19 & IFCB_14_adcdata(:,9)> 0.012);
laboea_sensitivity_ind_2=find(classlist(:,4)==4 & IFCB_14_adcdata(:,9)> 0.012);
proto_sensitivity_ind_2=find(classlist(:,2)==31 & IFCB_14_adcdata(:,9)> 0.012);
gyro_sensitivity_ind_2=find(classlist(:,2)==36 & IFCB_14_adcdata(:,9)> 0.012);

ciliate_sensitivity_ind=[ciliate_sensitivity_ind_2; ciliate_sensitivity_ind];
mesodinium_sensitivity_ind=[mesodinium_sensitivity_ind_2; mesodinium_sensitivity_ind];
tintinnid_sensitivity_ind=[tintinnid_sensitivity_ind_2; tintinnid_sensitivity_ind];
laboea_sensitivity_ind=[laboea_sensitivity_ind_2; laboea_sensitivity_ind];
proto_sensitivity_ind=[proto_sensitivity_ind_2; proto_sensitivity_ind];
gyro_sensitivity_ind=[gyro_sensitivity_ind_2; gyro_sensitivity_ind];

load '/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/Dinos_stained_unstained/2-1-14/Manual_fromClass/D20140201T193011_IFCB014.mat'
IFCB_14_adcdata=load ('/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/Dinos_stained_unstained/2-1-14/D20140201T193011_IFCB014.adc');

ciliate_sensitivity_ind_2=find(classlist(:,4)==1 & IFCB_14_adcdata(:,9)> 0.012);
mesodinium_sensitivity_ind_2=find(classlist(:,4)==6 & IFCB_14_adcdata(:,9)> 0.012);
tintinnid_sensitivity_ind_2=find(classlist(:,4)==19 & IFCB_14_adcdata(:,9)> 0.012);
laboea_sensitivity_ind_2=find(classlist(:,4)==4 & IFCB_14_adcdata(:,9)> 0.012);
proto_sensitivity_ind_2=find(classlist(:,2)==31 & IFCB_14_adcdata(:,9)> 0.012);
gyro_sensitivity_ind_2=find(classlist(:,2)==36 & IFCB_14_adcdata(:,9)> 0.012);

ciliate_sensitivity_ind=[ciliate_sensitivity_ind_2; ciliate_sensitivity_ind];
mesodinium_sensitivity_ind=[mesodinium_sensitivity_ind_2; mesodinium_sensitivity_ind];
tintinnid_sensitivity_ind=[tintinnid_sensitivity_ind_2; tintinnid_sensitivity_ind];
laboea_sensitivity_ind=[laboea_sensitivity_ind_2; laboea_sensitivity_ind];
proto_sensitivity_ind=[proto_sensitivity_ind_2; proto_sensitivity_ind];
gyro_sensitivity_ind=[gyro_sensitivity_ind_2; gyro_sensitivity_ind];

load '/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/Dinos_stained_unstained/2-1-14/Manual_fromClass/D20140201T202002_IFCB014.mat'
IFCB_14_adcdata=load ('/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/Dinos_stained_unstained/2-1-14/D20140201T202002_IFCB014.adc');

ciliate_sensitivity_ind_2=find(classlist(:,4)==1 & IFCB_14_adcdata(:,9)> 0.012);
mesodinium_sensitivity_ind_2=find(classlist(:,4)==6 & IFCB_14_adcdata(:,9)> 0.012);
tintinnid_sensitivity_ind_2=find(classlist(:,4)==19 & IFCB_14_adcdata(:,9)> 0.012);
laboea_sensitivity_ind_2=find(classlist(:,4)==4 & IFCB_14_adcdata(:,9)> 0.012);
proto_sensitivity_ind_2=find(classlist(:,2)==31 & IFCB_14_adcdata(:,9)> 0.012);
gyro_sensitivity_ind_2=find(classlist(:,2)==36 & IFCB_14_adcdata(:,9)> 0.012);

ciliate_sensitivity_ind=[ciliate_sensitivity_ind_2; ciliate_sensitivity_ind];
mesodinium_sensitivity_ind=[mesodinium_sensitivity_ind_2; mesodinium_sensitivity_ind];
tintinnid_sensitivity_ind=[tintinnid_sensitivity_ind_2; tintinnid_sensitivity_ind];
laboea_sensitivity_ind=[laboea_sensitivity_ind_2; laboea_sensitivity_ind];
proto_sensitivity_ind=[proto_sensitivity_ind_2; proto_sensitivity_ind];
gyro_sensitivity_ind=[gyro_sensitivity_ind_2; gyro_sensitivity_ind];



load '/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/Dinos_stained_unstained/2-1-14/Manual_fromClass/D20140201T210954_IFCB014.mat'
IFCB_14_adcdata=load ('/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/Dinos_stained_unstained/2-1-14/D20140201T210954_IFCB014.adc');

ciliate_sensitivity_ind_2=find(classlist(:,4)==1 & IFCB_14_adcdata(:,9)> 0.012);
mesodinium_sensitivity_ind_2=find(classlist(:,4)==6 & IFCB_14_adcdata(:,9)> 0.012);
tintinnid_sensitivity_ind_2=find(classlist(:,4)==19 & IFCB_14_adcdata(:,9)> 0.012);
laboea_sensitivity_ind_2=find(classlist(:,4)==4 & IFCB_14_adcdata(:,9)> 0.012);
proto_sensitivity_ind_2=find(classlist(:,2)==31 & IFCB_14_adcdata(:,9)> 0.012);
gyro_sensitivity_ind_2=find(classlist(:,2)==36 & IFCB_14_adcdata(:,9)> 0.012);

ciliate_sensitivity_ind=[ciliate_sensitivity_ind_2; ciliate_sensitivity_ind];
mesodinium_sensitivity_ind=[mesodinium_sensitivity_ind_2; mesodinium_sensitivity_ind];
tintinnid_sensitivity_ind=[tintinnid_sensitivity_ind_2; tintinnid_sensitivity_ind];
laboea_sensitivity_ind=[laboea_sensitivity_ind_2; laboea_sensitivity_ind];
proto_sensitivity_ind=[proto_sensitivity_ind_2; proto_sensitivity_ind];
gyro_sensitivity_ind=[gyro_sensitivity_ind_2; gyro_sensitivity_ind];

load '/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/Dinos_stained_unstained/2-1-14/Manual_fromClass/D20140201T215946_IFCB014.mat'
IFCB_14_adcdata=load ('/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/Dinos_stained_unstained/2-1-14/D20140201T215946_IFCB014.adc');

ciliate_sensitivity_ind_2=find(classlist(:,4)==1 & IFCB_14_adcdata(:,9)> 0.012);
mesodinium_sensitivity_ind_2=find(classlist(:,4)==6 & IFCB_14_adcdata(:,9)> 0.012);
tintinnid_sensitivity_ind_2=find(classlist(:,4)==19 & IFCB_14_adcdata(:,9)> 0.012);
laboea_sensitivity_ind_2=find(classlist(:,4)==4 & IFCB_14_adcdata(:,9)> 0.012);
proto_sensitivity_ind_2=find(classlist(:,2)==31 & IFCB_14_adcdata(:,9)> 0.012);
gyro_sensitivity_ind_2=find(classlist(:,2)==36 & IFCB_14_adcdata(:,9)> 0.012);

ciliate_sensitivity_ind=[ciliate_sensitivity_ind_2; ciliate_sensitivity_ind];
mesodinium_sensitivity_ind=[mesodinium_sensitivity_ind_2; mesodinium_sensitivity_ind];
tintinnid_sensitivity_ind=[tintinnid_sensitivity_ind_2; tintinnid_sensitivity_ind];
laboea_sensitivity_ind=[laboea_sensitivity_ind_2; laboea_sensitivity_ind];
proto_sensitivity_ind=[proto_sensitivity_ind_2; proto_sensitivity_ind];
gyro_sensitivity_ind=[gyro_sensitivity_ind_2; gyro_sensitivity_ind];

load '/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/Dinos_stained_unstained/2-1-14/Manual_fromClass/D20140201T224938_IFCB014.mat'
IFCB_14_adcdata=load ('/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/Dinos_stained_unstained/2-1-14/D20140201T224938_IFCB014.adc');

ciliate_sensitivity_ind_2=find(classlist(:,4)==1 & IFCB_14_adcdata(:,9)> 0.012);
mesodinium_sensitivity_ind_2=find(classlist(:,4)==6 & IFCB_14_adcdata(:,9)> 0.012);
tintinnid_sensitivity_ind_2=find(classlist(:,4)==19 & IFCB_14_adcdata(:,9)> 0.012);
laboea_sensitivity_ind_2=find(classlist(:,4)==4 & IFCB_14_adcdata(:,9)> 0.012);
proto_sensitivity_ind_2=find(classlist(:,2)==31 & IFCB_14_adcdata(:,9)> 0.012);
gyro_sensitivity_ind_2=find(classlist(:,2)==36 & IFCB_14_adcdata(:,9)> 0.012);

ciliate_sensitivity_ind=[ciliate_sensitivity_ind_2; ciliate_sensitivity_ind];
mesodinium_sensitivity_ind=[mesodinium_sensitivity_ind_2; mesodinium_sensitivity_ind];
tintinnid_sensitivity_ind=[tintinnid_sensitivity_ind_2; tintinnid_sensitivity_ind];
laboea_sensitivity_ind=[laboea_sensitivity_ind_2; laboea_sensitivity_ind];
proto_sensitivity_ind=[proto_sensitivity_ind_2; proto_sensitivity_ind];
gyro_sensitivity_ind=[gyro_sensitivity_ind_2; gyro_sensitivity_ind];

load '/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/Dinos_stained_unstained/2-1-14/Manual_fromClass/D20140201T233930_IFCB014.mat'
IFCB_14_adcdata=load ('/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/Dinos_stained_unstained/2-1-14/D20140201T233930_IFCB014.adc');

ciliate_sensitivity_ind_2=find(classlist(:,4)==1 & IFCB_14_adcdata(:,9)> 0.012);
mesodinium_sensitivity_ind_2=find(classlist(:,4)==6 & IFCB_14_adcdata(:,9)> 0.012);
tintinnid_sensitivity_ind_2=find(classlist(:,4)==19 & IFCB_14_adcdata(:,9)> 0.012);
laboea_sensitivity_ind_2=find(classlist(:,4)==4 & IFCB_14_adcdata(:,9)> 0.012);
proto_sensitivity_ind_2=find(classlist(:,2)==31 & IFCB_14_adcdata(:,9)> 0.012);
gyro_sensitivity_ind_2=find(classlist(:,2)==36 & IFCB_14_adcdata(:,9)> 0.012);

ciliate_sensitivity_ind=[ciliate_sensitivity_ind_2; ciliate_sensitivity_ind];
mesodinium_sensitivity_ind=[mesodinium_sensitivity_ind_2; mesodinium_sensitivity_ind];
tintinnid_sensitivity_ind=[tintinnid_sensitivity_ind_2; tintinnid_sensitivity_ind];
laboea_sensitivity_ind=[laboea_sensitivity_ind_2; laboea_sensitivity_ind];
proto_sensitivity_ind=[proto_sensitivity_ind_2; proto_sensitivity_ind];
gyro_sensitivity_ind=[gyro_sensitivity_ind_2; gyro_sensitivity_ind];

load '/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/Dinos_stained_unstained/2-1-14/Manual_fromClass/D20140202T002922_IFCB014.mat'
IFCB_14_adcdata=load ('/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/Dinos_stained_unstained/2-1-14/D20140202T002922_IFCB014.adc');


ciliate_sensitivity_ind_2=find(classlist(:,4)==1 & IFCB_14_adcdata(:,9)> 0.012);
mesodinium_sensitivity_ind_2=find(classlist(:,4)==6 & IFCB_14_adcdata(:,9)> 0.012);
tintinnid_sensitivity_ind_2=find(classlist(:,4)==19 & IFCB_14_adcdata(:,9)> 0.012);
laboea_sensitivity_ind_2=find(classlist(:,4)==4 & IFCB_14_adcdata(:,9)> 0.012);
proto_sensitivity_ind_2=find(classlist(:,2)==31 & IFCB_14_adcdata(:,9)> 0.012);
gyro_sensitivity_ind_2=find(classlist(:,2)==36 & IFCB_14_adcdata(:,9)> 0.012);

ciliate_sensitivity_ind=[ciliate_sensitivity_ind_2; ciliate_sensitivity_ind];
mesodinium_sensitivity_ind=[mesodinium_sensitivity_ind_2; mesodinium_sensitivity_ind];
tintinnid_sensitivity_ind=[tintinnid_sensitivity_ind_2; tintinnid_sensitivity_ind];
laboea_sensitivity_ind=[laboea_sensitivity_ind_2; laboea_sensitivity_ind];
proto_sensitivity_ind=[proto_sensitivity_ind_2; proto_sensitivity_ind];
gyro_sensitivity_ind=[gyro_sensitivity_ind_2; gyro_sensitivity_ind];


load '/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/Dinos_stained_unstained/2-1-14/Manual_fromClass/D20140202T011914_IFCB014.mat'
IFCB_14_adcdata=load ('/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/Dinos_stained_unstained/2-1-14/D20140202T011914_IFCB014.adc');

ciliate_sensitivity_ind_2=find(classlist(:,4)==1 & IFCB_14_adcdata(:,9)> 0.012);
mesodinium_sensitivity_ind_2=find(classlist(:,4)==6 & IFCB_14_adcdata(:,9)> 0.012);
tintinnid_sensitivity_ind_2=find(classlist(:,4)==19 & IFCB_14_adcdata(:,9)> 0.012);
laboea_sensitivity_ind_2=find(classlist(:,4)==4 & IFCB_14_adcdata(:,9)> 0.012);
proto_sensitivity_ind_2=find(classlist(:,2)==31 & IFCB_14_adcdata(:,9)> 0.012);
gyro_sensitivity_ind_2=find(classlist(:,2)==36 & IFCB_14_adcdata(:,9)> 0.012);

ciliate_sensitivity_ind=[ciliate_sensitivity_ind_2; ciliate_sensitivity_ind];
mesodinium_sensitivity_ind=[mesodinium_sensitivity_ind_2; mesodinium_sensitivity_ind];
tintinnid_sensitivity_ind=[tintinnid_sensitivity_ind_2; tintinnid_sensitivity_ind];
laboea_sensitivity_ind=[laboea_sensitivity_ind_2; laboea_sensitivity_ind];
proto_sensitivity_ind=[proto_sensitivity_ind_2; proto_sensitivity_ind];
gyro_sensitivity_ind=[gyro_sensitivity_ind_2; gyro_sensitivity_ind];

load '/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/Dinos_stained_unstained/2-1-14/Manual_fromClass/D20140202T020906_IFCB014.mat'
IFCB_14_adcdata=load ('/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/Dinos_stained_unstained/2-1-14/D20140202T020906_IFCB014.adc');

ciliate_sensitivity_ind_2=find(classlist(:,4)==1 & IFCB_14_adcdata(:,9)> 0.012);
mesodinium_sensitivity_ind_2=find(classlist(:,4)==6 & IFCB_14_adcdata(:,9)> 0.012);
tintinnid_sensitivity_ind_2=find(classlist(:,4)==19 & IFCB_14_adcdata(:,9)> 0.012);
laboea_sensitivity_ind_2=find(classlist(:,4)==4 & IFCB_14_adcdata(:,9)> 0.012);
proto_sensitivity_ind_2=find(classlist(:,2)==31 & IFCB_14_adcdata(:,9)> 0.012);
gyro_sensitivity_ind_2=find(classlist(:,2)==36 & IFCB_14_adcdata(:,9)> 0.012);

ciliate_sensitivity_ind=[ciliate_sensitivity_ind_2; ciliate_sensitivity_ind];
mesodinium_sensitivity_ind=[mesodinium_sensitivity_ind_2; mesodinium_sensitivity_ind];
tintinnid_sensitivity_ind=[tintinnid_sensitivity_ind_2; tintinnid_sensitivity_ind];
laboea_sensitivity_ind=[laboea_sensitivity_ind_2; laboea_sensitivity_ind];
proto_sensitivity_ind=[proto_sensitivity_ind_2; proto_sensitivity_ind];
gyro_sensitivity_ind=[gyro_sensitivity_ind_2; gyro_sensitivity_ind];

load '/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/Dinos_stained_unstained/2-1-14/Manual_fromClass/D20140202T025858_IFCB014.mat'
IFCB_14_adcdata=load ('/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/Dinos_stained_unstained/2-1-14/D20140202T025858_IFCB014.adc');

ciliate_sensitivity_ind_2=find(classlist(:,4)==1 & IFCB_14_adcdata(:,9)> 0.012);
mesodinium_sensitivity_ind_2=find(classlist(:,4)==6 & IFCB_14_adcdata(:,9)> 0.012);
tintinnid_sensitivity_ind_2=find(classlist(:,4)==19 & IFCB_14_adcdata(:,9)> 0.012);
laboea_sensitivity_ind_2=find(classlist(:,4)==4 & IFCB_14_adcdata(:,9)> 0.012);
proto_sensitivity_ind_2=find(classlist(:,2)==31 & IFCB_14_adcdata(:,9)> 0.012);
gyro_sensitivity_ind_2=find(classlist(:,2)==36 & IFCB_14_adcdata(:,9)> 0.012);

ciliate_sensitivity_ind=[ciliate_sensitivity_ind_2; ciliate_sensitivity_ind];
mesodinium_sensitivity_ind=[mesodinium_sensitivity_ind_2; mesodinium_sensitivity_ind];
tintinnid_sensitivity_ind=[tintinnid_sensitivity_ind_2; tintinnid_sensitivity_ind];
laboea_sensitivity_ind=[laboea_sensitivity_ind_2; laboea_sensitivity_ind];
proto_sensitivity_ind=[proto_sensitivity_ind_2; proto_sensitivity_ind];
gyro_sensitivity_ind=[gyro_sensitivity_ind_2; gyro_sensitivity_ind];

load '/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/Dinos_stained_unstained/2-1-14/Manual_fromClass/D20140202T034850_IFCB014.mat'
IFCB_14_adcdata=load ('/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/Dinos_stained_unstained/2-1-14/D20140202T034850_IFCB014.adc');

ciliate_sensitivity_ind_2=find(classlist(:,4)==1 & IFCB_14_adcdata(:,9)> 0.012);
mesodinium_sensitivity_ind_2=find(classlist(:,4)==6 & IFCB_14_adcdata(:,9)> 0.012);
tintinnid_sensitivity_ind_2=find(classlist(:,4)==19 & IFCB_14_adcdata(:,9)> 0.012);
laboea_sensitivity_ind_2=find(classlist(:,4)==4 & IFCB_14_adcdata(:,9)> 0.012);
proto_sensitivity_ind_2=find(classlist(:,2)==31 & IFCB_14_adcdata(:,9)> 0.012);
gyro_sensitivity_ind_2=find(classlist(:,2)==36 & IFCB_14_adcdata(:,9)> 0.012);

ciliate_sensitivity_ind=[ciliate_sensitivity_ind_2; ciliate_sensitivity_ind];
mesodinium_sensitivity_ind=[mesodinium_sensitivity_ind_2; mesodinium_sensitivity_ind];
tintinnid_sensitivity_ind=[tintinnid_sensitivity_ind_2; tintinnid_sensitivity_ind];
laboea_sensitivity_ind=[laboea_sensitivity_ind_2; laboea_sensitivity_ind];
proto_sensitivity_ind=[proto_sensitivity_ind_2; proto_sensitivity_ind];
gyro_sensitivity_ind=[gyro_sensitivity_ind_2; gyro_sensitivity_ind];

load '/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/Dinos_stained_unstained/2-1-14/Manual_fromClass/D20140202T043843_IFCB014.mat'
IFCB_14_adcdata=load ('/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/Dinos_stained_unstained/2-1-14/D20140202T043843_IFCB014.adc');

ciliate_sensitivity_ind_2=find(classlist(:,4)==1 & IFCB_14_adcdata(:,9)> 0.012);
mesodinium_sensitivity_ind_2=find(classlist(:,4)==6 & IFCB_14_adcdata(:,9)> 0.012);
tintinnid_sensitivity_ind_2=find(classlist(:,4)==19 & IFCB_14_adcdata(:,9)> 0.012);
laboea_sensitivity_ind_2=find(classlist(:,4)==4 & IFCB_14_adcdata(:,9)> 0.012);
proto_sensitivity_ind_2=find(classlist(:,2)==31 & IFCB_14_adcdata(:,9)> 0.012);
gyro_sensitivity_ind_2=find(classlist(:,2)==36 & IFCB_14_adcdata(:,9)> 0.012);

ciliate_sensitivity_ind=[ciliate_sensitivity_ind_2; ciliate_sensitivity_ind];
mesodinium_sensitivity_ind=[mesodinium_sensitivity_ind_2; mesodinium_sensitivity_ind];
tintinnid_sensitivity_ind=[tintinnid_sensitivity_ind_2; tintinnid_sensitivity_ind];
laboea_sensitivity_ind=[laboea_sensitivity_ind_2; laboea_sensitivity_ind];
proto_sensitivity_ind=[proto_sensitivity_ind_2; proto_sensitivity_ind];
gyro_sensitivity_ind=[gyro_sensitivity_ind_2; gyro_sensitivity_ind];

%%
load '/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/Dinos_stained_unstained/2-1-14/Manual_fromClass/summary/count_manual_14May2014.mat';

runtype_alt_ind=strmatch('ALT', runtype);
runtype_normal_ind=strmatch('NORMAL',runtype);

alt_ciliate_bin=[46 25 1 4 30 11];
alt_ciliate_ml=sum(ml_analyzed(runtype_alt_ind));
[alt_ci] = poisson_count_ci(alt_ciliate_bin, 0.95);
alt_ci_low=alt_ci(:,1);
alt_ci_upper=alt_ci(:,2);
%%



normal_ciliate_bin=[normal_ciliate normal_meso normal_Laboea normal_tintinnid normal_gyro normal_proto];
normal_ciliate_ml=sum(ml_analyzed(runtype_normal_ind));
[normal_ci] = poisson_count_ci(normal_ciliate_bin, 0.95);
normal_ci_low=normal_ci(:,1);
normal_ci_upper=normal_ci(:,2);

b = [normal_ciliate_bin./normal_ciliate_ml; alt_ciliate_bin./alt_ciliate_ml]';
errdata1 = [b(:,1)'-(normal_ci_low./normal_ciliate_ml)'; (normal_ci_upper./normal_ciliate_ml-b(:,1))']';
errdata2 = [b(:,2)'-(alt_ci_low./alt_ciliate_ml)'; (alt_ci_upper./alt_ciliate_ml-b(:,2))']'; 
%errdata3 = [b(:,3)'-(m_ci_low./microscope_ml)'; (m_ci_upper./microscope_ml-b(:,3))']'; 
errdata = [errdata1' errdata2'];
figure
h = bar('v6', b);
set(gca, 'linewidth', 2, 'fontsize', 18,'fontname', 'arial')
%set(gca, 'xticklabel', class2use','fontsize', 18, 'fontname', 'arial');
set(gca,'fontsize',24, 'fontname', 'arial')
set(gca,'XTickLabel',{'Ciliate mix','Mesodinium','Laboea','Tintinnid','Gyrodinium','Protoperidinium','Dactyliosolen','Dictyocha','Dinobryon','Ditylum','Ephemera','Eucampia','Eucampia_groenlandica','Guinardia','Guinardia_flaccida','Leptocylindrus','Pleurosigma','Pseudonitzschia','Rhizosolenia','Skeletonema','Thalassionema','Thalassiosira','Thalassiosira_dirty','bad','ciliate','detritus','pennate','mix','clusterflagellate','crypto','dino10','dino30','Dinophysis','Euglena','flagellate','Gyrodinium','kiteflagellates','Lauderia','Licmophora','Phaeocystis','Prorocentrum','Pyramimonas','roundCell','Stephanopyxis','Tropidoneis','other','Cerataulina','Coscinodiscus','Gonyaulax','Odontella','Guinardia_striata','Paralia','mix_elongated','Hemiaulus','unclassified','Chaetoceros_flagellate','Chaetoceros_pennate','Cerataulina_flagellate','G_delicatula_parasite','G_delicatula_external_parasite','Chaetoceros_other','diatom_flagellate','other_interaction','Chaetoceros_didymus','Leptocylindrus_mediterraneus','Chaetoceros_didymus_flagellate','pennates_on_diatoms','Parvicorbicula_socialis','Delphineis','G_delicatula_detritus','amoeba','Ciliate_mix','Didinium_sp','Euplotes_sp','Laboea_strobila','Leegaardiella_ovalis','Mesodinium_sp','Pleuronema_sp','Strobilidium_morphotype1','Strobilidium_morphotype2','Strombidium_capitatum','Strombidium_caudatum','Strombidium_conicum','Strombidium_inclinatum','Strombidium_morphotype1','Strombidium_morphotype2','Strombidium_oculatum','Strombidium_wulffi','Tiarina_fusus','Tintinnid','Tontonia_appendiculariformis','Tontonia_gracillima'},...
    'XTick',[1 2 3 4 5 6],...
    'LineWidth',2,...
    'FontSize',24,...
    'FontName','arial');


xdata = get(h,'XData');
sizz = size(b);

%determine the number of bars and groups
NumGroups = sizz(1);
SizeGroups = sizz(2);
NumBars = SizeGroups * NumGroups;

% Use the Indices of Non Zero Y values to get both X values 
% for each bar. xb becomes a 2 by NumBars matrix of the X values.
INZY = [1 3];
xb = [];

for i = 1:SizeGroups
for j = 1:NumGroups
xb = [xb xdata{i}(INZY, j)];
end
end

%find the center X value of each bar.
for i = 1:NumBars
centerX(i) = (xb(1,i) + xb(2,i))/2;
end

% To place the error bars - use the following:
hold on;
%eh = errorbar(centerX,b,errdata); If you are using MATLAB 6.5 (R13)
%eh = errorbar('v6',centerX,b,errdata);
eh = errorbar('v6',centerX,b,errdata(1,:), errdata(2,:));

set(eh(1),'linewidth',2); % This changes the thickness of the errorbars
set(eh(1),'color','k'); % This changes the color of the errorbars
set(eh(2),'linestyle','none'); % This removes the connecting line
ylabel('Cell concentration (mL^{-1})','fontsize', 24, 'fontname', 'arial');
lh = legend('Non stained', 'Stained');
set(lh, 'box', 'off')





