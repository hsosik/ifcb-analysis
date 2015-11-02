

%load '/Volumes/IFCB14_Dock/data/Manual_fromClass/Stain_non_Mixing_3-7-14/summary/count_manual_18Mar2014.mat'
% load '/Volumes/IFCB14_Dock/data/Manual_fromClass/Non_Mixing_3-3-14/summary/count_manual_18Mar2014.mat'
% load '/Volumes/IFCB14_Dock/data/Manual_fromClass/Mixing_non_stain_2-22-14/summary/count_manual_18Mar2014.mat'
% load '/Volumes/IFCB14_Dock/data/Manual_fromClass/Mixing_non_stain_3-1-14/summary/count_manual_18Mar2014.mat'
load '/Volumes/IFCB14_Dock/data/Manual_fromClass/Non_Mixing_2-17-14/summary/count_manual_18Mar2014.mat'

%indexes the runtype
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
title('Stain and non mixing 2-17-14')


%bar plot of day bin of all ciliates
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
title('Stain and non mixing 3-7-14')


%bar plots of day bin of individual ciliates
ciliate_normal_classcount=normal_classcount(:,92); %need to change this number for category of ciliates you want
ciliate_bin_normal=sum(ciliate_normal_classcount,2);
ciliate_daybin_normal=sum(ciliate_bin_normal,1);
ciliate_daybin_perml_normal=ciliate_daybin_normal/sum(ml_analyzed(runtype_normal_ind));
[ciliate_ci_normal] = poisson_count_ci(ciliate_daybin_normal, 0.95);
ciliate_ci_ml_normal=ciliate_ci_normal/sum(ml_analyzed(runtype_normal_ind));

ciliate_alt_classcount=alt_classcount(:,92);
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

title('Tontonia gracillima - no mixing no stain 2-17-14');


% 72=ciliate mix
% 74=Euplotes
% 76=Legaardiella
% 77=Mesodinium
% 78=Pleuronema
% 85=strombidium morphotype 1
% 87=strombidium oculatum
% 90=tintinnid
% 92=Tontonia gracillima

