
%
load ('\\raspberry\d_work\IFCB1\code_svn\trunk\Guinardia_parasite_analysis\Tall_day2006_2013.mat')
load ('\\raspberry\d_work\IFCB1\ifcb_data_mvco_jun06\Manual_fromClass\summary\count_biovol_manual_22Nov2013_day.mat')

ind59 = find(~isnan(ml_analyzed_mat_bin(:,59)));
ind14 = find(~isnan(ml_analyzed_mat_bin(:,14)));

figure1 = figure;
set(gcf, 'units', 'inches')
set(gcf, 'position', [1 2 7 7], 'paperposition', [1 1 7 7]);

[ ind_Gdel, class_label ] = get_G_delicatula_ind( class2use, class2use );

%find the time points when all diatoms were annotated
%ind_total = find(~isnan(mean(ml_analyzed_mat_bin(:,ind_diatom),2)));

%cubic microns per mL
ind_Gdel_par = strmatch('G_delicatula_parasite',class2use);

[ mdate_mat, y_mat, yearlist, yd ] = timeseries2ydmat( matdate_bin(ind14), sum((classcount_bin(ind14,ind_Gdel)./ml_analyzed_mat_bin(ind14,ind_Gdel)),2));
Gdel_mat = y_mat;
[ mdate_mat, y_mat, yearlist, yd ] = timeseries2ydmat( matdate_bin(ind59), (classcount_bin(ind59,59)./ml_analyzed_mat_bin(ind59,59)));
Gdel_par_mat = y_mat;
 
 X1=   Tday(:);
 Y1= Gdel_par_mat(:)./Gdel_mat(:)*100;
 X2=  Tday(:);
 Y2=  Gdel_mat(:);

 ind = find(~isnan(X1)&~isnan(Y1) &~isnan(X2));
 x=   Tday(ind);
 y= Gdel_par_mat(ind)./Gdel_mat(ind)*100;
 v=  Gdel_mat(ind);

axes1 = axes('Parent',figure1,...
    'XGrid','off',...
    'FontSize',20,...
    'CLim',[0 1]);


scatter(x,y,30, v, 'filled')
caxis([0 10])

ourmap = colormap;
ourmap(1:10,:) = []; %remove first 10 bluest
colormap(ourmap) 

hcb = colorbar('Location','EastOutside','Ytick',[2 4 6 8 10], 'YTickLabel',...
{'2',  '4', '6', '8', '>10'});

set(hcb,'XTickMode','manual', 'FontSize',20, 'Linewidth', 2)



text(19,31.5,'30%','FontSize',20);
text(.9,3.5,'2%','FontSize',20);

lowT = 4;
%4C temperature
line([lowT,lowT],[140,0],'LineWidth',2,'Color',[0 0 0],  'LineStyle', '--', 'Linewidth', 2);

% Create line, 2% infection
line([0,lowT],[2,2],'LineWidth',2,'Color',[.5 .5 .5]);

% Create line, 30% infection
line([lowT,22],[30,30],'LineWidth',2,'Color',[.5 .5 .5], 'Linewidth', 2);

xlabel('Temperature (\circC)','FontSize',20);
ylabel('Infected chains (%)','FontSize',20);
%text(26,14,'Chains (mL^{-1})', 'rotation', 90, 'FontSize', 14);
text(22,-3,{'Chains'; ' (ml^{-1})'}, 'FontSize',20);

xlim([0 22]);
ylim([0 40]);

grid off
view(2)
set(gca, 'box', 'on', 'Linewidth', 2)
axis square