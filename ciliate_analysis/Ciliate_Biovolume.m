load '/Volumes/d_work/IFCB1/ifcb_data_mvco_jun06/Manual_fromClass/summary/count_biovol_manual_current_day.mat'

[ ind_ciliate, class_label ] = get_ciliate_ind( class2use, class2use );
ciliate_classcount=(classbiovol_bin(:,ind_ciliate)./ml_analyzed_mat_bin(:,ind_ciliate));
%ciliate_classcount=(classcount_bin(:,ind_ciliate)./ml_analyzed_mat_bin(:,ind_ciliate));
ciliate_classcount(isnan(ciliate_classcount))=0;

Ciliate_all_classcount=ciliate_classcount(:,1:19);
ciliate_all_sum=sum(ciliate_classcount,2);

Ciliate_mix_classcount=ciliate_classcount(:,1);   
Didinium_sp_classcount=ciliate_classcount(:,2);    
Euplotes_sp_classcount=ciliate_classcount(:,3);   
Laboea_strobila_classcount=ciliate_classcount(:,4);  
Leegaardiella_ovalis_classcount=ciliate_classcount(:,5);

Mesodinium_sp_classcount=ciliate_classcount(:,6);
Pleuronema_sp_classcount=ciliate_classcount(:,7);
Strobilidium_morphotype1_classcount=ciliate_classcount(:,8);
Strombidium_capitatum_classcount=ciliate_classcount(:,9);

Strombidium_conicum_classcount=ciliate_classcount(:,10);    
Strombidium_inclinatum_classcount=ciliate_classcount(:,11);
Strombidium_morphotype1_classcount=ciliate_classcount(:,12);
Strombidium_morphotype2_classcount=ciliate_classcount(:,13);

Strombidium_oculatum_classcount=ciliate_classcount(:,14);
Strombidium_wulffi_classcount=ciliate_classcount(:,15);
Tiarina_fusus_classcount=ciliate_classcount(:,16);
Tintinnid_classcount=ciliate_classcount(:,17);
Tontonia_appendiculariformis_classcount=ciliate_classcount(:,18);
Tontonia_gracillima_classcount=ciliate_classcount(:,19);


[mdate_mat, ciliate_all_mat, yearlist, yd ] = timeseries2ydmat( matdate_bin, ciliate_all_sum);
[ciliate_all_week, mdate_wkmat, yd_wk] =ydmat2weeklymat(ciliate_all_mat, yearlist);

[mdate_mat, Ciliate_mix_mat, yearlist, yd ] = timeseries2ydmat( matdate_bin, Ciliate_mix_classcount);
[Ciliate_mix_week, mdate_wkmat, yd_wk] =ydmat2weeklymat(Ciliate_mix_mat, yearlist);

[mdate_mat, Didinium_sp_mat, yearlist, yd ] = timeseries2ydmat( matdate_bin, Didinium_sp_classcount);
[Didinium_sp_week, mdate_wkmat, yd_wk] =ydmat2weeklymat(Didinium_sp_mat, yearlist);

[mdate_mat, Euplotes_sp_mat, yearlist, yd ] = timeseries2ydmat( matdate_bin, Euplotes_sp_classcount);
[Euplotes_sp_week, mdate_wkmat, yd_wk] =ydmat2weeklymat(Euplotes_sp_mat, yearlist);

[mdate_mat, Laboea_strobila_mat, yearlist, yd ] = timeseries2ydmat( matdate_bin, Laboea_strobila_classcount);
[Laboea_strobila_week, mdate_wkmat, yd_wk] =ydmat2weeklymat(Laboea_strobila_mat, yearlist);

[mdate_mat, Leegaardiella_ovalis_mat, yearlist, yd ] = timeseries2ydmat( matdate_bin, Leegaardiella_ovalis_classcount);
[Leegaardiella_ovalis_week, mdate_wkmat, yd_wk] =ydmat2weeklymat(Leegaardiella_ovalis_mat, yearlist);

[mdate_mat, Mesodinium_sp_mat, yearlist, yd ] = timeseries2ydmat( matdate_bin, Mesodinium_sp_classcount);
[Mesodinium_sp_week, mdate_wkmat, yd_wk] =ydmat2weeklymat(Mesodinium_sp_mat, yearlist);

[mdate_mat, Pleuronema_sp_mat, yearlist, yd ] = timeseries2ydmat( matdate_bin, Pleuronema_sp_classcount);
[Pleuronema_sp_week, mdate_wkmat, yd_wk] =ydmat2weeklymat(Pleuronema_sp_mat, yearlist);

[mdate_mat, Strobilidium_morphotype1_mat, yearlist, yd ] = timeseries2ydmat( matdate_bin, Strobilidium_morphotype1_classcount);
[Strobilidium_morphotype1_week, mdate_wkmat, yd_wk] =ydmat2weeklymat(Strobilidium_morphotype1_mat, yearlist);


[mdate_mat, Strombidium_capitatum_mat, yearlist, yd ] = timeseries2ydmat( matdate_bin, Strombidium_capitatum_classcount);
[Strombidium_capitatum_week, mdate_wkmat, yd_wk] =ydmat2weeklymat(Strombidium_capitatum_mat, yearlist);


[mdate_mat, Strombidium_conicum_mat, yearlist, yd ] = timeseries2ydmat( matdate_bin, Strombidium_conicum_classcount);
[Strombidium_conicum_week, mdate_wkmat, yd_wk] =ydmat2weeklymat(Strombidium_conicum_mat, yearlist);

[mdate_mat, Strombidium_inclinatum_mat, yearlist, yd ] = timeseries2ydmat( matdate_bin, Strombidium_inclinatum_classcount);
[Strombidium_inclinatum_week, mdate_wkmat, yd_wk] =ydmat2weeklymat(Strombidium_inclinatum_mat, yearlist);

[mdate_mat, Strombidium_morphotype1_mat, yearlist, yd ] = timeseries2ydmat( matdate_bin, Strombidium_morphotype1_classcount);
[Strombidium_morphotype1_week, mdate_wkmat, yd_wk] =ydmat2weeklymat(Strombidium_morphotype1_mat, yearlist);

[mdate_mat, Strombidium_morphotype2_mat, yearlist, yd ] = timeseries2ydmat( matdate_bin, Strombidium_morphotype2_classcount);
[Strombidium_morphotype2_week, mdate_wkmat, yd_wk] =ydmat2weeklymat(Strombidium_morphotype2_mat, yearlist);

[mdate_mat, Strombidium_oculatum_mat, yearlist, yd ] = timeseries2ydmat( matdate_bin, Strombidium_oculatum_classcount);
[Strombidium_oculatum_week, mdate_wkmat, yd_wk] =ydmat2weeklymat(Strombidium_oculatum_mat, yearlist);

[mdate_mat, Strombidium_wulffi_mat, yearlist, yd ] = timeseries2ydmat( matdate_bin, Strombidium_wulffi_classcount);
[Strombidium_wulffi_week, mdate_wkmat, yd_wk] =ydmat2weeklymat(Strombidium_wulffi_mat, yearlist);

[mdate_mat, Tiarina_fusus_mat, yearlist, yd ] = timeseries2ydmat( matdate_bin, Tiarina_fusus_classcount);
[Tiarina_fusus_week, mdate_wkmat, yd_wk] =ydmat2weeklymat(Tiarina_fusus_mat, yearlist);

[mdate_mat, Tintinnid_mat, yearlist, yd ] = timeseries2ydmat( matdate_bin, Tintinnid_classcount);
[Tintinnid_week, mdate_wkmat, yd_wk] =ydmat2weeklymat(Tintinnid_mat, yearlist);

[mdate_mat, Tontonia_appendiculariformis_mat, yearlist, yd ] = timeseries2ydmat( matdate_bin, Tontonia_appendiculariformis_classcount);
[Tontonia_appendiculariformis_week, mdate_wkmat, yd_wk] =ydmat2weeklymat(Tontonia_appendiculariformis_mat, yearlist);

[mdate_mat, Tontonia_gracillima_mat, yearlist, yd ] = timeseries2ydmat( matdate_bin, Tontonia_gracillima_classcount);
[Tontonia_gracillima_week, mdate_wkmat, yd_wk] =ydmat2weeklymat(Tontonia_gracillima_mat, yearlist);


[smoothclimatology_ciliate_all_weekly, std_ciliate_all_week] = smoothed_climatology(ciliate_all_week, 1);
figure
plot(yd_wk, smoothclimatology_ciliate_all_weekly, '-b', 'LineWidth',2.5)
datetick('x', 3);
set(gca,'xgrid','on', 'FontSize',14);
ylabel('Total ciliate biovolume ( \mum^3 mL^-1)', 'fontsize', 14, 'fontname', 'arial')
%title('Total Ciliates', 'fontsize', 12, 'fontname', 'arial');
axis square


figure
plot(yd_wk, Ciliate_mix_week, '.')
hold on
plot(yd_wk, smoothclimatology_ciliate_all_weekly, '-b', 'LineWidth', 2)
datetick('x', 3);
set(gca,'xgrid','on', 'FontSize',14);
ylabel('biovolume ( \mum^3 mL^-1)', 'fontsize', 14, 'fontname', 'arial')
title('Total Ciliates', 'fontsize', 12, 'fontname', 'arial');
legend(num2str((2006:2013)'), 'location', 'south');

[smoothclimatology_Ciliate_mix_weekly, std_Ciliate_mix_week] = smoothed_climatology(Ciliate_mix_week, 1);
figure
plot(yd_wk, smoothclimatology_Ciliate_mix_weekly, '-b', 'LineWidth',2)
datetick('x', 3);
set(gca,'xgrid','on', 'FontSize',12);
ylabel('biovolume ( \mum^3 mL^-1)', 'fontsize', 14)
title('Ciliate Mix', 'fontsize', 12, 'fontname', 'arial');


figure
plot(yd_wk, Ciliate_mix_week, '.')
hold on
plot(yd_wk, smoothclimatology_Ciliate_mix_weekly, '-b', 'LineWidth', 2)
datetick('x', 3);
set(gca,'xgrid','on', 'FontSize',12);
ylabel('biovolume ( \mum^3 mL^-1)', 'fontsize', 14)
title('Ciliate Mix', 'fontsize', 12, 'fontname', 'arial');
legend(num2str((2006:2013)'), 'location', 'south');

[smoothclimatology_Didinium_sp_weekly, std_Didinium_sp_week] = smoothed_climatology(Didinium_sp_week, 1);
figure
plot(yd_wk, smoothclimatology_Didinium_sp_weekly, '-b', 'LineWidth',2)
datetick('x', 3 );
set(gca,'xgrid','on', 'FontSize',12);
ylabel('biovolume ( \mum^3 mL^-1)', 'fontsize', 14)
title('Didinium sp', 'fontsize', 12, 'fontname', 'arial');
 

figure
plot(yd_wk, Didinium_sp_week, '.')
hold on
plot(yd_wk, smoothclimatology_Didinium_sp_weekly, '-b', 'LineWidth', 2)
datetick('x', 3 );
set(gca,'xgrid','on', 'FontSize',12);
ylabel('Abundance (cell mL^{-1})', 'fontsize', 12);
title('Didinium sp', 'fontsize', 12, 'fontname', 'arial');
legend(num2str((2006:2013)'), 'location', 'south');

[smoothclimatology_Euplotes_sp_weekly, std_Euplotes_sp_week] = smoothed_climatology(Euplotes_sp_week, 1);
figure
plot(yd_wk, smoothclimatology_Euplotes_sp_weekly, '-b', 'LineWidth',2)
datetick('x', 3 );
set(gca,'xgrid','on', 'FontSize',12);
ylabel('Abundance (cell mL^{-1})', 'fontsize', 12);
title('Euplotes sp', 'fontsize', 12, 'fontname', 'arial');
 

figure
plot(yd_wk, Euplotes_sp_week, '.')
hold on
plot(yd_wk, smoothclimatology_Euplotes_sp_weekly, '-b', 'LineWidth', 2)
datetick('x', 3 );
set(gca,'xgrid','on', 'FontSize',12);
ylabel('Abundance (cell mL^{-1})', 'fontsize', 12);
title('Euplotes sp', 'fontsize', 12, 'fontname', 'arial');
legend(num2str((2006:2013)'), 'location', 'south');

[smoothclimatology_Laboea_strobila_weekly, std_Laboea_strobila_week] = smoothed_climatology(Laboea_strobila_week, 1);
figure
plot(yd_wk, smoothclimatology_Laboea_strobila_weekly, '-b', 'LineWidth',2)
datetick('x', 3 );
set(gca,'xgrid','on', 'FontSize',12);
ylabel('Abundance (cell mL^{-1})', 'fontsize', 12);
title('Laboea strobila', 'fontsize', 12, 'fontname', 'arial');
 

figure
plot(yd_wk, Laboea_strobila_week, '.')
hold on
plot(yd_wk, smoothclimatology_Laboea_strobila_weekly, '-b', 'LineWidth', 2)
datetick('x', 3 );
set(gca,'xgrid','on', 'FontSize',12);
ylabel('Abundance (cell mL^{-1})', 'fontsize', 12);
title('Laboea strobila', 'fontsize', 12, 'fontname', 'arial');
legend(num2str((2006:2013)'), 'location', 'south');

[smoothclimatology_Leegaardiella_ovalis_weekly, std_Leegaardiella_ovalis_week] = smoothed_climatology(Leegaardiella_ovalis_week, 1);
figure
plot(yd_wk, smoothclimatology_Leegaardiella_ovalis_weekly, '-b', 'LineWidth',2)
datetick('x', 3 );
set(gca,'xgrid','on', 'FontSize',12);
ylabel('Abundance (cell mL^{-1})', 'fontsize', 12);
title('Leegaardiella ovalis', 'fontsize', 12, 'fontname', 'arial');
 

figure
plot(yd_wk, Leegaardiella_ovalis_week, '.')
hold on
plot(yd_wk, smoothclimatology_Leegaardiella_ovalis_weekly, '-b', 'LineWidth', 2)
datetick('x', 3 );
set(gca,'xgrid','on', 'FontSize',12);
ylabel('Abundance (cell mL^{-1})', 'fontsize', 12);
title('Leegaardiella ovalis', 'fontsize', 12, 'fontname', 'arial');
legend(num2str((2006:2013)'), 'location', 'south');

[smoothclimatology_Mesodinium_sp_weekly, std_Mesodinium_sp_week] = smoothed_climatology(Mesodinium_sp_week, 1);
figure
plot(yd_wk, smoothclimatology_Mesodinium_sp_weekly, '-b', 'LineWidth',2)
datetick('x', 3 );
set(gca,'xgrid','on', 'FontSize',12);
ylabel('Abundance (cell mL^{-1})', 'fontsize', 12);
title('Mesodinium sp', 'fontsize', 12, 'fontname', 'arial');
 

figure
plot(yd_wk, Mesodinium_sp_week, '.')
hold on
plot(yd_wk, smoothclimatology_Mesodinium_sp_weekly, '-b', 'LineWidth', 2)
datetick('x', 3 );
set(gca,'xgrid','on', 'FontSize',12);
ylabel('Abundance (cell mL^{-1})', 'fontsize', 12);
title('Mesodinium sp', 'fontsize', 12, 'fontname', 'arial');
legend(num2str((2006:2013)'), 'location', 'south');

[smoothclimatology_Pleuronema_sp_weekly, std_Pleuronema_sp_week] = smoothed_climatology(Pleuronema_sp_week, 1);
figure
plot(yd_wk, smoothclimatology_Pleuronema_sp_weekly, '-b', 'LineWidth',2)
datetick('x', 3 );
set(gca,'xgrid','on', 'FontSize',12);
ylabel('Abundance (cell mL^{-1})', 'fontsize', 12);
title('Pleuronema sp', 'fontsize', 12, 'fontname', 'arial');
 

figure
plot(yd_wk, Pleuronema_sp_week, '.')
hold on
plot(yd_wk, smoothclimatology_Pleuronema_sp_weekly, '-b', 'LineWidth', 2)
datetick('x', 3 );
set(gca,'xgrid','on', 'FontSize',12);
ylabel('Abundance (cell mL^{-1})', 'fontsize', 12);
title('Pleuronema sp', 'fontsize', 12, 'fontname', 'arial');
legend(num2str((2006:2013)'), 'location', 'south');

[smoothclimatology_Strobilidium_morphotype1_weekly, std_Strobilidium_morphotype1_week] = smoothed_climatology(Strobilidium_morphotype1_week, 1);
figure
plot(yd_wk, smoothclimatology_Strobilidium_morphotype1_weekly, '-b', 'LineWidth',2)
datetick('x', 3 );
set(gca,'xgrid','on', 'FontSize',12);
ylabel('Abundance (cell mL^{-1})', 'fontsize', 12);
title('Strobilidium morphotype1', 'fontsize', 12, 'fontname', 'arial');
 

figure
plot(yd_wk, Strobilidium_morphotype1_week, '.')
hold on
plot(yd_wk, smoothclimatology_Strobilidium_morphotype1_weekly, '-b', 'LineWidth', 2)
datetick('x', 3 );
set(gca,'xgrid','on', 'FontSize',12);
ylabel('Abundance (cell mL^{-1})', 'fontsize', 12);
title('Strobilidium morphotype1', 'fontsize', 12, 'fontname', 'arial');
legend(num2str((2006:2013)'), 'location', 'south');


[smoothclimatology_Strombidium_capitatum_weekly, std_Strombidium_capitatum_week] = smoothed_climatology(Strombidium_capitatum_week, 1);
figure
plot(yd_wk, smoothclimatology_Strombidium_capitatum_weekly, '-b', 'LineWidth',2)
datetick('x', 3 );
set(gca,'xgrid','on', 'FontSize',12);
ylabel('Abundance (cell mL^{-1})', 'fontsize', 12);
title('Strombidium capitatum', 'fontsize', 12, 'fontname', 'arial');
 

figure
plot(yd_wk, Strombidium_capitatum_week, '.')
hold on
plot(yd_wk, smoothclimatology_Strombidium_capitatum_weekly, '-b', 'LineWidth', 2)
datetick('x', 3 );
set(gca,'xgrid','on', 'FontSize',12);
ylabel('Abundance (cell mL^{-1})', 'fontsize', 12);
title('Strombidium capitatum', 'fontsize', 12, 'fontname', 'arial');
legend(num2str((2006:2013)'), 'location', 'south');


[smoothclimatology_Strombidium_conicum_weekly, std_Strombidium_conicum_week] = smoothed_climatology(Strombidium_conicum_week, 1);
figure
plot(yd_wk, smoothclimatology_Strombidium_conicum_weekly, '-b', 'LineWidth',2)
datetick('x', 3 );
set(gca,'xgrid','on', 'FontSize',12);
ylabel('Abundance (cell mL^{-1})', 'fontsize', 12);
title('Strombidium conicum', 'fontsize', 12, 'fontname', 'arial');
 

figure
plot(yd_wk, Strombidium_conicum_week, '.')
hold on
plot(yd_wk, smoothclimatology_Strombidium_conicum_weekly, '-b', 'LineWidth', 2)
datetick('x', 3 );
set(gca,'xgrid','on', 'FontSize',12);
ylabel('Abundance (cell mL^{-1})', 'fontsize', 12);
title('Strombidium conicum', 'fontsize', 12, 'fontname', 'arial');
legend(num2str((2006:2013)'), 'location', 'south');

[smoothclimatology_Strombidium_inclinatum_weekly, std_Strombidium_inclinatum_week] = smoothed_climatology(Strombidium_inclinatum_week, 1);
figure
plot(yd_wk, smoothclimatology_Strombidium_inclinatum_weekly, '-b', 'LineWidth',2)
datetick('x', 3 );
set(gca,'xgrid','on', 'FontSize',12);
ylabel('Abundance (cell mL^{-1})', 'fontsize', 12);
title('Strombidium inclinatum', 'fontsize', 12, 'fontname', 'arial');
 

figure
plot(yd_wk, Strombidium_inclinatum_week, '.')
hold on
plot(yd_wk, smoothclimatology_Strombidium_inclinatum_weekly, '-b', 'LineWidth', 2)
datetick('x', 3 );
set(gca,'xgrid','on', 'FontSize',12);
ylabel('Abundance (cell mL^{-1})', 'fontsize', 12);
title('Strombidium inclinatum', 'fontsize', 12, 'fontname', 'arial');
legend(num2str((2006:2013)'), 'location', 'south');

[smoothclimatology_Strombidium_morphotype1_weekly, std_Strombidium_morphotype1_week] = smoothed_climatology(Strombidium_morphotype1_week, 1);
figure
plot(yd_wk, smoothclimatology_Strombidium_morphotype1_weekly, '-b', 'LineWidth',2)
datetick('x', 3 );
set(gca,'xgrid','on', 'FontSize',12);
ylabel('Abundance (cell mL^{-1})', 'fontsize', 12);
title('Strombidium morphotype1', 'fontsize', 12, 'fontname', 'arial');
 

figure
plot(yd_wk, Strombidium_morphotype1_week, '.')
hold on
plot(yd_wk, smoothclimatology_Strombidium_morphotype1_weekly, '-b', 'LineWidth', 2)
datetick('x', 3 );
set(gca,'xgrid','on', 'FontSize',12);
ylabel('Abundance (cell mL^{-1})', 'fontsize', 12);
title('Strombidium morphotype1', 'fontsize', 12, 'fontname', 'arial');
legend(num2str((2006:2013)'), 'location', 'south');

[smoothclimatology_Strombidium_morphotype2_weekly, std_Strombidium_morphotype2_week] = smoothed_climatology(Strombidium_morphotype2_week, 1);
figure
plot(yd_wk, smoothclimatology_Strombidium_morphotype2_weekly, '-b', 'LineWidth',2)
datetick('x', 3 );
set(gca,'xgrid','on', 'FontSize',12);
ylabel('Abundance (cell mL^{-1})', 'fontsize', 12);
title('Strombidium morphotype2', 'fontsize', 12, 'fontname', 'arial');
 

figure
plot(yd_wk, Strombidium_morphotype2_week, '.')
hold on
plot(yd_wk, smoothclimatology_Strombidium_morphotype2_weekly, '-b', 'LineWidth', 2)
datetick('x', 3 );
set(gca,'xgrid','on', 'FontSize',12);
ylabel('Abundance (cell mL^{-1})', 'fontsize', 12);
title('Strombidium morphotype2', 'fontsize', 12, 'fontname', 'arial');
legend(num2str((2006:2013)'), 'location', 'south');

[smoothclimatology_Strombidium_oculatum_weekly, std_Strombidium_oculatum_week] = smoothed_climatology(Strombidium_oculatum_week, 1);
figure
plot(yd_wk, smoothclimatology_Strombidium_oculatum_weekly, '-b', 'LineWidth',2)
datetick('x', 3 );
set(gca,'xgrid','on', 'FontSize',12);
ylabel('Abundance (cell mL^{-1})', 'fontsize', 12);
title('Strombidium oculatum', 'fontsize', 12, 'fontname', 'arial');
 

figure
plot(yd_wk, Strombidium_oculatum_week, '.')
hold on
plot(yd_wk, smoothclimatology_Strombidium_oculatum_weekly, '-b', 'LineWidth', 2)
datetick('x', 3 );
set(gca,'xgrid','on', 'FontSize',12);
ylabel('Abundance (cell mL^{-1})', 'fontsize', 12);
title('Strombidium oculatum', 'fontsize', 12, 'fontname', 'arial');
legend(num2str((2006:2013)'), 'location', 'south');

[smoothclimatology_Strombidium_wulffi_weekly, std_Strombidium_wulffi_week] = smoothed_climatology(Strombidium_wulffi_week, 1);
figure
plot(yd_wk, smoothclimatology_Strombidium_wulffi_weekly, '-b', 'LineWidth',2)
datetick('x', 3 );
set(gca,'xgrid','on', 'FontSize',12);
ylabel('Abundance (cell mL^{-1})', 'fontsize', 12);
title('Strombidium wulffi', 'fontsize', 12, 'fontname', 'arial');
 

figure
plot(yd_wk, Strombidium_wulffi_week, '.')
hold on
plot(yd_wk, smoothclimatology_Strombidium_wulffi_weekly, '-b', 'LineWidth', 2)
datetick('x', 3 );
set(gca,'xgrid','on', 'FontSize',12);
ylabel('Abundance (cell mL^{-1})', 'fontsize', 12);
title('Strombidium wulffi', 'fontsize', 12, 'fontname', 'arial');
legend(num2str((2006:2013)'), 'location', 'south');

[smoothclimatology_Tiarina_fusus_weekly, std_Tiarina_fusus_week] = smoothed_climatology(Tiarina_fusus_week, 1);
figure
plot(yd_wk, smoothclimatology_Tiarina_fusus_weekly, '-b', 'LineWidth',2)
datetick('x', 3 );
set(gca,'xgrid','on', 'FontSize',12);
ylabel('Abundance (cell mL^{-1})', 'fontsize', 12);
title('Tiarina fusus', 'fontsize', 12, 'fontname', 'arial');
 

figure
plot(yd_wk, Tiarina_fusus_week, '.')
hold on
plot(yd_wk, smoothclimatology_Tiarina_fusus_weekly, '-b', 'LineWidth', 2)
datetick('x', 3 );
set(gca,'xgrid','on', 'FontSize',12);
ylabel('Abundance (cell mL^{-1})', 'fontsize', 12);
title('Tiarina fusus', 'fontsize', 12, 'fontname', 'arial');
legend(num2str((2006:2013)'), 'location', 'south');

[smoothclimatology_Tintinnid_weekly, std_Tintinnid_week] = smoothed_climatology(Tintinnid_week, 1);
figure
plot(yd_wk, smoothclimatology_Tintinnid_weekly, '-b', 'LineWidth',2)
datetick('x', 3 );
set(gca,'xgrid','on', 'FontSize',12);
ylabel('Abundance (cell mL^{-1})', 'fontsize', 12);
title('Tintinnid', 'fontsize', 12, 'fontname', 'arial');
 

figure
plot(yd_wk, Tintinnid_week, '.')
hold on
plot(yd_wk, smoothclimatology_Tintinnid_weekly, '-b', 'LineWidth', 2)
datetick('x', 3 );
set(gca,'xgrid','on', 'FontSize',12);
ylabel('Abundance (cell mL^{-1})', 'fontsize', 12);
title('Tintinnid', 'fontsize', 12, 'fontname', 'arial');
legend(num2str((2006:2013)'), 'location', 'south');

[smoothclimatology_Tontonia_appendiculariformis_weekly, std_Tontonia_appendiculariformis_week] = smoothed_climatology(Tontonia_appendiculariformis_week, 1);
figure
plot(yd_wk, smoothclimatology_Tontonia_appendiculariformis_weekly, '-b', 'LineWidth',2)
datetick('x', 3 );
set(gca,'xgrid','on', 'FontSize',12);
ylabel('Abundance (cell mL^{-1})', 'fontsize', 12);
title('Tontonia appendiculariformis', 'fontsize', 12, 'fontname', 'arial');
 

figure
plot(yd_wk, Tontonia_appendiculariformis_week, '.')
hold on
plot(yd_wk, smoothclimatology_Tontonia_appendiculariformis_weekly, '-b', 'LineWidth', 2)
datetick('x', 3 );
set(gca,'xgrid','on', 'FontSize',12);
ylabel('Abundance (cell mL^{-1})', 'fontsize', 12);
title('Tontonia appendiculariformis', 'fontsize', 12, 'fontname', 'arial');
legend(num2str((2006:2013)'), 'location', 'south');

[smoothclimatology_Tontonia_gracillima_weekly, std_Tontonia_gracillima_week] = smoothed_climatology(Tontonia_gracillima_week, 1);
figure
plot(yd_wk, smoothclimatology_Tontonia_gracillima_weekly, '-b', 'LineWidth',2)
datetick('x', 3 );
set(gca,'xgrid','on', 'FontSize',12);
ylabel('Abundance (cell mL^{-1})', 'fontsize', 12);
title('Tontonia gracillima', 'fontsize', 12, 'fontname', 'arial');
 

figure
plot(yd_wk, Tontonia_gracillima_week, '.')
hold on
plot(yd_wk, smoothclimatology_Tontonia_gracillima_weekly, '-b', 'LineWidth', 2)
datetick('x', 3 );
set(gca,'xgrid','on', 'FontSize',12);
ylabel('Abundance (cell mL^{-1})', 'fontsize', 12);
title('Tontonia gracillima', 'fontsize', 12, 'fontname', 'arial');
legend(num2str((2006:2013)'), 'location', 'south');

close all
%%
figure
plot(yd_wk, smoothclimatology_Leegaardiella_ovalis_weekly, '-b', 'LineWidth',2.5)
hold on
plot(yd_wk, Leegaardiella_ovalis_week, 'b.');
hold on
plot(yd_wk, smoothclimatology_Strombidium_inclinatum_weekly, '-r', 'LineWidth',2.5)
plot(yd_wk, Strombidium_inclinatum_week, 'r.');
plot(yd_wk, smoothclimatology_Strombidium_morphotype1_weekly, '-g', 'LineWidth',2.5)
plot(yd_wk, Strombidium_morphotype1_week, 'g.');
plot(yd_wk, smoothclimatology_Strombidium_morphotype2_weekly, '-k', 'LineWidth',2.5)
plot(yd_wk, Strombidium_morphotype2_week, 'k.');

%%
%h_legend=legend('\it{Leegaardiella ovalis} \rm', '\it{Strombidium inclinatum} \rm', '\it{Strombidium} \rm morphotype1' ,'\it{Strombidium} \rm morphotype2')
h_legend=legend('\it{Leegaardiella ovalis} \rm', '\it{Strombidium} \rm morphotype1' ,'\it{Strombidium} \rm morphotype2')
set(h_legend,'FontSize',10);
datetick('x', 3 );
set(gca,'xgrid','on', 'FontSize',14);
%ylabel('Abundance (cell mL^{-1})', 'fontsize', 14);
axis square
%ylim([0 0.37])
ylabel('biovolume ( \mum^3 mL^-1)', 'fontsize', 14, 'fontname', 'arial')



