%% WINTER- January 19, 2014

load '/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/mixing_staining/1-18-14/results/alt/summary/count_manual_19Jan2014.mat';
ml_analyzed_norm=ml_analyzed;
load '/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/mixing_staining/1-18-14/results/normal/summary/count_manual_20Jan2014.mat';

alt_ciliate_bin=[89 49 0 3 17 3];
alt_ciliate_ml=sum(ml_analyzed);
[alt_ci] = poisson_count_ci(alt_ciliate_bin, 0.95);
alt_ci_low=alt_ci(:,1);
alt_ci_upper=alt_ci(:,2);

normal_ciliate_bin=[92 77 0 6 1 0 ];
normal_ciliate_ml=sum(ml_analyzed_norm);
[normal_ci] = poisson_count_ci(normal_ciliate_bin, 0.95);
normal_ci_low=normal_ci(:,1);
normal_ci_upper=normal_ci(:,2);

microscope_count = [0 0 0 0 0 0]; 
microscope_ml = 0; %total number/concentration of cells as determined by plankton concentration calculator
[m_ci] = poisson_count_ci(microscope_count, 0.95);
m_ci_low=m_ci(:,1);
m_ci_upper=m_ci(:,2);

b = [normal_ciliate_bin./normal_ciliate_ml; alt_ciliate_bin./alt_ciliate_ml; microscope_count./microscope_ml]';
errdata1 = [b(:,1)'-(normal_ci_low./normal_ciliate_ml)'; (normal_ci_upper./normal_ciliate_ml-b(:,1))']';
errdata2 = [b(:,2)'-(alt_ci_low./alt_ciliate_ml)'; (alt_ci_upper./alt_ciliate_ml-b(:,2))']'; 
errdata3 = [b(:,3)'-(m_ci_low./microscope_ml)'; (m_ci_upper./microscope_ml-b(:,3))']'; 
errdata = [errdata1' errdata2' errdata3'];

figure
set(gcf,'units','inches')
set(gcf,'position',[6 3.75 6.35 7.3],'paperposition', [1 1 6.35 7.3]);
subplot(4,1,1)

h = bar('v6', b);
set(gca, 'linewidth', 2, 'fontsize', 24,'fontname', 'Times new roman')
%set(gca, 'xticklabel', class2use','fontsize', 18, 'fontname', 'arial');
set(gca,'fontsize',14, 'fontname', 'Times New Roman')
set(gca,'XTickLabel',{'Ciliate mix','Meso','Laboea','Tintinnid','Gyro','Proto','Dactyliosolen','Dictyocha','Dinobryon','Ditylum','Ephemera','Eucampia','Eucampia_groenlandica','Guinardia','Guinardia_flaccida','Leptocylindrus','Pleurosigma','Pseudonitzschia','Rhizosolenia','Skeletonema','Thalassionema','Thalassiosira','Thalassiosira_dirty','bad','ciliate','detritus','pennate','mix','clusterflagellate','crypto','dino10','dino30','Dinophysis','Euglena','flagellate','Gyrodinium','kiteflagellates','Lauderia','Licmophora','Phaeocystis','Prorocentrum','Pyramimonas','roundCell','Stephanopyxis','Tropidoneis','other','Cerataulina','Coscinodiscus','Gonyaulax','Odontella','Guinardia_striata','Paralia','mix_elongated','Hemiaulus','unclassified','Chaetoceros_flagellate','Chaetoceros_pennate','Cerataulina_flagellate','G_delicatula_parasite','G_delicatula_external_parasite','Chaetoceros_other','diatom_flagellate','other_interaction','Chaetoceros_didymus','Leptocylindrus_mediterraneus','Chaetoceros_didymus_flagellate','pennates_on_diatoms','Parvicorbicula_socialis','Delphineis','G_delicatula_detritus','amoeba','Ciliate_mix','Didinium_sp','Euplotes_sp','Laboea_strobila','Leegaardiella_ovalis','Mesodinium_sp','Pleuronema_sp','Strobilidium_morphotype1','Strobilidium_morphotype2','Strombidium_capitatum','Strombidium_caudatum','Strombidium_conicum','Strombidium_inclinatum','Strombidium_morphotype1','Strombidium_morphotype2','Strombidium_oculatum','Strombidium_wulffi','Tiarina_fusus','Tintinnid','Tontonia_appendiculariformis','Tontonia_gracillima'},...
    'XTick',[1 2 3 4 5 6],...
    'LineWidth',2,...
    'FontSize',12,...
    'FontName','Times new roman');


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

set(eh(1),'linewidth',0.5); % This changes the thickness of the errorbars
set(eh(1),'color','k'); % This changes the color of the errorbars
set(eh(2),'linestyle','none'); % This removes the connecting line
%ylabel('Cell concentration (mL^{-1})','fontsize', 24, 'fontname', 'Times new roman');
lh = legend('Non-stained', 'Stained');
set(lh, 'box', 'off','fontsize',8)

text(0.25,1.5,' A','fontsize',16, 'fontname', 'Times New Roman')


lh=line([4.71 4.85],[normal_ci_upper(5)./normal_ciliate_ml + 0.3 normal_ci_upper(5)./normal_ciliate_ml + 0.3],'color','b','linewidth',2);
lh2=line([4.93 5.07],[alt_ci_upper(5)./alt_ciliate_ml + 0.3 alt_ci_upper(5)./alt_ciliate_ml + 0.3],'color','r','linewidth',2);


%% SPRING- MAY 11, 2014
clear all

load '/Users/markmiller/Documents/Experiments/IFCB_14/Microscopy_vs_Imager/5-11-14//Manual_fromClass/summary/count_manual_12May2014.mat'

runtype_alt_ind=strmatch('ALT', runtype);
runtype_normal_ind=strmatch('NORMAL',runtype);

Ciliate_mix_classcount_norm=sum(classcount(runtype_normal_ind,72),1);
Mesodinium_classcount_norm=sum(classcount(runtype_normal_ind,77),1);
Laboea_classcount_norm=sum(classcount(runtype_normal_ind,75),1);
Tintinnid_classcount_norm=sum(classcount(runtype_normal_ind,90),1);
Gyro_classcount_norm=sum(classcount(runtype_normal_ind,36),1);
Proto_classcount_norm=sum(classcount(runtype_normal_ind,32),1);

Ciliate_mix_classcount_alt=sum(classcount(runtype_alt_ind,72),1);
Mesodinium_classcount_alt=sum(classcount(runtype_alt_ind,77),1);
Laboea_classcount_alt=sum(classcount(runtype_alt_ind,75),1);
Tintinnid_classcount_alt=sum(classcount(runtype_alt_ind,90),1);
Gyro_classcount_alt=sum(classcount(runtype_alt_ind,36),1);
Proto_classcount_alt=sum(classcount(runtype_alt_ind,32),1);

normal_ciliate_bin=[Ciliate_mix_classcount_norm/10 Mesodinium_classcount_norm Laboea_classcount_norm Tintinnid_classcount_norm Gyro_classcount_norm Proto_classcount_norm];
%normal_ciliate_bin=[Ciliate_mix_classcount_norm Mesodinium_classcount_norm Laboea_classcount_norm Tintinnid_classcount_norm Gyro_classcount_norm Proto_classcount_norm];

normal_ciliate_ml=sum(ml_analyzed(runtype_normal_ind));
[normal_ci] = poisson_count_ci(normal_ciliate_bin, 0.95);
normal_ci_low=normal_ci(:,1);
normal_ci_upper=normal_ci(:,2);

alt_ciliate_ml=sum(ml_analyzed(runtype_alt_ind));
alt_ciliate_bin=[Ciliate_mix_classcount_alt/10 Mesodinium_classcount_alt Laboea_classcount_alt Tintinnid_classcount_alt Gyro_classcount_alt Proto_classcount_alt];
%alt_ciliate_bin=[Ciliate_mix_classcount_alt Mesodinium_classcount_alt Laboea_classcount_alt Tintinnid_classcount_alt Gyro_classcount_alt Proto_classcount_alt];

[alt_ci] = poisson_count_ci(alt_ciliate_bin, 0.95);
alt_ci_low=alt_ci(:,1);
alt_ci_upper=alt_ci(:,2);

microscope_count = [250/10 4 26 19 10 2];

microscope_ml = 251/35.698;
[m_ci] = poisson_count_ci(microscope_count, 0.95);
m_ci_low=m_ci(:,1);
m_ci_upper=m_ci(:,2);


b = [normal_ciliate_bin./normal_ciliate_ml; alt_ciliate_bin./alt_ciliate_ml; microscope_count./microscope_ml]';
%b=[b(1,:)/10; b(2:6,:)];
errdata1 = [b(:,1)'-(normal_ci_low./normal_ciliate_ml)'; (normal_ci_upper./normal_ciliate_ml-b(:,1))']';
errdata1=[errdata1(1,:)/10; errdata1(2:6,:)];
errdata2 = [b(:,2)'-(alt_ci_low./alt_ciliate_ml)'; (alt_ci_upper./alt_ciliate_ml-b(:,2))']'; 
errdata2=[errdata2(1,:)/10; errdata2(2:6,:)];
errdata3 = [b(:,3)'-(m_ci_low./microscope_ml)'; (m_ci_upper./microscope_ml-b(:,3))']'; 
errdata3=[errdata3(1,:)/10; errdata3(2:6,:)];
errdata = [errdata1' errdata2' errdata3'];


subplot(4,1,2)

h = bar('v6', b);
set(gca, 'linewidth', 2, 'fontsize', 24,'fontname', 'Times new roman')
%set(gca, 'xticklabel', class2use','fontsize', 18, 'fontname', 'arial');
set(gca,'fontsize',14, 'fontname', 'Times new roman')
set(gca,'XTickLabel',{'Ciliate mix','Meso','Laboea','Tintinnid','Gyro','Proto','Dactyliosolen','Dictyocha','Dinobryon','Ditylum','Ephemera','Eucampia','Eucampia_groenlandica','Guinardia','Guinardia_flaccida','Leptocylindrus','Pleurosigma','Pseudonitzschia','Rhizosolenia','Skeletonema','Thalassionema','Thalassiosira','Thalassiosira_dirty','bad','ciliate','detritus','pennate','mix','clusterflagellate','crypto','dino10','dino30','Dinophysis','Euglena','flagellate','Gyrodinium','kiteflagellates','Lauderia','Licmophora','Phaeocystis','Prorocentrum','Pyramimonas','roundCell','Stephanopyxis','Tropidoneis','other','Cerataulina','Coscinodiscus','Gonyaulax','Odontella','Guinardia_striata','Paralia','mix_elongated','Hemiaulus','unclassified','Chaetoceros_flagellate','Chaetoceros_pennate','Cerataulina_flagellate','G_delicatula_parasite','G_delicatula_external_parasite','Chaetoceros_other','diatom_flagellate','other_interaction','Chaetoceros_didymus','Leptocylindrus_mediterraneus','Chaetoceros_didymus_flagellate','pennates_on_diatoms','Parvicorbicula_socialis','Delphineis','G_delicatula_detritus','amoeba','Ciliate_mix','Didinium_sp','Euplotes_sp','Laboea_strobila','Leegaardiella_ovalis','Mesodinium_sp','Pleuronema_sp','Strobilidium_morphotype1','Strobilidium_morphotype2','Strombidium_capitatum','Strombidium_caudatum','Strombidium_conicum','Strombidium_inclinatum','Strombidium_morphotype1','Strombidium_morphotype2','Strombidium_oculatum','Strombidium_wulffi','Tiarina_fusus','Tintinnid','Tontonia_appendiculariformis','Tontonia_gracillima'},...
    'XTick',[1 2 3 4 5 6],...
    'LineWidth',2,...
    'FontSize',12,...
    'FontName','Times new roman');


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

set(eh(1),'linewidth',0.5); % This changes the thickness of the errorbars
set(eh(1),'color','k'); % This changes the color of the errorbars
set(eh(2),'linestyle','none'); % This removes the connecting line
ylabel('Cell concentration (mL^{-1})','fontsize', 14, 'fontname', 'Times new roman');
lh = legend('Non-stained', 'Stained', 'Manual microscopy');
set(lh, 'box', 'off','fontsize',8)
ylim([0 8])

text(0.25,6,' B','fontsize',16, 'fontname', 'Times New Roman')

lh=line([0.71 0.85],[normal_ci_upper(1)./normal_ciliate_ml + 0.1 normal_ci_upper(1)./normal_ciliate_ml + 0.1],'color','b','linewidth',2);
lh2=line([0.93 1.07],[alt_ci_upper(1)./alt_ciliate_ml + 0.1 alt_ci_upper(1)./alt_ciliate_ml + 0.1],'color','b','linewidth',2);
lh3=line([1.15 1.29],[m_ci_upper(1)./microscope_ml-0.5  m_ci_upper(1)./microscope_ml-0.5],'color','r','linewidth',2);

text(1.3,6,'^{*}10 ','fontsize',12, 'fontname', 'Times New Roman')

%% SUMMER COMPARISON JULY 2, 2014

clear all

load '/Users/markmiller/Documents/Experiments/IFCB_14/Microscopy_vs_Imager/7-2-14/Manual_fromClass/summary/count_manual_02Jul2014.mat'
runtype_alt_ind=strmatch('ALT', runtype);
runtype_normal_ind=strmatch('NORMAL',runtype);


alt_ciliate_bin=[132 1 0 129 1 1]; %cmix, meso, laboea, tintinnid, gyro, proto
alt_ciliate_ml=sum(ml_analyzed(runtype_alt_ind));
[alt_ci] = poisson_count_ci(alt_ciliate_bin, 0.95);
alt_ci_low=alt_ci(:,1);
alt_ci_upper=alt_ci(:,2);


normal_ciliate_bin=[102 1 0 92 0 0 ];
normal_ciliate_ml=sum(ml_analyzed(runtype_normal_ind));
[normal_ci] = poisson_count_ci(normal_ciliate_bin, 0.95);
normal_ci_low=normal_ci(:,1);
normal_ci_upper=normal_ci(:,2);

microscope_count = [49 0 0 92 2 1]; 
microscope_ml = 114/8.1067; %total number/concentration of cells as determined by plankton concentration calculator
[m_ci] = poisson_count_ci(microscope_count, 0.95);
m_ci_low=m_ci(:,1);
m_ci_upper=m_ci(:,2);

b = [normal_ciliate_bin./normal_ciliate_ml; alt_ciliate_bin./alt_ciliate_ml; microscope_count./microscope_ml]';
errdata1 = [b(:,1)'-(normal_ci_low./normal_ciliate_ml)'; (normal_ci_upper./normal_ciliate_ml-b(:,1))']';
errdata2 = [b(:,2)'-(alt_ci_low./alt_ciliate_ml)'; (alt_ci_upper./alt_ciliate_ml-b(:,2))']'; 
errdata3 = [b(:,3)'-(m_ci_low./microscope_ml)'; (m_ci_upper./microscope_ml-b(:,3))']'; 
errdata = [errdata1' errdata2' errdata3'];

subplot(4,1,3)
h = bar('v6', b);
set(gca, 'linewidth', 2, 'fontsize', 24,'fontname', 'Times new roman')
%set(gca, 'xticklabel', class2use','fontsize', 18, 'fontname', 'arial');
set(gca,'fontsize',14, 'fontname', 'Times New Roman')
set(gca,'XTickLabel',{'Ciliate mix','Meso','Laboea','Tintinnid','Gyro','Proto','Dactyliosolen','Dictyocha','Dinobryon','Ditylum','Ephemera','Eucampia','Eucampia_groenlandica','Guinardia','Guinardia_flaccida','Leptocylindrus','Pleurosigma','Pseudonitzschia','Rhizosolenia','Skeletonema','Thalassionema','Thalassiosira','Thalassiosira_dirty','bad','ciliate','detritus','pennate','mix','clusterflagellate','crypto','dino10','dino30','Dinophysis','Euglena','flagellate','Gyrodinium','kiteflagellates','Lauderia','Licmophora','Phaeocystis','Prorocentrum','Pyramimonas','roundCell','Stephanopyxis','Tropidoneis','other','Cerataulina','Coscinodiscus','Gonyaulax','Odontella','Guinardia_striata','Paralia','mix_elongated','Hemiaulus','unclassified','Chaetoceros_flagellate','Chaetoceros_pennate','Cerataulina_flagellate','G_delicatula_parasite','G_delicatula_external_parasite','Chaetoceros_other','diatom_flagellate','other_interaction','Chaetoceros_didymus','Leptocylindrus_mediterraneus','Chaetoceros_didymus_flagellate','pennates_on_diatoms','Parvicorbicula_socialis','Delphineis','G_delicatula_detritus','amoeba','Ciliate_mix','Didinium_sp','Euplotes_sp','Laboea_strobila','Leegaardiella_ovalis','Mesodinium_sp','Pleuronema_sp','Strobilidium_morphotype1','Strobilidium_morphotype2','Strombidium_capitatum','Strombidium_caudatum','Strombidium_conicum','Strombidium_inclinatum','Strombidium_morphotype1','Strombidium_morphotype2','Strombidium_oculatum','Strombidium_wulffi','Tiarina_fusus','Tintinnid','Tontonia_appendiculariformis','Tontonia_gracillima'},...
    'XTick',[1 2 3 4 5 6],...
    'LineWidth',2,...
    'FontSize',12,...
    'FontName','Times new roman');


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

set(eh(1),'linewidth',0.5); % This changes the thickness of the errorbars
set(eh(1),'color','k'); % This changes the color of the errorbars
set(eh(2),'linestyle','none'); % This removes the connecting line
%ylabel('Cell concentration (mL^{-1})','fontsize', 24, 'fontname', 'Times new roman');
lh = legend('Non-stained', 'Stained', 'Manual microscopy');
set(lh, 'box', 'off','fontsize',8)

text(0.25,15,' C','fontsize',16, 'fontname', 'Times New Roman')

lh=line([0.71 0.85],[(normal_ci_upper(1)./normal_ciliate_ml + 2) (normal_ci_upper(1)./normal_ciliate_ml + 2)],'color','b','linewidth',2);
lh2=line([0.93 1.07],[alt_ci_upper(1)./alt_ciliate_ml + 2 alt_ci_upper(1)./alt_ciliate_ml + 2],'color','b','linewidth',2);
lh3=line([1.15 1.29],[m_ci_upper(1)./microscope_ml + 2 m_ci_upper(1)./microscope_ml + 2],'color','r','linewidth',2);

lh4=line([3.71 3.85],[(normal_ci_upper(1)./normal_ciliate_ml + 2) (normal_ci_upper(1)./normal_ciliate_ml + 2)],'color','b','linewidth',2);
lh5=line([3.93 4.07],[alt_ci_upper(1)./alt_ciliate_ml + 2 alt_ci_upper(1)./alt_ciliate_ml + 2],'color','r','linewidth',2);
lh6=line([4.15 4.29],[m_ci_upper(1)./microscope_ml + 6 m_ci_upper(1)./microscope_ml + 6],'color','b','linewidth',2);


%% FALL COMPARISON OCTOBER 18, 2014

clear all

load '/Volumes/IFCB_products/IFCB14_Dock/Manual_fromClass/summary/count_manual_20Oct2014.mat'

runtype_alt_ind=strmatch('ALT', runtype(287:317));
runtype_normal_ind=strmatch('NORMAL',runtype(287:317));
classcount_A=classcount(287:317,:);
ml_analyzed_A=ml_analyzed(287:317);

%%
normal_ciliate_classcount=classcount_A(runtype_normal_ind,70:88);
alt_ciliate_classcount=classcount_A(runtype_alt_ind,70:88);

ciliate_total_classcount_normal=sum(normal_ciliate_classcount,2);
ciliate_total_classcount_Alt=sum(alt_ciliate_classcount,2);

ciliate_perml_normal=ciliate_total_classcount_normal./ml_analyzed_A(runtype_normal_ind);
ciliate_perml_alt=ciliate_total_classcount_Alt./ml_analyzed_A(runtype_alt_ind);

ciliate_perml_normal_day=sum(ciliate_perml_normal);
ciliate_perml_alt_day=sum(ciliate_perml_alt);


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

normal_proto_classcount=classcount_A(runtype_normal_ind,29);
normal_proto=sum(normal_proto_classcount,1);
alt_proto_classcount=classcount_A(runtype_alt_ind,29);
alt_proto=sum(alt_proto_classcount,1);

normal_Laboea_classcount=classcount_A(runtype_normal_ind,73);
normal_Laboea=sum(normal_Laboea_classcount,1);
alt_Laboea_classcount=classcount_A(runtype_alt_ind,73);
alt_Laboea=sum(alt_Laboea_classcount,1);

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


subplot(4,1,4)
h = bar('v6', b);
set(gca, 'linewidth', 2, 'fontsize', 24,'fontname', 'times new roman')
%set(gca, 'xticklabel', class2use','fontsize', 18, 'fontname', 'arial');
set(gca,'fontsize',14, 'fontname', 'times new roman')
set(gca,'XTickLabel',{'Ciliate mix','Meso','Laboea','Tintinnid','Gyro','Proto','Dactyliosolen','Dictyocha','Dinobryon','Ditylum','Ephemera','Eucampia','Eucampia_groenlandica','Guinardia','Guinardia_flaccida','Leptocylindrus','Pleurosigma','Pseudonitzschia','Rhizosolenia','Skeletonema','Thalassionema','Thalassiosira','Thalassiosira_dirty','bad','ciliate','detritus','pennate','mix','clusterflagellate','crypto','dino10','dino30','Dinophysis','Euglena','flagellate','Gyrodinium','kiteflagellates','Lauderia','Licmophora','Phaeocystis','Prorocentrum','Pyramimonas','roundCell','Stephanopyxis','Tropidoneis','other','Cerataulina','Coscinodiscus','Gonyaulax','Odontella','Guinardia_striata','Paralia','mix_elongated','Hemiaulus','unclassified','Chaetoceros_flagellate','Chaetoceros_pennate','Cerataulina_flagellate','G_delicatula_parasite','G_delicatula_external_parasite','Chaetoceros_other','diatom_flagellate','other_interaction','Chaetoceros_didymus','Leptocylindrus_mediterraneus','Chaetoceros_didymus_flagellate','pennates_on_diatoms','Parvicorbicula_socialis','Delphineis','G_delicatula_detritus','amoeba','Ciliate_mix','Didinium_sp','Euplotes_sp','Laboea_strobila','Leegaardiella_ovalis','Mesodinium_sp','Pleuronema_sp','Strobilidium_morphotype1','Strobilidium_morphotype2','Strombidium_capitatum','Strombidium_caudatum','Strombidium_conicum','Strombidium_inclinatum','Strombidium_morphotype1','Strombidium_morphotype2','Strombidium_oculatum','Strombidium_wulffi','Tiarina_fusus','Tintinnid','Tontonia_appendiculariformis','Tontonia_gracillima'},...
    'XTick',[1 2 3 4 5 6],...
    'LineWidth',2,...
    'FontSize',12,...
    'FontName','times new roman');


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

set(eh(1),'linewidth',0.5); % This changes the thickness of the errorbars
set(eh(1),'color','k'); % This changes the color of the errorbars
set(eh(2),'linestyle','none'); % This removes the connecting line
%ylabel('Cell concentration (mL^{-1})','fontsize', 24, 'fontname', 'times new roman');
lh = legend('Non-stained', 'Stained');
set(lh, 'box', 'off','fontsize',8)

text(0.25,1.5,' D','fontsize',16, 'fontname', 'Times New Roman')

%%

