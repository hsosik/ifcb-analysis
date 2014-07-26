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

ciliate_ratio=IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,4)./IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,5);
ciliate_ratio=ciliate_ratio';
ciliate_ratio_2=[ciliate_ratio_2 ciliate_ratio];

gyro_ratio= IFCB_14_adcdata(gyro_ind,4)./IFCB_14_adcdata(gyro_ind,5);
%gyro_ratio=gyro_ratio';
gyro_ratio_2=[gyro_ratio_2 gyro_ratio];

other_ratio= IFCB_14_adcdata(:,4)./IFCB_14_adcdata(:,5);
%other_ratio=other_ratio;
other_ratio_2=[other_ratio_2; other_ratio];

load '/Users/markmiller/Documents/Experiments/IFCB_14/Microscopy_vs_Imager/5-11-14/Manual_fromClass/D20140511T142939_IFCB014.mat'
IFCB_14_adcdata=load('/Users/markmiller/Documents/Experiments/IFCB_14/Microscopy_vs_Imager/5-11-14/D20140511T142939_IFCB014.adc');


IFCB_14_ciliate_roi_ind=find(~isnan(classlist(:,4)));

ciliate_ratio=IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,4)./IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,5);
ciliate_ratio=ciliate_ratio';
ciliate_ratio_2=[ciliate_ratio_2 ciliate_ratio];

gyro_ratio= IFCB_14_adcdata(gyro_ind,4)./IFCB_14_adcdata(gyro_ind,5);
%gyro_ratio=gyro_ratio';
gyro_ratio_2=[gyro_ratio_2 gyro_ratio];

other_ratio= IFCB_14_adcdata(:,4)./IFCB_14_adcdata(:,5);
%other_ratio=other_ratio;
other_ratio_2=[other_ratio_2; other_ratio];

load '/Users/markmiller/Documents/Experiments/IFCB_14/Microscopy_vs_Imager/5-11-14/Manual_fromClass/D20140511T152143_IFCB014.mat'
IFCB_14_adcdata=load('/Users/markmiller/Documents/Experiments/IFCB_14/Microscopy_vs_Imager/5-11-14/D20140511T152143_IFCB014.adc');


IFCB_14_ciliate_roi_ind=find(~isnan(classlist(:,4)));

ciliate_ratio=IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,4)./IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,5);
ciliate_ratio=ciliate_ratio';
ciliate_ratio_2=[ciliate_ratio_2 ciliate_ratio];

gyro_ratio= IFCB_14_adcdata(gyro_ind,4)./IFCB_14_adcdata(gyro_ind,5);
%gyro_ratio=gyro_ratio';
gyro_ratio_2=[gyro_ratio_2 gyro_ratio];

other_ratio= IFCB_14_adcdata(:,4)./IFCB_14_adcdata(:,5);
%other_ratio=other_ratio;
other_ratio_2=[other_ratio_2; other_ratio];

load '/Users/markmiller/Documents/Experiments/IFCB_14/Microscopy_vs_Imager/5-11-14/Manual_fromClass/D20140511T161218_IFCB014.mat'
IFCB_14_adcdata=load('/Users/markmiller/Documents/Experiments/IFCB_14/Microscopy_vs_Imager/5-11-14/D20140511T161218_IFCB014.adc');

IFCB_14_ciliate_roi_ind=find(~isnan(classlist(:,4)));

ciliate_ratio=IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,4)./IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,5);
ciliate_ratio=ciliate_ratio';
ciliate_ratio_2=[ciliate_ratio_2 ciliate_ratio];

gyro_ratio= IFCB_14_adcdata(gyro_ind,4)./IFCB_14_adcdata(gyro_ind,5);
%gyro_ratio=gyro_ratio';
gyro_ratio_2=[gyro_ratio_2 gyro_ratio];

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
load '/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/Dinos_stained_unstained/2-1-14/Manual_fromClass/D20140201T052229_IFCB014.mat'
IFCB_14_adcdata=load ('/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/Dinos_stained_unstained/2-1-14/D20140201T052229_IFCB014.adc');

IFCB_14_ciliate_roi_ind=find(~isnan(classlist(:,4)));
gyro_ind=find(classlist(:,2)==36);
other_ind=find(classlist(:,2)==46);
% ans=classlist(:,2);
% other_ind=find(isnan(ans));
% other_ind_1=find(classlist(:,2)==32);
% other_ind_2=[other_ind; other_ind_1];
ciliate_ratio_2=IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,4)./IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,5);
ciliate_ratio_2=ciliate_ratio_2';
gyro_ratio_2=IFCB_14_adcdata(gyro_ind,4)./IFCB_14_adcdata(gyro_ind,5);
other_ratio_2=IFCB_14_adcdata(other_ind,4)./IFCB_14_adcdata(other_ind,5);

load '/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/Dinos_stained_unstained/2-1-14/Manual_fromClass/D20140201T061221_IFCB014.mat'
IFCB_14_adcdata=load ('/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/Dinos_stained_unstained/2-1-14/D20140201T061221_IFCB014.adc');

IFCB_14_ciliate_roi_ind=find(~isnan(classlist(:,4)));
gyro_ind=find(classlist(:,2)==36);
other_ind=find(classlist(:,2)==46);
ciliate_ratio=IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,4)./IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,5);
ciliate_ratio=ciliate_ratio';
ciliate_ratio_2=[ciliate_ratio_2 ciliate_ratio];

gyro_ratio= IFCB_14_adcdata(gyro_ind,4)./IFCB_14_adcdata(gyro_ind,5);
%gyro_ratio=gyro_ratio';
gyro_ratio_2=[gyro_ratio_2; gyro_ratio];

other_ratio= IFCB_14_adcdata(other_ind,4)./IFCB_14_adcdata(other_ind,5);
%other_ratio=other_ratio;
other_ratio_2=[other_ratio_2; other_ratio];

load '/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/Dinos_stained_unstained/2-1-14/Manual_fromClass/D20140201T070213_IFCB014.mat'
IFCB_14_adcdata=load ('/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/Dinos_stained_unstained/2-1-14/D20140201T070213_IFCB014.adc');

IFCB_14_ciliate_roi_ind=find(~isnan(classlist(:,4)));
gyro_ind=find(classlist(:,2)==36);
other_ind=find(classlist(:,2)==46);
ciliate_ratio=IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,4)./IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,5);
ciliate_ratio=ciliate_ratio';
ciliate_ratio_2=[ciliate_ratio_2 ciliate_ratio];

gyro_ratio= IFCB_14_adcdata(gyro_ind,4)./IFCB_14_adcdata(gyro_ind,5);
%gyro_ratio=gyro_ratio';
gyro_ratio_2=[gyro_ratio_2; gyro_ratio];

other_ratio= IFCB_14_adcdata(other_ind,4)./IFCB_14_adcdata(other_ind,5);
%other_ratio=other_ratio;
other_ratio_2=[other_ratio_2; other_ratio];

load '/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/Dinos_stained_unstained/2-1-14/Manual_fromClass/D20140201T075205_IFCB014.mat'
IFCB_14_adcdata=load ('/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/Dinos_stained_unstained/2-1-14/D20140201T075205_IFCB014.adc');

IFCB_14_ciliate_roi_ind=find(~isnan(classlist(:,4)));
gyro_ind=find(classlist(:,2)==36);
other_ind=find(classlist(:,2)==46);
ciliate_ratio=IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,4)./IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,5);
ciliate_ratio=ciliate_ratio';
ciliate_ratio_2=[ciliate_ratio_2 ciliate_ratio];

gyro_ratio= IFCB_14_adcdata(gyro_ind,4)./IFCB_14_adcdata(gyro_ind,5);
%gyro_ratio=gyro_ratio';
gyro_ratio_2=[gyro_ratio_2; gyro_ratio];

other_ratio= IFCB_14_adcdata(other_ind,4)./IFCB_14_adcdata(other_ind,5);
%other_ratio=other_ratio;
other_ratio_2=[other_ratio_2; other_ratio];

load '/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/Dinos_stained_unstained/2-1-14/Manual_fromClass/D20140201T084157_IFCB014.mat'
IFCB_14_adcdata=load ('/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/Dinos_stained_unstained/2-1-14/D20140201T084157_IFCB014.adc');

IFCB_14_ciliate_roi_ind=find(~isnan(classlist(:,4)));
gyro_ind=find(classlist(:,2)==36);
other_ind=find(classlist(:,2)==46);
ciliate_ratio=IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,4)./IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,5);
ciliate_ratio=ciliate_ratio';
ciliate_ratio_2=[ciliate_ratio_2 ciliate_ratio];

gyro_ratio= IFCB_14_adcdata(gyro_ind,4)./IFCB_14_adcdata(gyro_ind,5);
%gyro_ratio=gyro_ratio';
gyro_ratio_2=[gyro_ratio_2; gyro_ratio];

other_ratio= IFCB_14_adcdata(other_ind,4)./IFCB_14_adcdata(other_ind,5);
%other_ratio=other_ratio;
other_ratio_2=[other_ratio_2; other_ratio];

load '/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/Dinos_stained_unstained/2-1-14/Manual_fromClass/D20140201T093148_IFCB014.mat'
IFCB_14_adcdata=load ('/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/Dinos_stained_unstained/2-1-14/D20140201T093148_IFCB014.adc');

IFCB_14_ciliate_roi_ind=find(~isnan(classlist(:,4)));
gyro_ind=find(classlist(:,2)==36);
other_ind=find(classlist(:,2)==46);
ciliate_ratio=IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,4)./IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,5);
ciliate_ratio=ciliate_ratio';
ciliate_ratio_2=[ciliate_ratio_2 ciliate_ratio];

gyro_ratio= IFCB_14_adcdata(gyro_ind,4)./IFCB_14_adcdata(gyro_ind,5);
%gyro_ratio=gyro_ratio';
gyro_ratio_2=[gyro_ratio_2; gyro_ratio];

other_ratio= IFCB_14_adcdata(other_ind,4)./IFCB_14_adcdata(other_ind,5);
%other_ratio=other_ratio;
other_ratio_2=[other_ratio_2; other_ratio];

load '/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/Dinos_stained_unstained/2-1-14/Manual_fromClass/D20140201T102140_IFCB014.mat'
IFCB_14_adcdata=load ('/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/Dinos_stained_unstained/2-1-14/D20140201T102140_IFCB014.adc');

IFCB_14_ciliate_roi_ind=find(~isnan(classlist(:,4)));
gyro_ind=find(classlist(:,2)==36);
other_ind=find(classlist(:,2)==46);
ciliate_ratio=IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,4)./IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,5);
ciliate_ratio=ciliate_ratio';
ciliate_ratio_2=[ciliate_ratio_2 ciliate_ratio];

gyro_ratio= IFCB_14_adcdata(gyro_ind,4)./IFCB_14_adcdata(gyro_ind,5);
%gyro_ratio=gyro_ratio';
gyro_ratio_2=[gyro_ratio_2; gyro_ratio];

other_ratio= IFCB_14_adcdata(other_ind,4)./IFCB_14_adcdata(other_ind,5);
%other_ratio=other_ratio;
other_ratio_2=[other_ratio_2; other_ratio];

load '/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/Dinos_stained_unstained/2-1-14/Manual_fromClass/D20140201T111133_IFCB014.mat'
IFCB_14_adcdata=load ('/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/Dinos_stained_unstained/2-1-14/D20140201T111133_IFCB014.adc');

IFCB_14_ciliate_roi_ind=find(~isnan(classlist(:,4)));
gyro_ind=find(classlist(:,2)==36);
other_ind=find(classlist(:,2)==46);
ciliate_ratio=IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,4)./IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,5);
ciliate_ratio=ciliate_ratio';
ciliate_ratio_2=[ciliate_ratio_2 ciliate_ratio];

gyro_ratio= IFCB_14_adcdata(gyro_ind,4)./IFCB_14_adcdata(gyro_ind,5);
%gyro_ratio=gyro_ratio';
gyro_ratio_2=[gyro_ratio_2; gyro_ratio];

other_ratio= IFCB_14_adcdata(other_ind,4)./IFCB_14_adcdata(other_ind,5);
%other_ratio=other_ratio;
other_ratio_2=[other_ratio_2; other_ratio];

load '/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/Dinos_stained_unstained/2-1-14/Manual_fromClass/D20140201T120124_IFCB014.mat'
IFCB_14_adcdata=load ('/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/Dinos_stained_unstained/2-1-14/D20140201T120124_IFCB014.adc');

IFCB_14_ciliate_roi_ind=find(~isnan(classlist(:,4)));
gyro_ind=find(classlist(:,2)==36);
other_ind=find(classlist(:,2)==46);
ciliate_ratio=IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,4)./IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,5);
ciliate_ratio=ciliate_ratio';
ciliate_ratio_2=[ciliate_ratio_2 ciliate_ratio];

gyro_ratio= IFCB_14_adcdata(gyro_ind,4)./IFCB_14_adcdata(gyro_ind,5);
%gyro_ratio=gyro_ratio';
gyro_ratio_2=[gyro_ratio_2; gyro_ratio];

other_ratio= IFCB_14_adcdata(other_ind,4)./IFCB_14_adcdata(other_ind,5);
%other_ratio=other_ratio;
other_ratio_2=[other_ratio_2; other_ratio];

load '/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/Dinos_stained_unstained/2-1-14/Manual_fromClass/D20140201T125116_IFCB014.mat'
IFCB_14_adcdata=load ('/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/Dinos_stained_unstained/2-1-14/D20140201T125116_IFCB014.adc');

IFCB_14_ciliate_roi_ind=find(~isnan(classlist(:,4)));
gyro_ind=find(classlist(:,2)==36);
other_ind=find(classlist(:,2)==46);
ciliate_ratio=IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,4)./IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,5);
ciliate_ratio=ciliate_ratio';
ciliate_ratio_2=[ciliate_ratio_2 ciliate_ratio];

gyro_ratio= IFCB_14_adcdata(gyro_ind,4)./IFCB_14_adcdata(gyro_ind,5);
%gyro_ratio=gyro_ratio';
gyro_ratio_2=[gyro_ratio_2; gyro_ratio];

other_ratio= IFCB_14_adcdata(other_ind,4)./IFCB_14_adcdata(other_ind,5);
%other_ratio=other_ratio;
other_ratio_2=[other_ratio_2; other_ratio];

load '/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/Dinos_stained_unstained/2-1-14/Manual_fromClass/D20140201T134108_IFCB014.mat'
IFCB_14_adcdata=load ('/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/Dinos_stained_unstained/2-1-14/D20140201T134108_IFCB014.adc');

IFCB_14_ciliate_roi_ind=find(~isnan(classlist(:,4)));
gyro_ind=find(classlist(:,2)==36);
other_ind=find(classlist(:,2)==46);
ciliate_ratio=IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,4)./IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,5);
ciliate_ratio=ciliate_ratio';
ciliate_ratio_2=[ciliate_ratio_2 ciliate_ratio];

gyro_ratio= IFCB_14_adcdata(gyro_ind,4)./IFCB_14_adcdata(gyro_ind,5);
%gyro_ratio=gyro_ratio';
gyro_ratio_2=[gyro_ratio_2; gyro_ratio];

other_ratio= IFCB_14_adcdata(other_ind,4)./IFCB_14_adcdata(other_ind,5);
%other_ratio=other_ratio;
other_ratio_2=[other_ratio_2; other_ratio];


load '/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/Dinos_stained_unstained/2-1-14/Manual_fromClass/D20140201T143100_IFCB014.mat'
IFCB_14_adcdata=load ('/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/Dinos_stained_unstained/2-1-14/D20140201T143100_IFCB014.adc');

IFCB_14_ciliate_roi_ind=find(~isnan(classlist(:,4)));
gyro_ind=find(classlist(:,2)==36);
other_ind=find(classlist(:,2)==46);
ciliate_ratio=IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,4)./IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,5);
ciliate_ratio=ciliate_ratio';
ciliate_ratio_2=[ciliate_ratio_2 ciliate_ratio];

gyro_ratio= IFCB_14_adcdata(gyro_ind,4)./IFCB_14_adcdata(gyro_ind,5);
%gyro_ratio=gyro_ratio';
gyro_ratio_2=[gyro_ratio_2; gyro_ratio];

other_ratio= IFCB_14_adcdata(other_ind,4)./IFCB_14_adcdata(other_ind,5);
%other_ratio=other_ratio;
other_ratio_2=[other_ratio_2; other_ratio];

load '/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/Dinos_stained_unstained/2-1-14/Manual_fromClass/D20140201T152052_IFCB014.mat'
IFCB_14_adcdata=load ('/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/Dinos_stained_unstained/2-1-14/D20140201T152052_IFCB014.adc');

IFCB_14_ciliate_roi_ind=find(~isnan(classlist(:,4)));
gyro_ind=find(classlist(:,2)==36);
other_ind=find(classlist(:,2)==46);
ciliate_ratio=IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,4)./IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,5);
ciliate_ratio=ciliate_ratio';
ciliate_ratio_2=[ciliate_ratio_2 ciliate_ratio];

gyro_ratio= IFCB_14_adcdata(gyro_ind,4)./IFCB_14_adcdata(gyro_ind,5);
%gyro_ratio=gyro_ratio';
gyro_ratio_2=[gyro_ratio_2; gyro_ratio];

other_ratio= IFCB_14_adcdata(other_ind,4)./IFCB_14_adcdata(other_ind,5);
%other_ratio=other_ratio;
other_ratio_2=[other_ratio_2; other_ratio];

load '/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/Dinos_stained_unstained/2-1-14/Manual_fromClass/D20140201T161044_IFCB014.mat'
IFCB_14_adcdata=load ('/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/Dinos_stained_unstained/2-1-14/D20140201T161044_IFCB014.adc');

IFCB_14_ciliate_roi_ind=find(~isnan(classlist(:,4)));
gyro_ind=find(classlist(:,2)==36);
other_ind=find(classlist(:,2)==46);
ciliate_ratio=IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,4)./IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,5);
ciliate_ratio=ciliate_ratio';
ciliate_ratio_2=[ciliate_ratio_2 ciliate_ratio];

gyro_ratio= IFCB_14_adcdata(gyro_ind,4)./IFCB_14_adcdata(gyro_ind,5);
%gyro_ratio=gyro_ratio';
gyro_ratio_2=[gyro_ratio_2; gyro_ratio];

other_ratio= IFCB_14_adcdata(other_ind,4)./IFCB_14_adcdata(other_ind,5);
%other_ratio=other_ratio;
other_ratio_2=[other_ratio_2; other_ratio];


load '/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/Dinos_stained_unstained/2-1-14/Manual_fromClass/D20140201T170036_IFCB014.mat'
IFCB_14_adcdata=load ('/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/Dinos_stained_unstained/2-1-14/D20140201T170036_IFCB014.adc');

IFCB_14_ciliate_roi_ind=find(~isnan(classlist(:,4)));
gyro_ind=find(classlist(:,2)==36);
other_ind=find(classlist(:,2)==46);
ciliate_ratio=IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,4)./IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,5);
ciliate_ratio=ciliate_ratio';
ciliate_ratio_2=[ciliate_ratio_2 ciliate_ratio];

gyro_ratio= IFCB_14_adcdata(gyro_ind,4)./IFCB_14_adcdata(gyro_ind,5);
%gyro_ratio=gyro_ratio';
gyro_ratio_2=[gyro_ratio_2; gyro_ratio];

other_ratio= IFCB_14_adcdata(other_ind,4)./IFCB_14_adcdata(other_ind,5);
%other_ratio=other_ratio;
other_ratio_2=[other_ratio_2; other_ratio];

load '/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/Dinos_stained_unstained/2-1-14/Manual_fromClass/D20140201T175027_IFCB014.mat'
IFCB_14_adcdata=load ('/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/Dinos_stained_unstained/2-1-14/D20140201T175027_IFCB014.adc');

IFCB_14_ciliate_roi_ind=find(~isnan(classlist(:,4)));
gyro_ind=find(classlist(:,2)==36);
other_ind=find(classlist(:,2)==46);
ciliate_ratio=IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,4)./IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,5);
ciliate_ratio=ciliate_ratio';
ciliate_ratio_2=[ciliate_ratio_2 ciliate_ratio];

gyro_ratio= IFCB_14_adcdata(gyro_ind,4)./IFCB_14_adcdata(gyro_ind,5);
%gyro_ratio=gyro_ratio';
gyro_ratio_2=[gyro_ratio_2; gyro_ratio];

other_ratio= IFCB_14_adcdata(other_ind,4)./IFCB_14_adcdata(other_ind,5);
%other_ratio=other_ratio;
other_ratio_2=[other_ratio_2; other_ratio];

load '/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/Dinos_stained_unstained/2-1-14/Manual_fromClass/D20140201T184019_IFCB014.mat'
IFCB_14_adcdata=load ('/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/Dinos_stained_unstained/2-1-14/D20140201T184019_IFCB014.adc');

IFCB_14_ciliate_roi_ind=find(~isnan(classlist(:,4)));
gyro_ind=find(classlist(:,2)==36);
other_ind=find(classlist(:,2)==46);
ciliate_ratio=IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,4)./IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,5);
ciliate_ratio=ciliate_ratio';
ciliate_ratio_2=[ciliate_ratio_2 ciliate_ratio];

gyro_ratio= IFCB_14_adcdata(gyro_ind,4)./IFCB_14_adcdata(gyro_ind,5);
%gyro_ratio=gyro_ratio';
gyro_ratio_2=[gyro_ratio_2; gyro_ratio];

other_ratio= IFCB_14_adcdata(other_ind,4)./IFCB_14_adcdata(other_ind,5);
%other_ratio=other_ratio;
other_ratio_2=[other_ratio_2; other_ratio];

load '/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/Dinos_stained_unstained/2-1-14/Manual_fromClass/D20140201T193011_IFCB014.mat'
IFCB_14_adcdata=load ('/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/Dinos_stained_unstained/2-1-14/D20140201T193011_IFCB014.adc');

IFCB_14_ciliate_roi_ind=find(~isnan(classlist(:,4)));
gyro_ind=find(classlist(:,2)==36);
other_ind=find(classlist(:,2)==46);
ciliate_ratio=IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,4)./IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,5);
ciliate_ratio=ciliate_ratio';
ciliate_ratio_2=[ciliate_ratio_2 ciliate_ratio];

gyro_ratio= IFCB_14_adcdata(gyro_ind,4)./IFCB_14_adcdata(gyro_ind,5);
%gyro_ratio=gyro_ratio';
gyro_ratio_2=[gyro_ratio_2; gyro_ratio];

other_ratio= IFCB_14_adcdata(other_ind,4)./IFCB_14_adcdata(other_ind,5);
%other_ratio=other_ratio;
other_ratio_2=[other_ratio_2; other_ratio];

load '/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/Dinos_stained_unstained/2-1-14/Manual_fromClass/D20140201T202002_IFCB014.mat'
IFCB_14_adcdata=load ('/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/Dinos_stained_unstained/2-1-14/D20140201T202002_IFCB014.adc');

IFCB_14_ciliate_roi_ind=find(~isnan(classlist(:,4)));
gyro_ind=find(classlist(:,2)==36);
other_ind=find(classlist(:,2)==46);
ciliate_ratio=IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,4)./IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,5);
ciliate_ratio=ciliate_ratio';
ciliate_ratio_2=[ciliate_ratio_2 ciliate_ratio];

gyro_ratio= IFCB_14_adcdata(gyro_ind,4)./IFCB_14_adcdata(gyro_ind,5);
%gyro_ratio=gyro_ratio';
gyro_ratio_2=[gyro_ratio_2; gyro_ratio];

other_ratio= IFCB_14_adcdata(other_ind,4)./IFCB_14_adcdata(other_ind,5);
%other_ratio=other_ratio;
other_ratio_2=[other_ratio_2; other_ratio];



load '/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/mixing_staining/1-18-14/results/alt/D20140118T044140_IFCB014.mat'
IFCB_14_adcdata=load('/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/mixing_staining/1-18-14/D20140118T044140_IFCB014.adc');

IFCB_14_ciliate_roi_ind=find(~isnan(classlist(:,4)));
gyro_ind=find(classlist(:,2)==36);
other_ind=find(classlist(:,2)==46);
ciliate_ratio=IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,4)./IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,5);
ciliate_ratio=ciliate_ratio';
ciliate_ratio_2=[ciliate_ratio_2 ciliate_ratio];

gyro_ratio= IFCB_14_adcdata(gyro_ind,4)./IFCB_14_adcdata(gyro_ind,5);
%gyro_ratio=gyro_ratio';
gyro_ratio_2=[gyro_ratio_2; gyro_ratio];

other_ratio= IFCB_14_adcdata(other_ind,4)./IFCB_14_adcdata(other_ind,5);
%other_ratio=other_ratio;
other_ratio_2=[other_ratio_2; other_ratio];

load '/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/mixing_staining/1-18-14/results/alt/D20140118T053132_IFCB014.mat'
IFCB_14_adcdata=load('/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/mixing_staining/1-18-14/D20140118T053132_IFCB014.adc');

IFCB_14_ciliate_roi_ind=find(~isnan(classlist(:,4)));
gyro_ind=find(classlist(:,2)==36);
other_ind=find(classlist(:,2)==46);
ciliate_ratio=IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,4)./IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,5);
ciliate_ratio=ciliate_ratio';
ciliate_ratio_2=[ciliate_ratio_2 ciliate_ratio];

gyro_ratio= IFCB_14_adcdata(gyro_ind,4)./IFCB_14_adcdata(gyro_ind,5);
%gyro_ratio=gyro_ratio';
gyro_ratio_2=[gyro_ratio_2; gyro_ratio];

other_ratio= IFCB_14_adcdata(other_ind,4)./IFCB_14_adcdata(other_ind,5);
%other_ratio=other_ratio;
other_ratio_2=[other_ratio_2; other_ratio];

load '/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/mixing_staining/1-18-14/results/alt/D20140118T062124_IFCB014.mat'
IFCB_14_adcdata=load('/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/mixing_staining/1-18-14/D20140118T062124_IFCB014.adc');

IFCB_14_ciliate_roi_ind=find(~isnan(classlist(:,4)));
gyro_ind=find(classlist(:,2)==36);
other_ind=find(classlist(:,2)==46);
ciliate_ratio=IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,4)./IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,5);
ciliate_ratio=ciliate_ratio';
ciliate_ratio_2=[ciliate_ratio_2 ciliate_ratio];

gyro_ratio= IFCB_14_adcdata(gyro_ind,4)./IFCB_14_adcdata(gyro_ind,5);
%gyro_ratio=gyro_ratio';
gyro_ratio_2=[gyro_ratio_2; gyro_ratio];

other_ratio= IFCB_14_adcdata(other_ind,4)./IFCB_14_adcdata(other_ind,5);
%other_ratio=other_ratio;
other_ratio_2=[other_ratio_2; other_ratio];

load '/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/mixing_staining/1-18-14/results/alt/D20140118T071114_IFCB014.mat'
IFCB_14_adcdata=load('/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/mixing_staining/1-18-14/D20140118T071114_IFCB014.adc');

IFCB_14_ciliate_roi_ind=find(~isnan(classlist(:,4)));
gyro_ind=find(classlist(:,2)==36);
other_ind=find(classlist(:,2)==46);
ciliate_ratio=IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,4)./IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,5);
ciliate_ratio=ciliate_ratio';
ciliate_ratio_2=[ciliate_ratio_2 ciliate_ratio];

gyro_ratio= IFCB_14_adcdata(gyro_ind,4)./IFCB_14_adcdata(gyro_ind,5);
%gyro_ratio=gyro_ratio';
gyro_ratio_2=[gyro_ratio_2; gyro_ratio];

other_ratio= IFCB_14_adcdata(other_ind,4)./IFCB_14_adcdata(other_ind,5);
%other_ratio=other_ratio;
other_ratio_2=[other_ratio_2; other_ratio];

% load '/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/mixing_staining/1-18-14/results/alt/D20140118T082718_IFCB014.mat'
% IFCB_14_adcdata=load('/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/mixing_staining/1-18-14/D20140118T082718_IFCB014.adc');
% 
% IFCB_14_ciliate_roi_ind=find(~isnan(classlist(:,4)));
% gyro_ind=find(classlist(:,2)==36);
% ciliate_ratio=IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,4)./IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,5);
% ciliate_ratio=ciliate_ratio';
% ciliate_ratio_2=[ciliate_ratio_2 ciliate_ratio];
% 
% gyro_ratio= IFCB_14_adcdata(gyro_ind,4)./IFCB_14_adcdata(gyro_ind,5);
% %gyro_ratio=gyro_ratio';
% gyro_ratio_2=[gyro_ratio_2; gyro_ratio];
% 
% other_ratio= IFCB_14_adcdata(:,4)./IFCB_14_adcdata(:,5);
% %other_ratio=other_ratio;
% other_ratio_2=[other_ratio_2; other_ratio];


load '/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/mixing_staining/1-18-14/results/alt/D20140118T085055_IFCB014.mat'
IFCB_14_adcdata=load('/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/mixing_staining/1-18-14/D20140118T085055_IFCB014.adc');

IFCB_14_ciliate_roi_ind=find(~isnan(classlist(:,4)));
gyro_ind=find(classlist(:,2)==36);
other_ind=find(classlist(:,2)==46);
ciliate_ratio=IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,4)./IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,5);
ciliate_ratio=ciliate_ratio';
ciliate_ratio_2=[ciliate_ratio_2 ciliate_ratio];

gyro_ratio= IFCB_14_adcdata(gyro_ind,4)./IFCB_14_adcdata(gyro_ind,5);
%gyro_ratio=gyro_ratio';
gyro_ratio_2=[gyro_ratio_2; gyro_ratio];

other_ratio= IFCB_14_adcdata(other_ind,4)./IFCB_14_adcdata(other_ind,5);
%other_ratio=other_ratio;
other_ratio_2=[other_ratio_2; other_ratio];

load '/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/mixing_staining/1-18-14/results/alt/D20140118T094047_IFCB014.mat'
IFCB_14_adcdata=load('/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/mixing_staining/1-18-14/D20140118T094047_IFCB014.adc');

IFCB_14_ciliate_roi_ind=find(~isnan(classlist(:,4)));
gyro_ind=find(classlist(:,2)==36);
other_ind=find(classlist(:,2)==46);
ciliate_ratio=IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,4)./IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,5);
ciliate_ratio=ciliate_ratio';
ciliate_ratio_2=[ciliate_ratio_2 ciliate_ratio];

gyro_ratio= IFCB_14_adcdata(gyro_ind,4)./IFCB_14_adcdata(gyro_ind,5);
%gyro_ratio=gyro_ratio';
gyro_ratio_2=[gyro_ratio_2; gyro_ratio];

other_ratio= IFCB_14_adcdata(other_ind,4)./IFCB_14_adcdata(other_ind,5);
%other_ratio=other_ratio;
other_ratio_2=[other_ratio_2; other_ratio];

load '/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/mixing_staining/1-18-14/results/alt/D20140118T103038_IFCB014.mat'
IFCB_14_adcdata=load('/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/mixing_staining/1-18-14/D20140118T103038_IFCB014.adc');

IFCB_14_ciliate_roi_ind=find(~isnan(classlist(:,4)));
gyro_ind=find(classlist(:,2)==36);
other_ind=find(classlist(:,2)==46);
ciliate_ratio=IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,4)./IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,5);
ciliate_ratio=ciliate_ratio';
ciliate_ratio_2=[ciliate_ratio_2 ciliate_ratio];

gyro_ratio= IFCB_14_adcdata(gyro_ind,4)./IFCB_14_adcdata(gyro_ind,5);
%gyro_ratio=gyro_ratio';
gyro_ratio_2=[gyro_ratio_2; gyro_ratio];

other_ratio= IFCB_14_adcdata(other_ind,4)./IFCB_14_adcdata(other_ind,5);
%other_ratio=other_ratio;
other_ratio_2=[other_ratio_2; other_ratio];

load '/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/mixing_staining/1-18-14/results/alt/D20140118T112028_IFCB014.mat'
IFCB_14_adcdata=load('/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/mixing_staining/1-18-14/D20140118T112028_IFCB014.adc');


IFCB_14_ciliate_roi_ind=find(~isnan(classlist(:,4)));
gyro_ind=find(classlist(:,2)==36);
other_ind=find(classlist(:,2)==46);
ciliate_ratio=IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,4)./IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,5);
ciliate_ratio=ciliate_ratio';
ciliate_ratio_2=[ciliate_ratio_2 ciliate_ratio];

gyro_ratio= IFCB_14_adcdata(gyro_ind,4)./IFCB_14_adcdata(gyro_ind,5);
%gyro_ratio=gyro_ratio';
gyro_ratio_2=[gyro_ratio_2; gyro_ratio];

other_ratio= IFCB_14_adcdata(other_ind,4)./IFCB_14_adcdata(other_ind,5);
%other_ratio=other_ratio;
other_ratio_2=[other_ratio_2; other_ratio];

load '/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/mixing_staining/1-18-14/results/alt/D20140118T121017_IFCB014.mat'
IFCB_14_adcdata=load('/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/mixing_staining/1-18-14/D20140118T121017_IFCB014.adc');

IFCB_14_ciliate_roi_ind=find(~isnan(classlist(:,4)));
gyro_ind=find(classlist(:,2)==36);
other_ind=find(classlist(:,2)==46);
ciliate_ratio=IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,4)./IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,5);
ciliate_ratio=ciliate_ratio';
ciliate_ratio_2=[ciliate_ratio_2 ciliate_ratio];

gyro_ratio= IFCB_14_adcdata(gyro_ind,4)./IFCB_14_adcdata(gyro_ind,5);
%gyro_ratio=gyro_ratio';
gyro_ratio_2=[gyro_ratio_2; gyro_ratio];

other_ratio= IFCB_14_adcdata(other_ind,4)./IFCB_14_adcdata(other_ind,5);
%other_ratio=other_ratio;
other_ratio_2=[other_ratio_2; other_ratio];

load '/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/mixing_staining/1-18-14/results/alt/D20140118T130007_IFCB014.mat'
IFCB_14_adcdata=load('/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/mixing_staining/1-18-14/D20140118T130007_IFCB014.adc');

IFCB_14_ciliate_roi_ind=find(~isnan(classlist(:,4)));
gyro_ind=find(classlist(:,2)==36);
other_ind=find(classlist(:,2)==46);
ciliate_ratio=IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,4)./IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,5);
ciliate_ratio=ciliate_ratio';
ciliate_ratio_2=[ciliate_ratio_2 ciliate_ratio];

gyro_ratio= IFCB_14_adcdata(gyro_ind,4)./IFCB_14_adcdata(gyro_ind,5);
%gyro_ratio=gyro_ratio';
gyro_ratio_2=[gyro_ratio_2; gyro_ratio];

other_ratio= IFCB_14_adcdata(other_ind,4)./IFCB_14_adcdata(other_ind,5);
%other_ratio=other_ratio;
other_ratio_2=[other_ratio_2; other_ratio];

load '/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/mixing_staining/1-18-14/results/alt/D20140118T134956_IFCB014.mat'
IFCB_14_adcdata=load('/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/mixing_staining/1-18-14/D20140118T134956_IFCB014.adc');

IFCB_14_ciliate_roi_ind=find(~isnan(classlist(:,4)));
gyro_ind=find(classlist(:,2)==36);
other_ind=find(classlist(:,2)==46);
ciliate_ratio=IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,4)./IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,5);
ciliate_ratio=ciliate_ratio';
ciliate_ratio_2=[ciliate_ratio_2 ciliate_ratio];

gyro_ratio= IFCB_14_adcdata(gyro_ind,4)./IFCB_14_adcdata(gyro_ind,5);
%gyro_ratio=gyro_ratio';
gyro_ratio_2=[gyro_ratio_2; gyro_ratio];

other_ratio= IFCB_14_adcdata(other_ind,4)./IFCB_14_adcdata(other_ind,5);
%other_ratio=other_ratio;
other_ratio_2=[other_ratio_2; other_ratio];

load '/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/mixing_staining/1-18-14/results/alt/D20140118T143945_IFCB014.mat'
IFCB_14_adcdata=load('/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/mixing_staining/1-18-14/D20140118T143945_IFCB014.adc');

IFCB_14_ciliate_roi_ind=find(~isnan(classlist(:,4)));
gyro_ind=find(classlist(:,2)==36);
other_ind=find(classlist(:,2)==46);
ciliate_ratio=IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,4)./IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,5);
ciliate_ratio=ciliate_ratio';
ciliate_ratio_2=[ciliate_ratio_2 ciliate_ratio];

gyro_ratio= IFCB_14_adcdata(gyro_ind,4)./IFCB_14_adcdata(gyro_ind,5);
%gyro_ratio=gyro_ratio';
gyro_ratio_2=[gyro_ratio_2; gyro_ratio];

other_ratio= IFCB_14_adcdata(other_ind,4)./IFCB_14_adcdata(other_ind,5);
%other_ratio=other_ratio;
other_ratio_2=[other_ratio_2; other_ratio];


load '/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/mixing_staining/1-18-14/results/alt/D20140118T152935_IFCB014.mat'
IFCB_14_adcdata=load('/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/mixing_staining/1-18-14/D20140118T152935_IFCB014.adc');

IFCB_14_ciliate_roi_ind=find(~isnan(classlist(:,4)));
gyro_ind=find(classlist(:,2)==36);
other_ind=find(classlist(:,2)==46);
ciliate_ratio=IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,4)./IFCB_14_adcdata(IFCB_14_ciliate_roi_ind,5);
ciliate_ratio=ciliate_ratio';
ciliate_ratio_2=[ciliate_ratio_2 ciliate_ratio];

gyro_ratio= IFCB_14_adcdata(gyro_ind,4)./IFCB_14_adcdata(gyro_ind,5);
%gyro_ratio=gyro_ratio';
gyro_ratio_2=[gyro_ratio_2; gyro_ratio];

other_ratio= IFCB_14_adcdata(other_ind,4)./IFCB_14_adcdata(other_ind,5);
%other_ratio=other_ratio;
other_ratio_2=[other_ratio_2; other_ratio];

load '/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/mixing_staining/1-18-14/results/alt/D20140118T161927_IFCB014.mat'
IFCB_14_adcdata=load('/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/mixing_staining/1-18-14/D20140118T161927_IFCB014.adc');


diambins=[0:0.5:20];
% figure
% hist(ciliate_ratio_2,diambins)
% 
% figure
% rng(0,'twister')
% hist(ratio_2,diambins)
% h = findobj(gca,'Type','patch');
% set(h,'FaceColor',[0 .5 .5],'EdgeColor','w')

other_ratio_phyto=find(other_ratio_2 < 2);

figure

[nb_1,xb_1]=hist(other_ratio_2,diambins);
[nb_2,xb_2]=hist(gyro_ratio_2,diambins);
[nb_3,xb_3]=hist(ciliate_ratio_2,diambins);
other_ratio_phyto=find(xb_1 < 2);
subplot(3,1,1)
bh_1=bar(xb_1,nb_1);
set(bh_1,'facecolor','b');
legend('phyto')
subplot(3,1,2)
bh_3=bar(xb_3,nb_3);
ylabel('Abundance')
set(bh_3,'facecolor','m');
legend('ciliate')
subplot(3,1,3)
bh_2=bar(xb_2,nb_2);
set(bh_2,'facecolor','c');
legend('gyro')
xlabel('Green fluorescence: Chlorophyll fluorescence')
set(gca, 'fontsize', 24, 'fontname','arial')



% figure;
% bar(xb_1, [nb_3' nb_2'], 1);
% hold on
% bar(xb_1(1:4),nb_1(1:4));



% % Set the axis limits
% axis([0 13 0 40000]);
% 
% % Add title and axis labels
% title('Childhood diseases by month');
% xlabel('Month');
% ylabel('Cases (in thousands)');
% 
% % Add a legend
% legend('Measles', 'Mumps', 'Chicken pox');











