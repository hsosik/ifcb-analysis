
Ciliate_Abundance
close all

Ciliate_all_sum=sum(ciliate_classcount,2);
[mdate_mat, Ciliate_all_mat, yearlist, yd ] = timeseries2ydmat( matdate_bin, Ciliate_all_sum);
[Ciliate_all_week, mdate_wkmat, yd_wk] =ydmat2weeklymat(Ciliate_all_mat, yearlist);
[smoothclimatology_Ciliate_all_weekly, std_Ciliate_all_week] = smoothed_climatology(Ciliate_all_week, 1);

%%
figure
plot(yd_wk, Ciliate_all_week, '.','markersize',18)
hold on
plot(yd_wk, smoothclimatology_Ciliate_all_weekly, '-b', 'LineWidth', 6)
%datetick('x', 4);
%set(gca,'xgrid','on', 'FontSize',12);
%ylabel('Abundance (cell mL^{-1})', 'fontsize', 14, 'fontname', 'arial');
ylabel('biovolume ( \mum^3 mL^-1)', 'fontsize', 24, 'fontname', 'arial')
%title('Ciliates', 'fontsize', 12, 'fontname', 'arial');
lh=legend(num2str((2006:2013)'), 'location', 'south');
set(gca,'fontsize', 24, 'fontname', 'arial')
axis square
datetick('x', 3 );
set(gca,'XTickLabel',{'Jan','Apr','Jul','Oct','Jan'},...
    'XTick',[1 92 183 275 367])
%lh = legend('Normal Settings', 'Alt Settings', 'Manual Microscopy');
set(lh,'fontsize',18)

%%

[smoothclimatology_Ciliate_mix_weekly, std_Ciliate_mix_week] = smoothed_climatology(Ciliate_mix_week, 1);
% figure
% plot(yd_wk, smoothclimatology_Ciliate_mix_weekly, '-b', 'LineWidth',2)
% datetick('x', 3);
% set(gca,'xgrid','on', 'FontSize',12);
% ylabel('Abundance (cell mL^{-1})', 'fontsize', 12);
% title('Ciliate Mix', 'fontsize', 12, 'fontname', 'arial');
% ylim([0 4])

% figure
% plot(yd_wk, Ciliate_mix_week, '.')
% hold on
% plot(yd_wk, smoothclimatology_Ciliate_mix_weekly, '-b', 'LineWidth', 2)
% datetick('x', 3);
% set(gca,'xgrid','on', 'FontSize',12);
% ylabel('Abundance (cell mL^{-1})', 'fontsize', 12);
% title('Ciliate Mix', 'fontsize', 12, 'fontname', 'arial');
% legend(num2str((2006:2013)'), 'location', 'south');

[smoothclimatology_Didinium_sp_weekly, std_Didinium_sp_week] = smoothed_climatology(Didinium_sp_week, 1);
% figure
% plot(yd_wk, smoothclimatology_Didinium_sp_weekly, '-b', 'LineWidth',2)
% datetick('x', 3 );
% set(gca,'xgrid','on', 'FontSize',12);
% ylabel('Abundance (cell mL^{-1})', 'fontsize', 12);
% title('Didinium sp', 'fontsize', 12, 'fontname', 'arial');
%  
% 
% figure
% plot(yd_wk, Didinium_sp_week, '.')
% hold on
% plot(yd_wk, smoothclimatology_Didinium_sp_weekly, '-b', 'LineWidth', 2)
% datetick('x', 3 );
% set(gca,'xgrid','on', 'FontSize',12);
% ylabel('Abundance (cell mL^{-1})', 'fontsize', 12);
% title('Didinium sp', 'fontsize', 12, 'fontname', 'arial');
% legend(num2str((2006:2013)'), 'location', 'south');

[smoothclimatology_Euplotes_sp_weekly, std_Euplotes_sp_week] = smoothed_climatology(Euplotes_sp_week, 1);
% figure
% plot(yd_wk, smoothclimatology_Euplotes_sp_weekly, '-b', 'LineWidth',2)
% datetick('x', 3 );
% set(gca,'xgrid','on', 'FontSize',12);
% ylabel('Abundance (cell mL^{-1})', 'fontsize', 12);
% title('Euplotes sp', 'fontsize', 12, 'fontname', 'arial');
%  
% 
% figure
% plot(yd_wk, Euplotes_sp_week, '.')
% hold on
% plot(yd_wk, smoothclimatology_Euplotes_sp_weekly, '-b', 'LineWidth', 2)
% datetick('x', 3 );
% set(gca,'xgrid','on', 'FontSize',12);
% ylabel('Abundance (cell mL^{-1})', 'fontsize', 12);
% title('Euplotes sp', 'fontsize', 12, 'fontname', 'arial');
% legend(num2str((2006:2013)'), 'location', 'south');

[smoothclimatology_Laboea_strobila_weekly, std_Laboea_strobila_week] = smoothed_climatology(Laboea_strobila_week, 1);
% figure
% plot(yd_wk, smoothclimatology_Laboea_strobila_weekly, '-b', 'LineWidth',2)
% datetick('x', 3 );
% set(gca,'xgrid','on', 'FontSize',12);
% ylabel('Abundance (cell mL^{-1})', 'fontsize', 12);
% title('Laboea strobila', 'fontsize', 12, 'fontname', 'arial');
 

% figure
% plot(yd_wk, Laboea_strobila_week, '.')
% hold on
% plot(yd_wk, smoothclimatology_Laboea_strobila_weekly, '-b', 'LineWidth', 2)
% datetick('x', 3 );
% set(gca,'xgrid','on', 'FontSize',12);
% ylabel('Abundance (cell mL^{-1})', 'fontsize', 12);
% title('Laboea strobila', 'fontsize', 12, 'fontname', 'arial');
% legend(num2str((2006:2013)'), 'location', 'south');

[smoothclimatology_Leegaardiella_ovalis_weekly, std_Leegaardiella_ovalis_week] = smoothed_climatology(Leegaardiella_ovalis_week, 1);
% figure
% plot(yd_wk, smoothclimatology_Leegaardiella_ovalis_weekly, '-b', 'LineWidth',2)
% datetick('x', 3 );
% set(gca,'xgrid','on', 'FontSize',12);
% ylabel('Abundance (cell mL^{-1})', 'fontsize', 12);
% title('Leegaardiella ovalis', 'fontsize', 12, 'fontname', 'arial');
%  

% figure
% plot(yd_wk, Leegaardiella_ovalis_week, '.')
% hold on
% plot(yd_wk, smoothclimatology_Leegaardiella_ovalis_weekly, '-b', 'LineWidth', 2)
% datetick('x', 3 );
% set(gca,'xgrid','on', 'FontSize',12);
% ylabel('Abundance (cell mL^{-1})', 'fontsize', 12);
% title('Leegaardiella ovalis', 'fontsize', 12, 'fontname', 'arial');
% legend(num2str((2006:2013)'), 'location', 'south');

[smoothclimatology_Mesodinium_sp_weekly, std_Mesodinium_sp_week] = smoothed_climatology(Mesodinium_sp_week, 1);
% figure
% plot(yd_wk, smoothclimatology_Mesodinium_sp_weekly, '-b', 'LineWidth',2)
% datetick('x', 3 );
% set(gca,'xgrid','on', 'FontSize',12);
% ylabel('Abundance (cell mL^{-1})', 'fontsize', 12);
% title('Mesodinium sp', 'fontsize', 12, 'fontname', 'arial');
%  
% 
% figure
% plot(yd_wk, Mesodinium_sp_week, '.')
% hold on
% plot(yd_wk, smoothclimatology_Mesodinium_sp_weekly, '-b', 'LineWidth', 2)
% datetick('x', 3 );
% set(gca,'xgrid','on', 'FontSize',12);
% ylabel('Abundance (cell mL^{-1})', 'fontsize', 12);
% title('Mesodinium sp', 'fontsize', 12, 'fontname', 'arial');
% legend(num2str((2006:2013)'), 'location', 'south');

[smoothclimatology_Pleuronema_sp_weekly, std_Pleuronema_sp_week] = smoothed_climatology(Pleuronema_sp_week, 1);
% figure
% plot(yd_wk, smoothclimatology_Pleuronema_sp_weekly, '-b', 'LineWidth',2)
% datetick('x', 3 );
% set(gca,'xgrid','on', 'FontSize',12);
% ylabel('Abundance (cell mL^{-1})', 'fontsize', 12);
% title('Pleuronema sp', 'fontsize', 12, 'fontname', 'arial');
%  
% 
% figure
% plot(yd_wk, Pleuronema_sp_week, '.')
% hold on
% plot(yd_wk, smoothclimatology_Pleuronema_sp_weekly, '-b', 'LineWidth', 2)
% datetick('x', 3 );
% set(gca,'xgrid','on', 'FontSize',12);
% ylabel('Abundance (cell mL^{-1})', 'fontsize', 12);
% title('Pleuronema sp', 'fontsize', 12, 'fontname', 'arial');
% legend(num2str((2006:2013)'), 'location', 'south');

[smoothclimatology_Strobilidium_morphotype1_weekly, std_Strobilidium_morphotype1_week] = smoothed_climatology(Strobilidium_morphotype1_week, 1);
% figure
% plot(yd_wk, smoothclimatology_Strobilidium_morphotype1_weekly, '-b', 'LineWidth',2)
% datetick('x', 3 );
% set(gca,'xgrid','on', 'FontSize',12);
% ylabel('Abundance (cell mL^{-1})', 'fontsize', 12);
% title('Strobilidium morphotype1', 'fontsize', 12, 'fontname', 'arial');
%  
% 
% figure
% plot(yd_wk, Strobilidium_morphotype1_week, '.')
% hold on
% plot(yd_wk, smoothclimatology_Strobilidium_morphotype1_weekly, '-b', 'LineWidth', 2)
% datetick('x', 3 );
% set(gca,'xgrid','on', 'FontSize',12);
% ylabel('Abundance (cell mL^{-1})', 'fontsize', 12);
% title('Strobilidium morphotype1', 'fontsize', 12, 'fontname', 'arial');
% legend(num2str((2006:2013)'), 'location', 'south');

[smoothclimatology_Strobilidium_morphotype2_weekly, std_Strobilidium_morphotype2_week] = smoothed_climatology(Strobilidium_morphotype2_week, 1);
% figure
% plot(yd_wk, smoothclimatology_Strobilidium_morphotype2_weekly, '-b', 'LineWidth',2)
% datetick('x', 3 );
% set(gca,'xgrid','on', 'FontSize',12);
% ylabel('Abundance (cell mL^{-1})', 'fontsize', 12);
% title('Strobilidium morphotype2', 'fontsize', 12, 'fontname', 'arial');
%  
% 
% figure
% plot(yd_wk, Strobilidium_morphotype2_week, '.')
% hold on
% plot(yd_wk, smoothclimatology_Strobilidium_morphotype2_weekly, '-b', 'LineWidth', 2)
% datetick('x', 3 );
% set(gca,'xgrid','on', 'FontSize',12);
% ylabel('Abundance (cell mL^{-1})', 'fontsize', 12);
% title('Strobilidium morphotype2', 'fontsize', 12, 'fontname', 'arial');
% legend(num2str((2006:2013)'), 'location', 'south');

[smoothclimatology_Strombidium_capitatum_weekly, std_Strombidium_capitatum_week] = smoothed_climatology(Strombidium_capitatum_week, 1);
% figure
% plot(yd_wk, smoothclimatology_Strombidium_capitatum_weekly, '-b', 'LineWidth',2)
% datetick('x', 3 );
% set(gca,'xgrid','on', 'FontSize',12);
% ylabel('Abundance (cell mL^{-1})', 'fontsize', 12);
% title('Strombidium capitatum', 'fontsize', 12, 'fontname', 'arial');
%  
% 
% figure
% plot(yd_wk, Strombidium_capitatum_week, '.')
% hold on
% plot(yd_wk, smoothclimatology_Strombidium_capitatum_weekly, '-b', 'LineWidth', 2)
% datetick('x', 3 );
% set(gca,'xgrid','on', 'FontSize',12);
% ylabel('Abundance (cell mL^{-1})', 'fontsize', 12);
% title('Strombidium capitatum', 'fontsize', 12, 'fontname', 'arial');
% legend(num2str((2006:2013)'), 'location', 'south');

[smoothclimatology_Strombidium_caudatum_weekly, std_Strombidium_caudatum_week] = smoothed_climatology(Strombidium_caudatum_week, 1);
% figure
% plot(yd_wk, smoothclimatology_Strombidium_caudatum_weekly, '-b', 'LineWidth',2)
% datetick('x', 3 );
% set(gca,'xgrid','on', 'FontSize',12);
% ylabel('Abundance (cell mL^{-1})', 'fontsize', 12);
% title('Strombidium caudatum', 'fontsize', 12, 'fontname', 'arial');
%  
% 
% figure
% plot(yd_wk, Strombidium_caudatum_week, '.')
% hold on
% plot(yd_wk, smoothclimatology_Strombidium_caudatum_weekly, '-b', 'LineWidth', 2)
% datetick('x', 3 );
% set(gca,'xgrid','on', 'FontSize',12);
% ylabel('Abundance (cell mL^{-1})', 'fontsize', 12);
% title('Strombidium caudatum', 'fontsize', 12, 'fontname', 'arial');
% legend(num2str((2006:2013)'), 'location', 'south');

[smoothclimatology_Strombidium_conicum_weekly, std_Strombidium_conicum_week] = smoothed_climatology(Strombidium_conicum_week, 1);
% figure
% plot(yd_wk, smoothclimatology_Strombidium_conicum_weekly, '-b', 'LineWidth',2)
% datetick('x', 3 );
% set(gca,'xgrid','on', 'FontSize',12);
% ylabel('Abundance (cell mL^{-1})', 'fontsize', 12);
% title('Strombidium conicum', 'fontsize', 12, 'fontname', 'arial');
%  
% 
% figure
% plot(yd_wk, Strombidium_conicum_week, '.')
% hold on
% plot(yd_wk, smoothclimatology_Strombidium_conicum_weekly, '-b', 'LineWidth', 2)
% datetick('x', 3 );
% set(gca,'xgrid','on', 'FontSize',12);
% ylabel('Abundance (cell mL^{-1})', 'fontsize', 12);
% title('Strombidium conicum', 'fontsize', 12, 'fontname', 'arial');
% legend(num2str((2006:2013)'), 'location', 'south');

[smoothclimatology_Strombidium_inclinatum_weekly, std_Strombidium_inclinatum_week] = smoothed_climatology(Strombidium_inclinatum_week, 1);
% figure
% plot(yd_wk, smoothclimatology_Strombidium_inclinatum_weekly, '-b', 'LineWidth',2)
% datetick('x', 3 );
% set(gca,'xgrid','on', 'FontSize',12);
% ylabel('Abundance (cell mL^{-1})', 'fontsize', 12);
% title('Strombidium inclinatum', 'fontsize', 12, 'fontname', 'arial');
%  
% 
% figure
% plot(yd_wk, Strombidium_inclinatum_week, '.')
% hold on
% plot(yd_wk, smoothclimatology_Strombidium_inclinatum_weekly, '-b', 'LineWidth', 2)
% datetick('x', 3 );
% set(gca,'xgrid','on', 'FontSize',12);
% ylabel('Abundance (cell mL^{-1})', 'fontsize', 12);
% title('Strombidium inclinatum', 'fontsize', 12, 'fontname', 'arial');
% legend(num2str((2006:2013)'), 'location', 'south');

[smoothclimatology_Strombidium_morphotype1_weekly, std_Strombidium_morphotype1_week] = smoothed_climatology(Strombidium_morphotype1_week, 1);
% figure
% plot(yd_wk, smoothclimatology_Strombidium_morphotype1_weekly, '-b', 'LineWidth',2)
% datetick('x', 3 );
% set(gca,'xgrid','on', 'FontSize',12);
% ylabel('Abundance (cell mL^{-1})', 'fontsize', 12);
% title('Strombidium morphotype1', 'fontsize', 12, 'fontname', 'arial');
%  
% 
% figure
% plot(yd_wk, Strombidium_morphotype1_week, '.')
% hold on
% plot(yd_wk, smoothclimatology_Strombidium_morphotype1_weekly, '-b', 'LineWidth', 2)
% datetick('x', 3 );
% set(gca,'xgrid','on', 'FontSize',12);
% ylabel('Abundance (cell mL^{-1})', 'fontsize', 12);
% title('Strombidium morphotype1', 'fontsize', 12, 'fontname', 'arial');
% legend(num2str((2006:2013)'), 'location', 'south');

[smoothclimatology_Strombidium_morphotype2_weekly, std_Strombidium_morphotype2_week] = smoothed_climatology(Strombidium_morphotype2_week, 1);
% figure
% plot(yd_wk, smoothclimatology_Strombidium_morphotype2_weekly, '-b', 'LineWidth',2)
% datetick('x', 3 );
% set(gca,'xgrid','on', 'FontSize',12);
% ylabel('Abundance (cell mL^{-1})', 'fontsize', 12);
% title('Strombidium morphotype2', 'fontsize', 12, 'fontname', 'arial');
%  
% 
% figure
% plot(yd_wk, Strombidium_morphotype2_week, '.')
% hold on
% plot(yd_wk, smoothclimatology_Strombidium_morphotype2_weekly, '-b', 'LineWidth', 2)
% datetick('x', 3 );
% set(gca,'xgrid','on', 'FontSize',12);
% ylabel('Abundance (cell mL^{-1})', 'fontsize', 12);
% title('Strombidium morphotype2', 'fontsize', 12, 'fontname', 'arial');
% legend(num2str((2006:2013)'), 'location', 'south');

[smoothclimatology_Strombidium_oculatum_weekly, std_Strombidium_oculatum_week] = smoothed_climatology(Strombidium_oculatum_week, 1);
% figure
% plot(yd_wk, smoothclimatology_Strombidium_oculatum_weekly, '-b', 'LineWidth',2)
% datetick('x', 3 );
% set(gca,'xgrid','on', 'FontSize',12);
% ylabel('Abundance (cell mL^{-1})', 'fontsize', 12);
% title('Strombidium oculatum', 'fontsize', 12, 'fontname', 'arial');
%  
% 
% figure
% plot(yd_wk, Strombidium_oculatum_week, '.')
% hold on
% plot(yd_wk, smoothclimatology_Strombidium_oculatum_weekly, '-b', 'LineWidth', 2)
% datetick('x', 3 );
% set(gca,'xgrid','on', 'FontSize',12);
% ylabel('Abundance (cell mL^{-1})', 'fontsize', 12);
% title('Strombidium oculatum', 'fontsize', 12, 'fontname', 'arial');
% legend(num2str((2006:2013)'), 'location', 'south');

[smoothclimatology_Strombidium_wulffi_weekly, std_Strombidium_wulffi_week] = smoothed_climatology(Strombidium_wulffi_week, 1);
% figure
% plot(yd_wk, smoothclimatology_Strombidium_wulffi_weekly, '-b', 'LineWidth',2)
% datetick('x', 3 );
% set(gca,'xgrid','on', 'FontSize',12);
% ylabel('Abundance (cell mL^{-1})', 'fontsize', 12);
% title('Strombidium wulffi', 'fontsize', 12, 'fontname', 'arial');
%  
% 
% figure
% plot(yd_wk, Strombidium_wulffi_week, '.')
% hold on
% plot(yd_wk, smoothclimatology_Strombidium_wulffi_weekly, '-b', 'LineWidth', 2)
% datetick('x', 3 );
% set(gca,'xgrid','on', 'FontSize',12);
% ylabel('Abundance (cell mL^{-1})', 'fontsize', 12);
% title('Strombidium wulffi', 'fontsize', 12, 'fontname', 'arial');
% legend(num2str((2006:2013)'), 'location', 'south');

[smoothclimatology_Tiarina_fusus_weekly, std_Tiarina_fusus_week] = smoothed_climatology(Tiarina_fusus_week, 1);
% figure
% plot(yd_wk, smoothclimatology_Tiarina_fusus_weekly, '-b', 'LineWidth',2)
% datetick('x', 3 );
% set(gca,'xgrid','on', 'FontSize',12);
% ylabel('Abundance (cell mL^{-1})', 'fontsize', 12);
% title('Tiarina fusus', 'fontsize', 12, 'fontname', 'arial');
%  
% 
% figure
% plot(yd_wk, Tiarina_fusus_week, '.')
% hold on
% plot(yd_wk, smoothclimatology_Tiarina_fusus_weekly, '-b', 'LineWidth', 2)
% datetick('x', 3 );
% set(gca,'xgrid','on', 'FontSize',12);
% ylabel('Abundance (cell mL^{-1})', 'fontsize', 12);
% title('Tiarina fusus', 'fontsize', 12, 'fontname', 'arial');
% legend(num2str((2006:2013)'), 'location', 'south');

[smoothclimatology_Tintinnid_weekly, std_Tintinnid_week] = smoothed_climatology(Tintinnid_week, 1);
% figure
% plot(yd_wk, smoothclimatology_Tintinnid_weekly, '-b', 'LineWidth',2)
% datetick('x', 3 );
% set(gca,'xgrid','on', 'FontSize',12);
% ylabel('Abundance (cell mL^{-1})', 'fontsize', 12);
% title('Tintinnid', 'fontsize', 12, 'fontname', 'arial');
%  
% 
% figure
% plot(yd_wk, Tintinnid_week, '.')
% hold on
% plot(yd_wk, smoothclimatology_Tintinnid_weekly, '-b', 'LineWidth', 2)
% datetick('x', 3 );
% set(gca,'xgrid','on', 'FontSize',12);
% ylabel('Abundance (cell mL^{-1})', 'fontsize', 12);
% title('Tintinnid', 'fontsize', 12, 'fontname', 'arial');
% legend(num2str((2006:2013)'), 'location', 'south');

[smoothclimatology_Tontonia_appendiculariformis_weekly, std_Tontonia_appendiculariformis_week] = smoothed_climatology(Tontonia_appendiculariformis_week, 1);
% figure
% plot(yd_wk, smoothclimatology_Tontonia_appendiculariformis_weekly, '-b', 'LineWidth',2)
% datetick('x', 3 );
% set(gca,'xgrid','on', 'FontSize',12);
% ylabel('Abundance (cell mL^{-1})', 'fontsize', 12);
% title('Tontonia appendiculariformis', 'fontsize', 12, 'fontname', 'arial');
%  
% 
% figure
% plot(yd_wk, Tontonia_appendiculariformis_week, '.')
% hold on
% plot(yd_wk, smoothclimatology_Tontonia_appendiculariformis_weekly, '-b', 'LineWidth', 2)
% datetick('x', 3 );
% set(gca,'xgrid','on', 'FontSize',12);
% ylabel('Abundance (cell mL^{-1})', 'fontsize', 12);
% title('Tontonia appendiculariformis', 'fontsize', 12, 'fontname', 'arial');
% legend(num2str((2006:2013)'), 'location', 'south');

[smoothclimatology_Tontonia_gracillima_weekly, std_Tontonia_gracillima_week] = smoothed_climatology(Tontonia_gracillima_week, 1);
% figure
% plot(yd_wk, smoothclimatology_Tontonia_gracillima_weekly, '-b', 'LineWidth',2)
% datetick('x', 3 );
% set(gca,'xgrid','on', 'FontSize',12);
% ylabel('Abundance (cell mL^{-1})', 'fontsize', 12);
% title('Tontonia gracillima', 'fontsize', 12, 'fontname', 'arial');
%  
% 
% figure
% plot(yd_wk, Tontonia_gracillima_week, '.')
% hold on
% plot(yd_wk, smoothclimatology_Tontonia_gracillima_weekly, '-b', 'LineWidth', 2)
% datetick('x', 3 );
% set(gca,'xgrid','on', 'FontSize',12);
% ylabel('Abundance (cell mL^{-1})', 'fontsize', 12);
% title('Tontonia gracillima', 'fontsize', 12, 'fontname', 'arial');
% legend(num2str((2006:2013)'), 'location', 'south');
% 
% close all
%%
figure
plot(yd_wk, smoothclimatology_Leegaardiella_ovalis_weekly, '.-b', 'LineWidth',2,'markersize',30)
hold on
plot(yd_wk, smoothclimatology_Strombidium_inclinatum_weekly, '.-g', 'LineWidth',2,'markersize',30)
plot(yd_wk, smoothclimatology_Strombidium_morphotype1_weekly, '.-r', 'LineWidth',2,'markersize',30)
plot(yd_wk, smoothclimatology_Strombidium_morphotype2_weekly, '.-m', 'LineWidth',2,'markersize',30)
%h_legend=legend('\it{Leegaardiella ovalis} \rm', '\it{Strombidium inclinatum} \rm', '\it{Strombidium} \rm morphotype1' ,'\it{Strombidium} \rm morphotype2')
h_legend=legend('\it{Leegaardiella ovalis} \rm','\it{Strombidium inclinatum} ','\it{Strombidium} \rm morphotype1' ,'\it{Strombidium} \rm morphotype2')
set(h_legend,'FontSize',14,'fontname','arial');
datetick('x', 3 );
set(gca, 'FontSize',24,'fontname','arial');
%ylabel('Abundance (cell mL^{-1})', 'fontsize', 14);
axis square
ylabel('biovolume ( \mum^3 mL^-1)', 'fontsize', 24, 'fontname', 'arial')
%plot(yd_wk, Leegaardiella_ovalis_week, 'b.');
%plot(yd_wk, Strombidium_inclinatum_week, 'r.');
%plot(yd_wk, Strombidium_morphotype1_week, 'g.');
%plot(yd_wk, Strombidium_morphotype2_week, 'k.');
ylim([0 6000])
set(gca,'XTickLabel',{'Jan','Apr','Jul','Oct','Jan'},...
    'XTick',[1 92 183 275 367])




