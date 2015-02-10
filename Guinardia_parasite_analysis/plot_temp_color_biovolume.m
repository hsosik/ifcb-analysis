
%
load ('\\raspberry\d_work\IFCB1\code_svn\trunk\Guinardia_parasite_analysis\Tall_day2006_2013.mat')
load ('\\raspberry\d_work\IFCB1\ifcb_data_mvco_jun06\Manual_fromClass\summary\count_biovol_manual_04Nov2013_day.mat')

ind59 = find(~isnan(ml_analyzed_mat_bin(:,59)));
ind14 = find(~isnan(ml_analyzed_mat_bin(:,14)));

figure1 = figure;
set(gcf, 'units', 'inches')
set(gcf, 'position', [1 2 7 7], 'paperposition', [1 1 7 7]);


[ ind_diatom, class_label ] = get_diatom_ind( class2use, class2use );
[ ind_Gdel, class_label ] = get_G_delicatula_ind( class2use, class2use );

%find the time points when all diatoms were annotated
%ind_total = find(~isnan(mean(ml_analyzed_mat_bin(:,ind_diatom),2)));

%cubic microns per mL
%diatom_biovol_conc = sum(classbiovol_bin(ind_total,ind_diatom)./ml_analyzed_mat_bin(ind_total, ind_diatom),2); 
%Gdel_biovol_conc = sum(classbiovol_bin(ind_total,ind_Gdel)./ml_analyzed_mat_bin(ind_total, ind_Gdel),2); 
Gdel_biovol_conc = sum(classbiovol_bin(ind14,ind_Gdel)./ml_analyzed_mat_bin(ind14,ind_Gdel),2); 


ind_Gdel_par = strmatch('G_delicatula_parasite',class2use);
Gdel_par_biovol_conc = sum(classbiovol_bin(ind14,ind_Gdel_par)./ml_analyzed_mat_bin(ind14, ind_Gdel_par),2); 

%[ mdate_mat, y_mat, yearlist, yd ] = timeseries2ydmat( matdate_bin(ind14), (classcount_bin(ind14,14)./ml_analyzed_mat_bin(ind14,14)));
%Gdel_mat = y_mat;
%[ mdate_mat, y_mat, yearlist, yd ] = timeseries2ydmat( matdate_bin(ind59), (classcount_bin(ind59,59)./ml_analyzed_mat_bin(ind59,59)));
%Gdel_par_mat = y_mat;
 
[ mdate_mat, y_mat, yearlist, yd ] = timeseries2ydmat( matdate_bin(ind14), sum(classbiovol_bin(ind14,ind_Gdel)./ml_analyzed_mat_bin(ind14,ind_Gdel),2));
Gdel_biovol_conc = y_mat;
[ mdate_mat, y_mat, yearlist, yd ] = timeseries2ydmat( matdate_bin(ind59), sum(classbiovol_bin(ind59,ind_Gdel_par)./ml_analyzed_mat_bin(ind59, ind_Gdel_par),2));
Gdel_par_biovol_conc = y_mat;

 X1=   Tday(:);
 Y1= Gdel_par_biovol_conc(:)./(Gdel_biovol_conc(:))*100;
 X2=  Tday(:);
 Y2=  Gdel_biovol_conc(:);

 ind = find(~isnan(X1)&~isnan(Y1) &~isnan(Y2));
 x=   Tday(ind);
 y= Gdel_par_biovol_conc(ind)./(Gdel_biovol_conc(ind))*100;
 v=  Gdel_biovol_conc(ind)/10000;

axes1 = axes('Parent',figure1,...
    'XGrid','off',...
    'FontSize',20,...
    'CLim',[0 1]);


scatter(x,y,30, v, 'filled')
caxis([0 10])

ourmap = colormap;
ourmap(1:10,:) = []; %remove first 10 bluest
colormap(ourmap) 

hcb = colorbar('Location','EastOutside','YTickLabel',...
{'2',  '4', '6', '8', '>10'});

set(hcb,'XTickMode','manual', 'FontSize',20)



text(19,31.5,'30%','FontSize',20);
text(1,6.5,'5%','FontSize',20);


line([5,5],[140,0],'LineWidth',2,'Color',[0 0 0],  'LineStyle', '--');

% Create line
line([0,5],[5,5],'LineWidth',2,'Color',[.5 .5 .5]);

% Create line
line([5,22],[30,30],'LineWidth',2,'Color',[.5 .5 .5]);

xlabel('Temperature (\circC)','FontSize',20);
ylabel('Infected chains (%)','FontSize',20);
%text(26,14,'Chains (mL^{-1})', 'rotation', 90, 'FontSize', 14);
%text(22,-3,'Biovolume', 'FontSize',20);

xlim([0 22]);
ylim([0 40]);

grid off
view(2)
set(gca, 'box', 'on')
axis square