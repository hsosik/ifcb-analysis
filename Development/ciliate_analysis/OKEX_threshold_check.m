
clear all
close all

load '/Volumes/IFCB010_OkeanosExplorerAug2013/data/Manual_fromClass/summary/count_manual_19Jan2014.mat'
ciliate_classcount_IFCB10=classcount(9:73,72:92);
gyro_classcount_IFCB10_total=classcount(9:73,36);
ciliate_classcount_IFCB10_total=sum(ciliate_classcount_IFCB10,2);
ciliate_bin_perml_IFCB10=sum(ciliate_classcount_IFCB10_total)/sum(ml_analyzed(9:73));
gyro_bin_perml_IFCB10=sum(gyro_classcount_IFCB10_total)/sum(ml_analyzed(9:73));
[IFCB10_ci] = poisson_count_ci(sum(ciliate_classcount_IFCB10_total), 0.95);
IFCB10_ci_ml=IFCB10_ci/sum(ml_analyzed(9:73));
[IFCB10_ci_gyro] = poisson_count_ci(sum(gyro_classcount_IFCB10_total), 0.95);
IFCB10_ci_ml_gyro=IFCB10_ci_gyro/sum(ml_analyzed(9:73));
%%
load '/Volumes/IFCB014_OkeanosExplorerAug2013/data/continuous/Manual_fromClass/summary/count_manual_mid_chl02Oct2014.mat'

runtype_alt_ind=strmatch('ALT', runtype);

ciliate_classcount_high_chl=classcount_lowgreen(runtype_alt_ind(1:17),72:92);
ciliate_classcount_high_chl_total=sum(ciliate_classcount_high_chl,2);
ciliate_bin_perml_high_chl=sum(ciliate_classcount_high_chl_total)/sum(ml_analyzed_lowgreen(runtype_alt_ind(1:17)));
[high_chl_ci] = poisson_count_ci(sum(ciliate_classcount_high_chl_total), 0.95);
high_chl_ci_ml=high_chl_ci/sum(ml_analyzed_lowgreen(runtype_alt_ind(1:17)));

gyro_classcount_high_chl_total=classcount_lowgreen(runtype_alt_ind(1:17),36);
gyro_bin_perml_high_chl=sum(gyro_classcount_high_chl_total)/sum(ml_analyzed_lowgreen(runtype_alt_ind(1:17)));
[high_chl_ci_gyro] = poisson_count_ci(sum(gyro_classcount_high_chl_total), 0.95);
high_chl_ci_ml_gyro=high_chl_ci_gyro/sum(ml_analyzed_lowgreen(runtype_alt_ind(1:17)));
%%
load '/Volumes/IFCB014_OkeanosExplorerAug2013/data/continuous/Manual_fromClass/summary/count_manual_midmid_chl02Oct2014.mat'

runtype_alt_ind=strmatch('ALT', runtype(3:51));

ciliate_classcount_low_chl=classcount_lowgreen(runtype_alt_ind(1:17),72:92);
ciliate_classcount_low_chl_total=sum(ciliate_classcount_low_chl,2);
ciliate_bin_perml_low_chl=sum(ciliate_classcount_low_chl_total)/sum(ml_analyzed_lowgreen(runtype_alt_ind(1:17)));
[low_chl_ci] = poisson_count_ci(sum(ciliate_classcount_low_chl_total), 0.95);
low_chl_ci_ml=low_chl_ci/sum(ml_analyzed_lowgreen(runtype_alt_ind(1:17)));

gyro_classcount_low_chl_total=classcount_lowgreen(runtype_alt_ind(1:17),36);
gyro_bin_perml_low_chl=sum(gyro_classcount_low_chl_total)/sum(ml_analyzed_lowgreen(runtype_alt_ind(1:17)));
[low_chl_ci_gyro] = poisson_count_ci(sum(gyro_classcount_low_chl_total), 0.95);
low_chl_ci_ml_gyro=low_chl_ci_gyro/sum(ml_analyzed_lowgreen(runtype_alt_ind(1:17)));

% lower=[IFCB10_ci_ml(1) low_green_ci_ml(1) high_green_ci_ml(1)];
% upper=[IFCB10_ci_ml(2) low_green_ci_ml(2) high_green_ci_ml(2)];

lower=[IFCB10_ci_ml(1) IFCB10_ci_ml_gyro(1) low_chl_ci_ml(1) low_chl_ci_ml_gyro(1) high_chl_ci_ml(1) high_chl_ci_ml_gyro(1)];
upper=[IFCB10_ci_ml(2) IFCB10_ci_ml_gyro(2) low_chl_ci_ml(2) low_chl_ci_ml_gyro(2) high_chl_ci_ml(2) high_chl_ci_ml_gyro(2)];
 

lower=[ciliate_bin_perml_IFCB10-IFCB10_ci_ml(1) gyro_bin_perml_IFCB10-IFCB10_ci_ml_gyro(1) ciliate_bin_perml_low_chl-low_chl_ci_ml(1) ciliate_bin_perml_high_chl-high_chl_ci_ml(1) gyro_bin_perml_low_chl-low_chl_ci_ml_gyro(1) gyro_bin_perml_high_chl-high_chl_ci_ml_gyro(1)];
upper=[IFCB10_ci_ml(2)-ciliate_bin_perml_IFCB10 IFCB10_ci_ml_gyro(2)-gyro_bin_perml_IFCB10 low_chl_ci_ml(2)-ciliate_bin_perml_low_chl high_chl_ci_ml(2)-ciliate_bin_perml_high_chl low_chl_ci_ml_gyro(2)-gyro_bin_perml_low_chl high_chl_ci_ml_gyro(2)-gyro_bin_perml_high_chl];


%%
% xaxis=[1 2];
% red = [0.448 0.5195]';
% green = [0 1.2507]';
% points=[0.448 0.5195 1.7702];
% xaxis_2=[1 2 2];

xaxis=[1 2 3 4];
%red = [0.448 0.1706 0.3848 0.0495]';
red = [ciliate_bin_perml_IFCB10 gyro_bin_perml_IFCB10 ciliate_bin_perml_high_chl gyro_bin_perml_high_chl]';
%green = [0 0 1.2507 0.3463]';
green = [0 0 ciliate_bin_perml_low_chl gyro_bin_perml_low_chl]';
%points=[0.448 0.1706 0.3848 1.6355 0.0577 0.4040];
points=[ciliate_bin_perml_IFCB10 gyro_bin_perml_IFCB10 ciliate_bin_perml_high_chl gyro_bin_perml_high_chl ciliate_bin_perml_high_chl+ciliate_bin_perml_low_chl gyro_bin_perml_high_chl+gyro_bin_perml_low_chl]; 
xaxis_2=[1 2 3 3 4 4];


% Create a stacked bar chart using the bar function
figure;
bar1= bar(xaxis, [red green], 0.8, 'stack');
hold on
plot(xaxis_2, points, '.k', 'markersize', 0.1);
errorbar(xaxis_2, points, lower, upper, 'r', 'Marker', 'none', 'LineStyle', 'none', 'Linewidth', 1 , 'color' ,[0 0 0]);
set(bar1(1),'FaceColor',[0 0 1]);
set(bar1(2),'FaceColor',[0 1 0]);
ylabel('Cell abundance (cell mL^{-1})\bf', 'fontsize',24, 'fontname', 'Times New Roman');
set(gca,'xticklabel',{'Standard IFCB','Staining IFCB'}, 'fontsize', 24, 'fontname', 'Times New Roman');
axis square