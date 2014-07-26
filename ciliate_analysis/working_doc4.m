load '/Volumes/IFCB14_Dock/data/Manual_fromClass/Mxing_non_stain_3-1-14/Normal/summary/count_manual_03Mar2014.mat'
figure %example
classnum = 72; %90 for tintinnid
plot(matdate, classcount(:,classnum)./ml_analyzed, '.-')
datetick('x')
ylabel([class2use{classnum} ' (mL^{-1})'])
hold on

load '/Volumes/IFCB14_Dock/data/Manual_fromClass/Mxing_non_stain_3-1-14/Alt/summary/count_manual_03Mar2014.mat'
classnum = 72; %90 for tintinnid
plot(matdate, classcount(:,classnum)./ml_analyzed, 'r.-')
legend('no stain','stain');
title('Mixing no stain 3-1-14')


load '/Volumes/IFCB14_Dock/data/Manual_fromClass/Mixing_non_stain_2-22-14/Normal/summary/count_manual_03Mar2014.mat'
figure %example
classnum = 72; %90 for tintinnid
plot(matdate, classcount(:,classnum)./ml_analyzed, '.-')
datetick('x')
ylabel([class2use{classnum} ' (mL^{-1})'])
hold on

load '/Volumes/IFCB14_Dock/data/Manual_fromClass/Mixing_non_stain_2-22-14/Alt/summary/count_manual_03Mar2014.mat'
classnum = 72; %90 for tintinnid
plot(matdate, classcount(:,classnum)./ml_analyzed, 'r.-')
legend('no stain','stain');
title('Mixing no stain 2-22-14')



load '/Volumes/IFCB14_Dock/data/Manual_fromClass/Non_Mixing_2-17-14/Normal/summary/count_manual_03Mar2014.mat'
figure %example
classnum = 72; %90 for tintinnid
plot(matdate, classcount(:,classnum)./ml_analyzed, '.-')
datetick('x')
ylabel([class2use{classnum} ' (mL^{-1})'])
hold on

load '/Volumes/IFCB14_Dock/data/Manual_fromClass/Non_Mixing_2-17-14/Alt/summary/count_manual_03Mar2014.mat'
classnum = 72; %90 for tintinnid
plot(matdate, classcount(:,classnum)./ml_analyzed, 'r.-')

legend('no stain','stain');
title('Non Mixing- no stain  2-17-14')


load '/Volumes/IFCB14_Dock/data/Manual_fromClass/Mxing_non_stain_3-1-14/Normal/summary/count_manual_03Mar2014.mat'
ciliate_classcount_normal=classcount(:,72);
ciliate_classcount_total_normal=sum(ciliate_classcount_normal,2);
ciliate_bin_perml_normal=sum(ciliate_classcount_total_normal)/sum(ml_analyzed);
[ciliate_ci_normal] = poisson_count_ci(sum(ciliate_classcount_total_normal), 0.95);
ciliate_ci_ml_normal=ciliate_ci_normal/sum(ml_analyzed);

load '/Volumes/IFCB14_Dock/data/Manual_fromClass/Mxing_non_stain_3-1-14/Alt/summary/count_manual_03Mar2014.mat'
ciliate_classcount_alt=classcount(:,72);
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
title('Mixing no stain 3-1-14');



load '/Volumes/IFCB14_Dock/data/Manual_fromClass/Mixing_non_stain_2-22-14/Normal/summary/count_manual_03Mar2014.mat'
ciliate_classcount_normal=classcount(:,72);
ciliate_classcount_total_normal=sum(ciliate_classcount_normal,2);
ciliate_bin_perml_normal=sum(ciliate_classcount_total_normal)/sum(ml_analyzed);
[ciliate_ci_normal] = poisson_count_ci(sum(ciliate_classcount_total_normal), 0.95);
ciliate_ci_ml_normal=ciliate_ci_normal/sum(ml_analyzed);

load '/Volumes/IFCB14_Dock/data/Manual_fromClass/Mixing_non_stain_2-22-14/Alt/summary/count_manual_03Mar2014.mat'
ciliate_classcount_alt=classcount(:,72);
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
title('Mixing no stain 2-22-14');


load '/Volumes/IFCB14_Dock/data/Manual_fromClass/Non_Mixing_2-17-14/Normal/summary/count_manual_03Mar2014.mat'
ciliate_classcount_normal=classcount(:,72);
ciliate_classcount_total_normal=sum(ciliate_classcount_normal,2);
ciliate_bin_perml_normal=sum(ciliate_classcount_total_normal)/sum(ml_analyzed);
[ciliate_ci_normal] = poisson_count_ci(sum(ciliate_classcount_total_normal), 0.95);
ciliate_ci_ml_normal=ciliate_ci_normal/sum(ml_analyzed);

load '/Volumes/IFCB14_Dock/data/Manual_fromClass/Non_Mixing_2-17-14/Alt/summary/count_manual_03Mar2014.mat'
ciliate_classcount_alt=classcount(:,72);
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
title('Non Mixing- no stain  2-17-14')


load '/Users/markmiller/Desktop/Van/Normal/summary/count_manual_20Jan2014.mat'
figure %example
ciliate_classcount=classcount(:,72:92);
ciliate_sum=sum(ciliate_classcount,2);
plot(matdate, ciliate_sum./ml_analyzed, '.-')
datetick('x')
ylabel('Ciliates (mL^{-1})');
hold on

load '/Users/markmiller/Desktop/Van/Alt/summary/count_manual_19Jan2014.mat'
ciliate_classcount=classcount(:,72:92);
ciliate_sum=sum(ciliate_classcount,2);
plot(matdate, ciliate_sum./ml_analyzed, 'r.-')
legend('no stain','stain');
title('Mixing and stain 1-18-14')

load '/Users/markmiller/Desktop/Van/Normal/summary/count_manual_20Jan2014.mat'
ciliate_classcount_normal=classcount(:,72:92);
ciliate_sum_normal=sum(ciliate_classcount_normal,2);
ciliate_classcount_total_normal=sum(ciliate_sum_normal,1);
ciliate_bin_perml_normal=sum(ciliate_classcount_total_normal)/sum(ml_analyzed);
[ciliate_ci_normal] = poisson_count_ci(sum(ciliate_classcount_total_normal), 0.95);
ciliate_ci_ml_normal=ciliate_ci_normal/sum(ml_analyzed);

load '/Users/markmiller/Desktop/Van/Alt/summary/count_manual_19Jan2014.mat'
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
title('Mixing and stain  1-18-14')




