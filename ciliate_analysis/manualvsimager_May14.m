


load '/Users/markmiller/Documents/Experiments/IFCB_14/Microscopy_vs_Imager/5-11-14//Manual_fromClass/summary/count_manual_12May2014.mat'

runtype_alt_ind=strmatch('ALT', runtype);
runtype_normal_ind=strmatch('NORMAL',runtype);

Ciliate_mix_classcount_norm=sum(classcount(runtype_normal_ind,72),1);
Mesodinium_classcount_norm=sum(classcount(runtype_normal_ind,77),1);
Laboea_classcount_norm=sum(classcount(runtype_normal_ind,75),1);
Tintinnid_classcount_norm=sum(classcount(runtype_normal_ind,90),1);
Gyro_classcount_norm=sum(classcount(runtype_normal_ind,36),1);
Proto_classcount_norm=sum(classcount(runtype_normal_ind,32),1);

normal_ciliate_ml=sum(ml_analyzed(runtype_normal_ind));
normal_ciliate_bin=[Ciliate_mix_classcount_norm Mesodinium_classcount_norm Laboea_classcount_norm Tintinnid_classcount_norm Gyro_classcount_norm Proto_classcount_norm];
[normal_ci] = poisson_count_ci(normal_ciliate_bin, 0.95);
normal_ci_perml=normal_ci./normal_ciliate_ml;
normal_conc=normal_ciliate_bin./normal_ciliate_ml;

Ciliate_mix_classcount_alt=sum(classcount(runtype_alt_ind,72),1);
Mesodinium_classcount_alt=sum(classcount(runtype_alt_ind,77),1);
Laboea_classcount_alt=sum(classcount(runtype_alt_ind,75),1);
Tintinnid_classcount_alt=sum(classcount(runtype_alt_ind,90),1);
Gyro_classcount_alt=sum(classcount(runtype_alt_ind,36),1);
Proto_classcount_alt=sum(classcount(runtype_alt_ind,32),1);

alt_ciliate_ml=sum(ml_analyzed(runtype_alt_ind));
alt_ciliate_bin=[Ciliate_mix_classcount_alt Mesodinium_classcount_alt Laboea_classcount_alt Tintinnid_classcount_alt Gyro_classcount_alt Proto_classcount_alt];
[alt_ci] = poisson_count_ci(alt_ciliate_bin, 0.95);
alt_ci_perml=alt_ci./alt_ciliate_ml;
alt_conc=alt_ciliate_bin./alt_ciliate_ml;



microscope_ciliate_bin = [20 15 1 0]; %ciliate_mix, tintinnid, myrionecta, laboea
microscope_ml = 36/5.12;
[microscope_ci] = poisson_count_ci(microscope_ciliate_bin, 0.95);
microscope_ci_perml=microscope_ci./microscope_ml;
microscope_conc=microscope_ciliate_bin./microscope_ml;

lower_ci=[normal_conc'-normal_ci_perml(:,1); alt_conc'-alt_ci_perml(:,1); microscope_conc'-microscope_ci_perml(:,1)];
upper_ci=[normal_ci_perml(:,2)-normal_conc'; alt_ci_perml(:,2)-alt_conc'; microscope_ci_perml(:,2)-microscope_conc'];

b = [normal_conc alt_conc microscope_conc]';
xaxis=[1 2 3 4 5 6 7 8 9 10 11 12];

lower_ci_vec=[lower_ci(:,1); lower_ci(:,2)];% lower_ci(:,3)];
upper_ci_vec=[upper_ci(:,1); upper_ci(:,2)];% upper_ci(:,3)];

Ciliate_mix=[normal_conc(1); alt_conc(1)];
Mesodinium=[normal_conc(2); alt_conc(2)];
Laboea=[normal_conc(3); alt_conc(3)];
Tintinnid=[normal_conc(4); alt_conc(4)];
Gyro=[normal_conc(5); alt_conc(5)];
Proto=[normal_conc(6); alt_conc(6)];

b_2=[Ciliate_mix; Mesodinium; Laboea; Tintinnid; Gyro; Proto];

lower_ci_vec_2=[lower_ci_vec(1) lower_ci_vec(7) lower_ci_vec(2)  lower_ci_vec(8)  lower_ci_vec(3)  lower_ci_vec(9)  lower_ci_vec(4)  lower_ci_vec(10)  lower_ci_vec(5)  lower_ci_vec(11)  lower_ci_vec(6)  lower_ci_vec(12)]; 
upper_ci_vec_2=[upper_ci_vec(1) upper_ci_vec(7) upper_ci_vec(2)  upper_ci_vec(8)  upper_ci_vec(3)  upper_ci_vec(9)  upper_ci_vec(4)  upper_ci_vec(10)  upper_ci_vec(5)  upper_ci_vec(11)  upper_ci_vec(6)  upper_ci_vec(12)]; 

lower_ci_vec_2=lower_ci_vec_2';
upper_ci_vec_2=upper_ci_vec_2';

% figure
% h = bar( b);
% set(gca, 'linewidth', 2, 'fontsize', 12)
% hold on
% plot(xaxis,b,'b.','markersize', 0.5)
% errorbar(xaxis, b, upper_ci_vec, upper_ci_vec, 'r', 'Marker', 'none', 'LineStyle', 'none', 'Linewidth', 1 , 'color' ,[0 0 0]);
% %set(gca, 'xticklabel', {'Ciliate_mix', 'Mesodinium', 'tintinnid','Ciliate_mix', 'Mesodinium', 'tintinnid','Ciliate_mix', 'Mesodinium', 'tintinnid'})
% set(gca, 'xticklabel', {'C_mix', 'Meso', 'tin','Laboea','C_mix', 'Meso', 'tin', 'Laboea '});%'Cmix', 'Meso', 'tin',' '})
% ylabel('Cell (mL^{-1})')

figure
h = bar( b_2);
set(gca, 'linewidth', 2, 'fontsize', 12)
hold on
plot(xaxis,b_2,'b.','markersize', 0.5)
errorbar(xaxis, b_2, lower_ci_vec_2, upper_ci_vec_2, 'r', 'Marker', 'none', 'LineStyle', 'none', 'Linewidth', 1 , 'color' ,[0 0 0]);
%set(gca, 'xticklabel', {'Ciliate_mix', 'Mesodinium', 'tintinnid','Ciliate_mix', 'Mesodinium', 'tintinnid','Ciliate_mix', 'Mesodinium', 'tintinnid'})
set(gca, 'xticklabel', {'C_mix', 'Meso', 'tin','Laboea','C_mix', 'Meso', 'tin', 'Laboea '});%'Cmix', 'Meso', 'tin',' '})
ylabel('Cell (mL^{-1})')
legend('Ciliate mix', 'Mesodinium_sp', 'Laboea', 'Tinntinnid', 'Gyrodinoid', 'Protoperidinium');