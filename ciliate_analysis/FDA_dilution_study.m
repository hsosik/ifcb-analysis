
%code for 4-24-14...experiment didn't work very well
% load '/Users/markmiller/Documents/Experiments/IFCB_14/FDA_dilution_study/Manual_fromClass/summary/count_manual_24Apr2014.mat'
% 
% runtype_alt_ind=strmatch('ALT', runtype);
% runtype_normal_ind=strmatch('NORMAL',runtype);
% 
% figure 
% classcount_100=classcount([1,2,3],:);
% classcount_100_ciliate_mix=classcount_100(:,72);
% bar([1,2,3], classcount_100_ciliate_mix./ml_analyzed([1,2,3]))
% ylabel('Ciliates (mL^{-1})');
% title('100% FDA')
% 
% figure 
% classcount_50_bad=classcount([4,5],:);
% classcount_50_bad_ciliate_mix=classcount_50_bad(:,72);
% bar([1,2], classcount_50_bad_ciliate_mix./ml_analyzed([4,5]))
% ylabel('Ciliates (mL^{-1})');
% title('50% FDA-bad')
% 
% figure 
% classcount_50=classcount([6,7,8],:);
% classcount_50_ciliate_mix=classcount_50(:,72);
% bar([1,2,3], classcount_50_ciliate_mix./ml_analyzed([6,7,8]))
% ylabel('Ciliates (mL^{-1})');
% title('50% FDA')
% 
% figure 
% classcount_10=classcount([9,10,11],:);
% classcount_10_ciliate_mix=classcount_10(:,72);
% bar([1,2,3], classcount_10_ciliate_mix./ml_analyzed([9,10,11]))
% ylabel('Ciliates (mL^{-1})');
% title('10% FDA')



load '/Users/markmiller/Documents/Experiments/IFCB_14/FDA_dilution_study/4-25-14/Manual_fromClass/summary/count_manual_28Apr2014.mat'

Ciliate_mix_classcount_perml=classcount(:,72)./ml_analyzed;
Mesodinium_classcount_perml=classcount(:,77)./ml_analyzed;
Pleuronema_classcount_perml=classcount(:,78)./ml_analyzed;
S_capitatum_classcount_perml=classcount(:,81)./ml_analyzed;
Tintinnid_classcount_perml=classcount(:,90)./ml_analyzed;

all_ciliate_classcount=sum(classcount(:,72:92),2);
all_ciliate_classcount_perml=all_ciliate_classcount./ml_analyzed;
[all_ciliate_ci] = poisson_count_ci(all_ciliate_classcount, 0.95);
lower_all_ciliate_ci_ml=all_ciliate_ci(:,1)./ml_analyzed;
upper_all_ciliate_ci_ml=all_ciliate_ci(:,2)./ml_analyzed;

lower=[all_ciliate_classcount_perml-lower_all_ciliate_ci_ml];
upper=[upper_all_ciliate_ci_ml-all_ciliate_classcount_perml];

figure
bar(1:8,[Ciliate_mix_classcount_perml Mesodinium_classcount_perml Pleuronema_classcount_perml S_capitatum_classcount_perml Tintinnid_classcount_perml],0.5,'stack');
hold on
plot(1:8, all_ciliate_classcount_perml, '.k', 'markersize', 0.1);
errorbar(1:8, all_ciliate_classcount_perml, lower, upper, 'r', 'Marker', 'none', 'LineStyle', 'none', 'Linewidth', 1 , 'color' ,[0 0 0]);
ylabel('Ciliates (mL^{-1})', 'fontsize', 12, 'fontname', 'arial');
set(gca,'xticklabel',{'0%','100%','0%','100%','0%','50%','0%','50%'}, 'fontsize', 12, 'fontname', 'arial');
%axis square
title('Automated staining 4-25-14')
legend('Ciliate_mix', 'Mesodinium', 'Pleuronema','S capitatum', 'tintinnid');


load '/Users/markmiller/Documents/Experiments/IFCB_14/FDA_dilution_study/4-27-14/Manual_fromClass/summary/count_manual_28Apr2014.mat'

Ciliate_mix_classcount_perml=classcount(:,72)./ml_analyzed;
Laboea_strobila_classcount_perml=classcount(:,75)./ml_analyzed;
Mesodinium_classcount_perml=classcount(:,77)./ml_analyzed;
Pleuronema_classcount_perml=classcount(:,78)./ml_analyzed;
Strobilidium_morphotype1_classcount_perml=classcount(:,79)./ml_analyzed;
Strombidium_morphotype1_classcount_perml=classcount(:,85)./ml_analyzed;
S_wulffi_classcount_perml=classcount(:,88)./ml_analyzed;
Tintinnid_classcount_perml=classcount(:,90)./ml_analyzed;

all_ciliate_classcount=sum(classcount(:,72:92),2);
all_ciliate_classcount_perml=all_ciliate_classcount./ml_analyzed;
[all_ciliate_ci] = poisson_count_ci(all_ciliate_classcount, 0.95);
lower_all_ciliate_ci_ml=all_ciliate_ci(:,1)./ml_analyzed;
upper_all_ciliate_ci_ml=all_ciliate_ci(:,2)./ml_analyzed;

lower=[all_ciliate_classcount_perml-lower_all_ciliate_ci_ml];
upper=[upper_all_ciliate_ci_ml-all_ciliate_classcount_perml];

figure
bar(1:8,[Ciliate_mix_classcount_perml Laboea_strobila_classcount_perml Mesodinium_classcount_perml Pleuronema_classcount_perml Strobilidium_morphotype1_classcount_perml Strombidium_morphotype1_classcount_perml S_wulffi_classcount_perml Tintinnid_classcount_perml],0.5,'stack');
hold on
plot(1:8, all_ciliate_classcount_perml, '.k', 'markersize', 0.1);
errorbar(1:8, all_ciliate_classcount_perml, lower, upper, 'r', 'Marker', 'none', 'LineStyle', 'none', 'Linewidth', 1 , 'color' ,[0 0 0]);
ylabel('Ciliates (mL^{-1})', 'fontsize', 12, 'fontname', 'arial');
set(gca,'xticklabel',{'0%','10%','0%','10%','0%','25%','0%','25%'}, 'fontsize', 12, 'fontname', 'arial');
%axis square
title('Automated staining 4-27-14')
legend('Ciliate_mix', 'Laboea strobila', 'Mesodinium', 'Pleuronema','Strob m1', 'Stromb m1','S wulffi', 'tintinnid');

%%
load '/Users/markmiller/Documents/Experiments/IFCB_14/FDA_dilution_study/4-28-14/Manual_fromClass/summary/count_manual_28Apr2014.mat'

Ciliate_mix_classcount_perml_1=classcount(:,72)./ml_analyzed;
Laboea_strobila_classcount_perml_1=classcount(:,75)./ml_analyzed;
Leegaardiella_classcount_perml_1=classcount(:,76)./ml_analyzed;
Mesodinium_classcount_perml_1=classcount(:,77)./ml_analyzed;
Pleuronema_classcount_perml_1=classcount(:,78)./ml_analyzed;
Strobilidium_morphotype1_classcount_perml_1=classcount(:,79)./ml_analyzed;
S_capitatum_classcount_perml_1=classcount(:,81)./ml_analyzed;
Strombidium_morphotype1_classcount_perml_1=classcount(:,85)./ml_analyzed;
S_wulffi_classcount_perml_1=classcount(:,88)./ml_analyzed;
Tintinnid_classcount_perml_1=classcount(:,90)./ml_analyzed;

all_ciliate_classcount=sum(classcount(:,72:92),2);
all_ciliate_classcount_perml_1=all_ciliate_classcount./ml_analyzed;
[all_ciliate_ci] = poisson_count_ci(all_ciliate_classcount, 0.95);
lower_all_ciliate_ci_ml=all_ciliate_ci(:,1)./ml_analyzed;
upper_all_ciliate_ci_ml=all_ciliate_ci(:,2)./ml_analyzed;

lower_1=[all_ciliate_classcount_perml_1-lower_all_ciliate_ci_ml];
upper_1=[upper_all_ciliate_ci_ml-all_ciliate_classcount_perml_1];

load '/Users/markmiller/Documents/Experiments/IFCB_14/FDA_dilution_study/4-29-14/Manual_fromClass/summary/count_manual_29Apr2014.mat'

Ciliate_mix_classcount_perml=classcount(:,72)./ml_analyzed;
Laboea_strobila_classcount_perml=classcount(:,75)./ml_analyzed;
Leegaardiella_classcount_perml=classcount(:,76)./ml_analyzed;
Mesodinium_classcount_perml=classcount(:,77)./ml_analyzed;
Pleuronema_classcount_perml=classcount(:,78)./ml_analyzed;
Strobilidium_morphotype1_classcount_perml=classcount(:,79)./ml_analyzed;
S_capitatum_classcount_perml=classcount(:,81)./ml_analyzed;
Strombidium_morphotype1_classcount_perml=classcount(:,85)./ml_analyzed;
S_wulffi_classcount_perml=classcount(:,88)./ml_analyzed;
Tintinnid_classcount_perml=classcount(:,90)./ml_analyzed;

all_ciliate_classcount=sum(classcount(:,72:92),2);
all_ciliate_classcount_perml=all_ciliate_classcount./ml_analyzed;
[all_ciliate_ci] = poisson_count_ci(all_ciliate_classcount, 0.95);
lower_all_ciliate_ci_ml=all_ciliate_ci(:,1)./ml_analyzed;
upper_all_ciliate_ci_ml=all_ciliate_ci(:,2)./ml_analyzed;

lower=[all_ciliate_classcount_perml-lower_all_ciliate_ci_ml];
upper=[upper_all_ciliate_ci_ml-all_ciliate_classcount_perml];

Ciliate_mix_classcount_perml=[Ciliate_mix_classcount_perml_1; Ciliate_mix_classcount_perml];
Laboea_strobila_classcount_perml=[Laboea_strobila_classcount_perml_1; Laboea_strobila_classcount_perml];
Leegaardiella_classcount_perml=[Leegaardiella_classcount_perml_1; Leegaardiella_classcount_perml];
Mesodinium_classcount_perml=[Mesodinium_classcount_perml_1; Mesodinium_classcount_perml];
Pleuronema_classcount_perml=[Pleuronema_classcount_perml_1; Pleuronema_classcount_perml];
Strobilidium_morphotype1_classcount_perml=[Strobilidium_morphotype1_classcount_perml_1; Strobilidium_morphotype1_classcount_perml];
S_capitatum_classcount_perml=[S_capitatum_classcount_perml_1; S_capitatum_classcount_perml];
Strombidium_morphotype1_classcount_perml=[Strombidium_morphotype1_classcount_perml_1; Strombidium_morphotype1_classcount_perml];
S_wulffi_classcount_perml=[S_wulffi_classcount_perml_1; S_wulffi_classcount_perml];
Tintinnid_classcount_perml=[Tintinnid_classcount_perml_1; Tintinnid_classcount_perml];

all_ciliate_classcount_perml=[all_ciliate_classcount_perml_1; all_ciliate_classcount_perml];
lower=[lower_1; lower];
upper=[upper_1; upper];

figure
bar(1:16,[Ciliate_mix_classcount_perml Laboea_strobila_classcount_perml Leegaardiella_classcount_perml Mesodinium_classcount_perml Pleuronema_classcount_perml Strobilidium_morphotype1_classcount_perml S_capitatum_classcount_perml Strombidium_morphotype1_classcount_perml S_wulffi_classcount_perml Tintinnid_classcount_perml],0.5,'stack');
hold on
plot(1:16, all_ciliate_classcount_perml, '.k', 'markersize', 0.1);
errorbar(1:16, all_ciliate_classcount_perml, lower, upper, 'r', 'Marker', 'none', 'LineStyle', 'none', 'Linewidth', 1 , 'color' ,[0 0 0]);
ylabel('Ciliates (mL^{-1})', 'fontsize', 12, 'fontname', 'arial');
set(gca,'xtick',[1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16],'xticklabel',{'0%','10%','0%','10%','0%','25%','0%','25%','0%','50%','0%','50%','0%','100%','0%','100%'}, 'fontsize', 12, 'fontname', 'arial');
%axis square

title('Manual staining 4-28-14/4-29-14')
legend('Ciliate_mix', 'Laboea strobila','Leegaardiella', 'Mesodinium', 'Pleuronema','Strob m1', 'S capitatum', 'Stromb m1','S wulffi', 'tintinnid');

%%