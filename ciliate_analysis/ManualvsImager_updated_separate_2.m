load '/Users/markmiller/Documents/Experiments/IFCB_14/Microscopy_vs_Imager/5-11-14//Manual_fromClass/summary/count_manual_12May2014.mat'
runtype_alt_ind=strmatch('ALT', runtype);
 runtype_normal_ind=strmatch('NORMAL',runtype);

%%

Ciliate_mix_classcount_norm=sum(classcount(runtype_normal_ind,72),1);
Ciliate_mix_classcount_alt=sum(classcount(runtype_alt_ind,72),1);


Mesodinium_classcount_norm=sum(classcount(runtype_normal_ind,77),1);
Laboea_classcount_norm=sum(classcount(runtype_normal_ind,75),1);
Tintinnid_classcount_norm=sum(classcount(runtype_normal_ind,90),1);
Gyro_classcount_norm=sum(classcount(runtype_normal_ind,36),1);
Proto_classcount_norm=sum(classcount(runtype_normal_ind,32),1);

Mesodinium_classcount_alt=sum(classcount(runtype_alt_ind,77),1);
Laboea_classcount_alt=sum(classcount(runtype_alt_ind,75),1);
Tintinnid_classcount_alt=sum(classcount(runtype_alt_ind,90),1);
Gyro_classcount_alt=sum(classcount(runtype_alt_ind,36),1);
Proto_classcount_alt=sum(classcount(runtype_alt_ind,32),1);

normal_ciliate_bin=[Ciliate_mix_classcount_norm/10 Mesodinium_classcount_norm Laboea_classcount_norm Tintinnid_classcount_norm Gyro_classcount_norm Proto_classcount_norm];
normal_ciliate_ml=sum(ml_analyzed(runtype_normal_ind));
[normal_ci] = poisson_count_ci(normal_ciliate_bin, 0.95);
normal_ci_low=normal_ci(:,1);
normal_ci_upper=normal_ci(:,2);

alt_ciliate_ml=sum(ml_analyzed(runtype_alt_ind));
alt_ciliate_bin= [Ciliate_mix_classcount_alt/10 Mesodinium_classcount_alt Laboea_classcount_alt Tintinnid_classcount_alt Gyro_classcount_alt Proto_classcount_alt];
[alt_ci] = poisson_count_ci(alt_ciliate_bin, 0.95);
alt_ci_low=alt_ci(:,1);
alt_ci_upper=alt_ci(:,2);

ciliate_mix_microscope_count=250/10
microscope_count = [4 26 19 8 2];
ciliate_ml=305/35.698/10;
microscope_ml = 305/35.698;
[m_ci] = poisson_count_ci(microscope_count, 0.95);
[m_cm_ci] =poisson_count_ci(ciliate_mix_microscope,0.95);
m_ci_low=m_ci(:,1);
m_ci_upper=m_ci(:,2);
total_microscope_count=[25 4 26 19 8 2];


b = [normal_ciliate_bin./normal_ciliate_ml; alt_ciliate_bin./alt_ciliate_ml; total_microscope_count./microscope_ml]';
errdata1 = [b(:,1)'-(normal_ci_low./normal_ciliate_ml)'; (normal_ci_upper./normal_ciliate_ml-b(:,1))']';
errdata2 = [b(:,2)'-(alt_ci_low./alt_ciliate_ml)'; (alt_ci_upper./alt_ciliate_ml-b(:,2))']'; 
errdata3 = [b(:,3)'-(m_ci_low./microscope_ml)'; (m_ci_upper./microscope_ml-b(:,3))']'; 
errdata3 = [b(:,3)'-(m_ci_low./microscope_ml)'; (m_ci_upper./microscope_ml-b(:,3))']';
errdata = [errdata1' errdata2' errdata3'];
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
lh = legend('Non stained', 'Stained', 'Manual Microscopy');
set(lh, 'box', 'off')