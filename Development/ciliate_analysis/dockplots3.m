
load '/Users/markmiller/Documents/Experiments/Dock_ETOH/manual_fromclass/D20140327T165806_IFCB014.mat'
adcdata=load ('/Users/markmiller/Documents/Experiments/Dock_ETOH/D20140327T165806_IFCB014.adc');

ciliate_roi_ind=find(classlist(:,4)== 1);

runtype_alt_ind=strmatch('ALT', runtype);
runtype_normal_ind=strmatch('NORMAL',runtype);

%plotting all ciliates over course of day-you probably only need this first
%figure to do what you want to do
figure 
normal_classcount=classcount(runtype_normal_ind,:);
ciliate_normal_classcount=normal_classcount(:,72:92);
ciliate_normal_sum=sum(ciliate_normal_classcount,2);
plot((matdate(runtype_normal_ind)), ciliate_normal_sum./(ml_analyzed(runtype_normal_ind)), '.-')
ylabel('Ciliates (mL^{-1})');
hold on


alt_classcount=classcount(runtype_alt_ind,:);
ciliate_alt_classcount=alt_classcount(:,72:92);
ciliate_alt_sum=sum(ciliate_alt_classcount,2);
plot((matdate(runtype_alt_ind)), ciliate_alt_sum./(ml_analyzed(runtype_alt_ind)), 'r.-')
legend('no stain','stain');
datetick('x')
title('Stain verus nonstain 3-27-14')

ciliate_bin_normal=sum(ciliate_normal_classcount,2);
ciliate_daybin_normal=sum(ciliate_bin_normal,1);
ciliate_daybin_perml_normal=ciliate_daybin_normal/sum(ml_analyzed(runtype_normal_ind));
[ciliate_ci_normal] = poisson_count_ci(ciliate_daybin_normal, 0.95);
ciliate_ci_ml_normal=ciliate_ci_normal/sum(ml_analyzed(runtype_normal_ind));


ciliate_bin_alt=sum(ciliate_alt_classcount,2);
ciliate_daybin_alt=sum(ciliate_bin_alt,1);
ciliate_daybin_perml_alt=ciliate_daybin_alt/sum(ml_analyzed(runtype_alt_ind));
[ciliate_ci_alt] = poisson_count_ci(ciliate_daybin_alt, 0.95);
ciliate_ci_ml_alt=ciliate_ci_alt/sum(ml_analyzed(runtype_alt_ind));

lower=[ciliate_daybin_perml_normal-ciliate_ci_ml_normal(1) ciliate_daybin_perml_alt-ciliate_ci_ml_alt(1)];
upper=[ciliate_ci_ml_normal(2)-ciliate_daybin_perml_normal ciliate_ci_ml_alt(2)-ciliate_daybin_perml_alt];
xaxis=[1 2];
points=[ciliate_daybin_perml_normal ciliate_daybin_perml_alt];

figure;
bar1= bar(xaxis, [ciliate_daybin_perml_normal ciliate_daybin_perml_alt]);
hold on
plot(xaxis, points, '.k', 'markersize', 0.1);
errorbar(xaxis, points, lower, upper, 'r', 'Marker', 'none', 'LineStyle', 'none', 'Linewidth', 1 , 'color' ,[0 0 0]);
ylabel('Ciliates (mL^{-1})', 'fontsize', 12, 'fontname', 'arial');
set(gca,'xticklabel',{'no stain','stain'}, 'fontsize', 12, 'fontname', 'arial');
axis square
title('Stain verus nonstain 3-27-14')


load '/Users/markmiller/Documents/Experiments/Experiments/manual_fromclass/summary/count_manual_27Mar2014.mat'

%filelist_1=Meso unstained on PE settings
%filelist_2=Meso unstained on Green settings (no PMTC)
%filelist_3=FSW on green settings
%filelist_4=FSW
%filelist_5=FSW
%filelist_6=FSW
%filelist_7=Dock sample on PE settings no stain
%filelist_8=FSW
%filelist_9=FSW
%filelist_11=Meso on FDA settings with stain
%filelist_12=Meso on FDA settings with no stain
%filelist_13=Meso on FDA settings with no stain
%filelist_14=Meso on FDA settings with no stain

%77=Meso

Meso_count_PE=classcount(1,77)/ml_analyzed(1);
Meso_count_Green=classcount(2,77)/ml_analyzed(1);

figure
bar1=bar([1 2], [Meso_count_PE Meso_count_Green]);
ylabel('Cells (mL^{-1})', 'fontsize', 12, 'fontname', 'arial');
set(gca,'xticklabel',{'PE settings','Green settings'}, 'fontsize', 12, 'fontname', 'arial');
axis square
title('Non stained Meso')

Meso_count_FSW=[classcount(3,77)/ml_analyzed(3) classcount(4,77)/ml_analyzed(4) classcount(5,77)/ml_analyzed(5)];

figure
bar1=bar([1 2 3 4], [Meso_count_Green Meso_count_FSW]);
ylabel('Cells (mL^{-1})', 'fontsize', 12, 'fontname', 'arial');
set(gca,'xticklabel',{'Meso', 'FSW 1', 'FSW 2', 'FSW 3' }, 'fontsize', 12, 'fontname', 'arial');
axis square
title('Non stained Meso')

Percent_Meso_leftover=[Meso_count_Green/Meso_count_Green Meso_count_FSW(1)/Meso_count_Green Meso_count_FSW(2)/Meso_count_Green Meso_count_FSW(3)/Meso_count_Green]*100;

figure
plot([1 2 3 4], Percent_Meso_leftover,'*-');
ylabel('Percent Meso Cells', 'fontsize', 12, 'fontname', 'arial');
set(gca,'xticklabel',{'Meso',' ', 'FSW',' ', 'FSW',' ', 'FSW',' ' }, 'fontsize', 12, 'fontname', 'arial');
axis square
title('Non stained Meso')

Cells_total=classcount(7:9,1:92);
Cells_total_ml=(sum(Cells_total,2))/ml_analyzed(7:9);
Cells_percent=[Cells_total_ml(1)/Cells_total_ml(1) Cells_total_ml(2)/Cells_total_ml(1) Cells_total_ml(3)/Cells_total_ml(1)]*100;

figure
bar([1 2 3], Cells_total_ml)
ylabel('Cells (mL^{-1})', 'fontsize', 12, 'fontname', 'arial');
set(gca,'xticklabel',{'Dock Sample', 'FSW 1', 'FSW 2' }, 'fontsize', 12, 'fontname', 'arial');
axis square
title('Unstained Dock Sample')

figure
plot([1 2 3], Cells_percent,'*-');
ylabel('Percent total Cells', 'fontsize', 12, 'fontname', 'arial');
set(gca,'xticklabel',{'Dock Sample',' ', 'FSW',' ', 'FSW',' '}, 'fontsize', 12, 'fontname', 'arial');
axis square
title('Unstained Dock Sample')

load '/Users/markmiller/Documents/Experiments/Experiments/manual_fromclass/D20140325T175541_IFCB014.mat'
adcdata=load ('/Users/markmiller/Documents/Experiments/Experiments/D20140325T175541_IFCB014.adc');

Meso_roi_ind=find(classlist(:,4)== 6);
Meso_green=adcdata(Meso_roi_ind,5);
Meso_green_mean_1=mean(Meso_green);

load '/Users/markmiller/Documents/Experiments/Experiments/manual_fromclass/D20140325T180318_IFCB014.mat'
adcdata=load ('/Users/markmiller/Documents/Experiments/Experiments/D20140325T180318_IFCB014.adc');

Meso_roi_ind=find(classlist(:,4)== 6);
Meso_green=adcdata(Meso_roi_ind,5);
Meso_green_mean_2=mean(Meso_green);

load '/Users/markmiller/Documents/Experiments/Experiments/manual_fromclass/D20140325T180838_IFCB014.mat'
adcdata=load ('/Users/markmiller/Documents/Experiments/Experiments/D20140325T180838_IFCB014.adc');

Meso_roi_ind=find(classlist(:,4)== 6);
Meso_green=adcdata(Meso_roi_ind,5);
Meso_green_mean_3=mean(Meso_green);

load '/Users/markmiller/Documents/Experiments/Experiments/manual_fromclass/D20140325T181358_IFCB014.mat'
adcdata=load ('/Users/markmiller/Documents/Experiments/Experiments/D20140325T181358_IFCB014.adc');

Meso_roi_ind=find(classlist(:,4)== 6);
Meso_green=adcdata(Meso_roi_ind,5);
Meso_green_mean_4=mean(Meso_green);

Meso_green_mean_all=[Meso_green_mean_1 Meso_green_mean_2 Meso_green_mean_3 Meso_green_mean_4];

figure
bar1=bar([1 2 3 4], Meso_green_mean_all);
ylabel('Green fluorescence', 'fontsize', 12, 'fontname', 'arial');
set(gca,'xticklabel',{'stain', 'nonstain', 'nonstain', 'nonstain' }, 'fontsize', 12, 'fontname', 'arial');
axis square
title('Meso Green Fluorescence')





