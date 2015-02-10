close all
clear all

load ('\\raspberry\d_work\IFCB1\ifcb_data_mvco_jun06\Manual_fromClass\summary\count_biovol_manual_19Jun2013_day.mat')

ind59 = find(~isnan(ml_analyzed_mat_bin(:,59)));
ind14 = find(~isnan(ml_analyzed_mat_bin(:,14)));

[ ind_diatom, class_label ] = get_diatom_ind( class2use, class2use );
[ ind_Gdel, class_label ] = get_G_delicatula_ind( class2use, class2use );

%find the time points when all diatoms were annotated
ind_total = find(~isnan(mean(ml_analyzed_mat_bin(:,ind_diatom),2)));

%cubic microns per mL
diatom_biovol_conc = sum(classbiovol_bin(ind_total,ind_diatom)./ml_analyzed_mat_bin(ind_total, ind_diatom),2); 
Gdel_biovol_conc = sum(classbiovol_bin(ind_total,ind_Gdel)./ml_analyzed_mat_bin(ind_total, ind_Gdel),2); 

ind_Gdel_par = strmatch('G_delicatula_parasite',class2use);
Gdel_par_biovol_conc = sum(classbiovol_bin(ind_total,ind_Gdel_par)./ml_analyzed_mat_bin(ind_total, ind_Gdel_par),2); 


figure, plot(matdate_bin(ind_total), diatom_biovol_conc, '.-')
figure, plot(matdate_bin(ind_total), Gdel_biovol_conc./diatom_biovol_conc, '.-')
figure, plot(matdate_bin(ind_total), Gdel_par_biovol_conc, '.-')

%figure, plot(matdate_bin(ind_total), Gdel_biovol_conc, '.-')
%hold on
%plot(matdate_bin(ind_total), (Gdel_biovol_conc./diatom_biovol_conc)*100*1000, 'g.-')

load ('\\raspberry\d_work\IFCB1\code_svn\trunk\Guinardia_parasite_analysis\Tall_day2006_2013.mat')

[ mdate_mat, y_mat, yearlist, yd ] = timeseries2ydmat( matdate_bin(ind14), (classcount_bin(ind14,14)./ml_analyzed_mat_bin(ind14,14)));
Gdel_mat = y_mat;
[ mdate_mat, y_mat, yearlist, yd ] = timeseries2ydmat( matdate_bin(ind59), (classcount_bin(ind59,59)./ml_analyzed_mat_bin(ind59,59)));
Gdel_par_mat = y_mat;

figure, plot(Tday(:), Gdel_mat(:), '.')
hold on, plot(Tday(:), Gdel_par_mat(:), 'r.')

figure, plot(Tday(:), Gdel_par_mat(:)./(Gdel_mat(:)+Gdel_par_mat(:))*100, 'k.', 'MarkerSize', 10)
hold on, plot(Tday(:), Gdel_mat(:), 'g.')
line([5,5],[140,0], 'LineWidth',2, 'Color',[1 0 0])
xlim([-1, 22]);
legend('G. delicatula', '% infected G. delicatula');
ylabel('Number of images/ml, %','FontSize',14);
xlabel('Temperature(C)','FontSize',14);
axes1 = axes('Parent',figure5,...
    'YTickLabel',{'0','20','40','60','80','100','120','140'},...
    'XTickLabel',{'0','2','4','6','8','10','12','14','16','18', '20', '22'},...
    'XTick',[0 2 4 6 8 10 12 14 16 18 20 22],...
    'XGrid','on',...
    'FontSize',14,...
    'CLim',[0 1]);