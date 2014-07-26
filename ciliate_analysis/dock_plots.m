runtype_alt_ind=strmatch('ALT', runtype);

load '/Volumes/IFCB14_Dock/data/Manual_fromClass/Stain_non_Mixing_3-7-14/Normal/summary/count_manual_11Mar2014.mat'
figure %example
ciliate_classcount=classcount(:,72:92);
ciliate_sum=sum(ciliate_classcount,2);
plot(matdate, ciliate_sum./ml_analyzed, '.-')
datetick('x')
ylabel('Ciliates (mL^{-1})');
hold on

load '/Volumes/IFCB14_Dock/data/Manual_fromClass/Stain_non_Mixing_3-7-14/Alt/summary/count_manual_11Mar2014.mat'
ciliate_classcount=classcount(:,72:92);
ciliate_sum=sum(ciliate_classcount,2);
plot(matdate, ciliate_sum./ml_analyzed, 'r.-')
legend('no stain','stain');
title('Stain and non mixing 3-7-14')

load '/Volumes/IFCB14_Dock/data/Manual_fromClass/Stain_non_Mixing_3-7-14/Normal/summary/count_manual_11Mar2014.mat'
ciliate_classcount_normal=classcount(:,72:92);
ciliate_sum_normal=sum(ciliate_classcount_normal,2);
ciliate_classcount_total_normal=sum(ciliate_sum_normal,1);
ciliate_bin_perml_normal=sum(ciliate_classcount_total_normal)/sum(ml_analyzed);
[ciliate_ci_normal] = poisson_count_ci(sum(ciliate_classcount_total_normal), 0.95);
ciliate_ci_ml_normal=ciliate_ci_normal/sum(ml_analyzed);

load '/Volumes/IFCB14_Dock/data/Manual_fromClass/Stain_non_Mixing_3-7-14/Alt/summary/count_manual_11Mar2014.mat'
ciliate_classcount_alt=classcount(:,72:92);
ciliate_sum_alt=sum(ciliate_classcount_alt,2);
ciliate_classcount_total_alt=sum(ciliate_sum_alt,1);
ciliate_bin_perml_alt=sum(ciliate_classcount_total_alt)/sum(ml_analyzed);
[ciliate_ci_alt] = poisson_count_ci(sum(ciliate_classcount_total_alt), 0.95);
ciliate_ci_ml_alt=ciliate_ci_alt/sum(ml_analyzed);

lower=[ciliate_bin_perml_normal-ciliate_ci_ml_normal(1) ciliate_bin_perml_alt-ciliate_ci_ml_alt(1)];
upper=[ciliate_ci_ml_normal(2)-ciliate_bin_perml_normal ciliate_ci_ml_alt(2)-ciliate_bin_perml_alt];


xaxis=[1 2];
points=[ciliate_bin_perml_normal ciliate_bin_perml_alt];

figure;
bar1= bar(xaxis, [ciliate_bin_perml_normal ciliate_bin_perml_alt]);
hold on
plot(xaxis, points, '.k', 'markersize', 0.1);
errorbar(xaxis, points, lower, upper, 'r', 'Marker', 'none', 'LineStyle', 'none', 'Linewidth', 1 , 'color' ,[0 0 0]);
ylabel('Ciliates (mL^{-1})', 'fontsize', 12, 'fontname', 'arial');
set(gca,'xticklabel',{'no stain','stain'}, 'fontsize', 12, 'fontname', 'arial');
axis square
title('Stain and non mixing 3-7-14')


%bar plots of individual ciliates
load '/Volumes/IFCB14_Dock/data/Manual_fromClass/Stain_non_Mixing_3-7-14/Normal/summary/count_manual_11Mar2014.mat'
ciliate_classcount_normal=classcount(:,90);
ciliate_classcount_total_normal=sum(ciliate_classcount_normal,2);
ciliate_bin_perml_normal=sum(ciliate_classcount_total_normal)/sum(ml_analyzed);
[ciliate_ci_normal] = poisson_count_ci(sum(ciliate_classcount_total_normal), 0.95);
ciliate_ci_ml_normal=ciliate_ci_normal/sum(ml_analyzed);

load '/Volumes/IFCB14_Dock/data/Manual_fromClass/Stain_non_Mixing_3-7-14/Alt/summary/count_manual_11Mar2014.mat'
ciliate_classcount_alt=classcount(:,90);
ciliate_classcount_total_alt=sum(ciliate_classcount_alt,2);
ciliate_bin_perml_alt=sum(ciliate_classcount_total_alt)/sum(ml_analyzed);
[ciliate_ci_alt] = poisson_count_ci(sum(ciliate_classcount_total_alt), 0.95);
ciliate_ci_ml_alt=ciliate_ci_alt/sum(ml_analyzed);

lower=[ciliate_bin_perml_normal-ciliate_ci_ml_normal(1) ciliate_bin_perml_alt-ciliate_ci_ml_alt(1)];
upper=[ciliate_ci_ml_normal(2)-ciliate_bin_perml_normal ciliate_ci_ml_alt(2)-ciliate_bin_perml_alt];


xaxis=[1 2];
points=[ciliate_bin_perml_normal ciliate_bin_perml_alt];

figure;
bar1= bar(xaxis, [ciliate_bin_perml_normal ciliate_bin_perml_alt]);
hold on
plot(xaxis, points, '.k', 'markersize', 0.1);
errorbar(xaxis, points, lower, upper, 'r', 'Marker', 'none', 'LineStyle', 'none', 'Linewidth', 1 , 'color' ,[0 0 0]);
ylabel('Ciliates (mL^{-1})', 'fontsize', 12, 'fontname', 'arial');
set(gca,'xticklabel',{'no stain','stain'}, 'fontsize', 12, 'fontname', 'arial');
axis square
title('Tintinnid - Mixing no stain 3-1-14');


72=ciliate mix
74=Euplotes
76=Legaardiella
77=Mesodinium
85=strombidium morphotype 1
87=strombidium oculatum
90=tintinnid

