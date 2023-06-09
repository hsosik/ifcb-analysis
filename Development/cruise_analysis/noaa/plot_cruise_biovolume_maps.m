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

for i = 2;
    %load(char(strcat('\\sosiknas1\IFCB_products\', cruise_list(i), '\Manual_fromClass\summary\count_manual_current.mat')));
    %load(char(strcat('\\sosiknas1\IFCB_products\', cruise_list(i), '\class\summary\summary_allTB.mat')));
    load(char(strcat('\\sosiknas1\IFCB_products\', cruise_list(i), '\class\summary\summary_biovol_allTB.mat')));
    %load(char(strcat('\\sosiknas1\IFCB_data\', cruise_list(i),'\metadata\metadata_manual.mat')));
   % load(char(strcat('\\sosiknas1\IFCB_data\', cruise_list(i),'\metadata\metadata_TB.mat')));
   load(char(strcat('\\sosiknas1\IFCB_data\', cruise_list(i),'\metadata\', cruise_list(i), '_ifcb_locations.mat')));
   lat_IFCB_TB = latitude; lon_IFCB_TB = longitude;
    load(char(strcat('\\sosiknas1\IFCB_data\', cruise_list(i),'\metadata\metadata_raw.mat')));
    pid_path = [fileparts(pid{1}) '/'];
    pid = regexprep(pid, pid_path, '')';
    %[ ind_diatom, class_label ] = get_diatom_ind( class2use, class2use );
     [ ind_diatomTB, class_label ] = get_diatom_ind( class2useTB, class2useTB );
     [ ind_dinoTB, class_label ] = get_dino_ind( class2useTB, class2useTB );
    [~,ifcb_ind2plot, indGPS] = intersect(filelistTB, pid);
    lat_IFCB_TB = lat_IFCB_TB(indGPS); %skip any that don't have products
    lon_IFCB_TB = lon_IFCB_TB(indGPS);
    
    t = strmatch('D20141108T000809_IFCB102', filelistTB(ifcb_ind2plot)); %bubbles
    ifcb_ind2plot(t) = [];lat_IFCB_TB(t) = []; lon_IFCB_TB(t) = [];
    t = strmatch('D20141108T003202_IFCB102', filelistTB(ifcb_ind2plot)); %bubbles
    ifcb_ind2plot(t) = [];lat_IFCB_TB(t) = []; lon_IFCB_TB(t) = [];
  
    Z = classC_TB_above_optthresh./1000; %divide by 1000 to convert to ng for carbon
    
    %plot cruise tracks with automated counts of diatoms (counts/ml).
    figure(i+12)
    m_proj('UTM','long',[-76 -65],'lat',[35 45]);
    m_usercoast('gumby','patch',[.7 1 .7],'edgecolor','k');
    m_tbase('contour',[-500 -100 000:2000:5000],'edgecolor','k');
    m_grid('box','fancy','tickdir','out','fontsize', 8, 'fontname','Times New Roman');
    hold on
    ha = m_line(longitude, latitude,'color','b','linewi',1.25); %plot cruise track
     %plot IFCB positions, marker size, and abundance.
    [X2,Y2] = m_ll2xy(lon_IFCB_TB, lat_IFCB_TB);
    %diatom_abundanceTB = sum(classbiovolTB_above_optthresh(ifcb_ind2plot,ind_diatomTB),2)./ml_analyzedTB(ifcb_ind2plot);
    diatomZ = sum(Z(ifcb_ind2plot,ind_diatomTB),2)./ml_analyzedTB(ifcb_ind2plot);
    hb = scatter(X2,Y2, 30, log10(diatomZ), 'filled'); 
    cb = colorbar; 
    yt = [.1 .3 1 3 10 30];
    set(cb,'ytick', log10(yt), 'yticklabel', num2str(yt'))
    caxis(log10([.1 60]))
    legend(ha, 'Diatom biomass (\mugC l^{-1})', 'Location', 'NorthWest');
    title(cruise_list(i), 'interpreter', 'none');
    
   %plot cruise tracks with automated counts of dinoflagellates (counts/ml).
        figure(i+18)
    m_proj('UTM','long',[-76 -65],'lat',[35 45]);
    m_usercoast('gumby','patch',[.7 1 .7],'edgecolor','k');
    m_tbase('contour',[-500 -100 000:2000:5000],'edgecolor','k');
    m_grid('box','fancy','tickdir','out','fontsize', 8, 'fontname','Times New Roman');
    hold on
    ha = m_line(longitude, latitude,'color','b','linewi',1.25); %plot cruise track
     %plot IFCB positions, marker size, and abundance.
    [X2,Y2] = m_ll2xy(lon_IFCB_TB, lat_IFCB_TB);
%    dino_abundanceTB = sum(classbiovolTB_above_optthresh(ifcb_ind2plot,ind_dinoTB),2)./ml_analyzedTB(ifcb_ind2plot);
    dinoZ = sum(Z(ifcb_ind2plot,ind_dinoTB),2)./ml_analyzedTB(ifcb_ind2plot);
    hb = scatter(X2,Y2, 30, log10(dinoZ), 'filled'); 
    cb = colorbar; 
    yt = [.1 .3 1 3 10 30];
    set(cb,'ytick', log10(yt), 'yticklabel', num2str(yt'))
    caxis(log10([.1 60]))
    legend(ha, 'Dinoflagellate biomass (\mugC l^{-1})', 'Location', 'NorthWest');
    title(cruise_list(i), 'interpreter', 'none');
    
     %plot cruise tracks with automated biovolume of individual diatoms (counts/ml).
%      class2plot = {'pennate'
%          'Guinardia'
%          'Chaetoceros'
%          'Thalassiosira'
%          'Asterionellopsis'
%          'Cerataulina'
%          'Pseudonitzschia'
%          'Skeletonema'
%          'Leptocylindrus'
%          'Ephemera'
%          'Guinardia_striata'
%          'Thalassionema'
%          'Ditylum'};
%      for j = 1:length(class2plot);
%          
%     figure(j+24)
%     m_proj('UTM','long',[-76 -65],'lat',[35 45]);
%     m_usercoast('gumby','patch',[.7 1 .7],'edgecolor','k');
%     m_tbase('contour',[-500 -100 000:2000:5000],'edgecolor','k');
%     m_grid('box','fancy','tickdir','out','fontsize', 16, 'fontname','Times New Roman');
%     hold on
%     ha = m_line(longitude, latitude,'color','b','linewi',1.25); %plot cruise track
%      %plot IFCB positions, marker size, and abundance.
%     [X2,Y2] = m_ll2xy(lon_IFCB_TB, lat_IFCB_TB);
%     %diatom_abundanceTB = sum(classbiovolTB_above_optthresh(ifcb_ind2plot,ind_diatomTB),2)./ml_analyzedTB(ifcb_ind2plot);
%     [ind_class2plot, ia, ib] = intersect(class2useTB, class2plot(j));
%     class_abundanceTB = classbiovolTB_above_optthresh(ifcb_ind2plot,ia)./ml_analyzedTB(ifcb_ind2plot);
%     hb = scatter(X2,Y2, 30, class_abundanceTB, 'filled'); 
%       colorbar; 
%     caxis([0 40]);
%     legend(ha, 'diatom counts/ml auto', 'Location', 'NorthWest');
%     title(class2plot(j));
%      end
end 




