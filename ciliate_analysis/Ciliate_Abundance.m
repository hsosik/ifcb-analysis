
load 'C:\Users\Emily Fay\Documents\Ciliate_Code\count_manual_03Dec2013_day.mat'
%load 'C:\Users\Emily Fay\Documents\Ciliate_Code\count_manual_10Jun2013_day.mat'
%load 'C:\Users\Emily Fay\Documents\Ciliate_Code\count_biovol_size_manual_01May2013.mat'
[ ind_ciliate, class_label ] = get_ciliate_ind( class2use, class2use );
ciliate_classcount=(classcount_bin(:,ind_ciliate)./ml_analyzed_mat_bin(:,ind_ciliate));
ciliate_classcount(isnan(ciliate_classcount))=0;


Ciliate_mix_classcount=ciliate_classcount(:,1);   
Didinium_sp_classcount=ciliate_classcount(:,2);    
Euplotes_sp_classcount=ciliate_classcount(:,3);   
Laboea_strobila_classcount=ciliate_classcount(:,4);  
Leegaardiella_ovalis_classcount=ciliate_classcount(:,5);

Mesodinium_sp_classcount=ciliate_classcount(:,6);
Pleuronema_sp_classcount=ciliate_classcount(:,7);
Strobilidium_morphotype1_classcount=ciliate_classcount(:,8);
Strobilidium_morphotype2_classcount=ciliate_classcount(:,9);

Strombidium_capitatum_classcount=ciliate_classcount(:,10);
Strombidium_caudatum_classcount=ciliate_classcount(:,11);
Strombidium_conicum_classcount=ciliate_classcount(:,12);    
Strombidium_inclinatum_classcount=ciliate_classcount(:,13);
Strombidium_morphotype1_classcount=ciliate_classcount(:,14);
Strombidium_morphotype2_classcount=ciliate_classcount(:,15);

Strombidium_oculatum_classcount=ciliate_classcount(:,16);
Strombidium_wulffi_classcount=ciliate_classcount(:,17);
Tiarina_fusus_classcount=ciliate_classcount(:,18);
Tintinnid_classcount=ciliate_classcount(:,19);
Tontonia_appendiculariformis_classcount=ciliate_classcount(:,20);
Tontonia_gracillima_classcount=ciliate_classcount(:,21);


[mdate_mat, Ciliate_mix_mat, yearlist, yd ] = timeseries2ydmat( matdate_bin, Ciliate_mix_classcount);
[Ciliate_mix_week, Ciliate_mix_weekstd, mdate_wkmat, yd_wk] =ydmat2weeklymat(Ciliate_mix_mat, yearlist);


figure 
hold on
h= plot(yd_wk, Ciliate_mix_week, '.-');
legend(num2str((2006:2013)'), 'location', 'south');
title('Ciliate Mix', 'fontsize', 10, 'fontname', 'arial');
ylabel('Abundance (cell mL^{-1} \mum{-1})', 'fontsize', 12);
set(h(8),'DisplayName','2013','Color',[0 0 0]);
datetick('x', 3, 'keeplimits');
set(gca,'xgrid','on');

[mdate_mat, Didinium_sp_mat, yearlist, yd ] = timeseries2ydmat( matdate_bin, Didinium_sp_classcount);
[Didinium_sp_week, Didinium_sp_weekstd, mdate_wkmat, yd_wk] =ydmat2weeklymat(Didinium_sp_mat, yearlist);

figure
h= plot(yd_wk, Didinium_sp_week, '.-');
legend(num2str((2006:2013)'), 'location', 'south');
title('Didinium sp', 'fontsize', 10, 'fontname', 'arial');
ylabel('Abundance (cell mL^{-1} \mum{-1})', 'fontsize', 12);
set(h(8),'DisplayName','2013','Color',[0 0 0]);
datetick('x', 3, 'keeplimits');
set(gca,'xgrid','on');

[mdate_mat, Euplotes_sp_mat, yearlist, yd ] = timeseries2ydmat( matdate_bin, Euplotes_sp_classcount);
[Euplotes_sp_week, Euplotes_sp_weekstd, mdate_wkmat, yd_wk] =ydmat2weeklymat(Euplotes_sp_mat, yearlist);

figure
h=plot(yd_wk,Euplotes_sp_week, '.-');
legend(num2str((2006:2013)'), 'location', 'south');
title('Euplotes sp', 'fontsize', 10, 'fontname', 'arial');
ylabel('Abundance (cell mL^{-1} \mum{-1})', 'fontsize', 12);
set(h(8),'DisplayName','2013','Color',[0 0 0]);
datetick('x', 3, 'keeplimits');
set(gca,'xgrid','on');

[mdate_mat, Laboea_strobila_mat, yearlist, yd ] = timeseries2ydmat( matdate_bin, Laboea_strobila_classcount);
[Laboea_strobila_week, Laboea_strobila_weekstd, mdate_wkmat, yd_wk] =ydmat2weeklymat(Laboea_strobila_mat, yearlist);

figure
h=plot(yd_wk, Laboea_strobila_week, '.-');
legend(num2str((2006:2013)'), 'location', 'south');
title('Laboea strobila', 'fontsize', 10, 'fontname', 'arial');
ylabel('Abundance (cell mL^{-1} \mum{-1})', 'fontsize', 12);
set(h(8),'DisplayName','2013','Color',[0 0 0]);
datetick('x', 3, 'keeplimits');
set(gca,'xgrid','on');

[mdate_mat, Leegaardiella_ovalis_mat, yearlist, yd ] = timeseries2ydmat( matdate_bin, Leegaardiella_ovalis_classcount);
[Leegaardiella_ovalis_week, Leegaardiella_ovalis_weekstd, mdate_wkmat, yd_wk] =ydmat2weeklymat(Leegaardiella_ovalis_mat, yearlist);

figure
h= plot(yd_wk, Leegaardiella_ovalis_week, '.-');
legend(num2str((2006:2013)'), 'location', 'south');
title('Leegaardiella ovalis', 'fontsize', 10, 'fontname', 'arial');
ylabel('Abundance (cell mL^{-1} \mum{-1})', 'fontsize', 12);
set(h(8),'DisplayName','2013','Color',[0 0 0]);
datetick('x', 3, 'keeplimits');
set(gca,'xgrid','on');

[mdate_mat, Mesodinium_sp_mat, yearlist, yd ] = timeseries2ydmat( matdate_bin, Mesodinium_sp_classcount);
[Mesodinium_sp_week, Mesodinium_sp_weekstd, mdate_wkmat, yd_wk] =ydmat2weeklymat(Mesodinium_sp_mat, yearlist);

figure
h=plot(yd_wk, Mesodinium_sp_week, '.-');
legend(num2str((2006:2013)'), 'location', 'south');
title('Mesodinium sp', 'fontsize', 10, 'fontname', 'arial');
ylabel('Abundance (cell mL^{-1} \mum{-1})', 'fontsize', 12);
set(h(8),'DisplayName','2013','Color',[0 0 0]);
datetick('x', 3, 'keeplimits');
set(gca,'xgrid','on');


[mdate_mat, Pleuronema_sp_mat, yearlist, yd ] = timeseries2ydmat( matdate_bin, Pleuronema_sp_classcount);
[Pleuronema_sp_week, Pleuronema_sp_weekstd, mdate_wkmat, yd_wk] =ydmat2weeklymat(Pleuronema_sp_mat, yearlist);

figure
h= plot(yd_wk, Pleuronema_sp_week, '.-');
legend(num2str((2006:2013)'), 'location', 'south');
title('Pleuronema sp', 'fontsize', 10, 'fontname', 'arial');
ylabel('Abundance (cell mL^{-1} \mum{-1})', 'fontsize', 12);
set(h(8),'DisplayName','2013','Color',[0 0 0]);
datetick('x', 3, 'keeplimits');
set(gca,'xgrid','on');

[mdate_mat, Strobilidium_morphotype1_mat, yearlist, yd ] = timeseries2ydmat( matdate_bin, Strobilidium_morphotype1_classcount);
[Strobilidium_morphotype1_week, Strobilidium_morphotype1_weekstd, mdate_wkmat, yd_wk] =ydmat2weeklymat(Strobilidium_morphotype1_mat, yearlist);

figure
h= plot(yd_wk, Strobilidium_morphotype1_week, '.-');
legend(num2str((2006:2013)'), 'location', 'south');
title('Strobilidium morphotype1', 'fontsize', 10, 'fontname', 'arial');
ylabel('Abundance (cell mL^{-1} \mum{-1})', 'fontsize', 12);
set(h(8),'DisplayName','2013','Color',[0 0 0]);
datetick('x', 3, 'keeplimits');
set(gca,'xgrid','on');

[mdate_mat, Strobilidium_morphotype2_mat, yearlist, yd ] = timeseries2ydmat( matdate_bin, Strobilidium_morphotype2_classcount);
[Strobilidium_morphotype2_week, Strobilidium_morphotype2_weekstd, mdate_wkmat, yd_wk] =ydmat2weeklymat(Strobilidium_morphotype2_mat, yearlist);

figure
h= plot(yd_wk, Strobilidium_morphotype2_week, '.-');
legend(num2str((2006:2013)'), 'location', 'south');
title('Strobilidium morphotype2', 'fontsize', 10, 'fontname', 'arial');
ylabel('Abundance (cell mL^{-1} \mum{-1})', 'fontsize', 12);
set(h(8),'DisplayName','2013','Color',[0 0 0]);
datetick('x', 3, 'keeplimits');
set(gca,'xgrid','on');

[mdate_mat, Strombidium_captitatum_mat, yearlist, yd ] = timeseries2ydmat( matdate_bin, Strombidium_capitatum_classcount);
[Strombidium_captitatum_week, Strombidium_captitatum_weekstd, mdate_wkmat, yd_wk] =ydmat2weeklymat(Strombidium_captitatum_mat, yearlist);

figure
h= plot(yd_wk, Strombidium_captitatum_week, '.-');
legend(num2str((2006:2013)'), 'location', 'south');
title('Strombidium captitatum', 'fontsize', 10, 'fontname', 'arial');
ylabel('Abundance (cell mL^{-1} \mum{-1})', 'fontsize', 12);
set(h(8),'DisplayName','2013','Color',[0 0 0]);
datetick('x', 3, 'keeplimits');
set(gca,'xgrid','on');

[mdate_mat, Strombidium_caudatum_mat, yearlist, yd ] = timeseries2ydmat( matdate_bin, Strombidium_caudatum_classcount);
[Strombidium_caudatum_week, Strombidium_caudatum_weekstd, mdate_wkmat, yd_wk] =ydmat2weeklymat(Strombidium_caudatum_mat, yearlist);

figure
h=plot(yd_wk, Strombidium_caudatum_week, '.-');
legend(num2str((2006:2013)'), 'location', 'south');
title('Strombidium caudatum', 'fontsize', 10, 'fontname', 'arial');
ylabel('Abundance (cell mL^{-1} \mum{-1})', 'fontsize', 12);
set(h(8),'DisplayName','2013','Color',[0 0 0]);
datetick('x', 3, 'keeplimits');
set(gca,'xgrid','on');

[mdate_mat, Strombidium_conicum_mat, yearlist, yd ] = timeseries2ydmat( matdate_bin, Strombidium_conicum_classcount);
[Strombidium_conicum_week, Strombidium_conicum_weekstd, mdate_wkmat, yd_wk] =ydmat2weeklymat(Strombidium_conicum_mat, yearlist);

figure
h=plot(yd_wk, Strombidium_conicum_week, '.-');
legend(num2str((2006:2013)'), 'location', 'south');
title('Strombidium conicum', 'fontsize', 10, 'fontname', 'arial');
ylabel('Abundance (cell mL^{-1} \mum{-1})', 'fontsize', 12);
set(h(8),'DisplayName','2013','Color',[0 0 0]);
datetick('x', 3, 'keeplimits');
set(gca,'xgrid','on');

[mdate_mat, Strombidium_inclinatum_mat, yearlist, yd ] = timeseries2ydmat( matdate_bin, Strombidium_inclinatum_classcount);
[Strombidium_inclinatum_week, Strombidium_inclinatum_weekstd, mdate_wkmat, yd_wk] =ydmat2weeklymat(Strombidium_inclinatum_mat, yearlist);

figure
h=plot(yd_wk, Strombidium_inclinatum_week, '.-');
legend(num2str((2006:2013)'), 'location', 'south');
title('Strombidium inclinatum', 'fontsize', 10, 'fontname', 'arial');
ylabel('Abundance (cell mL^{-1} \mum{-1})', 'fontsize', 12);
set(h(8),'DisplayName','2013','Color',[0 0 0]);
datetick('x', 3, 'keeplimits');
set(gca,'xgrid','on');

[mdate_mat, Strombidium_morphotype1_mat, yearlist, yd ] = timeseries2ydmat( matdate_bin, Strombidium_morphotype1_classcount);
[Strombidium_morphotype1_week, Strombidium_morphotype1_weekstd, mdate_wkmat, yd_wk] =ydmat2weeklymat(Strombidium_morphotype1_mat, yearlist);

figure
h= plot(yd_wk, Strombidium_morphotype1_week, '.-');
legend(num2str((2006:2013)'), 'location', 'south');
title('Strombidium morphotype1', 'fontsize', 10, 'fontname', 'arial');
ylabel('Abundance (cell mL^{-1} \mum{-1})', 'fontsize', 12);
set(h(8),'DisplayName','2013','Color',[0 0 0]);
datetick('x', 3, 'keeplimits');
set(gca,'xgrid','on');

[mdate_mat, Strombidium_morphotype2_mat, yearlist, yd ] = timeseries2ydmat( matdate_bin, Strombidium_morphotype2_classcount);
[Strombidium_morphotype2_week, Strombidium_morphotype2_weekstd, mdate_wkmat, yd_wk] =ydmat2weeklymat(Strombidium_morphotype2_mat, yearlist);

figure
h= plot(yd_wk, Strombidium_morphotype2_week, '.-');
legend(num2str((2006:2013)'), 'location', 'south');
title('Strombidium morphotype2', 'fontsize', 10, 'fontname', 'arial');
ylabel('Abundance (cell mL^{-1} \mum{-1})', 'fontsize', 12);
set(h(8),'DisplayName','2013','Color',[0 0 0]);
datetick('x', 3, 'keeplimits');
set(gca,'xgrid','on');

[mdate_mat, Strombidium_oculatum_mat, yearlist, yd ] = timeseries2ydmat( matdate_bin, Strombidium_oculatum_classcount);
[Strombidium_oculatum_week, Strombidium_oculatum_weekstd, mdate_wkmat, yd_wk] =ydmat2weeklymat(Strombidium_oculatum_mat, yearlist);

figure
h= plot(yd_wk, Strombidium_oculatum_week, '.-');
legend(num2str((2006:2013)'), 'location', 'south');
title('Strombidium oculatum', 'fontsize', 10, 'fontname', 'arial');
ylabel('Abundance (cell mL^{-1} \mum{-1})', 'fontsize', 12);
set(h(8),'DisplayName','2013','Color',[0 0 0]);
datetick('x', 3, 'keeplimits');
set(gca,'xgrid','on');

[mdate_mat, Strombidium_wulffi_mat, yearlist, yd ] = timeseries2ydmat( matdate_bin, Strombidium_wulffi_classcount);
[Strombidium_wulffi_week, Strombidium_wulffi_weekstd, mdate_wkmat, yd_wk] =ydmat2weeklymat(Strombidium_wulffi_mat, yearlist);

figure
h=plot(yd_wk, Strombidium_wulffi_week, '.-');
legend(num2str((2006:2013)'), 'location', 'south');
title('Strombidium wulffi', 'fontsize', 10, 'fontname', 'arial');
ylabel('Abundance (cell mL^{-1} \mum{-1})', 'fontsize', 12);
set(h(8),'DisplayName','2013','Color',[0 0 0]);
datetick('x', 3, 'keeplimits');
set(gca,'xgrid','on');

[mdate_mat, Tiarina_fusus_mat, yearlist, yd ] = timeseries2ydmat( matdate_bin, Tiarina_fusus_classcount);
[Tiarina_fusus_week, Tiarina_fusus_weekstd, mdate_wkmat, yd_wk] =ydmat2weeklymat(Tiarina_fusus_mat, yearlist);

figure
h=plot(yd_wk, Tiarina_fusus_week, '.-');
legend(num2str((2006:2013)'), 'location', 'south');
title('Tiarina fusus', 'fontsize', 10, 'fontname', 'arial');
ylabel('Abundance (cell mL^{-1} \mum{-1})', 'fontsize', 12);
set(h(8),'DisplayName','2013','Color',[0 0 0]);
datetick('x', 3, 'keeplimits');
set(gca,'xgrid','on');

[mdate_mat, Tintinnid_mat, yearlist, yd ] = timeseries2ydmat( matdate_bin, Tintinnid_classcount);
[Tintinnid_week, Tintinnid_weekstd, mdate_wkmat, yd_wk] =ydmat2weeklymat(Tintinnid_mat, yearlist);

Tintinnid_week(isnan(Tintinnid_week))=0;
figure
h=plot(yd_wk, Tintinnid_week, '.-');
legend(num2str((2006:2013)'), 'location', 'south');
title('Tintinnid', 'fontsize', 10, 'fontname', 'arial');
ylabel('Abundance (cell mL^{-1} \mum{-1})', 'fontsize', 12);
set(h(8),'DisplayName','2013','Color',[0 0 0]);
datetick('x', 3, 'keeplimits');
set(gca,'xgrid','on');

[mdate_mat, Tontonia_appendiculariformis_mat, yearlist, yd ] = timeseries2ydmat( matdate_bin, Tontonia_appendiculariformis_classcount);
[Tontonia_appendiculariformis_week, Tontonia_appendiculariformis_weekstd, mdate_wkmat, yd_wk] =ydmat2weeklymat(Tontonia_appendiculariformis_mat, yearlist);

figure
h=plot(yd_wk, Tontonia_appendiculariformis_week, '.-');
legend(num2str((2006:2013)'), 'location', 'south');
title('Tontonia appendiculariformis', 'fontsize', 10, 'fontname', 'arial');
ylabel('Abundance (cell mL^{-1} \mum{-1})', 'fontsize', 12);
set(h(8),'DisplayName','2013','Color',[0 0 0]);
datetick('x', 3, 'keeplimits');
set(gca,'xgrid','on');

[mdate_mat, Tontonia_gracillima_mat, yearlist, yd ] = timeseries2ydmat( matdate_bin, Tontonia_gracillima_classcount);
[Tontonia_gracillima_week, Tontonia_gracillima_weekstd, mdate_wkmat, yd_wk] =ydmat2weeklymat(Tontonia_gracillima_mat, yearlist);

figure
h=plot(yd_wk, Tontonia_gracillima_week, '.-');
legend(num2str((2006:2013)'), 'location', 'south');
title('Tontonia gracillima', 'fontsize', 10, 'fontname', 'arial');
ylabel('Abundance (cell mL^{-1} \mum{-1})', 'fontsize', 12);
set(h(8),'DisplayName','2013','Color',[0 0 0]);
datetick('x', 3, 'keeplimits');
set(gca,'xgrid','on');




[smoothclimatology_Ciliate_mix_weekly, std_Ciliate_mix_week] = smoothed_climatology(Ciliate_mix_week, 1);


% figure
% th1 = subplot(4,1,1);
% plot(yd_wk, Strombidium_morphotype1_week, '.-')
% legend(num2str((2006:2013)'), 'location', 'south');
% title('Strombidium 1', 'fontsize', 10, 'fontname', 'arial');
% datetick('x', 3, 'keeplimits');
% set(gca,'xgrid','on');
% 
% th2 = subplot(4,1,2);
% plot(yd_wk, Strombidium_morphotype2_week, '.-')
% title('Strombidium 2', 'fontsize', 10, 'fontname', 'arial');
% datetick('x', 3, 'keeplimits');
% set(gca,'xgrid','on');
% 
% th3 = subplot(4,1,3);
% plot(yd_wk, S_inclinatum_week, '.-')
% title('S inclinatum', 'fontsize', 10, 'fontname', 'arial');
% datetick('x', 3, 'keeplimits');
% set(gca,'xgrid','on');
% 
% th4 = subplot(4,1,4);
% plot(yd_wk, S_capitatum_week, '.-')
% title('S capitatum', 'fontsize', 10, 'fontname', 'arial');
% datetick('x', 3, 'keeplimits');
% set(gca,'xgrid','on');


