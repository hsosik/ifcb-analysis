IFCB_14_adcdata=load('/Volumes/IFCB014_OkeanosExplorerAug2013/data/continuous/D20130825T175150_IFCB014.adc');
load '/Volumes/IFCB014_OkeanosExplorerAug2013/data/continuous/Manual_fromClass/D20130825T175150_IFCB014.mat'

ciliate_sensitivity_ind=find(classlist(:,4)==1 & IFCB_14_adcdata(:,9)> 0.012 & IFCB_14_adcdata(:,8)> 0.012);
mesodinium_sensitivity_ind=find(classlist(:,4)==6 & IFCB_14_adcdata(:,9)> 0.012 & IFCB_14_adcdata(:,8)> 0.012);
tintinnid_sensitivity_ind=find(classlist(:,4)==19 & IFCB_14_adcdata(:,9)> 0.012 & IFCB_14_adcdata(:,8)> 0.012);
laboea_sensitivity_ind=find(classlist(:,4)==4 & IFCB_14_adcdata(:,9)> 0.012 & IFCB_14_adcdata(:,8)> 0.012);
proto_sensitivity_ind=find(classlist(:,2)==31 & IFCB_14_adcdata(:,9)> 0.012 & IFCB_14_adcdata(:,8)> 0.012);
gyro_sensitivity_ind=find(classlist(:,2)==36 & IFCB_14_adcdata(:,9)> 0.012 & IFCB_14_adcdata(:,8)> 0.012);

IFCB_14_adcdata=load('/Volumes/IFCB014_OkeanosExplorerAug2013/data/continuous/D20130825T010723_IFCB014.adc');
load '/Volumes/IFCB014_OkeanosExplorerAug2013/data/continuous/Manual_fromClass/D20130825T010723_IFCB014.mat'

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

IFCB_14_adcdata=load('/Volumes/IFCB014_OkeanosExplorerAug2013/data/continuous/D20130825T022235_IFCB014.adc');
load '/Volumes/IFCB014_OkeanosExplorerAug2013/data/continuous/Manual_fromClass/D20130825T022235_IFCB014.mat'

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

IFCB_14_adcdata=load('/Volumes/IFCB014_OkeanosExplorerAug2013/data/continuous/D20130825T033749_IFCB014.adc');
load '/Volumes/IFCB014_OkeanosExplorerAug2013/data/continuous/Manual_fromClass/D20130825T033749_IFCB014.mat'

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
%%
IFCB_14_adcdata=load('/Volumes/IFCB014_OkeanosExplorerAug2013/data/continuous/D20130825T045259_IFCB014.adc');
load '/Volumes/IFCB014_OkeanosExplorerAug2013/data/continuous/Manual_fromClass/D20130825T045259_IFCB014.mat'

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

IFCB_14_adcdata=load('/Volumes/IFCB014_OkeanosExplorerAug2013/data/continuous/D20130825T060810_IFCB014.adc');
load '/Volumes/IFCB014_OkeanosExplorerAug2013/data/continuous/Manual_fromClass/D20130825T060810_IFCB014.mat'

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
%%
IFCB_14_adcdata=load('/Volumes/IFCB014_OkeanosExplorerAug2013/data/continuous/D20130825T072324_IFCB014.adc');
load '/Volumes/IFCB014_OkeanosExplorerAug2013/data/continuous/Manual_fromClass/D20130825T072324_IFCB014.mat'

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

IFCB_14_adcdata=load('/Volumes/IFCB014_OkeanosExplorerAug2013/data/continuous/D20130825T083838_IFCB014.adc');
load '/Volumes/IFCB014_OkeanosExplorerAug2013/data/continuous/Manual_fromClass/D20130825T083838_IFCB014.mat'

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


IFCB_14_adcdata=load('/Volumes/IFCB014_OkeanosExplorerAug2013/data/continuous/D20130825T095352_IFCB014.adc');
load '/Volumes/IFCB014_OkeanosExplorerAug2013/data/continuous/Manual_fromClass/D20130825T095352_IFCB014.mat'

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

%%
IFCB_14_adcdata=load('/Volumes/IFCB014_OkeanosExplorerAug2013/data/continuous/D20130825T110907_IFCB014.adc');
load '/Volumes/IFCB014_OkeanosExplorerAug2013/data/continuous/Manual_fromClass/D20130825T110907_IFCB014.mat'

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

IFCB_14_adcdata=load('/Volumes/IFCB014_OkeanosExplorerAug2013/data/continuous/D20130825T122423_IFCB014.adc');
load '/Volumes/IFCB014_OkeanosExplorerAug2013/data/continuous/Manual_fromClass/D20130825T122423_IFCB014.mat'

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

IFCB_14_adcdata=load('/Volumes/IFCB014_OkeanosExplorerAug2013/data/continuous/D20130825T133939_IFCB014.adc');
load '/Volumes/IFCB014_OkeanosExplorerAug2013/data/continuous/Manual_fromClass/D20130825T133939_IFCB014.mat'

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

%%
IFCB_14_adcdata=load('/Volumes/IFCB014_OkeanosExplorerAug2013/data/continuous/D20130825T145453_IFCB014.adc');
load '/Volumes/IFCB014_OkeanosExplorerAug2013/data/continuous/Manual_fromClass/D20130825T145453_IFCB014.mat'

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

IFCB_14_adcdata=load('/Volumes/IFCB014_OkeanosExplorerAug2013/data/continuous/D20130825T161009_IFCB014.adc');
load '/Volumes/IFCB014_OkeanosExplorerAug2013/data/continuous/Manual_fromClass/D20130825T161009_IFCB014.mat'

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

IFCB_14_adcdata=load('/Volumes/IFCB014_OkeanosExplorerAug2013/data/continuous/D20130825T172524_IFCB014.adc');
load '/Volumes/IFCB014_OkeanosExplorerAug2013/data/continuous/Manual_fromClass/D20130825T172524_IFCB014.mat'

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

%%
IFCB_14_adcdata=load('/Volumes/IFCB014_OkeanosExplorerAug2013/data/continuous/D20130825T184041_IFCB014.adc');
load '/Volumes/IFCB014_OkeanosExplorerAug2013/data/continuous/Manual_fromClass/D20130825T184041_IFCB014.mat'

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

IFCB_14_adcdata=load('/Volumes/IFCB014_OkeanosExplorerAug2013/data/continuous/D20130825T195555_IFCB014.adc');
load '/Volumes/IFCB014_OkeanosExplorerAug2013/data/continuous/Manual_fromClass/D20130825T195555_IFCB014.mat'

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
