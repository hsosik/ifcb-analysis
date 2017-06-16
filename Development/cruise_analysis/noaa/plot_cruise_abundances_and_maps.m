%Emily P. January 2016. 
%Plots abundances over time - not super useful, just a place to start
%before learning how to plot on maps.

clear all;close all;

cruise_list = {'IFCB010_OkeanosExplorerAug2013',
   % 'OkeanosExplorerNov2013',
    'IFCB102_PiscesNov2014',
    'IFCB101_BigelowMay2015',
    'IFCB101_GordonGunterOct2015',
   % 'BigelowNov2015'
   'IFCB101_GordonGunterMay2016',
   'IFCB101_GordonGunterJun2016'
   };
for i = 1:4;
    load(char(strcat('\\sosiknas1\IFCB_products\', cruise_list(i), '\Manual_fromClass\summary\count_manual_current.mat')));
    load(char(strcat('\\sosiknas1\IFCB_products\', cruise_list(i), '\class\summary\summary_allTB.mat')));
    load(char(strcat('\\sosiknas1\IFCB_data\', cruise_list(i),'\metadata\metadata_manual.mat')));
    load(char(strcat('\\sosiknas1\IFCB_data\', cruise_list(i),'\metadata\metadata_TB.mat')));
    load(char(strcat('\\sosiknas1\IFCB_data\', cruise_list(i),'\metadata\metadata_raw.mat')));
    
    [ ind_diatom, class_label ] = get_diatom_ind( class2use, class2use );
     [ ind_diatomTB, class_label ] = get_diatom_ind( class2useTB, class2useTB );
      [ ind_dinoTB, class_label ] = get_dino_ind( class2useTB, class2useTB );
      %plot automated counts of diatoms vs date.
     figure(i)
    plot(mdateTB, sum(classcountTB_above_optthresh(:,ind_diatomTB),2)./ml_analyzedTB, 'k.');
      hold on;
        plot(matdate, sum(classcount(:,ind_diatom),2)./ml_analyzed, 'r*');
    datetick('x',2);
    title(cruise_list(i));
    legend('diatom counts/ml, auto', 'diatom counts/ml manual')
   
   %plot cruise tracks with manual counts of diatoms (counts/ml).
    figure(i+6)
    m_proj('UTM','long',[-76 -65],'lat',[35 45]);
    m_usercoast('gumby','patch',[.7 1 .7],'edgecolor','k');
    m_tbase('contour',[-500 -100 000:2000:5000],'edgecolor','k');
    m_grid('box','fancy','tickdir','out','fontsize', 16, 'fontname','Times New Roman');
    hold on
    ha = m_line(longitude, latitude,'color','b','linewi',1.25); %plot cruise track
    [X,Y] = m_ll2xy(lon_IFCB, lat_IFCB);
    diatom_abundance = sum(classcount(:,ind_diatom),2)./ml_analyzed; % sum diatom abundance/ml
    hb = scatter(X,Y, 30, diatom_abundance, 'filled'); 
    colorbar; 
    caxis([0 100]);%add the color bar and specify the scale of the color bar. In the Bigelow data, 
    %there are a couple of points with really high diatom counts, so all of
    %those would be red, or we cannot see the vatiation in the other points.
    legend(ha, 'diatom counts/ml manual', 'Location', 'NorthWest');
    title(cruise_list(i));
    
    %plot cruise tracks with automated counts of diatoms (counts/ml).
    figure(i+12)
    m_proj('UTM','long',[-76 -65],'lat',[35 45]);
    m_usercoast('gumby','patch',[.7 1 .7],'edgecolor','k');
    m_tbase('contour',[-500 -100 000:2000:5000],'edgecolor','k');
    m_grid('box','fancy','tickdir','out','fontsize', 16, 'fontname','Times New Roman');
    hold on
    ha = m_line(longitude, latitude,'color','b','linewi',1.25); %plot cruise track
     %plot IFCB positions, marker size, and abundance.
    [X2,Y2] = m_ll2xy(lon_IFCB_TB, lat_IFCB_TB);
    diatom_abundanceTB = sum(classcountTB_above_optthresh(ifcb_ind2plot,ind_diatomTB),2)./ml_analyzedTB(ifcb_ind2plot);
    hb = scatter(X2,Y2, 30, diatom_abundanceTB, 'filled'); 
      colorbar; 
    caxis([0 100]);
    legend(ha, 'diatom counts/ml auto', 'Location', 'NorthWest');
    title(cruise_list(i));
    
   %plot cruise tracks with automated counts of dinoflagellates (counts/ml).
        figure(i+18)
    m_proj('UTM','long',[-76 -65],'lat',[35 45]);
    m_usercoast('gumby','patch',[.7 1 .7],'edgecolor','k');
    m_tbase('contour',[-500 -100 000:2000:5000],'edgecolor','k');
    m_grid('box','fancy','tickdir','out','fontsize', 16, 'fontname','Times New Roman');
    hold on
    ha = m_line(longitude, latitude,'color','b','linewi',1.25); %plot cruise track
     %plot IFCB positions, marker size, and abundance.
    [X2,Y2] = m_ll2xy(lon_IFCB_TB, lat_IFCB_TB);
    dino_abundanceTB = sum(classcountTB_above_optthresh(ifcb_ind2plot,ind_dinoTB),2)./ml_analyzedTB(ifcb_ind2plot);
    hb = scatter(X2,Y2, 30, dino_abundanceTB, 'filled'); 
      colorbar; 
    caxis([0 100]);
    legend(ha, 'dino counts/ml auto', 'Location', 'NorthWest');
    title(cruise_list(i));
    
     %plot cruise tracks with automated counts of diatoms (counts/ml).
     class2plot = {'pennate'
         'Guinardia'
         'Chaetoceros'
         'Thalassiosira'
         'Asterionellopsis'
         'Cerataulina'
         'Pseudonitzschia'
         'Skeletonema'
         'Leptocylindrus'
         'Ephemera'
         'Guinardia_striata'
         'Thalassionema'
         'Ditylum'};
     for j = 1:length(class2plot);
         
    figure(j+24)
    m_proj('UTM','long',[-76 -65],'lat',[35 45]);
    m_usercoast('gumby','patch',[.7 1 .7],'edgecolor','k');
    m_tbase('contour',[-500 -100 000:2000:5000],'edgecolor','k');
    m_grid('box','fancy','tickdir','out','fontsize', 16, 'fontname','Times New Roman');
    hold on
    ha = m_line(longitude, latitude,'color','b','linewi',1.25); %plot cruise track
     %plot IFCB positions, marker size, and abundance.
    [X2,Y2] = m_ll2xy(lon_IFCB_TB, lat_IFCB_TB);
    %diatom_abundanceTB = sum(classcountTB_above_optthresh(ifcb_ind2plot,ind_diatomTB),2)./ml_analyzedTB(ifcb_ind2plot);
    [ind_class2plot, ia, ib] = intersect(class2useTB, class2plot(j));
    class_abundanceTB = classcountTB_above_optthresh(ifcb_ind2plot,ia)./ml_analyzedTB(ifcb_ind2plot);
    hb = scatter(X2,Y2, 30, class_abundanceTB, 'filled'); 
      colorbar; 
    caxis([0 40]);
    legend(ha, 'diatom counts/ml auto', 'Location', 'NorthWest');
    title(class2plot(j));
     end
end 

for i = 5:6;
    %plot automated counts of diatoms vs date.
    %load(char(strcat('\\sosiknas1\IFCB_products\', cruise_list(i), '\Manual_fromClass\summary\count_manual_current.mat')));
    load(char(strcat('\\sosiknas1\IFCB_products\', cruise_list(i), '\class\summary\summary_allTB.mat')));
    %load(char(strcat('\\sosiknas1\IFCB_data\', cruise_list(i),'\metadata\metadata_manual.mat')));
    load(char(strcat('\\sosiknas1\IFCB_data\', cruise_list(i),'\metadata\metadata_TB.mat')));
    load(char(strcat('\\sosiknas1\IFCB_data\', cruise_list(i),'\metadata\metadata_raw.mat')));
    [ ind_diatomTB, class_label ] = get_diatom_ind( class2useTB, class2useTB );
    [ ind_dinoTB, class_label ] = get_dino_ind( class2useTB, class2useTB );
     figure(i)
     plot(mdateTB, sum(classcountTB(:,ind_diatomTB),2)./ml_analyzedTB, 'k.');
    datetick('x',2);
    hold on
        title(cruise_list(i));
    legend('diatom counts/ml, auto', 'diatom counts/ml manual')
    
    %plot cruise tracks with automated counts of diatoms (counts/ml).
    figure(i+12)
    m_proj('UTM','long',[-76 -65],'lat',[35 45]);
    m_usercoast('gumby','patch',[.7 1 .7],'edgecolor','k');
    m_tbase('contour',[-500 -100 000:2000:5000],'edgecolor','k');
    m_grid('box','fancy','tickdir','out','fontsize', 16, 'fontname','Times New Roman');
    hold on
    ha = m_line(longitude, latitude,'color','b','linewi',1.25); %plot cruise track
     %plot IFCB positions, marker size, and abundance.
    [X2,Y2] = m_ll2xy(lon_IFCB_TB, lat_IFCB_TB);
    diatom_abundanceTB = sum(classcountTB_above_optthresh(ifcb_ind2plot,ind_diatomTB),2)./ml_analyzedTB(ifcb_ind2plot);
    hb = scatter(X2,Y2, 30, diatom_abundanceTB, 'filled'); 
      colorbar; 
    caxis([0 100]);
    legend(ha, 'diatom counts/ml auto', 'Location', 'NorthWest');
    title(cruise_list(i));
    
    %plot cruise tracks with automated counts of dinoflagellates (counts/ml).
        figure(i+18)
    m_proj('UTM','long',[-76 -65],'lat',[35 45]);
    m_usercoast('gumby','patch',[.7 1 .7],'edgecolor','k');
    m_tbase('contour',[-500 -100 000:2000:5000],'edgecolor','k');
    m_grid('box','fancy','tickdir','out','fontsize', 16, 'fontname','Times New Roman');
    hold on
    ha = m_line(longitude, latitude,'color','b','linewi',1.25); %plot cruise track
     %plot IFCB positions, marker size, and abundance.
    [X2,Y2] = m_ll2xy(lon_IFCB_TB, lat_IFCB_TB);
    dino_abundanceTB = sum(classcountTB_above_optthresh(ifcb_ind2plot,ind_dinoTB),2)./ml_analyzedTB(ifcb_ind2plot);
    hb = scatter(X2,Y2, 30, dino_abundanceTB, 'filled'); 
      colorbar; 
    caxis([0 100]);
    legend(ha, 'dino counts/ml auto', 'Location', 'NorthWest');
    title(cruise_list(i));
end 



