load '/Users/markmiller/Documents/Experiments/IFCB_14/New_Tubing/Manual_fromClass/summary/count_manual_09May2014.mat'

Ciliate_mix_classcount_perml=classcount(17:22,72)./ml_analyzed(17:22);
Mesodinium_classcount_perml=classcount(17:22,77)./ml_analyzed(17:22);
Pleuronema_classcount_perml=classcount(17:22,78)./ml_analyzed(17:22);
Laboea_classcount_perml=classcount(17:22,75)./ml_analyzed(17:22);
Strombidium_morphotype1_classcount_perml=classcount(17:22,85)./ml_analyzed(17:22);
Tintinnid_classcount_perml=classcount(17:22,90)./ml_analyzed(17:22);

all_ciliate_classcount=sum(classcount(17:22,72:92),2);
all_ciliate_classcount_perml=all_ciliate_classcount./ml_analyzed(17:22);
[all_ciliate_ci] = poisson_count_ci(all_ciliate_classcount, 0.95);
lower_all_ciliate_ci_ml=all_ciliate_ci(:,1)./ml_analyzed(17:22);
upper_all_ciliate_ci_ml=all_ciliate_ci(:,2)./ml_analyzed(17:22);

lower=[all_ciliate_classcount_perml-lower_all_ciliate_ci_ml];
upper=[upper_all_ciliate_ci_ml-all_ciliate_classcount_perml];

figure
bar(1:6,[Ciliate_mix_classcount_perml Mesodinium_classcount_perml Pleuronema_classcount_perml Laboea_classcount_perml Strombidium_morphotype1_classcount_perml Tintinnid_classcount_perml],0.5,'stack');
hold on
plot(1:6, all_ciliate_classcount_perml, '.k', 'markersize', 0.1);
errorbar(1:6, all_ciliate_classcount_perml, lower, upper, 'r', 'Marker', 'none', 'LineStyle', 'none', 'Linewidth', 1 , 'color' ,[0 0 0]);
ylabel('Ciliates (mL^{-1})', 'fontsize', 12, 'fontname', 'arial');
set(gca,'xticklabel',{'stain','no stain','stain','no stain','stain','no stain'}, 'fontsize', 12, 'fontname', 'arial');
%axis square
title('Automated staining 5-9-14')
legend('Ciliate_mix', 'Mesodinium', 'Pleuronema','Laboea','Stombidium M1', 'tintinnid');


%%

load '/Users/markmiller/Documents/Experiments/IFCB_14/Microscopy_vs_Imager/5-10-14/Manual_fromClass/summary/count_manual_10May2014.mat'

Ciliate_mix_classcount_perml=classcount(:,72)./ml_analyzed;
Mesodinium_classcount_perml=classcount(:,77)./ml_analyzed;
%Pleuronema_classcount_perml=classcount(17:22,78)./ml_analyzed(17:22);
Laboea_classcount_perml=classcount(:,75)./ml_analyzed;
%Strombidium_morphotype1_classcount_perml=classcount(17:22,85)./ml_analyzed(17:22);
Tintinnid_classcount_perml=classcount(:,90)./ml_analyzed;

all_ciliate_classcount=sum(classcount(:,72:92),2);
all_ciliate_classcount_perml=all_ciliate_classcount./ml_analyzed;
[all_ciliate_ci] = poisson_count_ci(all_ciliate_classcount, 0.95);
lower_all_ciliate_ci_ml=all_ciliate_ci(:,1)./ml_analyzed;
upper_all_ciliate_ci_ml=all_ciliate_ci(:,2)./ml_analyzed;

lower=[all_ciliate_classcount_perml-lower_all_ciliate_ci_ml];
upper=[upper_all_ciliate_ci_ml-all_ciliate_classcount_perml];

figure
bar(1:14,[Ciliate_mix_classcount_perml Mesodinium_classcount_perml Laboea_classcount_perml Tintinnid_classcount_perml],0.5,'stack');
hold on
plot(1:14, all_ciliate_classcount_perml, '.k', 'markersize', 0.1);
errorbar(1:14, all_ciliate_classcount_perml, lower, upper, 'r', 'Marker', 'none', 'LineStyle', 'none', 'Linewidth', 1 , 'color' ,[0 0 0]);
ylabel('Ciliates (mL^{-1})', 'fontsize', 12, 'fontname', 'arial');
set(gca,'xticklabel',{'stain','no ','stain','no ','stain','no','stain','stain','no','mixing','no','stain','no','stain'}, 'fontsize', 12, 'fontname', 'arial');
%axis square

%%
%load '/Users/markmiller/Documents/Experiments/IFCB_14/Microscopy_vs_Imager/5-11-14//Manual_fromClass/summary/count_manual_12May2014.mat'

Ciliate_mix_classcount_perml=classcount(:,72)./ml_analyzed;
Mesodinium_classcount_perml=classcount(:,77)./ml_analyzed;
%Pleuronema_classcount_perml=classcount(17:22,78)./ml_analyzed(17:22);
Laboea_classcount_perml=classcount(:,75)./ml_analyzed;
%Strombidium_morphotype1_classcount_perml=classcount(17:22,85)./ml_analyzed(17:22);
Tintinnid_classcount_perml=classcount(:,90)./ml_analyzed;

all_ciliate_classcount=sum(classcount(:,72:92),2);
all_ciliate_classcount_perml=all_ciliate_classcount./ml_analyzed;
[all_ciliate_ci] = poisson_count_ci(all_ciliate_classcount, 0.95);
lower_all_ciliate_ci_ml=all_ciliate_ci(:,1)./ml_analyzed;
upper_all_ciliate_ci_ml=all_ciliate_ci(:,2)./ml_analyzed;

lower=[all_ciliate_classcount_perml-lower_all_ciliate_ci_ml];
upper=[upper_all_ciliate_ci_ml-all_ciliate_classcount_perml];

figure
bar(1:5,[Ciliate_mix_classcount_perml Mesodinium_classcount_perml Laboea_classcount_perml Tintinnid_classcount_perml],0.5,'stack');
hold on
plot(1:5, all_ciliate_classcount_perml, '.k', 'markersize', 0.1);
errorbar(1:5, all_ciliate_classcount_perml, lower, upper, 'r', 'Marker', 'none', 'LineStyle', 'none', 'Linewidth', 1 , 'color' ,[0 0 0]);
ylabel('Ciliates (mL^{-1})', 'fontsize', 12, 'fontname', 'arial');
set(gca,'xticklabel',{'manual stain','auto stain','no stain'}, 'fontsize', 12, 'fontname', 'arial');
%axis square


title('Automated staining 5-11-14')
legend('Ciliate_mix', 'Mesodinium','Laboea', 'tintinnid');

%%