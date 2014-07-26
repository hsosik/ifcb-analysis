load '/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/mixing_staining/1-18-14/Manual_fromClass/D20140118T044140_IFCB014.mat'
IFCB_14_adcdata=load('/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/mixing_staining/1-18-14/D20140118T044140_IFCB014.adc');

ciliate_sensitivity_ind=find(classlist(:,4)==1 & IFCB_14_adcdata(:,9)> 0.012 & IFCB_14_adcdata(:,8)> 0.012);
mesodinium_sensitivity_ind=find(classlist(:,4)==6 & IFCB_14_adcdata(:,9)> 0.012 & IFCB_14_adcdata(:,8)> 0.012);
tintinnid_sensitivity_ind=find(classlist(:,4)==19 & IFCB_14_adcdata(:,9)> 0.012 & IFCB_14_adcdata(:,8)> 0.012);
laboea_sensitivity_ind=find(classlist(:,4)==4 & IFCB_14_adcdata(:,9)> 0.012 & IFCB_14_adcdata(:,8)> 0.012);
proto_sensitivity_ind=find(classlist(:,2)==31 & IFCB_14_adcdata(:,9)> 0.012 & IFCB_14_adcdata(:,8)> 0.012);
gyro_sensitivity_ind=find(classlist(:,2)==36 & IFCB_14_adcdata(:,9)> 0.012 & IFCB_14_adcdata(:,8)> 0.012);

load '/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/mixing_staining/1-18-14/Manual_fromClass/D20140118T053132_IFCB014.mat'
IFCB_14_adcdata=load('/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/mixing_staining/1-18-14/D20140118T053132_IFCB014.adc');

ciliate_sensitivity_ind_2=find(classlist(:,4)==1 & IFCB_14_adcdata(:,9)> 0.012 & IFCB_14_adcdata(:,8)> 0.012);
mesodinium_sensitivity_ind_2=find(classlist(:,4)==6 & IFCB_14_adcdata(:,9)> 0.012 & IFCB_14_adcdata(:,8)> 0.012);
tintinnid_sensitivity_ind_2=find(classlist(:,4)==19 & IFCB_14_adcdata(:,9)> 0.012 & IFCB_14_adcdata(:,8)> 0.012);
laboea_sensitivity_ind_2=find(classlist(:,4)==4 & IFCB_14_adcdata(:,9)> 0.012 & IFCB_14_adcdata(:,8)> 0.012);
proto_sensitivity_ind_2=find(classlist(:,2)==31 & IFCB_14_adcdata(:,9)> 0.012 & IFCB_14_adcdata(:,8)> 0.012);
gyro_sensitivity_ind_2=find(classlist(:,2)==36 & IFCB_14_adcdata(:,9)> 0.012 & IFCB_14_adcdata(:,8)> 0.012);

ciliate_sensitivity_ind=[ciliate_sensitivity_ind_2; ciliate_sensitivity_ind];
mesodinium_sensitivity_ind=[mesodinium_sensitivity_ind_2; mesodinium_sensitivity_ind];
tintinnid_sensitivity_ind=[tintinnid_sensitivity_ind_2; tintinnid_sensitivity_ind];
laboea_sensitivity_ind=[laboea_sensitivity_ind_2; laboea_sensitivity_ind];
proto_sensitivity_ind=[proto_sensitivity_ind_2; proto_sensitivity_ind];
gyro_sensitivity_ind=[gyro_sensitivity_ind_2; gyro_sensitivity_ind];

load '/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/mixing_staining/1-18-14/Manual_fromClass/D20140118T062124_IFCB014.mat'
IFCB_14_adcdata=load('/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/mixing_staining/1-18-14/D20140118T062124_IFCB014.adc');


ciliate_sensitivity_ind_2=find(classlist(:,4)==1 & IFCB_14_adcdata(:,9)> 0.012 & IFCB_14_adcdata(:,8)> 0.012);
mesodinium_sensitivity_ind_2=find(classlist(:,4)==6 & IFCB_14_adcdata(:,9)> 0.012 & IFCB_14_adcdata(:,8)> 0.012);
tintinnid_sensitivity_ind_2=find(classlist(:,4)==19 & IFCB_14_adcdata(:,9)> 0.012 & IFCB_14_adcdata(:,8)> 0.012);
laboea_sensitivity_ind_2=find(classlist(:,4)==4 & IFCB_14_adcdata(:,9)> 0.012 & IFCB_14_adcdata(:,8)> 0.012);
proto_sensitivity_ind_2=find(classlist(:,2)==31 & IFCB_14_adcdata(:,9)> 0.012 & IFCB_14_adcdata(:,8)> 0.012);
gyro_sensitivity_ind_2=find(classlist(:,2)==36 & IFCB_14_adcdata(:,9)> 0.012 & IFCB_14_adcdata(:,8)> 0.012);

ciliate_sensitivity_ind=[ciliate_sensitivity_ind_2; ciliate_sensitivity_ind];
mesodinium_sensitivity_ind=[mesodinium_sensitivity_ind_2; mesodinium_sensitivity_ind];
tintinnid_sensitivity_ind=[tintinnid_sensitivity_ind_2; tintinnid_sensitivity_ind];
laboea_sensitivity_ind=[laboea_sensitivity_ind_2; laboea_sensitivity_ind];
proto_sensitivity_ind=[proto_sensitivity_ind_2; proto_sensitivity_ind];
gyro_sensitivity_ind=[gyro_sensitivity_ind_2; gyro_sensitivity_ind];


load '/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/mixing_staining/1-18-14/Manual_fromClass/D20140118T071114_IFCB014.mat'
IFCB_14_adcdata=load('/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/mixing_staining/1-18-14/D20140118T071114_IFCB014.adc');

ciliate_sensitivity_ind_2=find(classlist(:,4)==1 & IFCB_14_adcdata(:,9)> 0.012 & IFCB_14_adcdata(:,8)> 0.012);
mesodinium_sensitivity_ind_2=find(classlist(:,4)==6 & IFCB_14_adcdata(:,9)> 0.012 & IFCB_14_adcdata(:,8)> 0.012);
tintinnid_sensitivity_ind_2=find(classlist(:,4)==19 & IFCB_14_adcdata(:,9)> 0.012 & IFCB_14_adcdata(:,8)> 0.012);
laboea_sensitivity_ind_2=find(classlist(:,4)==4 & IFCB_14_adcdata(:,9)> 0.012 & IFCB_14_adcdata(:,8)> 0.012);
proto_sensitivity_ind_2=find(classlist(:,2)==31 & IFCB_14_adcdata(:,9)> 0.012 & IFCB_14_adcdata(:,8)> 0.012);
gyro_sensitivity_ind_2=find(classlist(:,2)==36 & IFCB_14_adcdata(:,9)> 0.012 & IFCB_14_adcdata(:,8)> 0.012);

ciliate_sensitivity_ind=[ciliate_sensitivity_ind_2; ciliate_sensitivity_ind];
mesodinium_sensitivity_ind=[mesodinium_sensitivity_ind_2; mesodinium_sensitivity_ind];
tintinnid_sensitivity_ind=[tintinnid_sensitivity_ind_2; tintinnid_sensitivity_ind];
laboea_sensitivity_ind=[laboea_sensitivity_ind_2; laboea_sensitivity_ind];
proto_sensitivity_ind=[proto_sensitivity_ind_2; proto_sensitivity_ind];
gyro_sensitivity_ind=[gyro_sensitivity_ind_2; gyro_sensitivity_ind];


load '/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/mixing_staining/1-18-14/Manual_fromClass/D20140118T085055_IFCB014.mat'
IFCB_14_adcdata=load('/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/mixing_staining/1-18-14/D20140118T085055_IFCB014.adc');

ciliate_sensitivity_ind_2=find(classlist(:,4)==1 & IFCB_14_adcdata(:,9)> 0.012 & IFCB_14_adcdata(:,8)> 0.012);
mesodinium_sensitivity_ind_2=find(classlist(:,4)==6 & IFCB_14_adcdata(:,9)> 0.012 & IFCB_14_adcdata(:,8)> 0.012);
tintinnid_sensitivity_ind_2=find(classlist(:,4)==19 & IFCB_14_adcdata(:,9)> 0.012 & IFCB_14_adcdata(:,8)> 0.012);
laboea_sensitivity_ind_2=find(classlist(:,4)==4 & IFCB_14_adcdata(:,9)> 0.012 & IFCB_14_adcdata(:,8)> 0.012);
proto_sensitivity_ind_2=find(classlist(:,2)==31 & IFCB_14_adcdata(:,9)> 0.012 & IFCB_14_adcdata(:,8)> 0.012);
gyro_sensitivity_ind_2=find(classlist(:,2)==36 & IFCB_14_adcdata(:,9)> 0.012 & IFCB_14_adcdata(:,8)> 0.012);

ciliate_sensitivity_ind=[ciliate_sensitivity_ind_2; ciliate_sensitivity_ind];
mesodinium_sensitivity_ind=[mesodinium_sensitivity_ind_2; mesodinium_sensitivity_ind];
tintinnid_sensitivity_ind=[tintinnid_sensitivity_ind_2; tintinnid_sensitivity_ind];
laboea_sensitivity_ind=[laboea_sensitivity_ind_2; laboea_sensitivity_ind];
proto_sensitivity_ind=[proto_sensitivity_ind_2; proto_sensitivity_ind];
gyro_sensitivity_ind=[gyro_sensitivity_ind_2; gyro_sensitivity_ind];


load '/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/mixing_staining/1-18-14/Manual_fromClass/D20140118T094047_IFCB014.mat'
IFCB_14_adcdata=load('/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/mixing_staining/1-18-14/D20140118T094047_IFCB014.adc');


ciliate_sensitivity_ind_2=find(classlist(:,4)==1 & IFCB_14_adcdata(:,9)> 0.012 & IFCB_14_adcdata(:,8)> 0.012);
mesodinium_sensitivity_ind_2=find(classlist(:,4)==6 & IFCB_14_adcdata(:,9)> 0.012 & IFCB_14_adcdata(:,8)> 0.012);
tintinnid_sensitivity_ind_2=find(classlist(:,4)==19 & IFCB_14_adcdata(:,9)> 0.012 & IFCB_14_adcdata(:,8)> 0.012);
laboea_sensitivity_ind_2=find(classlist(:,4)==4 & IFCB_14_adcdata(:,9)> 0.012 & IFCB_14_adcdata(:,8)> 0.012);
proto_sensitivity_ind_2=find(classlist(:,2)==31 & IFCB_14_adcdata(:,9)> 0.012 & IFCB_14_adcdata(:,8)> 0.012);
gyro_sensitivity_ind_2=find(classlist(:,2)==36 & IFCB_14_adcdata(:,9)> 0.012 & IFCB_14_adcdata(:,8)> 0.012);

ciliate_sensitivity_ind=[ciliate_sensitivity_ind_2; ciliate_sensitivity_ind];
mesodinium_sensitivity_ind=[mesodinium_sensitivity_ind_2; mesodinium_sensitivity_ind];
tintinnid_sensitivity_ind=[tintinnid_sensitivity_ind_2; tintinnid_sensitivity_ind];
laboea_sensitivity_ind=[laboea_sensitivity_ind_2; laboea_sensitivity_ind];
proto_sensitivity_ind=[proto_sensitivity_ind_2; proto_sensitivity_ind];
gyro_sensitivity_ind=[gyro_sensitivity_ind_2; gyro_sensitivity_ind];


load '/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/mixing_staining/1-18-14/Manual_fromClass/D20140118T103038_IFCB014.mat'
IFCB_14_adcdata=load('/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/mixing_staining/1-18-14/D20140118T103038_IFCB014.adc');


ciliate_sensitivity_ind_2=find(classlist(:,4)==1 & IFCB_14_adcdata(:,9)> 0.012 & IFCB_14_adcdata(:,8)> 0.012);
mesodinium_sensitivity_ind_2=find(classlist(:,4)==6 & IFCB_14_adcdata(:,9)> 0.012 & IFCB_14_adcdata(:,8)> 0.012);
tintinnid_sensitivity_ind_2=find(classlist(:,4)==19 & IFCB_14_adcdata(:,9)> 0.012 & IFCB_14_adcdata(:,8)> 0.012);
laboea_sensitivity_ind_2=find(classlist(:,4)==4 & IFCB_14_adcdata(:,9)> 0.012 & IFCB_14_adcdata(:,8)> 0.012);
proto_sensitivity_ind_2=find(classlist(:,2)==31 & IFCB_14_adcdata(:,9)> 0.012 & IFCB_14_adcdata(:,8)> 0.012);
gyro_sensitivity_ind_2=find(classlist(:,2)==36 & IFCB_14_adcdata(:,9)> 0.012 & IFCB_14_adcdata(:,8)> 0.012);

ciliate_sensitivity_ind=[ciliate_sensitivity_ind_2; ciliate_sensitivity_ind];
mesodinium_sensitivity_ind=[mesodinium_sensitivity_ind_2; mesodinium_sensitivity_ind];
tintinnid_sensitivity_ind=[tintinnid_sensitivity_ind_2; tintinnid_sensitivity_ind];
laboea_sensitivity_ind=[laboea_sensitivity_ind_2; laboea_sensitivity_ind];
proto_sensitivity_ind=[proto_sensitivity_ind_2; proto_sensitivity_ind];
gyro_sensitivity_ind=[gyro_sensitivity_ind_2; gyro_sensitivity_ind];


load '/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/mixing_staining/1-18-14/Manual_fromClass/D20140118T112028_IFCB014.mat'
IFCB_14_adcdata=load('/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/mixing_staining/1-18-14/D20140118T112028_IFCB014.adc');


ciliate_sensitivity_ind_2=find(classlist(:,4)==1 & IFCB_14_adcdata(:,9)> 0.012 & IFCB_14_adcdata(:,8)> 0.012);
mesodinium_sensitivity_ind_2=find(classlist(:,4)==6 & IFCB_14_adcdata(:,9)> 0.012 & IFCB_14_adcdata(:,8)> 0.012);
tintinnid_sensitivity_ind_2=find(classlist(:,4)==19 & IFCB_14_adcdata(:,9)> 0.012 & IFCB_14_adcdata(:,8)> 0.012);
laboea_sensitivity_ind_2=find(classlist(:,4)==4 & IFCB_14_adcdata(:,9)> 0.012 & IFCB_14_adcdata(:,8)> 0.012);
proto_sensitivity_ind_2=find(classlist(:,2)==31 & IFCB_14_adcdata(:,9)> 0.012 & IFCB_14_adcdata(:,8)> 0.012);
gyro_sensitivity_ind_2=find(classlist(:,2)==36 & IFCB_14_adcdata(:,9)> 0.012 & IFCB_14_adcdata(:,8)> 0.012);

ciliate_sensitivity_ind=[ciliate_sensitivity_ind_2; ciliate_sensitivity_ind];
mesodinium_sensitivity_ind=[mesodinium_sensitivity_ind_2; mesodinium_sensitivity_ind];
tintinnid_sensitivity_ind=[tintinnid_sensitivity_ind_2; tintinnid_sensitivity_ind];
laboea_sensitivity_ind=[laboea_sensitivity_ind_2; laboea_sensitivity_ind];
proto_sensitivity_ind=[proto_sensitivity_ind_2; proto_sensitivity_ind];
gyro_sensitivity_ind=[gyro_sensitivity_ind_2; gyro_sensitivity_ind];



load '/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/mixing_staining/1-18-14/Manual_fromClass/D20140118T121017_IFCB014.mat'
IFCB_14_adcdata=load('/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/mixing_staining/1-18-14/D20140118T121017_IFCB014.adc');


ciliate_sensitivity_ind_2=find(classlist(:,4)==1 & IFCB_14_adcdata(:,9)> 0.012 & IFCB_14_adcdata(:,8)> 0.012);
mesodinium_sensitivity_ind_2=find(classlist(:,4)==6 & IFCB_14_adcdata(:,9)> 0.012 & IFCB_14_adcdata(:,8)> 0.012);
tintinnid_sensitivity_ind_2=find(classlist(:,4)==19 & IFCB_14_adcdata(:,9)> 0.012 & IFCB_14_adcdata(:,8)> 0.012);
laboea_sensitivity_ind_2=find(classlist(:,4)==4 & IFCB_14_adcdata(:,9)> 0.012 & IFCB_14_adcdata(:,8)> 0.012);
proto_sensitivity_ind_2=find(classlist(:,2)==31 & IFCB_14_adcdata(:,9)> 0.012 & IFCB_14_adcdata(:,8)> 0.012);
gyro_sensitivity_ind_2=find(classlist(:,2)==36 & IFCB_14_adcdata(:,9)> 0.012 & IFCB_14_adcdata(:,8)> 0.012);

ciliate_sensitivity_ind=[ciliate_sensitivity_ind_2; ciliate_sensitivity_ind];
mesodinium_sensitivity_ind=[mesodinium_sensitivity_ind_2; mesodinium_sensitivity_ind];
tintinnid_sensitivity_ind=[tintinnid_sensitivity_ind_2; tintinnid_sensitivity_ind];
laboea_sensitivity_ind=[laboea_sensitivity_ind_2; laboea_sensitivity_ind];
proto_sensitivity_ind=[proto_sensitivity_ind_2; proto_sensitivity_ind];
gyro_sensitivity_ind=[gyro_sensitivity_ind_2; gyro_sensitivity_ind];


load '/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/mixing_staining/1-18-14/Manual_fromClass/D20140118T130007_IFCB014.mat'
IFCB_14_adcdata=load('/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/mixing_staining/1-18-14/D20140118T130007_IFCB014.adc');


ciliate_sensitivity_ind_2=find(classlist(:,4)==1 & IFCB_14_adcdata(:,9)> 0.012 & IFCB_14_adcdata(:,8)> 0.012);
mesodinium_sensitivity_ind_2=find(classlist(:,4)==6 & IFCB_14_adcdata(:,9)> 0.012 & IFCB_14_adcdata(:,8)> 0.012);
tintinnid_sensitivity_ind_2=find(classlist(:,4)==19 & IFCB_14_adcdata(:,9)> 0.012 & IFCB_14_adcdata(:,8)> 0.012);
laboea_sensitivity_ind_2=find(classlist(:,4)==4 & IFCB_14_adcdata(:,9)> 0.012 & IFCB_14_adcdata(:,8)> 0.012);
proto_sensitivity_ind_2=find(classlist(:,2)==31 & IFCB_14_adcdata(:,9)> 0.012 & IFCB_14_adcdata(:,8)> 0.012);
gyro_sensitivity_ind_2=find(classlist(:,2)==36 & IFCB_14_adcdata(:,9)> 0.012 & IFCB_14_adcdata(:,8)> 0.012);

ciliate_sensitivity_ind=[ciliate_sensitivity_ind_2; ciliate_sensitivity_ind];
mesodinium_sensitivity_ind=[mesodinium_sensitivity_ind_2; mesodinium_sensitivity_ind];
tintinnid_sensitivity_ind=[tintinnid_sensitivity_ind_2; tintinnid_sensitivity_ind];
laboea_sensitivity_ind=[laboea_sensitivity_ind_2; laboea_sensitivity_ind];
proto_sensitivity_ind=[proto_sensitivity_ind_2; proto_sensitivity_ind];
gyro_sensitivity_ind=[gyro_sensitivity_ind_2; gyro_sensitivity_ind];


load '/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/mixing_staining/1-18-14/Manual_fromClass/D20140118T134956_IFCB014.mat'
IFCB_14_adcdata=load('/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/mixing_staining/1-18-14/D20140118T134956_IFCB014.adc');

ciliate_sensitivity_ind_2=find(classlist(:,4)==1 & IFCB_14_adcdata(:,9)> 0.012 & IFCB_14_adcdata(:,8)> 0.012);
mesodinium_sensitivity_ind_2=find(classlist(:,4)==6 & IFCB_14_adcdata(:,9)> 0.012 & IFCB_14_adcdata(:,8)> 0.012);
tintinnid_sensitivity_ind_2=find(classlist(:,4)==19 & IFCB_14_adcdata(:,9)> 0.012 & IFCB_14_adcdata(:,8)> 0.012);
laboea_sensitivity_ind_2=find(classlist(:,4)==4 & IFCB_14_adcdata(:,9)> 0.012 & IFCB_14_adcdata(:,8)> 0.012);
proto_sensitivity_ind_2=find(classlist(:,2)==31 & IFCB_14_adcdata(:,9)> 0.012 & IFCB_14_adcdata(:,8)> 0.012);
gyro_sensitivity_ind_2=find(classlist(:,2)==36 & IFCB_14_adcdata(:,9)> 0.012 & IFCB_14_adcdata(:,8)> 0.012);

ciliate_sensitivity_ind=[ciliate_sensitivity_ind_2; ciliate_sensitivity_ind];
mesodinium_sensitivity_ind=[mesodinium_sensitivity_ind_2; mesodinium_sensitivity_ind];
tintinnid_sensitivity_ind=[tintinnid_sensitivity_ind_2; tintinnid_sensitivity_ind];
laboea_sensitivity_ind=[laboea_sensitivity_ind_2; laboea_sensitivity_ind];
proto_sensitivity_ind=[proto_sensitivity_ind_2; proto_sensitivity_ind];
gyro_sensitivity_ind=[gyro_sensitivity_ind_2; gyro_sensitivity_ind];



load '/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/mixing_staining/1-18-14/Manual_fromClass/D20140118T143945_IFCB014.mat'
IFCB_14_adcdata=load('/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/mixing_staining/1-18-14/D20140118T143945_IFCB014.adc');

ciliate_sensitivity_ind_2=find(classlist(:,4)==1 & IFCB_14_adcdata(:,9)> 0.012 & IFCB_14_adcdata(:,8)> 0.012);
mesodinium_sensitivity_ind_2=find(classlist(:,4)==6 & IFCB_14_adcdata(:,9)> 0.012 & IFCB_14_adcdata(:,8)> 0.012);
tintinnid_sensitivity_ind_2=find(classlist(:,4)==19 & IFCB_14_adcdata(:,9)> 0.012 & IFCB_14_adcdata(:,8)> 0.012);
laboea_sensitivity_ind_2=find(classlist(:,4)==4 & IFCB_14_adcdata(:,9)> 0.012 & IFCB_14_adcdata(:,8)> 0.012);
proto_sensitivity_ind_2=find(classlist(:,2)==31 & IFCB_14_adcdata(:,9)> 0.012 & IFCB_14_adcdata(:,8)> 0.012);
gyro_sensitivity_ind_2=find(classlist(:,2)==36 & IFCB_14_adcdata(:,9)> 0.012 & IFCB_14_adcdata(:,8)> 0.012);

ciliate_sensitivity_ind=[ciliate_sensitivity_ind_2; ciliate_sensitivity_ind];
mesodinium_sensitivity_ind=[mesodinium_sensitivity_ind_2; mesodinium_sensitivity_ind];
tintinnid_sensitivity_ind=[tintinnid_sensitivity_ind_2; tintinnid_sensitivity_ind];
laboea_sensitivity_ind=[laboea_sensitivity_ind_2; laboea_sensitivity_ind];
proto_sensitivity_ind=[proto_sensitivity_ind_2; proto_sensitivity_ind];
gyro_sensitivity_ind=[gyro_sensitivity_ind_2; gyro_sensitivity_ind];



load '/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/mixing_staining/1-18-14/Manual_fromClass/D20140118T152935_IFCB014.mat'
IFCB_14_adcdata=load('/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/mixing_staining/1-18-14/D20140118T152935_IFCB014.adc');


ciliate_sensitivity_ind_2=find(classlist(:,4)==1 & IFCB_14_adcdata(:,9)> 0.012 & IFCB_14_adcdata(:,8)> 0.012);
mesodinium_sensitivity_ind_2=find(classlist(:,4)==6 & IFCB_14_adcdata(:,9)> 0.012 & IFCB_14_adcdata(:,8)> 0.012);
tintinnid_sensitivity_ind_2=find(classlist(:,4)==19 & IFCB_14_adcdata(:,9)> 0.012 & IFCB_14_adcdata(:,8)> 0.012);
laboea_sensitivity_ind_2=find(classlist(:,4)==4 & IFCB_14_adcdata(:,9)> 0.012 & IFCB_14_adcdata(:,8)> 0.012);
proto_sensitivity_ind_2=find(classlist(:,2)==31 & IFCB_14_adcdata(:,9)> 0.012 & IFCB_14_adcdata(:,8)> 0.012);
gyro_sensitivity_ind_2=find(classlist(:,2)==36 & IFCB_14_adcdata(:,9)> 0.012 & IFCB_14_adcdata(:,8)> 0.012);

ciliate_sensitivity_ind=[ciliate_sensitivity_ind_2; ciliate_sensitivity_ind];
mesodinium_sensitivity_ind=[mesodinium_sensitivity_ind_2; mesodinium_sensitivity_ind];
tintinnid_sensitivity_ind=[tintinnid_sensitivity_ind_2; tintinnid_sensitivity_ind];
laboea_sensitivity_ind=[laboea_sensitivity_ind_2; laboea_sensitivity_ind];
proto_sensitivity_ind=[proto_sensitivity_ind_2; proto_sensitivity_ind];
gyro_sensitivity_ind=[gyro_sensitivity_ind_2; gyro_sensitivity_ind];

load '/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/mixing_staining/1-18-14/Manual_fromClass/D20140118T161927_IFCB014.mat'
IFCB_14_adcdata=load('/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/mixing_staining/1-18-14/D20140118T161927_IFCB014.adc');


ciliate_sensitivity_ind_2=find(classlist(:,4)==1 & IFCB_14_adcdata(:,9)> 0.012 & IFCB_14_adcdata(:,8)> 0.012);
mesodinium_sensitivity_ind_2=find(classlist(:,4)==6 & IFCB_14_adcdata(:,9)> 0.012 & IFCB_14_adcdata(:,8)> 0.012);
tintinnid_sensitivity_ind_2=find(classlist(:,4)==19 & IFCB_14_adcdata(:,9)> 0.012 & IFCB_14_adcdata(:,8)> 0.012);
laboea_sensitivity_ind_2=find(classlist(:,4)==4 & IFCB_14_adcdata(:,9)> 0.012 & IFCB_14_adcdata(:,8)> 0.012);
proto_sensitivity_ind_2=find(classlist(:,2)==31 & IFCB_14_adcdata(:,9)> 0.012 & IFCB_14_adcdata(:,8)> 0.012);
gyro_sensitivity_ind_2=find(classlist(:,2)==36 & IFCB_14_adcdata(:,9)> 0.012 & IFCB_14_adcdata(:,8)> 0.012);

ciliate_sensitivity_ind=[ciliate_sensitivity_ind_2; ciliate_sensitivity_ind];
mesodinium_sensitivity_ind=[mesodinium_sensitivity_ind_2; mesodinium_sensitivity_ind];
tintinnid_sensitivity_ind=[tintinnid_sensitivity_ind_2; tintinnid_sensitivity_ind];
laboea_sensitivity_ind=[laboea_sensitivity_ind_2; laboea_sensitivity_ind];
proto_sensitivity_ind=[proto_sensitivity_ind_2; proto_sensitivity_ind];
gyro_sensitivity_ind=[gyro_sensitivity_ind_2; gyro_sensitivity_ind];
