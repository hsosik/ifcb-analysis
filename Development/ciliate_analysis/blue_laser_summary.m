%488 nm summary

%adc_data
%7 = peak scatter
%8 = peak green/orange
%9 = peak chlorophyll


% Is there a difference between stained and non-stained cells triggering on only green?
% 	-amount of cells:
% 	-amount of green fluorescence

%unstained/green settings/green trigger
adcdata=load('/Users/markmiller/Documents/Experiments/IFCB_14/March_3_2015/D20150303T190527_IFCB014.adc');
load '/Users/markmiller/Documents/Experiments/IFCB_14/March_3_2015/Manual_fromClass/D20150303T190527_IFCB014.mat'

chl = adcdata(:,9); green = adcdata(:,8); scattering = adcdata(:,7);

scut_ind=find(classlist(:,2)==70);
crypto_ind=find(classlist(:,2)==28);
meso_ind=find(classlist(:,2)==75);
dun_ind=find(classlist(:,2)==30);
cyl_ind=find(classlist(:,2)==5);

figure %green vs. red fl
plot(green(scut_ind),chl(scut_ind),'*m','markersize',15)
hold on
plot(green(crypto_ind),chl(crypto_ind),'*r','markersize',15)
plot(green(meso_ind),chl(meso_ind),'*b','markersize',15)
plot(green(dun_ind),chl(dun_ind),'*g','markersize',15)
plot(green(cyl_ind),chl(cyl_ind),'*k','markersize',15)
title('no stain,green settings, green trigger','fontsize', 18)
legend('scut','crypto','meso','dun','cyl')
xlabel('Green Fluorescence','fontsize',16)
ylabel('Chl Fluorescence','fontsize',16)
xlim([0 3.5])
ylim([0 4])

%stained/green settings/green trigger
adcdata=load('/Users/markmiller/Documents/Experiments/IFCB_14/March_4_2015/D20150304T144907_IFCB014.adc');
load '/Users/markmiller/Documents/Experiments/IFCB_14/March_4_2015/Manual_fromClass/D20150304T144907_IFCB014.mat'

chl = adcdata(:,9); green = adcdata(:,8); scattering = adcdata(:,7);

scut_ind=find(classlist(:,2)==70);
crypto_ind=find(classlist(:,2)==28);
meso_ind=find(classlist(:,2)==75);
dun_ind=find(classlist(:,2)==30);
cyl_ind=find(classlist(:,2)==5);

figure %green vs. red fl
plot(green(scut_ind),chl(scut_ind),'*m','markersize',15)
hold on
plot(green(crypto_ind),chl(crypto_ind),'*r','markersize',15)
plot(green(meso_ind),chl(meso_ind),'*b','markersize',15)
plot(green(dun_ind),chl(dun_ind),'*g','markersize',15)
plot(green(cyl_ind),chl(cyl_ind),'*k','markersize',15)
title('stain,green settings, green trigger','fontsize', 18)
legend('scut','crypto','meso','dun','cyl')
xlabel('Green Fluorescence','fontsize',16)
ylabel('Chl Fluorescence','fontsize',16)
xlim([0 3.5])
ylim([0 4])

%%
%Do green stained cells show up when only triggering on red fluorescence?

adcdata=load('/Users/markmiller/Documents/Experiments/IFCB_14/March_4_2015/D20150304T142114_IFCB014.adc');
load '/Users/markmiller/Documents/Experiments/IFCB_14/March_4_2015/Manual_fromClass/D20150304T142114_IFCB014.mat'

chl = adcdata(:,9); green = adcdata(:,8); scattering = adcdata(:,7);

scut_ind=find(classlist(:,2)==70);
crypto_ind=find(classlist(:,2)==28);
meso_ind=find(classlist(:,2)==75);
dun_ind=find(classlist(:,2)==30);
cyl_ind=find(classlist(:,2)==5);

figure %green vs. red fl
plot(green(scut_ind),chl(scut_ind),'*m','markersize',15)
hold on
plot(green(crypto_ind),chl(crypto_ind),'*r','markersize',15)
plot(green(meso_ind),chl(meso_ind),'*b','markersize',15)
plot(green(dun_ind),chl(dun_ind),'*g','markersize',15)
plot(green(cyl_ind),chl(cyl_ind),'*k','markersize',15)
title('stain,green settings, red trigger','fontsize', 18)
legend('scut','crypto','meso','dun','cyl')
xlabel('Green Fluorescence','fontsize',16)
ylabel('Chl Fluorescence','fontsize',16)
xlim([0 3.5])
ylim([0 4])
%%
%Do PE containing cells show up when only triggering on green, no stain?

adcdata=load('/Users/markmiller/Documents/Experiments/IFCB_14/March_3_2015/D20150303T190527_IFCB014.adc');
load '/Users/markmiller/Documents/Experiments/IFCB_14/March_3_2015/Manual_fromClass/D20150303T190527_IFCB014.mat'

chl = adcdata(:,9); green = adcdata(:,8); scattering = adcdata(:,7);

scut_ind=find(classlist(:,2)==70);
crypto_ind=find(classlist(:,2)==28);
meso_ind=find(classlist(:,2)==75);
dun_ind=find(classlist(:,2)==30);
cyl_ind=find(classlist(:,2)==5);

figure %green vs. red fl
plot(green(scut_ind),chl(scut_ind),'*m','markersize',15)
hold on
plot(green(crypto_ind),chl(crypto_ind),'*r','markersize',15)
plot(green(meso_ind),chl(meso_ind),'*b','markersize',15)
plot(green(dun_ind),chl(dun_ind),'*g','markersize',15)
plot(green(cyl_ind),chl(cyl_ind),'*k','markersize',15)
title('no stain,green settings, green trigger','fontsize', 18)
legend('scut','crypto','meso','dun','cyl')
xlabel('Green Fluorescence','fontsize',16)
ylabel('Chl Fluorescence','fontsize',16)
xlim([0 3.5])
ylim([0 4])
%%
%Do green stained cells show up when only triggering on orange?
%Do chl containing cells show up when only triggering on orange?

adcdata=load('/Users/markmiller/Documents/Experiments/IFCB_14/March_4_2015/D20150304T145622_IFCB014.adc');
load '/Users/markmiller/Documents/Experiments/IFCB_14/March_4_2015/Manual_fromClass/D20150304T145622_IFCB014.mat'

chl = adcdata(:,9); green = adcdata(:,8); scattering = adcdata(:,7);

scut_ind=find(classlist(:,2)==70);
crypto_ind=find(classlist(:,2)==28);
meso_ind=find(classlist(:,2)==75);
dun_ind=find(classlist(:,2)==30);
cyl_ind=find(classlist(:,2)==5);

figure %green vs. red fl
plot(green(scut_ind),chl(scut_ind),'*m','markersize',15)
hold on
plot(green(crypto_ind),chl(crypto_ind),'*r','markersize',15)
plot(green(meso_ind),chl(meso_ind),'*b','markersize',15)
plot(green(dun_ind),chl(dun_ind),'*g','markersize',15)
plot(green(cyl_ind),chl(cyl_ind),'*k','markersize',15)
title('stain,PE settings, PE trigger','fontsize', 18)
legend('scut','crypto','meso','dun','cyl')
xlabel('PE Fluorescence','fontsize',16)
ylabel('Chl Fluorescence','fontsize',16)
xlim([0 1.5])
ylim([0 4])
set(gca, 'xscale','log','yscale','log')

%hist(log10(green(crypto_ind)),50)
%%
% figure %green vs. red fl
% plot(scattering(crypto_ind),green(crypto_ind),'*m','markersize',15)
% set(gca, 'xscale','log','yscale','log')

%%
%ENVIRONMENTAL SAMPLES

%Are nonstained sample showing cells with high green/chl ratios?

adcdata=load('/Users/markmiller/Documents/Experiments/IFCB_14/March_1_2015/D20150301T185820_IFCB014.adc');
%load '/Users/markmiller/Documents/Experiments/IFCB_14/March_1_2015/Manual_fromClass/D20150301T185820_IFCB014.mat'

chl = adcdata(:,9); green = adcdata(:,8); scattering = adcdata(:,7);

% scut_ind=find(classlist(:,2)==70);
% crypto_ind=find(classlist(:,2)==28);
% meso_ind=find(classlist(:,2)==75);
% dun_ind=find(classlist(:,2)==30);
% cyl_ind=find(classlist(:,2)==5);

figure %green vs. red fl
plot(green,chl,'*b','markersize',15)
title('no stain,green settings, green and red trigger','fontsize', 18)
%legend('scut','crypto','meso','dun','cyl')
xlabel('Green Fluorescence','fontsize',16)
ylabel('Chl Fluorescence','fontsize',16)
xlim([0 1.5])
ylim([0 4])

adcdata=load('/Users/markmiller/Documents/Experiments/IFCB_14/March_1_2015/D20150301T194803_IFCB014.adc');
%load '/Users/markmiller/Documents/Experiments/IFCB_14/March_1_2015/Manual_fromClass/D20150301T185820_IFCB014.mat'

chl = adcdata(:,9); green = adcdata(:,8); scattering = adcdata(:,7);

% scut_ind=find(classlist(:,2)==70);
% crypto_ind=find(classlist(:,2)==28);
% meso_ind=find(classlist(:,2)==75);
% dun_ind=find(classlist(:,2)==30);
% cyl_ind=find(classlist(:,2)==5);

figure %green vs. red fl
plot(green,chl,'*b','markersize',15)
title(' stain,green settings, green and red trigger','fontsize', 18)
%legend('scut','crypto','meso','dun','cyl')
xlabel('Green Fluorescence','fontsize',16)
ylabel('Chl Fluorescence','fontsize',16)
xlim([0 1.5])
ylim([0 4])

%%
%3 = int scatter
%4 = int green/orange
%5 = int chlorophyll

adcdata=load('/Users/markmiller/Documents/Experiments/IFCB_14/March_1_2015/D20150301T185820_IFCB014.adc');
%load '/Users/markmiller/Documents/Experiments/IFCB_14/March_1_2015/Manual_fromClass/D20150301T185820_IFCB014.mat'
chl = adcdata(:,5); green = adcdata(:,4); scattering = adcdata(:,3);
figure1 = figure;

% Create axes
axes1 = axes('Parent',figure1,'YScale','log','YMinorTick','on',...
    'XScale','log',...
    'XMinorTick','on',...
    'PlotBoxAspectRatio',[1 1 1],...
    'FontSize',14);
box(axes1,'on');
hold(axes1,'all');
hold on
plot(green, chl, '*','markersize', 2)
axis square
ylabel('Chlorophyll fluorescence', 'fontsize', 24, 'fontname', 'arial');
xlabel('FDA fluorescence','fontsize', 24, 'fontname', 'arial');
set(gca, 'FontSize',24);
xlim([0.002 0.2])
title('no stain,green settings, green and red trigger','fontsize', 18)

adcdata=load('/Users/markmiller/Documents/Experiments/IFCB_14/March_1_2015/D20150301T194803_IFCB014.adc');
%load '/Users/markmiller/Documents/Experiments/IFCB_14/March_1_2015/Manual_fromClass/D20150301T185820_IFCB014.mat'
chl = adcdata(:,5); green = adcdata(:,4); scattering = adcdata(:,3);

figure1 = figure;

% Create axes
axes1 = axes('Parent',figure1,'YScale','log','YMinorTick','on',...
    'XScale','log',...
    'XMinorTick','on',...
    'PlotBoxAspectRatio',[1 1 1],...
    'FontSize',14);
box(axes1,'on');
hold(axes1,'all');
hold on
plot(green, chl, '*','markersize', 2)
axis square
ylabel('Chlorophyll fluorescence', 'fontsize', 24, 'fontname', 'arial');
xlabel('FDA fluorescence','fontsize', 24, 'fontname', 'arial');
set(gca, 'FontSize',24);
xlim([0.002 0.2])
title(' stain,green settings, green and red trigger','fontsize', 18)
%%

%Are we seeing cells that have a high PE/high chl ratios? Is this b/c green is coming through?

adcdata=load('/Users/markmiller/Documents/Experiments/IFCB_14/March_1_2015/D20150301T192245_IFCB014.adc');
%load '/Users/markmiller/Documents/Experiments/IFCB_14/March_1_2015/Manual_fromClass/D20150301T185820_IFCB014.mat'

chl = adcdata(:,9); green = adcdata(:,8); scattering = adcdata(:,7);

% scut_ind=find(classlist(:,2)==70);
% crypto_ind=find(classlist(:,2)==28);
% meso_ind=find(classlist(:,2)==75);
% dun_ind=find(classlist(:,2)==30);
% cyl_ind=find(classlist(:,2)==5);

figure %green vs. red fl
plot(green,chl,'*b','markersize',15)
title('no stain,PE settings, PE and red trigger','fontsize', 18)
%legend('scut','crypto','meso','dun','cyl')
xlabel('PE Fluorescence','fontsize',16)
ylabel('Chl Fluorescence','fontsize',16)
xlim([0 3.5])
ylim([0 4])

chl = adcdata(:,5); green = adcdata(:,4); scattering = adcdata(:,3);

figure1 = figure;

% Create axes
axes1 = axes('Parent',figure1,'YScale','log','YMinorTick','on',...
    'XScale','log',...
    'XMinorTick','on',...
    'PlotBoxAspectRatio',[1 1 1],...
    'FontSize',14);
box(axes1,'on');
hold(axes1,'all');
hold on
plot(green, chl, '*','markersize', 2)
axis square
ylabel('Chlorophyll fluorescence', 'fontsize', 24, 'fontname', 'arial');
xlabel('PE fluorescence','fontsize', 24, 'fontname', 'arial');
set(gca, 'FontSize',24);

title('no stain,PE settings, PE and red trigger','fontsize', 18)

%%
%Are we seeing dinos that we weren?t seeing before on orange settings?

load '/Users/markmiller/Documents/Experiments/IFCB_14/March_2_2015/Manual_fromClass/summary/count_manual_04Mar2015.mat'

%287-317

runtype_alt_ind=strmatch('ALT', runtype(1:7));
runtype_normal_ind=strmatch('NORMAL',runtype(1:7));

classcount_A=classcount(1:7,:);
ml_analyzed_A=ml_analyzed(1:7);


normal_ciliate_classcount=classcount_A(runtype_normal_ind,70:88);
alt_ciliate_classcount=classcount_A(runtype_alt_ind,70:88);

ciliate_total_classcount_normal=sum(normal_ciliate_classcount,2);
ciliate_total_classcount_Alt=sum(alt_ciliate_classcount,2);

ciliate_perml_normal=ciliate_total_classcount_normal./ml_analyzed_A(runtype_normal_ind);
ciliate_perml_alt=ciliate_total_classcount_Alt./ml_analyzed_A(runtype_alt_ind);

ciliate_perml_normal_day=sum(ciliate_perml_normal);
ciliate_perml_alt_day=sum(ciliate_perml_alt);

% [all_ciliate_ci] = poisson_count_ci(all_ciliate_classcount, 0.95);
% lower_all_ciliate_ci_ml=all_ciliate_ci(:,1)./ml_analyzed;
% upper_all_ciliate_ci_ml=all_ciliate_ci(:,2)./ml_analyzed;
% 
% lower=[all_ciliate_classcount_perml-lower_all_ciliate_ci_ml];
% upper=[upper_all_ciliate_ci_ml-all_ciliate_classcount_perml];
% 
% %total ciliates
% figure
% bar(1:2, [ciliate_perml_normal_day; ciliate_perml_alt_day])
% ylabel('Ciliates (mL^{-1})', 'fontsize', 12, 'fontname', 'arial');
% set(gca,'xticklabel',{'no staining','staining'}, 'fontsize', 12, 'fontname', 'arial');


%c_mix and strombidium_morphotype1
normal_ciliate_classcount=classcount_A(runtype_normal_ind,70);
alt_ciliate_classcount=classcount_A(runtype_alt_ind,70);
normal_strom_classcount=classcount_A(runtype_normal_ind,78);
alt_strom_classcount=classcount_A(runtype_alt_ind,78);
normal_tontonia_classcount=classcount_A(runtype_normal_ind,87);
alt_tontonia_classcount=classcount_A(runtype_alt_ind,87);
normal_pleuronema_classcount=classcount_A(runtype_normal_ind,76);
alt_pleuronema_classcount=classcount_A(runtype_alt_ind,76);
ciliate_total_classcount_normal=normal_ciliate_classcount+normal_strom_classcount + normal_tontonia_classcount+normal_pleuronema_classcount;
ciliate_total_classcount_Alt=alt_ciliate_classcount+alt_strom_classcount + alt_tontonia_classcount+alt_pleuronema_classcount;;
ciliate_perml_normal=ciliate_total_classcount_normal./ml_analyzed_A(runtype_normal_ind);
ciliate_perml_alt=ciliate_total_classcount_Alt./ml_analyzed_A(runtype_alt_ind);
ciliate_perml_normal_day=sum(ciliate_perml_normal);
ciliate_perml_alt_day=sum(ciliate_perml_alt);

%Laboea
normal_laboea_classcount=classcount_A(runtype_normal_ind,73);
alt_laboea_classcount=classcount_A(runtype_alt_ind,73);
laboea_perml_normal=normal_laboea_classcount./ml_analyzed_A(runtype_normal_ind);
laboea_perml_alt=alt_laboea_classcount./ml_analyzed_A(runtype_alt_ind);
laboea_perml_normal_day=sum(laboea_perml_normal);
laboea_perml_alt_day=sum(laboea_perml_alt);

%mesodinium
normal_mesodinium_classcount=classcount_A(runtype_normal_ind,75);
alt_mesodinium_classcount=classcount_A(runtype_alt_ind,75);
mesodinium_perml_normal=normal_mesodinium_classcount./ml_analyzed_A(runtype_normal_ind);
mesodinium_perml_alt=alt_mesodinium_classcount./ml_analyzed_A(runtype_alt_ind);
mesodinium_perml_normal_day=sum(mesodinium_perml_normal);
mesodinium_perml_alt_day=sum(mesodinium_perml_alt);

%tintinnid
normal_tintinnid_classcount=classcount_A(runtype_normal_ind,86);
alt_tintinnid_classcount=classcount_A(runtype_alt_ind,86);
tintinnid_perml_normal=normal_tintinnid_classcount./ml_analyzed_A(runtype_normal_ind);

tintinnid_perml_alt=alt_tintinnid_classcount./ml_analyzed_A(runtype_alt_ind);
tintinnid_perml_normal_day=sum(tintinnid_perml_normal);
tintinnid_perml_alt_day=sum(tintinnid_perml_alt);

%tontonia
normal_tontonia_classcount=classcount_A(runtype_normal_ind,87);
alt_tontonia_classcount=classcount_A(runtype_alt_ind,87);
tontonia_perml_normal=normal_tontonia_classcount./ml_analyzed_A(runtype_normal_ind);
tontonia_perml_alt=alt_tontonia_classcount./ml_analyzed_A(runtype_alt_ind);
tontonia_perml_normal_day=sum(tontonia_perml_normal);
tontonia_perml_alt_day=sum(tontonia_perml_alt);

%pleuronema
normal_pleuronema_classcount=classcount_A(runtype_normal_ind,76);
alt_pleuronema_classcount=classcount_A(runtype_alt_ind,76);
pleuronema_perml_normal=normal_pleuronema_classcount./ml_analyzed_A(runtype_normal_ind);
pleuronema_perml_alt=alt_pleuronema_classcount./ml_analyzed_A(runtype_alt_ind);
pleuronema_perml_normal_day=sum(pleuronema_perml_normal);
pleuronema_perml_alt_day=sum(pleuronema_perml_alt);

%gyrodinoid
normal_gyro_classcount=classcount_A(runtype_normal_ind,34);
alt_gyro_classcount=classcount_A(runtype_alt_ind,34);
gyro_perml_normal=normal_gyro_classcount./ml_analyzed_A(runtype_normal_ind);
gyro_perml_alt=alt_gyro_classcount./ml_analyzed_A(runtype_alt_ind);
gyro_perml_normal_day=sum(gyro_perml_normal);
gyro_perml_alt_day=sum(gyro_perml_alt);

%protoperidinium
normal_proto_classcount=classcount_A(runtype_normal_ind,100);
alt_proto_classcount=classcount_A(runtype_alt_ind,100);
proto_perml_normal=normal_proto_classcount./ml_analyzed_A(runtype_normal_ind);
proto_perml_alt=alt_proto_classcount./ml_analyzed_A(runtype_alt_ind);
proto_perml_normal_day=sum(proto_perml_normal);
proto_perml_alt_day=sum(proto_perml_alt);


%y = [ciliate_perml_normal_day ciliate_perml_alt_day; laboea_perml_normal_day laboea_perml_alt_day; mesodinium_perml_normal_day mesodinium_perml_alt_day; tintinnid_perml_normal_day tintinnid_perml_alt_day; tontonia_perml_normal_day tontonia_perml_alt_day; pleuronema_perml_normal_day pleuronema_perml_alt_day; gyro_perml_normal_day gyro_perml_alt_day ];
y = [ciliate_perml_normal_day ciliate_perml_alt_day; laboea_perml_normal_day laboea_perml_alt_day; mesodinium_perml_normal_day mesodinium_perml_alt_day; tintinnid_perml_normal_day tintinnid_perml_alt_day; gyro_perml_normal_day gyro_perml_alt_day; proto_perml_normal_day proto_perml_alt_day];

% figure
% bar(y)
% set(gca,'xticklabel',{'ciliate mix','laboea','mesodinium','tinitnnid','gyro', 'proto'}, 'fontsize', 12, 'fontname', 'arial');
% legend('no staining','staining')
% ylabel('Ciliates (mL^{-1})', 'fontsize', 12, 'fontname', 'arial');



normal_ciliate_ml=sum(ml_analyzed_A(runtype_normal_ind));
alt_ciliate_ml=sum(ml_analyzed_A(runtype_alt_ind));

normal_tintinnid_classcount=classcount_A(runtype_normal_ind,86);
normal_tintinnid=sum(normal_tintinnid_classcount,1);
alt_tintinnid_classcount=classcount_A(runtype_alt_ind,86);
alt_tintinnid=sum(alt_tintinnid_classcount,1);


normal_ciliate_classcount=classcount_A(runtype_normal_ind,70);
normal_strom_classcount=classcount_A(runtype_normal_ind,78);
normal_pleuronema_classcount=classcount_A(runtype_normal_ind,76);
normal_tontonia_classcount=classcount_A(runtype_normal_ind,87);
normal_ciliate_classcount=normal_ciliate_classcount+normal_strom_classcount+normal_pleuronema_classcount+normal_tontonia_classcount;
normal_ciliate=sum(normal_ciliate_classcount,1);
alt_ciliate_classcount=classcount_A(runtype_alt_ind,70);
alt_strom_classcount=classcount_A(runtype_alt_ind,78);
alt_pleuronema_classcount=classcount_A(runtype_alt_ind,76);
alt_tontonia_classcount=classcount_A(runtype_alt_ind,87);
alt_ciliate_classcount=alt_ciliate_classcount+alt_strom_classcount+alt_pleuronema_classcount+alt_tontonia_classcount;
alt_ciliate=sum(alt_ciliate_classcount,1);

normal_meso_classcount=classcount_A(runtype_normal_ind,75);
normal_meso=sum(normal_meso_classcount,1);
alt_meso_classcount=classcount_A(runtype_alt_ind,75);
alt_meso=sum(alt_meso_classcount,1);

normal_gyro_classcount=classcount_A(runtype_normal_ind,34);
normal_gyro=sum(normal_gyro_classcount,1);
alt_gyro_classcount=classcount_A(runtype_alt_ind,34);
alt_gyro=sum(alt_gyro_classcount,1);

normal_proto_classcount=classcount_A(runtype_normal_ind,100);
normal_proto=sum(normal_proto_classcount,1);
alt_proto_classcount=classcount_A(runtype_alt_ind,100);
alt_proto=sum(alt_proto_classcount,1);

normal_Laboea_classcount=classcount_A(runtype_normal_ind,73);
normal_Laboea=sum(normal_Laboea_classcount,1);
alt_Laboea_classcount=classcount_A(runtype_alt_ind,73);
alt_Laboea=sum(alt_Laboea_classcount,1);

% normal_pleuronema_classcount=classcount_A(runtype_normal_ind,76);
% normal_pleuronema=sum(normal_pleuronema_classcount,1);
% alt_pleuronema_classcount=classcount_A(runtype_alt_ind,76);
% alt_pleuronema=sum(alt_pleuronema_classcount,1);
% 
% normal_tontonia_classcount=classcount_A(runtype_normal_ind,87);
% normal_tontonia=sum(normal_tontonia_classcount,1);
% alt_tontonia_classcount=classcount_A(runtype_alt_ind,87);
% alt_tontonia=sum(alt_tontonia_classcount,1);

%figure
%bar(1:12,[normal_ciliate alt_ciliate normal_tintinnid alt_tintinnid normal_meso alt_meso normal_Laboea alt_Laboea normal_gyro alt_gyro normal_pleuronema alt_pleuronema])



%normal_ciliate_bin=[normal_ciliate normal_meso normal_Laboea normal_tintinnid normal_gyro normal_pleuronema normal_tontonia];
normal_ciliate_bin=[normal_ciliate normal_meso normal_Laboea normal_tintinnid normal_gyro normal_proto];
normal_ciliate_ml=sum(ml_analyzed_A(runtype_normal_ind));
[normal_ci] = poisson_count_ci(normal_ciliate_bin, 0.95);
normal_ci_low=normal_ci(:,1);
normal_ci_upper=normal_ci(:,2);

alt_ciliate_ml=sum(ml_analyzed_A(runtype_alt_ind));
%alt_ciliate_bin= [alt_ciliate alt_meso alt_Laboea alt_tintinnid alt_gyro alt_pleuronema alt_tontonia];
alt_ciliate_bin= [alt_ciliate alt_meso alt_Laboea alt_tintinnid alt_gyro alt_proto];
[alt_ci] = poisson_count_ci(alt_ciliate_bin, 0.95);
alt_ci_low=alt_ci(:,1);
alt_ci_upper=alt_ci(:,2);

b = [normal_ciliate_bin./normal_ciliate_ml; alt_ciliate_bin./alt_ciliate_ml]';
errdata1 = [b(:,1)'-(normal_ci_low./normal_ciliate_ml)'; (normal_ci_upper./normal_ciliate_ml-b(:,1))']';
errdata2 = [b(:,2)'-(alt_ci_low./alt_ciliate_ml)'; (alt_ci_upper./alt_ciliate_ml-b(:,2))']'; 
%errdata3 = [b(:,3)'-(m_ci_low./microscope_ml)'; (m_ci_upper./microscope_ml-b(:,3))']'; 
errdata = [errdata1' errdata2'];
figure
h = bar('v6', b);
set(gca, 'linewidth', 2, 'fontsize', 18,'fontname', 'arial')
%set(gca, 'xticklabel', class2use','fontsize', 18, 'fontname', 'arial');
set(gca,'fontsize',18, 'fontname', 'arial')
set(gca,'XTickLabel',{'Ciliate mix','Meso','Laboea','Tintinnid','Gyro','Proto','Dactyliosolen','Dictyocha','Dinobryon','Ditylum','Ephemera','Eucampia','Eucampia_groenlandica','Guinardia','Guinardia_flaccida','Leptocylindrus','Pleurosigma','Pseudonitzschia','Rhizosolenia','Skeletonema','Thalassionema','Thalassiosira','Thalassiosira_dirty','bad','ciliate','detritus','pennate','mix','clusterflagellate','crypto','dino10','dino30','Dinophysis','Euglena','flagellate','Gyrodinium','kiteflagellates','Lauderia','Licmophora','Phaeocystis','Prorocentrum','Pyramimonas','roundCell','Stephanopyxis','Tropidoneis','other','Cerataulina','Coscinodiscus','Gonyaulax','Odontella','Guinardia_striata','Paralia','mix_elongated','Hemiaulus','unclassified','Chaetoceros_flagellate','Chaetoceros_pennate','Cerataulina_flagellate','G_delicatula_parasite','G_delicatula_external_parasite','Chaetoceros_other','diatom_flagellate','other_interaction','Chaetoceros_didymus','Leptocylindrus_mediterraneus','Chaetoceros_didymus_flagellate','pennates_on_diatoms','Parvicorbicula_socialis','Delphineis','G_delicatula_detritus','amoeba','Ciliate_mix','Didinium_sp','Euplotes_sp','Laboea_strobila','Leegaardiella_ovalis','Mesodinium_sp','Pleuronema_sp','Strobilidium_morphotype1','Strobilidium_morphotype2','Strombidium_capitatum','Strombidium_caudatum','Strombidium_conicum','Strombidium_inclinatum','Strombidium_morphotype1','Strombidium_morphotype2','Strombidium_oculatum','Strombidium_wulffi','Tiarina_fusus','Tintinnid','Tontonia_appendiculariformis','Tontonia_gracillima'},...
    'XTick',[1 2 3 4 5 6],...
    'LineWidth',2,...
    'FontSize',18,...
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

%%
% Are we seeing dinos that we weren?t seeing before on orange settings?
% -example: Protoperidinium
% 		-Is green autofluorescence showing up as orange?
% 		-Is stain carrying over?

adcdata=load('/Users/markmiller/Documents/Experiments/IFCB_14/March_2_2015/D20150302T182028_IFCB014.adc');
load '/Users/markmiller/Documents/Experiments/IFCB_14/March_2_2015/Manual_fromClass/D20150302T182028_IFCB014.mat'

chl = adcdata(:,9); green = adcdata(:,8); scattering = adcdata(:,7);

 ciliate_ind=find(classlist(:,2)==70);
tintinnid_ind=find(classlist(:,2)==86);
gyro_ind=find(classlist(:,2)==34);
proto_ind=find(classlist(:,2)==100);
% cyl_ind=find(classlist(:,2)==5);

figure %green vs. red fl
plot(green,chl,'*b','markersize',15)
hold on
plot(green(proto_ind),chl(proto_ind),'*r','markersize',15)
plot(green(gyro_ind),chl(gyro_ind),'*g','markersize',15)
plot(green(ciliate_ind),chl(ciliate_ind),'*m','markersize',15)
plot(green(tintinnid_ind),chl(tintinnid_ind),'*y','markersize',15)
title('no stain,PE settings,red trigger','fontsize', 18)
%legend('scut','crypto','meso','dun','cyl')
xlabel('PE Fluorescence','fontsize',16)
ylabel('Chl Fluorescence','fontsize',16)
xlim([0 1])
ylim([0 4])
%legend('all','proto','gyro','ciliate mix','tintinnid')

%%

adcdata=load('/Users/markmiller/Documents/Experiments/IFCB_14/March_2_2015/D20150302T184746_IFCB014.adc');
load '/Users/markmiller/Documents/Experiments/IFCB_14/March_2_2015/Manual_fromClass/D20150302T184746_IFCB014.mat'

chl = adcdata(:,9); green = adcdata(:,8); scattering = adcdata(:,7);

 ciliate_ind=find(classlist(:,2)==70);
tintinnid_ind=find(classlist(:,2)==86);
gyro_ind=find(classlist(:,2)==34);
proto_ind=find(classlist(:,2)==100);
% cyl_ind=find(classlist(:,2)==5);

figure %green vs. red fl
plot(green,chl,'*b','markersize',15)
hold on
plot(green(proto_ind),chl(proto_ind),'*r','markersize',15)
plot(green(gyro_ind),chl(gyro_ind),'*g','markersize',15)
plot(green(ciliate_ind),chl(ciliate_ind),'*m','markersize',15)
plot(green(tintinnid_ind),chl(tintinnid_ind),'*y','markersize',15)
title('no stain,PE settings,red  and PE trigger','fontsize', 18)
%legend('scut','crypto','meso','dun','cyl')
xlabel('PE Fluorescence','fontsize',16)
ylabel('Chl Fluorescence','fontsize',16)
xlim([0 1])
ylim([0 4])
%legend('all','proto','gyro','ciliate mix','tintinnid')

%%

adcdata=load('/Users/markmiller/Documents/Experiments/IFCB_14/March_2_2015/D20150302T163734_IFCB014.adc');
load '/Users/markmiller/Documents/Experiments/IFCB_14/March_2_2015/Manual_fromClass/D20150302T163734_IFCB014.mat'

chl = adcdata(:,9); green = adcdata(:,8); scattering = adcdata(:,7);

 ciliate_ind=find(classlist(:,2)==70);
tintinnid_ind=find(classlist(:,2)==86);
gyro_ind=find(classlist(:,2)==34);
proto_ind=find(classlist(:,2)==100);
% cyl_ind=find(classlist(:,2)==5);

figure %green vs. red fl
plot(green,chl,'*b','markersize',15)
hold on
plot(green(proto_ind),chl(proto_ind),'*r','markersize',15)
plot(green(gyro_ind),chl(gyro_ind),'*g','markersize',15)
plot(green(ciliate_ind),chl(ciliate_ind),'*m','markersize',15)
plot(green(tintinnid_ind),chl(tintinnid_ind),'*y','markersize',15)
title('no stain,PE settings,red and orange trigger','fontsize', 18)
%legend('scut','crypto','meso','dun','cyl')
xlabel('PE Fluorescence','fontsize',16)
ylabel('Chl Fluorescence','fontsize',16)
xlim([0 1])
ylim([0 4])
%legend('all','proto','gyro','ciliate mix','tintinnid')

%%

adcdata=load('/Users/markmiller/Documents/Experiments/IFCB_14/March_2_2015/D20150302T161113_IFCB014.adc');
load '/Users/markmiller/Documents/Experiments/IFCB_14/March_2_2015/Manual_fromClass/D20150302T161113_IFCB014.mat'

chl = adcdata(:,9); green = adcdata(:,8); scattering = adcdata(:,7);

 ciliate_ind=find(classlist(:,2)==70);
tintinnid_ind=find(classlist(:,2)==86);
gyro_ind=find(classlist(:,2)==34);
proto_ind=find(classlist(:,2)==100);
% cyl_ind=find(classlist(:,2)==5);

figure %green vs. red fl
plot(green,chl,'*b','markersize',15)
hold on
plot(green(proto_ind),chl(proto_ind),'*r','markersize',15)
plot(green(gyro_ind),chl(gyro_ind),'*g','markersize',15)
plot(green(ciliate_ind),chl(ciliate_ind),'*m','markersize',15)
plot(green(tintinnid_ind),chl(tintinnid_ind),'*y','markersize',15)
title('stain,Green settings,green trigger','fontsize', 18)
%legend('scut','crypto','meso','dun','cyl')
xlabel('Green Fluorescence','fontsize',16)
ylabel('Chl Fluorescence','fontsize',16)
xlim([0 1])
ylim([0 4])
%legend('all','proto','gyro','ciliate mix','tintinnid')


%%
%%peak signals in ciliates

%nonstained sample
adcdata=load('/Users/markmiller/Documents/Experiments/IFCB_14/March_2_2015/D20150302T154735_IFCB014.adc');
load '/Users/markmiller/Documents/Experiments/IFCB_14/March_2_2015/Manual_fromClass/D20150302T154735_IFCB014.mat'

chl = adcdata(:,9); green = adcdata(:,8); scattering = adcdata(:,7); roi = adcdata(:,1);
ciliate_ind=find(classlist(:,2)==70);


figure
plot(roi,chl,'.b')
hold on
plot(roi(ciliate_ind),chl(ciliate_ind),'*r','markersize',15)
plot(roi(ciliate_ind(4)),chl(ciliate_ind(4)),'*m','markersize',15)
xlabel('roi number')
ylabel('chlorophyll fluorescence')
title('no stain, orange settings, orange and red trigger')
legend('all','ciliate mix')

%%
figure
plot(roi,green,'.b')
hold on
plot(roi(ciliate_ind),green(ciliate_ind),'*r','markersize',15)
plot(roi(ciliate_ind(4)),green(ciliate_ind(4)),'*m','markersize',15)
xlabel('roi number')
ylabel('PE fluorescence')
title('no stain, orange settings, orange and red trigger')
legend('all','ciliate mix')

%%

%Is staining increasing over time?

adcdata=load('/Users/markmiller/Documents/Experiments/IFCB_14/March_2_2015/D20150302T161113_IFCB014.adc');
load '/Users/markmiller/Documents/Experiments/IFCB_14/March_2_2015/Manual_fromClass/D20150302T161113_IFCB014.mat'

chl = adcdata(:,9); green = adcdata(:,8); scattering = adcdata(:,7); roi = adcdata(:,1);
ciliate_ind=find(classlist(:,2)==70);


figure
plot(roi,green,'.b')

xlabel('roi number')
ylabel('green fluorescence')
title('stain, green settings, red and green trigger')
%%





