

ciliate_all_byyear=nansum(ciliate_all_mat,1);

Ciliate_mix_byyear=nansum(Ciliate_mix_mat,1)./ciliate_all_byyear;
Didinium_sp_byyear=nansum(Didinium_sp_mat,1)./ciliate_all_byyear;
Euplotes_sp_byyear=nansum(Euplotes_sp_mat,1)./ciliate_all_byyear;
Laboea_strobila_byyear=nansum(Laboea_strobila_mat,1)./ciliate_all_byyear;
Leegaardiella_ovalis_byyear=nansum(Leegaardiella_ovalis_mat,1)./ciliate_all_byyear;
Mesodinium_sp_byyear=nansum(Mesodinium_sp_mat,1)./ciliate_all_byyear;
Pleuronema_sp_byyear=nansum(Pleuronema_sp_mat,1)./ciliate_all_byyear;
Strobilidium_morphotype1_byyear=nansum(Strobilidium_morphotype1_mat,1)./ciliate_all_byyear;
Strombidium_capitatum_byyear=nansum(Strombidium_capitatum_mat,1)./ciliate_all_byyear;
Strombidium_conicum_byyear=nansum(Strombidium_conicum_mat,1)./ciliate_all_byyear;
Strombidium_inclinatum_byyear=nansum(Strombidium_inclinatum_mat,1)./ciliate_all_byyear;
Strombidium_morphotype1_byyear=nansum(Strombidium_morphotype1_mat,1)./ciliate_all_byyear;
Strombidium_morphotype2_byyear=nansum(Strombidium_morphotype2_mat,1)./ciliate_all_byyear;
Strombidium_oculatum_byyear=nansum(Strombidium_oculatum_mat,1)./ciliate_all_byyear;
Strombidium_wulffi_byyear=nansum(Strombidium_wulffi_mat,1)./ciliate_all_byyear;
Tiarina_fusus_byyear=nansum(Tiarina_fusus_mat,1)./ciliate_all_byyear;
Tintinnid_byyear=nansum(Tintinnid_mat,1)./ciliate_all_byyear;
Tontonia_appendiculariformis_byyear=nansum(Tontonia_appendiculariformis_mat,1)./ciliate_all_byyear;
Tontonia_gracillima_byyear=nansum(Tontonia_gracillima_mat,1)./ciliate_all_byyear;

%%
ciliate_percentage_mat=[Ciliate_mix_byyear; Didinium_sp_byyear; Euplotes_sp_byyear; Laboea_strobila_byyear;Leegaardiella_ovalis_byyear;...
    Mesodinium_sp_byyear; Pleuronema_sp_byyear; Strobilidium_morphotype1_byyear; Strombidium_capitatum_byyear;...
    Strombidium_conicum_byyear; Strombidium_inclinatum_byyear; Strombidium_morphotype1_byyear; Strombidium_morphotype2_byyear;...
    Strombidium_oculatum_byyear; Strombidium_wulffi_byyear; Tiarina_fusus_byyear; Tintinnid_byyear;...
    Tontonia_appendiculariformis_byyear; Tontonia_gracillima_byyear];


%%

figure1 = figure;
axes1 = axes('Parent',figure1,...
    'XTickLabel',{'2006','2007','2008','2009','2010','2011','2012','2013','2014','2015'},...
    'XTick',[1 2 3 4 5 6 7 8 9 10]);

box(axes1,'on');
hold(axes1,'all');

% Create multiple lines using matrix input to bar
bar1 = bar(ciliate_percentage_mat','BarLayout','stacked','Parent',axes1);
set(bar1(1),'DisplayName','ciliate mix');
set(bar1(2),'DisplayName','Didinium');
set(bar1(3),'DisplayName','Euplotes');
set(bar1(4),'DisplayName','Laboea');
set(bar1(5),'DisplayName','Leegaardiella');
set(bar1(6),'DisplayName','Mesodinium');
set(bar1(7),'DisplayName','Pleuronema');
set(bar1(8),'DisplayName','Strobilidium m1');
set(bar1(9),'DisplayName','S capitatum');
set(bar1(10),'DisplayName','S conicum');
set(bar1(11),'DisplayName','S inclinatum');
set(bar1(12),'DisplayName','S m1');
set(bar1(13),'DisplayName','S m2');
set(bar1(14),'DisplayName','S oculatum');
set(bar1(15),'DisplayName','S wulffi');
set(bar1(16),'DisplayName','Tiarina');
set(bar1(17),'DisplayName','Tintinnid');
set(bar1(18),'DisplayName','Tontonia appen.');
set(bar1(19),'DisplayName','Tontonia grac.');

% Create legend
legend1 = legend(axes1,'show');
set(legend1,...
    'Position',[0.839125512695162 0.3012385401498 0.118972949373082 0.598756447922449]);

ylim([0 1.05])
ylabel('Percentage Biovolume ( \mum^3 mL^-1)')
xlabel('Year')

[B,I] = sort(ciliate_percentage_mat(:,1))


