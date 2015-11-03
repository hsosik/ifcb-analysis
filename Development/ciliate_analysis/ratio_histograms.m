IFCB_14_adcdata=load('/Volumes/IFCB014_OkeanosExplorerAug2013/data/continuous/D20130825T175150_IFCB014.adc');
load '/Volumes/IFCB014_OkeanosExplorerAug2013/data/continuous/Manual_fromClass/D20130825T175150_IFCB014.mat'

IFCB_14_ciliate_roi_ind=find(~isnan(classlist(:,4)));
gyro_ind=find(classlist(:,2)==36);
% ans=classlist(:,2);
% other_ind=find(isnan(ans));
% other_ind_1=find(classlist(:,2)==32);
% other_ind_2=[other_ind; other_ind_1];
ciliate_ratio_2=IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,4)./IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,5);
ciliate_ratio_2=ciliate_ratio_2';
gyro_ratio_2=IFCB_14_adcdata(gyro_ind,4)./IFCB_14_adcdata(gyro_ind,5);
other_ratio_2=IFCB_14_adcdata(:,4)./IFCB_14_adcdata(:,5);


IFCB_14_adcdata=load('/Volumes/IFCB014_OkeanosExplorerAug2013/data/continuous/D20130825T010723_IFCB014.adc');
load '/Volumes/IFCB014_OkeanosExplorerAug2013/data/continuous/Manual_fromClass/D20130825T010723_IFCB014.mat'

IFCB_14_ciliate_roi_ind=find(~isnan(classlist(:,4)));

ciliate_ratio=IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,4)./IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,5);
ciliate_ratio=ciliate_ratio';
ciliate_ratio_2=[ciliate_ratio_2 ciliate_ratio];

gyro_ratio= IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,4)./IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,5);
gyro_ratio=gyro_ratio';
gyro_ratio_2=[gyro_ratio_2 gyro_ratio];

other_ratio= IFCB_14_adcdata(:,4)./IFCB_14_adcdata(:,5);
%other_ratio=other_ratio;
other_ratio_2=[other_ratio_2; other_ratio];

IFCB_14_adcdata=load('/Volumes/IFCB014_OkeanosExplorerAug2013/data/continuous/D20130825T022235_IFCB014.adc');
load '/Volumes/IFCB014_OkeanosExplorerAug2013/data/continuous/Manual_fromClass/D20130825T022235_IFCB014.mat'

IFCB_14_ciliate_roi_ind=find(~isnan(classlist(:,4)));

ciliate_ratio=IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,4)./IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,5);
ciliate_ratio=ciliate_ratio';
ciliate_ratio_2=[ciliate_ratio_2 ciliate_ratio];

gyro_ratio= IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,4)./IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,5);
gyro_ratio=gyro_ratio';
gyro_ratio_2=[gyro_ratio_2 gyro_ratio];

other_ratio= IFCB_14_adcdata(:,4)./IFCB_14_adcdata(:,5);
other_ratio=other_ratio;
other_ratio_2=[other_ratio_2; other_ratio];

IFCB_14_adcdata=load('/Volumes/IFCB014_OkeanosExplorerAug2013/data/continuous/D20130825T033749_IFCB014.adc');
load '/Volumes/IFCB014_OkeanosExplorerAug2013/data/continuous/Manual_fromClass/D20130825T033749_IFCB014.mat'

IFCB_14_ciliate_roi_ind=find(~isnan(classlist(:,4)));

ciliate_ratio=IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,4)./IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,5);
ciliate_ratio=ciliate_ratio';
ciliate_ratio_2=[ciliate_ratio_2 ciliate_ratio];

gyro_ratio= IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,4)./IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,5);
gyro_ratio=gyro_ratio';
gyro_ratio_2=[gyro_ratio_2 gyro_ratio];

other_ratio= IFCB_14_adcdata(:,4)./IFCB_14_adcdata(:,5);
other_ratio=other_ratio;
other_ratio_2=[other_ratio_2; other_ratio];
%%
IFCB_14_adcdata=load('/Volumes/IFCB014_OkeanosExplorerAug2013/data/continuous/D20130825T045259_IFCB014.adc');
load '/Volumes/IFCB014_OkeanosExplorerAug2013/data/continuous/Manual_fromClass/D20130825T045259_IFCB014.mat'

IFCB_14_ciliate_roi_ind=find(~isnan(classlist(:,4)));

ciliate_ratio=IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,4)./IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,5);
ciliate_ratio=ciliate_ratio';
ciliate_ratio_2=[ciliate_ratio_2 ciliate_ratio];

gyro_ratio= IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,4)./IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,5);
gyro_ratio=gyro_ratio';
gyro_ratio_2=[gyro_ratio_2 gyro_ratio];

other_ratio= IFCB_14_adcdata(:,4)./IFCB_14_adcdata(:,5);
other_ratio=other_ratio;
other_ratio_2=[other_ratio_2; other_ratio];

IFCB_14_adcdata=load('/Volumes/IFCB014_OkeanosExplorerAug2013/data/continuous/D20130825T060810_IFCB014.adc');
load '/Volumes/IFCB014_OkeanosExplorerAug2013/data/continuous/Manual_fromClass/D20130825T060810_IFCB014.mat'

IFCB_14_ciliate_roi_ind=find(~isnan(classlist(:,4)));

ciliate_ratio=IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,4)./IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,5);
ciliate_ratio=ciliate_ratio';
ciliate_ratio_2=[ciliate_ratio_2 ciliate_ratio];

gyro_ratio= IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,4)./IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,5);
gyro_ratio=gyro_ratio';
gyro_ratio_2=[gyro_ratio_2 gyro_ratio];

other_ratio= IFCB_14_adcdata(:,4)./IFCB_14_adcdata(:,5);
other_ratio=other_ratio;
other_ratio_2=[other_ratio_2; other_ratio];
%%
IFCB_14_adcdata=load('/Volumes/IFCB014_OkeanosExplorerAug2013/data/continuous/D20130825T072324_IFCB014.adc');
load '/Volumes/IFCB014_OkeanosExplorerAug2013/data/continuous/Manual_fromClass/D20130825T072324_IFCB014.mat'

IFCB_14_ciliate_roi_ind=find(~isnan(classlist(:,4)));

ciliate_ratio=IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,4)./IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,5);
ciliate_ratio=ciliate_ratio';
ciliate_ratio_2=[ciliate_ratio_2 ciliate_ratio];

gyro_ratio= IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,4)./IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,5);
gyro_ratio=gyro_ratio';
gyro_ratio_2=[gyro_ratio_2 gyro_ratio];

other_ratio= IFCB_14_adcdata(:,4)./IFCB_14_adcdata(:,5);
other_ratio=other_ratio;
other_ratio_2=[other_ratio_2; other_ratio];

IFCB_14_adcdata=load('/Volumes/IFCB014_OkeanosExplorerAug2013/data/continuous/D20130825T083838_IFCB014.adc');
load '/Volumes/IFCB014_OkeanosExplorerAug2013/data/continuous/Manual_fromClass/D20130825T083838_IFCB014.mat'

IFCB_14_ciliate_roi_ind=find(~isnan(classlist(:,4)));

ciliate_ratio=IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,4)./IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,5);
ciliate_ratio=ciliate_ratio';
ciliate_ratio_2=[ciliate_ratio_2 ciliate_ratio];

gyro_ratio= IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,4)./IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,5);
gyro_ratio=gyro_ratio';
gyro_ratio_2=[gyro_ratio_2 gyro_ratio];

other_ratio= IFCB_14_adcdata(:,4)./IFCB_14_adcdata(:,5);
other_ratio=other_ratio;
other_ratio_2=[other_ratio_2; other_ratio];


IFCB_14_adcdata=load('/Volumes/IFCB014_OkeanosExplorerAug2013/data/continuous/D20130825T095352_IFCB014.adc');
load '/Volumes/IFCB014_OkeanosExplorerAug2013/data/continuous/Manual_fromClass/D20130825T095352_IFCB014.mat'

IFCB_14_ciliate_roi_ind=find(~isnan(classlist(:,4)));

ciliate_ratio=IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,4)./IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,5);
ciliate_ratio=ciliate_ratio';
ciliate_ratio_2=[ciliate_ratio_2 ciliate_ratio];

gyro_ratio= IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,4)./IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,5);
gyro_ratio=gyro_ratio';
gyro_ratio_2=[gyro_ratio_2 gyro_ratio];

other_ratio= IFCB_14_adcdata(:,4)./IFCB_14_adcdata(:,5);
other_ratio=other_ratio;
other_ratio_2=[other_ratio_2; other_ratio];

%%
IFCB_14_adcdata=load('/Volumes/IFCB014_OkeanosExplorerAug2013/data/continuous/D20130825T110907_IFCB014.adc');
load '/Volumes/IFCB014_OkeanosExplorerAug2013/data/continuous/Manual_fromClass/D20130825T110907_IFCB014.mat'

IFCB_14_ciliate_roi_ind=find(~isnan(classlist(:,4)));

ciliate_ratio=IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,4)./IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,5);
ciliate_ratio=ciliate_ratio';
ciliate_ratio_2=[ciliate_ratio_2 ciliate_ratio];

gyro_ratio= IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,4)./IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,5);
gyro_ratio=gyro_ratio';
gyro_ratio_2=[gyro_ratio_2 gyro_ratio];

other_ratio= IFCB_14_adcdata(:,4)./IFCB_14_adcdata(:,5);
other_ratio=other_ratio;
other_ratio_2=[other_ratio_2; other_ratio];

IFCB_14_adcdata=load('/Volumes/IFCB014_OkeanosExplorerAug2013/data/continuous/D20130825T122423_IFCB014.adc');
load '/Volumes/IFCB014_OkeanosExplorerAug2013/data/continuous/Manual_fromClass/D20130825T122423_IFCB014.mat'

IFCB_14_ciliate_roi_ind=find(~isnan(classlist(:,4)));

ciliate_ratio=IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,4)./IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,5);
ciliate_ratio=ciliate_ratio';
ciliate_ratio_2=[ciliate_ratio_2 ciliate_ratio];

gyro_ratio= IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,4)./IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,5);
gyro_ratio=gyro_ratio';
gyro_ratio_2=[gyro_ratio_2 gyro_ratio];

other_ratio= IFCB_14_adcdata(:,4)./IFCB_14_adcdata(:,5);
other_ratio=other_ratio;
other_ratio_2=[other_ratio_2; other_ratio];

IFCB_14_adcdata=load('/Volumes/IFCB014_OkeanosExplorerAug2013/data/continuous/D20130825T133939_IFCB014.adc');
load '/Volumes/IFCB014_OkeanosExplorerAug2013/data/continuous/Manual_fromClass/D20130825T133939_IFCB014.mat'

IFCB_14_ciliate_roi_ind=find(~isnan(classlist(:,4)));

ciliate_ratio=IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,4)./IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,5);
ciliate_ratio=ciliate_ratio';
ciliate_ratio_2=[ciliate_ratio_2 ciliate_ratio];

gyro_ratio= IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,4)./IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,5);
gyro_ratio=gyro_ratio';
gyro_ratio_2=[gyro_ratio_2 gyro_ratio];

other_ratio= IFCB_14_adcdata(:,4)./IFCB_14_adcdata(:,5);
other_ratio=other_ratio;
other_ratio_2=[other_ratio_2; other_ratio];

%%
IFCB_14_adcdata=load('/Volumes/IFCB014_OkeanosExplorerAug2013/data/continuous/D20130825T145453_IFCB014.adc');
load '/Volumes/IFCB014_OkeanosExplorerAug2013/data/continuous/Manual_fromClass/D20130825T145453_IFCB014.mat'

IFCB_14_ciliate_roi_ind=find(~isnan(classlist(:,4)));

ciliate_ratio=IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,4)./IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,5);
ciliate_ratio=ciliate_ratio';
ciliate_ratio_2=[ciliate_ratio_2 ciliate_ratio];

gyro_ratio= IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,4)./IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,5);
gyro_ratio=gyro_ratio';
gyro_ratio_2=[gyro_ratio_2 gyro_ratio];

other_ratio= IFCB_14_adcdata(:,4)./IFCB_14_adcdata(:,5);
other_ratio=other_ratio;
other_ratio_2=[other_ratio_2; other_ratio];

IFCB_14_adcdata=load('/Volumes/IFCB014_OkeanosExplorerAug2013/data/continuous/D20130825T161009_IFCB014.adc');
load '/Volumes/IFCB014_OkeanosExplorerAug2013/data/continuous/Manual_fromClass/D20130825T161009_IFCB014.mat'

IFCB_14_ciliate_roi_ind=find(~isnan(classlist(:,4)));

ciliate_ratio=IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,4)./IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,5);
ciliate_ratio=ciliate_ratio';
ciliate_ratio_2=[ciliate_ratio_2 ciliate_ratio];

gyro_ratio= IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,4)./IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,5);
gyro_ratio=gyro_ratio';
gyro_ratio_2=[gyro_ratio_2 gyro_ratio];

other_ratio= IFCB_14_adcdata(:,4)./IFCB_14_adcdata(:,5);
other_ratio=other_ratio;
other_ratio_2=[other_ratio_2; other_ratio];

IFCB_14_adcdata=load('/Volumes/IFCB014_OkeanosExplorerAug2013/data/continuous/D20130825T172524_IFCB014.adc');
load '/Volumes/IFCB014_OkeanosExplorerAug2013/data/continuous/Manual_fromClass/D20130825T172524_IFCB014.mat'

IFCB_14_ciliate_roi_ind=find(~isnan(classlist(:,4)));

ciliate_ratio=IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,4)./IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,5);
ciliate_ratio=ciliate_ratio';
ciliate_ratio_2=[ciliate_ratio_2 ciliate_ratio];

gyro_ratio= IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,4)./IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,5);
gyro_ratio=gyro_ratio';
gyro_ratio_2=[gyro_ratio_2 gyro_ratio];

other_ratio= IFCB_14_adcdata(:,4)./IFCB_14_adcdata(:,5);
other_ratio=other_ratio;
other_ratio_2=[other_ratio_2; other_ratio];

%%
IFCB_14_adcdata=load('/Volumes/IFCB014_OkeanosExplorerAug2013/data/continuous/D20130825T184041_IFCB014.adc');
load '/Volumes/IFCB014_OkeanosExplorerAug2013/data/continuous/Manual_fromClass/D20130825T184041_IFCB014.mat'

IFCB_14_ciliate_roi_ind=find(~isnan(classlist(:,4)));

ciliate_ratio=IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,4)./IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,5);
ciliate_ratio=ciliate_ratio';
ciliate_ratio_2=[ciliate_ratio_2 ciliate_ratio];

gyro_ratio= IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,4)./IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,5);
gyro_ratio=gyro_ratio';
gyro_ratio_2=[gyro_ratio_2 gyro_ratio];

other_ratio= IFCB_14_adcdata(:,4)./IFCB_14_adcdata(:,5);
other_ratio=other_ratio;
other_ratio_2=[other_ratio_2; other_ratio];

IFCB_14_adcdata=load('/Volumes/IFCB014_OkeanosExplorerAug2013/data/continuous/D20130825T195555_IFCB014.adc');
load '/Volumes/IFCB014_OkeanosExplorerAug2013/data/continuous/Manual_fromClass/D20130825T195555_IFCB014.mat'

IFCB_14_ciliate_roi_ind=find(~isnan(classlist(:,4)));

ciliate_ratio=IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,4)./IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,5);
ciliate_ratio=ciliate_ratio';
ciliate_ratio_2=[ciliate_ratio_2 ciliate_ratio];

gyro_ratio= IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,4)./IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,5);
gyro_ratio=gyro_ratio';
gyro_ratio_2=[gyro_ratio_2 gyro_ratio];

other_ratio= IFCB_14_adcdata(:,4)./IFCB_14_adcdata(:,5);
other_ratio=other_ratio;
other_ratio_2=[other_ratio_2; other_ratio];

diambins=[0:1:60];
% figure
% hist(ciliate_ratio_2,diambins)
% 
% figure
% rng(0,'twister')
% hist(ratio_2,diambins)
% h = findobj(gca,'Type','patch');
% set(h,'FaceColor',[0 .5 .5],'EdgeColor','w')


figure

[nb_1,xb_1]=hist(other_ratio_2,diambins);
nb_1_small=nb_1/1000;
[nb_2,xb_2]=hist(gyro_ratio_2,diambins);
[nb_3,xb_3]=hist(ciliate_ratio_2,diambins);
subplot(3,1,1)
bh_1=bar(xb_1,nb_1_small);
set(bh_1,'facecolor',[1 1 0]);
subplot(3,1,2)
bh_3=bar(xb_3,nb_3);
set(bh_3,'facecolor',[1 0 0]);
subplot(3,1,3)
bh_2=bar(xb_2,nb_2);
set(bh_2,'facecolor',[0 1 0]);
legend('phyto','ciliate','gyro')


% [nb,xb]=hist(rand(50,1));
%      bh=bar(xb,nb);
%      set(bh,'facecolor',[1 1 0]);
