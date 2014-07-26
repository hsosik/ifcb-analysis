%Spring

load '/Users/markmiller/Documents/Experiments/IFCB_14/Microscopy_vs_Imager/5-11-14/Manual_fromClass/D20140511T124604_IFCB014.mat'
IFCB_14_adcdata=load('/Users/markmiller/Documents/Experiments/IFCB_14/Microscopy_vs_Imager/5-11-14/D20140511T124604_IFCB014.adc');

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


load '/Users/markmiller/Documents/Experiments/IFCB_14/Microscopy_vs_Imager/5-11-14/Manual_fromClass/D20140511T133850_IFCB014.mat'
IFCB_14_adcdata=load('/Users/markmiller/Documents/Experiments/IFCB_14/Microscopy_vs_Imager/5-11-14/D20140511T133850_IFCB014.adc');


IFCB_14_ciliate_roi_ind=find(~isnan(classlist(:,4)));
gyro_ind=find(classlist(:,2)==36);
ciliate_ratio=IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,4)./IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,5);
ciliate_ratio=ciliate_ratio';
ciliate_ratio_2=[ciliate_ratio_2 ciliate_ratio];

gyro_ratio= IFCB_14_adcdata(gyro_ind,4)./IFCB_14_adcdata(gyro_ind,5);
gyro_ratio=gyro_ratio';
gyro_ratio_2=[gyro_ratio_2; gyro_ratio];

other_ratio= IFCB_14_adcdata(:,4)./IFCB_14_adcdata(:,5);
%other_ratio=other_ratio;
other_ratio_2=[other_ratio_2; other_ratio];

load '/Users/markmiller/Documents/Experiments/IFCB_14/Microscopy_vs_Imager/5-11-14/Manual_fromClass/D20140511T142939_IFCB014.mat'
IFCB_14_adcdata=load('/Users/markmiller/Documents/Experiments/IFCB_14/Microscopy_vs_Imager/5-11-14/D20140511T142939_IFCB014.adc');


IFCB_14_ciliate_roi_ind=find(~isnan(classlist(:,4)));
gyro_ind=find(classlist(:,2)==36);
ciliate_ratio=IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,4)./IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,5);
ciliate_ratio=ciliate_ratio';
ciliate_ratio_2=[ciliate_ratio_2 ciliate_ratio];

gyro_ratio= IFCB_14_adcdata(gyro_ind,4)./IFCB_14_adcdata(gyro_ind,5);
%gyro_ratio=gyro_ratio';
gyro_ratio_2=[gyro_ratio_2; gyro_ratio];

other_ratio= IFCB_14_adcdata(:,4)./IFCB_14_adcdata(:,5);
%other_ratio=other_ratio;
other_ratio_2=[other_ratio_2; other_ratio];

load '/Users/markmiller/Documents/Experiments/IFCB_14/Microscopy_vs_Imager/5-11-14/Manual_fromClass/D20140511T152143_IFCB014.mat'
IFCB_14_adcdata=load('/Users/markmiller/Documents/Experiments/IFCB_14/Microscopy_vs_Imager/5-11-14/D20140511T152143_IFCB014.adc');


IFCB_14_ciliate_roi_ind=find(~isnan(classlist(:,4)));
gyro_ind=find(classlist(:,2)==36);
ciliate_ratio=IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,4)./IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,5);
ciliate_ratio=ciliate_ratio';
ciliate_ratio_2=[ciliate_ratio_2 ciliate_ratio];

gyro_ratio= IFCB_14_adcdata(gyro_ind,4)./IFCB_14_adcdata(gyro_ind,5);
%gyro_ratio=gyro_ratio';
gyro_ratio_2=[gyro_ratio_2; gyro_ratio];

other_ratio= IFCB_14_adcdata(:,4)./IFCB_14_adcdata(:,5);
%other_ratio=other_ratio;
other_ratio_2=[other_ratio_2; other_ratio];

load '/Users/markmiller/Documents/Experiments/IFCB_14/Microscopy_vs_Imager/5-11-14/Manual_fromClass/D20140511T161218_IFCB014.mat'
IFCB_14_adcdata=load('/Users/markmiller/Documents/Experiments/IFCB_14/Microscopy_vs_Imager/5-11-14/D20140511T161218_IFCB014.adc');

IFCB_14_ciliate_roi_ind=find(~isnan(classlist(:,4)));
gyro_ind=find(classlist(:,2)==36);
ciliate_ratio=IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,4)./IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,5);
ciliate_ratio=ciliate_ratio';
ciliate_ratio_2=[ciliate_ratio_2 ciliate_ratio];

gyro_ratio= IFCB_14_adcdata(gyro_ind,4)./IFCB_14_adcdata(gyro_ind,5);
%gyro_ratio=gyro_ratio';
gyro_ratio_2=[gyro_ratio_2; gyro_ratio];

other_ratio= IFCB_14_adcdata(:,4)./IFCB_14_adcdata(:,5);
%other_ratio=other_ratio;
other_ratio_2=[other_ratio_2; other_ratio];


diambins=[0:0.5:20];
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
[nb_2,xb_2]=hist(gyro_ratio_2,diambins);
[nb_3,xb_3]=hist(ciliate_ratio_2,diambins);
subplot(3,1,1)
bh_1=bar(xb_1,nb_1);
set(bh_1,'facecolor',[1 1 0]);
legend('all')
subplot(3,1,2)
bh_3=bar(xb_3,nb_3);
set(bh_3,'facecolor',[1 0 0]);
legend('ciliate')
subplot(3,1,3)
bh_2=bar(xb_2,nb_2);
set(bh_2,'facecolor',[0 1 0]);
legend('gyro')

%%

%winter
%2-1-14 good day for gyros - did gyro comparison for this day
load '/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/Dinos_stained_unstained/2-1-14/Manual_fromClass/D20140201T045850_IFCB014.mat'
IFCB_14_adcdata=load ('/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/Dinos_stained_unstained/2-1-14/D20140201T045850_IFCB014.adc');

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

load '/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/Dinos_stained_unstained/2-1-14/Manual_fromClass/D20140201T054841_IFCB014.mat'
IFCB_14_adcdata=load ('/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/Dinos_stained_unstained/2-1-14/D20140201T054841_IFCB014.adc');

IFCB_14_ciliate_roi_ind=find(~isnan(classlist(:,4)));
gyro_ind=find(classlist(:,2)==36);
ciliate_ratio=IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,4)./IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,5);
ciliate_ratio=ciliate_ratio';
ciliate_ratio_2=[ciliate_ratio_2 ciliate_ratio];

gyro_ratio= IFCB_14_adcdata(gyro_ind,4)./IFCB_14_adcdata(gyro_ind,5);
gyro_ratio=gyro_ratio';
gyro_ratio_2=[gyro_ratio_2; gyro_ratio];

other_ratio= IFCB_14_adcdata(:,4)./IFCB_14_adcdata(:,5);
%other_ratio=other_ratio;
other_ratio_2=[other_ratio_2; other_ratio];

load '/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/Dinos_stained_unstained/2-1-14/Manual_fromClass/D20140201T063834_IFCB014.mat'
IFCB_14_adcdata=load ('/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/Dinos_stained_unstained/2-1-14/D20140201T063834_IFCB014.adc');

IFCB_14_ciliate_roi_ind=find(~isnan(classlist(:,4)));
gyro_ind=find(classlist(:,2)==36);
ciliate_ratio=IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,4)./IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,5);
ciliate_ratio=ciliate_ratio';
ciliate_ratio_2=[ciliate_ratio_2 ciliate_ratio];

gyro_ratio= IFCB_14_adcdata(gyro_ind,4)./IFCB_14_adcdata(gyro_ind,5);
gyro_ratio=gyro_ratio';
gyro_ratio_2=[gyro_ratio_2; gyro_ratio];

other_ratio= IFCB_14_adcdata(:,4)./IFCB_14_adcdata(:,5);
%other_ratio=other_ratio;
other_ratio_2=[other_ratio_2; other_ratio];

%%

load '/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/Dinos_stained_unstained/2-1-14/Manual_fromClass/D20140201T072825_IFCB014.mat'
IFCB_14_adcdata=load ('/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/Dinos_stained_unstained/2-1-14/D20140201T072825_IFCB014.adc');

IFCB_14_ciliate_roi_ind=find(~isnan(classlist(:,4)));
gyro_ind=find(classlist(:,2)==36);
ciliate_ratio=IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,4)./IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,5);
ciliate_ratio=ciliate_ratio';
ciliate_ratio_2=[ciliate_ratio_2 ciliate_ratio];

gyro_ratio= IFCB_14_adcdata(gyro_ind,4)./IFCB_14_adcdata(gyro_ind,5);
gyro_ratio=gyro_ratio';
gyro_ratio_2=[gyro_ratio_2; gyro_ratio];

other_ratio= IFCB_14_adcdata(:,4)./IFCB_14_adcdata(:,5);
%other_ratio=other_ratio;
other_ratio_2=[other_ratio_2; other_ratio];

load '/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/Dinos_stained_unstained/2-1-14/Manual_fromClass/D20140201T081818_IFCB014.mat'
IFCB_14_adcdata=load ('/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/Dinos_stained_unstained/2-1-14/D20140201T081818_IFCB014.adc');

IFCB_14_ciliate_roi_ind=find(~isnan(classlist(:,4)));
gyro_ind=find(classlist(:,2)==36);
ciliate_ratio=IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,4)./IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,5);
ciliate_ratio=ciliate_ratio';
ciliate_ratio_2=[ciliate_ratio_2 ciliate_ratio];

gyro_ratio= IFCB_14_adcdata(gyro_ind,4)./IFCB_14_adcdata(gyro_ind,5);
gyro_ratio=gyro_ratio';
gyro_ratio_2=[gyro_ratio_2; gyro_ratio];

other_ratio= IFCB_14_adcdata(:,4)./IFCB_14_adcdata(:,5);
%other_ratio=other_ratio;
other_ratio_2=[other_ratio_2; other_ratio];


load '/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/Dinos_stained_unstained/2-1-14/Manual_fromClass/D20140201T090809_IFCB014.mat'
IFCB_14_adcdata=load ('/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/Dinos_stained_unstained/2-1-14/D20140201T090809_IFCB014.adc');

IFCB_14_ciliate_roi_ind=find(~isnan(classlist(:,4)));
gyro_ind=find(classlist(:,2)==36);
ciliate_ratio=IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,4)./IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,5);
ciliate_ratio=ciliate_ratio';
ciliate_ratio_2=[ciliate_ratio_2 ciliate_ratio];

gyro_ratio= IFCB_14_adcdata(gyro_ind,4)./IFCB_14_adcdata(gyro_ind,5);
gyro_ratio=gyro_ratio';
gyro_ratio_2=[gyro_ratio_2; gyro_ratio];

other_ratio= IFCB_14_adcdata(:,4)./IFCB_14_adcdata(:,5);
%other_ratio=other_ratio;
other_ratio_2=[other_ratio_2; other_ratio];

load '/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/Dinos_stained_unstained/2-1-14/Manual_fromClass/D20140201T095801_IFCB014.mat'
IFCB_14_adcdata=load ('/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/Dinos_stained_unstained/2-1-14/D20140201T095801_IFCB014.adc');

IFCB_14_ciliate_roi_ind=find(~isnan(classlist(:,4)));
gyro_ind=find(classlist(:,2)==36);
ciliate_ratio=IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,4)./IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,5);
ciliate_ratio=ciliate_ratio';
ciliate_ratio_2=[ciliate_ratio_2 ciliate_ratio];

gyro_ratio= IFCB_14_adcdata(gyro_ind,4)./IFCB_14_adcdata(gyro_ind,5);
gyro_ratio=gyro_ratio';
gyro_ratio_2=[gyro_ratio_2; gyro_ratio];

other_ratio= IFCB_14_adcdata(:,4)./IFCB_14_adcdata(:,5);
%other_ratio=other_ratio;
other_ratio_2=[other_ratio_2; other_ratio];

load '/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/Dinos_stained_unstained/2-1-14/Manual_fromClass/D20140201T104753_IFCB014.mat'
IFCB_14_adcdata=load ('/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/Dinos_stained_unstained/2-1-14/D20140201T104753_IFCB014.adc');

IFCB_14_ciliate_roi_ind=find(~isnan(classlist(:,4)));
gyro_ind=find(classlist(:,2)==36);
ciliate_ratio=IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,4)./IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,5);
ciliate_ratio=ciliate_ratio';
ciliate_ratio_2=[ciliate_ratio_2 ciliate_ratio];

gyro_ratio= IFCB_14_adcdata(gyro_ind,4)./IFCB_14_adcdata(gyro_ind,5);
gyro_ratio=gyro_ratio';
gyro_ratio_2=[gyro_ratio_2; gyro_ratio];

other_ratio= IFCB_14_adcdata(:,4)./IFCB_14_adcdata(:,5);
%other_ratio=other_ratio;
other_ratio_2=[other_ratio_2; other_ratio];

load '/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/Dinos_stained_unstained/2-1-14/Manual_fromClass/D20140201T113745_IFCB014.mat'
IFCB_14_adcdata=load ('/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/Dinos_stained_unstained/2-1-14/D20140201T113745_IFCB014.adc');

IFCB_14_ciliate_roi_ind=find(~isnan(classlist(:,4)));
gyro_ind=find(classlist(:,2)==36);
ciliate_ratio=IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,4)./IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,5);
ciliate_ratio=ciliate_ratio';
ciliate_ratio_2=[ciliate_ratio_2 ciliate_ratio];

gyro_ratio= IFCB_14_adcdata(gyro_ind,4)./IFCB_14_adcdata(gyro_ind,5);
gyro_ratio=gyro_ratio';
gyro_ratio_2=[gyro_ratio_2; gyro_ratio];

other_ratio= IFCB_14_adcdata(:,4)./IFCB_14_adcdata(:,5);
%other_ratio=other_ratio;
other_ratio_2=[other_ratio_2; other_ratio];

load '/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/Dinos_stained_unstained/2-1-14/Manual_fromClass/D20140201T122737_IFCB014.mat'
IFCB_14_adcdata=load ('/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/Dinos_stained_unstained/2-1-14/D20140201T122737_IFCB014.adc');

IFCB_14_ciliate_roi_ind=find(~isnan(classlist(:,4)));
gyro_ind=find(classlist(:,2)==36);
ciliate_ratio=IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,4)./IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,5);
ciliate_ratio=ciliate_ratio';
ciliate_ratio_2=[ciliate_ratio_2 ciliate_ratio];

gyro_ratio= IFCB_14_adcdata(gyro_ind,4)./IFCB_14_adcdata(gyro_ind,5);
gyro_ratio=gyro_ratio';
gyro_ratio_2=[gyro_ratio_2; gyro_ratio];

other_ratio= IFCB_14_adcdata(:,4)./IFCB_14_adcdata(:,5);
%other_ratio=other_ratio;
other_ratio_2=[other_ratio_2; other_ratio];



load '/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/Dinos_stained_unstained/2-1-14/Manual_fromClass/D20140201T131729_IFCB014.mat'
IFCB_14_adcdata=load ('/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/Dinos_stained_unstained/2-1-14/D20140201T131729_IFCB014.adc');

IFCB_14_ciliate_roi_ind=find(~isnan(classlist(:,4)));
gyro_ind=find(classlist(:,2)==36);
ciliate_ratio=IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,4)./IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,5);
ciliate_ratio=ciliate_ratio';
ciliate_ratio_2=[ciliate_ratio_2 ciliate_ratio];

gyro_ratio= IFCB_14_adcdata(gyro_ind,4)./IFCB_14_adcdata(gyro_ind,5);
gyro_ratio=gyro_ratio';
gyro_ratio_2=[gyro_ratio_2; gyro_ratio];

other_ratio= IFCB_14_adcdata(:,4)./IFCB_14_adcdata(:,5);
%other_ratio=other_ratio;
other_ratio_2=[other_ratio_2; other_ratio];

load '/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/Dinos_stained_unstained/2-1-14/Manual_fromClass/D20140201T140721_IFCB014.mat'
IFCB_14_adcdata=load ('/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/Dinos_stained_unstained/2-1-14/D20140201T140721_IFCB014.adc');

IFCB_14_ciliate_roi_ind=find(~isnan(classlist(:,4)));
gyro_ind=find(classlist(:,2)==36);
ciliate_ratio=IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,4)./IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,5);
ciliate_ratio=ciliate_ratio';
ciliate_ratio_2=[ciliate_ratio_2 ciliate_ratio];

gyro_ratio= IFCB_14_adcdata(gyro_ind,4)./IFCB_14_adcdata(gyro_ind,5);
gyro_ratio=gyro_ratio';
gyro_ratio_2=[gyro_ratio_2; gyro_ratio];

other_ratio= IFCB_14_adcdata(:,4)./IFCB_14_adcdata(:,5);
%other_ratio=other_ratio;
other_ratio_2=[other_ratio_2; other_ratio];

load '/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/Dinos_stained_unstained/2-1-14/Manual_fromClass/D20140201T145712_IFCB014.mat'
IFCB_14_adcdata=load ('/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/Dinos_stained_unstained/2-1-14/D20140201T145712_IFCB014.adc');

IFCB_14_ciliate_roi_ind=find(~isnan(classlist(:,4)));
gyro_ind=find(classlist(:,2)==36);
ciliate_ratio=IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,4)./IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,5);
ciliate_ratio=ciliate_ratio';
ciliate_ratio_2=[ciliate_ratio_2 ciliate_ratio];

gyro_ratio= IFCB_14_adcdata(gyro_ind,4)./IFCB_14_adcdata(gyro_ind,5);
gyro_ratio=gyro_ratio';
gyro_ratio_2=[gyro_ratio_2; gyro_ratio];

other_ratio= IFCB_14_adcdata(:,4)./IFCB_14_adcdata(:,5);
%other_ratio=other_ratio;
other_ratio_2=[other_ratio_2; other_ratio];

load '/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/Dinos_stained_unstained/2-1-14/Manual_fromClass/D20140201T154705_IFCB014.mat'
IFCB_14_adcdata=load ('/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/Dinos_stained_unstained/2-1-14/D20140201T154705_IFCB014.adc');

IFCB_14_ciliate_roi_ind=find(~isnan(classlist(:,4)));
gyro_ind=find(classlist(:,2)==36);
ciliate_ratio=IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,4)./IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,5);
ciliate_ratio=ciliate_ratio';
ciliate_ratio_2=[ciliate_ratio_2 ciliate_ratio];

gyro_ratio= IFCB_14_adcdata(gyro_ind,4)./IFCB_14_adcdata(gyro_ind,5);
gyro_ratio=gyro_ratio';
gyro_ratio_2=[gyro_ratio_2; gyro_ratio];

other_ratio= IFCB_14_adcdata(:,4)./IFCB_14_adcdata(:,5);
%other_ratio=other_ratio;
other_ratio_2=[other_ratio_2; other_ratio];

load '/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/Dinos_stained_unstained/2-1-14/Manual_fromClass/D20140201T163656_IFCB014.mat'
IFCB_14_adcdata=load ('/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/Dinos_stained_unstained/2-1-14/D20140201T163656_IFCB014.adc');


IFCB_14_ciliate_roi_ind=find(~isnan(classlist(:,4)));
gyro_ind=find(classlist(:,2)==36);
ciliate_ratio=IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,4)./IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,5);
ciliate_ratio=ciliate_ratio';
ciliate_ratio_2=[ciliate_ratio_2 ciliate_ratio];

gyro_ratio= IFCB_14_adcdata(gyro_ind,4)./IFCB_14_adcdata(gyro_ind,5);
gyro_ratio=gyro_ratio';
gyro_ratio_2=[gyro_ratio_2; gyro_ratio];

other_ratio= IFCB_14_adcdata(:,4)./IFCB_14_adcdata(:,5);
%other_ratio=other_ratio;
other_ratio_2=[other_ratio_2; other_ratio];

load '/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/Dinos_stained_unstained/2-1-14/Manual_fromClass/D20140201T172648_IFCB014.mat'
IFCB_14_adcdata=load ('/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/Dinos_stained_unstained/2-1-14/D20140201T172648_IFCB014.adc');

IFCB_14_ciliate_roi_ind=find(~isnan(classlist(:,4)));
gyro_ind=find(classlist(:,2)==36);
ciliate_ratio=IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,4)./IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,5);
ciliate_ratio=ciliate_ratio';
ciliate_ratio_2=[ciliate_ratio_2 ciliate_ratio];

gyro_ratio= IFCB_14_adcdata(gyro_ind,4)./IFCB_14_adcdata(gyro_ind,5);
gyro_ratio=gyro_ratio';
gyro_ratio_2=[gyro_ratio_2; gyro_ratio];

other_ratio= IFCB_14_adcdata(:,4)./IFCB_14_adcdata(:,5);
%other_ratio=other_ratio;
other_ratio_2=[other_ratio_2; other_ratio];

load '/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/Dinos_stained_unstained/2-1-14/Manual_fromClass/D20140201T181640_IFCB014.mat'
IFCB_14_adcdata=load ('/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/Dinos_stained_unstained/2-1-14/D20140201T181640_IFCB014.adc');

IFCB_14_ciliate_roi_ind=find(~isnan(classlist(:,4)));
gyro_ind=find(classlist(:,2)==36);
ciliate_ratio=IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,4)./IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,5);
ciliate_ratio=ciliate_ratio';
ciliate_ratio_2=[ciliate_ratio_2 ciliate_ratio];

gyro_ratio= IFCB_14_adcdata(gyro_ind,4)./IFCB_14_adcdata(gyro_ind,5);
gyro_ratio=gyro_ratio';
gyro_ratio_2=[gyro_ratio_2; gyro_ratio];

other_ratio= IFCB_14_adcdata(:,4)./IFCB_14_adcdata(:,5);
%other_ratio=other_ratio;
other_ratio_2=[other_ratio_2; other_ratio];

load '/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/Dinos_stained_unstained/2-1-14/Manual_fromClass/D20140201T190632_IFCB014.mat'
IFCB_14_adcdata=load ('/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/Dinos_stained_unstained/2-1-14/D20140201T190632_IFCB014.adc');

IFCB_14_ciliate_roi_ind=find(~isnan(classlist(:,4)));
gyro_ind=find(classlist(:,2)==36);
ciliate_ratio=IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,4)./IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,5);
ciliate_ratio=ciliate_ratio';
ciliate_ratio_2=[ciliate_ratio_2 ciliate_ratio];

gyro_ratio= IFCB_14_adcdata(gyro_ind,4)./IFCB_14_adcdata(gyro_ind,5);
gyro_ratio=gyro_ratio';
gyro_ratio_2=[gyro_ratio_2; gyro_ratio];

other_ratio= IFCB_14_adcdata(:,4)./IFCB_14_adcdata(:,5);
%other_ratio=other_ratio;
other_ratio_2=[other_ratio_2; other_ratio];

load '/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/Dinos_stained_unstained/2-1-14/Manual_fromClass/D20140201T195623_IFCB014.mat'
IFCB_14_adcdata=load ('/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/Dinos_stained_unstained/2-1-14/D20140201T195623_IFCB014.adc');

IFCB_14_ciliate_roi_ind=find(~isnan(classlist(:,4)));
gyro_ind=find(classlist(:,2)==36);
ciliate_ratio=IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,4)./IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,5);
ciliate_ratio=ciliate_ratio';
ciliate_ratio_2=[ciliate_ratio_2 ciliate_ratio];

gyro_ratio= IFCB_14_adcdata(gyro_ind,4)./IFCB_14_adcdata(gyro_ind,5);
gyro_ratio=gyro_ratio';
gyro_ratio_2=[gyro_ratio_2; gyro_ratio];

other_ratio= IFCB_14_adcdata(:,4)./IFCB_14_adcdata(:,5);
%other_ratio=other_ratio;
other_ratio_2=[other_ratio_2; other_ratio];


%1-18-14 good day for ciliates - did winter comparison for this day

load '/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/mixing_staining/1-18-14/results/normal/D20140118T055745_IFCB014.mat'
IFCB_14_adcdata=load('/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/mixing_staining/1-18-14/D20140118T055745_IFCB014.adc');

IFCB_14_ciliate_roi_ind=find(~isnan(classlist(:,4)));
gyro_ind=find(classlist(:,2)==36);
ciliate_ratio=IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,4)./IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,5);
ciliate_ratio=ciliate_ratio';
ciliate_ratio_2=[ciliate_ratio_2 ciliate_ratio];

gyro_ratio= IFCB_14_adcdata(gyro_ind,4)./IFCB_14_adcdata(gyro_ind,5);
gyro_ratio=gyro_ratio';
gyro_ratio_2=[gyro_ratio_2; gyro_ratio];

other_ratio= IFCB_14_adcdata(:,4)./IFCB_14_adcdata(:,5);
%other_ratio=other_ratio;
other_ratio_2=[other_ratio_2; other_ratio];



load '/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/mixing_staining/1-18-14/results/normal/D20140118T050753_IFCB014.mat'
IFCB_14_adcdata=load('/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/mixing_staining/1-18-14/D20140118T050753_IFCB014.adc');

IFCB_14_ciliate_roi_ind=find(~isnan(classlist(:,4)));
gyro_ind=find(classlist(:,2)==36);
ciliate_ratio=IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,4)./IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,5);
ciliate_ratio=ciliate_ratio';
ciliate_ratio_2=[ciliate_ratio_2 ciliate_ratio];

gyro_ratio= IFCB_14_adcdata(gyro_ind,4)./IFCB_14_adcdata(gyro_ind,5);
gyro_ratio=gyro_ratio';
gyro_ratio_2=[gyro_ratio_2; gyro_ratio];

other_ratio= IFCB_14_adcdata(:,4)./IFCB_14_adcdata(:,5);
%other_ratio=other_ratio;
other_ratio_2=[other_ratio_2; other_ratio];

load '/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/mixing_staining/1-18-14/results/normal/D20140118T064737_IFCB014.mat'
IFCB_14_adcdata=load('/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/mixing_staining/1-18-14/D20140118T064737_IFCB014.adc');

IFCB_14_ciliate_roi_ind=find(~isnan(classlist(:,4)));
gyro_ind=find(classlist(:,2)==36);
ciliate_ratio=IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,4)./IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,5);
ciliate_ratio=ciliate_ratio';
ciliate_ratio_2=[ciliate_ratio_2 ciliate_ratio];

gyro_ratio= IFCB_14_adcdata(gyro_ind,4)./IFCB_14_adcdata(gyro_ind,5);
gyro_ratio=gyro_ratio';
gyro_ratio_2=[gyro_ratio_2; gyro_ratio];

other_ratio= IFCB_14_adcdata(:,4)./IFCB_14_adcdata(:,5);
%other_ratio=other_ratio;
other_ratio_2=[other_ratio_2; other_ratio];

load '/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/mixing_staining/1-18-14/results/normal/D20140118T073727_IFCB014.mat'
IFCB_14_adcdata=load('/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/mixing_staining/1-18-14/D20140118T073727_IFCB014.adc');

IFCB_14_ciliate_roi_ind=find(~isnan(classlist(:,4)));
gyro_ind=find(classlist(:,2)==36);
ciliate_ratio=IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,4)./IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,5);
ciliate_ratio=ciliate_ratio';
ciliate_ratio_2=[ciliate_ratio_2 ciliate_ratio];

gyro_ratio= IFCB_14_adcdata(gyro_ind,4)./IFCB_14_adcdata(gyro_ind,5);
gyro_ratio=gyro_ratio';
gyro_ratio_2=[gyro_ratio_2; gyro_ratio];

other_ratio= IFCB_14_adcdata(:,4)./IFCB_14_adcdata(:,5);
%other_ratio=other_ratio;
other_ratio_2=[other_ratio_2; other_ratio];

% load '/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/mixing_staining/1-18-14/results/normal/D20140118T080105_IFCB014.mat'
% IFCB_14_adcdata=load('/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/mixing_staining/1-18-14/D20140118T080105_IFCB014.adc');
% 
% IFCB_14_ciliate_roi_ind=find(~isnan(classlist(:,4)));
% gyro_ind=find(classlist(:,2)==36);
% ciliate_ratio=IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,4)./IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,5);
% ciliate_ratio=ciliate_ratio';
% ciliate_ratio_2=[ciliate_ratio_2 ciliate_ratio];
% 
% gyro_ratio= IFCB_14_adcdata(gyro_ind,4)./IFCB_14_adcdata(gyro_ind,5);
% gyro_ratio=gyro_ratio';
% gyro_ratio_2=[gyro_ratio_2; gyro_ratio];
% 
% other_ratio= IFCB_14_adcdata(:,4)./IFCB_14_adcdata(:,5);
% %other_ratio=other_ratio;
% other_ratio_2=[other_ratio_2; other_ratio];

load '/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/mixing_staining/1-18-14/results/normal/D20140118T091708_IFCB014.mat'
IFCB_14_adcdata=load('/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/mixing_staining/1-18-14/D20140118T091708_IFCB014.adc');

IFCB_14_ciliate_roi_ind=find(~isnan(classlist(:,4)));
gyro_ind=find(classlist(:,2)==36);
ciliate_ratio=IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,4)./IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,5);
ciliate_ratio=ciliate_ratio';
ciliate_ratio_2=[ciliate_ratio_2 ciliate_ratio];

gyro_ratio= IFCB_14_adcdata(gyro_ind,4)./IFCB_14_adcdata(gyro_ind,5);
gyro_ratio=gyro_ratio';
gyro_ratio_2=[gyro_ratio_2; gyro_ratio];

other_ratio= IFCB_14_adcdata(:,4)./IFCB_14_adcdata(:,5);
%other_ratio=other_ratio;
other_ratio_2=[other_ratio_2; other_ratio];

load '/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/mixing_staining/1-18-14/results/normal/D20140118T100700_IFCB014.mat'
IFCB_14_adcdata=load('/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/mixing_staining/1-18-14/D20140118T100700_IFCB014.adc');

IFCB_14_ciliate_roi_ind=find(~isnan(classlist(:,4)));
gyro_ind=find(classlist(:,2)==36);
ciliate_ratio=IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,4)./IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,5);
ciliate_ratio=ciliate_ratio';
ciliate_ratio_2=[ciliate_ratio_2 ciliate_ratio];

gyro_ratio= IFCB_14_adcdata(gyro_ind,4)./IFCB_14_adcdata(gyro_ind,5);
gyro_ratio=gyro_ratio';
gyro_ratio_2=[gyro_ratio_2; gyro_ratio];

other_ratio= IFCB_14_adcdata(:,4)./IFCB_14_adcdata(:,5);
%other_ratio=other_ratio;
other_ratio_2=[other_ratio_2; other_ratio];

load '/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/mixing_staining/1-18-14/results/normal/D20140118T105650_IFCB014.mat'
IFCB_14_adcdata=load('/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/mixing_staining/1-18-14/D20140118T105650_IFCB014.adc');

IFCB_14_ciliate_roi_ind=find(~isnan(classlist(:,4)));
gyro_ind=find(classlist(:,2)==36);
ciliate_ratio=IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,4)./IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,5);
ciliate_ratio=ciliate_ratio';
ciliate_ratio_2=[ciliate_ratio_2 ciliate_ratio];

gyro_ratio= IFCB_14_adcdata(gyro_ind,4)./IFCB_14_adcdata(gyro_ind,5);
gyro_ratio=gyro_ratio';
gyro_ratio_2=[gyro_ratio_2; gyro_ratio];

other_ratio= IFCB_14_adcdata(:,4)./IFCB_14_adcdata(:,5);
%other_ratio=other_ratio;
other_ratio_2=[other_ratio_2; other_ratio];

load '/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/mixing_staining/1-18-14/results/normal/D20140118T105650_IFCB014.mat'
IFCB_14_adcdata=load('/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/mixing_staining/1-18-14/D20140118T105650_IFCB014.adc');

IFCB_14_ciliate_roi_ind=find(~isnan(classlist(:,4)));
gyro_ind=find(classlist(:,2)==36);
ciliate_ratio=IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,4)./IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,5);
ciliate_ratio=ciliate_ratio';
ciliate_ratio_2=[ciliate_ratio_2 ciliate_ratio];

gyro_ratio= IFCB_14_adcdata(gyro_ind,4)./IFCB_14_adcdata(gyro_ind,5);
gyro_ratio=gyro_ratio';
gyro_ratio_2=[gyro_ratio_2; gyro_ratio];

other_ratio= IFCB_14_adcdata(:,4)./IFCB_14_adcdata(:,5);
%other_ratio=other_ratio;
other_ratio_2=[other_ratio_2; other_ratio];

load '/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/mixing_staining/1-18-14/results/normal/D20140118T114640_IFCB014.mat'
IFCB_14_adcdata=load('/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/mixing_staining/1-18-14/D20140118T114640_IFCB014.adc');

IFCB_14_ciliate_roi_ind=find(~isnan(classlist(:,4)));
gyro_ind=find(classlist(:,2)==36);
ciliate_ratio=IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,4)./IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,5);
ciliate_ratio=ciliate_ratio';
ciliate_ratio_2=[ciliate_ratio_2 ciliate_ratio];

gyro_ratio= IFCB_14_adcdata(gyro_ind,4)./IFCB_14_adcdata(gyro_ind,5);
gyro_ratio=gyro_ratio';
gyro_ratio_2=[gyro_ratio_2; gyro_ratio];

other_ratio= IFCB_14_adcdata(:,4)./IFCB_14_adcdata(:,5);
%other_ratio=other_ratio;
other_ratio_2=[other_ratio_2; other_ratio];

load '/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/mixing_staining/1-18-14/results/normal/D20140118T114640_IFCB014.mat'
IFCB_14_adcdata=load('/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/mixing_staining/1-18-14/D20140118T114640_IFCB014.adc');

IFCB_14_ciliate_roi_ind=find(~isnan(classlist(:,4)));
gyro_ind=find(classlist(:,2)==36);
ciliate_ratio=IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,4)./IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,5);
ciliate_ratio=ciliate_ratio';
ciliate_ratio_2=[ciliate_ratio_2 ciliate_ratio];

gyro_ratio= IFCB_14_adcdata(gyro_ind,4)./IFCB_14_adcdata(gyro_ind,5);
gyro_ratio=gyro_ratio';
gyro_ratio_2=[gyro_ratio_2; gyro_ratio];

other_ratio= IFCB_14_adcdata(:,4)./IFCB_14_adcdata(:,5);
%other_ratio=other_ratio;
other_ratio_2=[other_ratio_2; other_ratio];

load '/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/mixing_staining/1-18-14/results/normal/D20140118T123629_IFCB014.mat'
IFCB_14_adcdata=load('/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/mixing_staining/1-18-14/D20140118T123629_IFCB014.adc');

IFCB_14_ciliate_roi_ind=find(~isnan(classlist(:,4)));
gyro_ind=find(classlist(:,2)==36);
ciliate_ratio=IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,4)./IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,5);
ciliate_ratio=ciliate_ratio';
ciliate_ratio_2=[ciliate_ratio_2 ciliate_ratio];

gyro_ratio= IFCB_14_adcdata(gyro_ind,4)./IFCB_14_adcdata(gyro_ind,5);
gyro_ratio=gyro_ratio';
gyro_ratio_2=[gyro_ratio_2; gyro_ratio];

other_ratio= IFCB_14_adcdata(:,4)./IFCB_14_adcdata(:,5);
%other_ratio=other_ratio;
other_ratio_2=[other_ratio_2; other_ratio];

load '/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/mixing_staining/1-18-14/results/normal/D20140118T132618_IFCB014.mat'
IFCB_14_adcdata=load('/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/mixing_staining/1-18-14/D20140118T132618_IFCB014.adc');

IFCB_14_ciliate_roi_ind=find(~isnan(classlist(:,4)));
gyro_ind=find(classlist(:,2)==36);
ciliate_ratio=IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,4)./IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,5);
ciliate_ratio=ciliate_ratio';
ciliate_ratio_2=[ciliate_ratio_2 ciliate_ratio];

gyro_ratio= IFCB_14_adcdata(gyro_ind,4)./IFCB_14_adcdata(gyro_ind,5);
gyro_ratio=gyro_ratio';
gyro_ratio_2=[gyro_ratio_2; gyro_ratio];

other_ratio= IFCB_14_adcdata(:,4)./IFCB_14_adcdata(:,5);
%other_ratio=other_ratio;
other_ratio_2=[other_ratio_2; other_ratio];

load '/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/mixing_staining/1-18-14/results/normal/D20140118T141608_IFCB014.mat'
IFCB_14_adcdata=load('/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/mixing_staining/1-18-14/D20140118T141608_IFCB014.adc');

IFCB_14_ciliate_roi_ind=find(~isnan(classlist(:,4)));
gyro_ind=find(classlist(:,2)==36);
ciliate_ratio=IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,4)./IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,5);
ciliate_ratio=ciliate_ratio';
ciliate_ratio_2=[ciliate_ratio_2 ciliate_ratio];

gyro_ratio= IFCB_14_adcdata(gyro_ind,4)./IFCB_14_adcdata(gyro_ind,5);
gyro_ratio=gyro_ratio';
gyro_ratio_2=[gyro_ratio_2; gyro_ratio];

other_ratio= IFCB_14_adcdata(:,4)./IFCB_14_adcdata(:,5);
%other_ratio=other_ratio;
other_ratio_2=[other_ratio_2; other_ratio];

load '/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/mixing_staining/1-18-14/results/normal/D20140118T150557_IFCB014.mat'
IFCB_14_adcdata=load('/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/mixing_staining/1-18-14/D20140118T150557_IFCB014.adc');

IFCB_14_ciliate_roi_ind=find(~isnan(classlist(:,4)));
gyro_ind=find(classlist(:,2)==36);
ciliate_ratio=IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,4)./IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,5);
ciliate_ratio=ciliate_ratio';
ciliate_ratio_2=[ciliate_ratio_2 ciliate_ratio];

gyro_ratio= IFCB_14_adcdata(gyro_ind,4)./IFCB_14_adcdata(gyro_ind,5);
gyro_ratio=gyro_ratio';
gyro_ratio_2=[gyro_ratio_2; gyro_ratio];

other_ratio= IFCB_14_adcdata(:,4)./IFCB_14_adcdata(:,5);
%other_ratio=other_ratio;
other_ratio_2=[other_ratio_2; other_ratio];

load '/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/mixing_staining/1-18-14/results/normal/D20140118T155548_IFCB014.mat'
IFCB_14_adcdata=load('/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/mixing_staining/1-18-14/D20140118T155548_IFCB014.adc');

IFCB_14_ciliate_roi_ind=find(~isnan(classlist(:,4)));
gyro_ind=find(classlist(:,2)==36);
ciliate_ratio=IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,4)./IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,5);
ciliate_ratio=ciliate_ratio';
ciliate_ratio_2=[ciliate_ratio_2 ciliate_ratio];

gyro_ratio= IFCB_14_adcdata(gyro_ind,4)./IFCB_14_adcdata(gyro_ind,5);
gyro_ratio=gyro_ratio';
gyro_ratio_2=[gyro_ratio_2; gyro_ratio];

other_ratio= IFCB_14_adcdata(:,4)./IFCB_14_adcdata(:,5);
%other_ratio=other_ratio;
other_ratio_2=[other_ratio_2; other_ratio];

load '/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/mixing_staining/1-18-14/results/normal/D20140118T164540_IFCB014.mat'
IFCB_14_adcdata=load('/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/mixing_staining/1-18-14/D20140118T164540_IFCB014.adc');

IFCB_14_ciliate_roi_ind=find(~isnan(classlist(:,4)));
gyro_ind=find(classlist(:,2)==36);
ciliate_ratio=IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,4)./IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,5);
ciliate_ratio=ciliate_ratio';
ciliate_ratio_2=[ciliate_ratio_2 ciliate_ratio];

gyro_ratio= IFCB_14_adcdata(gyro_ind,4)./IFCB_14_adcdata(gyro_ind,5);
gyro_ratio=gyro_ratio';
gyro_ratio_2=[gyro_ratio_2; gyro_ratio];

other_ratio= IFCB_14_adcdata(:,4)./IFCB_14_adcdata(:,5);
%other_ratio=other_ratio;
other_ratio_2=[other_ratio_2; other_ratio];


diambins=[0:0.5:20];
% figure
% hist(ciliate_ratio_2,diambins)
% 
% figure
% rng(0,'twister')
% hist(ratio_2,diambins)
% h = findobj(gca,'Type','patch');
% set(h,'FaceColor',[0 .5 .5],'EdgeColor','w')

%%
figure
title('PE-Spring')
[nb_1,xb_1]=hist(other_ratio_2,diambins);
[nb_2,xb_2]=hist(gyro_ratio_2,diambins);
[nb_3,xb_3]=hist(ciliate_ratio_2,diambins);
subplot(3,1,1)
bh_1=bar(xb_1,nb_1);
set(bh_1,'facecolor',[1 1 0]);
legend('all')
subplot(3,1,2)
bh_3=bar(xb_3,nb_3);
set(bh_3,'facecolor',[1 0 0]);
legend('ciliate')
subplot(3,1,3)
bh_2=bar(xb_2,nb_2);
set(bh_2,'facecolor',[0 1 0]);
legend('gyro')











