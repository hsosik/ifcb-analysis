load ('\\raspberry\d_work\IFCB1\code_svn\trunk\Guinardia_parasite_analysis\Tall_day2006_2013.mat')
load ('\\raspberry\d_work\IFCB1\ifcb_data_mvco_jun06\Manual_fromClass\summary\count_biovol_manual_29Jul2013_day.mat')

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

[ mdate_mat, y_mat, yearlist, yd ] = timeseries2ydmat( matdate_bin(ind14), (classcount_bin(ind14,14)./ml_analyzed_mat_bin(ind14,14)));
Gdel_mat = y_mat;
[ mdate_mat, y_mat, yearlist, yd ] = timeseries2ydmat( matdate_bin(ind59), (classcount_bin(ind59,59)./ml_analyzed_mat_bin(ind59,59)));
Gdel_par_mat = y_mat;
 
 X1=   Tday(:);
 Y1= Gdel_par_mat(:)./(Gdel_mat(:)+Gdel_par_mat(:))*100;
 X2=  Tday(:);
 Y2=  Gdel_mat(:);
 
figure
[ax,h1,h2]=plotyy(X1, Y1, X2, Y2);
set(h1,'linestyle','none','marker','.','color','b','markersize',10)
set(h2,'linestyle','none','marker','.','color','r','markersize',10)
set(ax(1),'ylabel','Percent Infected')