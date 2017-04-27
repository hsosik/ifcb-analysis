
clear all;
close all;

load('\\SOSIKNAS1\IFCB_data\IFCB101_BigelowMay2015\metadata\bigelow_metadata.mat');
load('\\SOSIKNAS1\IFCB_data\IFCB101_BigelowMay2015\metadata\bigelow_metadata_IFCB.mat');


%this section uses m_map to plot the map back ground.
m_proj('UTM','long',[-76 -65],'lat',[35 45]);
figure(1);
m_usercoast('gumby','patch',[.7 1 .7],'edgecolor','k');
m_tbase('contour',[-500 -100 000:2000:5000],'edgecolor','k');
m_grid('box','fancy','tickdir','out','fontsize', 16, 'fontname','Times New Roman');
hold on

% this section plots the cruise track and diatom data from bigelow May 2015
ha = m_line(SAMOSLonVALUE, SAMOSLatitudeVALUE,'color','b','linewi',1.25); %plot cruise track
[X,Y] = m_ll2xy(lon_IFCB, lat_IFCB); %convert positions of IFCB manual points to map coordinates
load \\sosiknas1\IFCB_products\IFCB101_BigelowMay2015\Manual_fromClass\summary\count_manual_13Jan2016;
[ ind_diatom, class_label ] = get_diatom_ind( class2use, class2use ); %get diatom ind to plot sum of all diatom counts together.
diatom_abundance = sum(classcount(:,ind_diatom),2)./ml_analyzed; % sum diatom abundance/ml
hb = scatter(X,Y, 30, diatom_abundance, 'filled'); %plot IFCB positions, marker size, and abundance.
colorbar; 
caxis([0 100]);%add the color bar and specify the scale of the color bar. In the Bigelow data, 
%there are a couple of points with really high diatom counts, so all of
%those would be red, or we cannot see the vatiation in the other points.
legend(ha, 'May 2015 diatom counts/ml', 'Location', 'NorthWest');


figure(2)
m_proj('UTM','long',[-76 -65],'lat',[35 45]);
m_usercoast('gumby','patch',[.7 1 .7],'edgecolor','k');
m_tbase('contour',[-500 -100 000:2000:5000],'edgecolor','k');
m_grid('box','fancy','tickdir','out','fontsize', 16, 'fontname','Times New Roman');
hold on
%plot the cruise track and diatom data from gordon gunter October 2015
load \\SOSIKNAS1\IFCB_data\IFCB101_GordonGunterOct2015\metadata\gordon_gunter_metadata.mat;
load \\SOSIKNAS1\IFCB_data\IFCB101_GordonGunterOct2015\metadata\gordon_gunter_metadata_IFCB.mat;
hc = m_line(SAMOSLonVALUE, SAMOSLatitudeVALUE,'color','c','linewi',1.25); %plot cruise track
[X,Y] = m_ll2xy(lon_IFCB, lat_IFCB); %convert positions of IFCB manual points to map coordinates
load \\sosiknas1\IFCB_products\IFCB101_GordonGunterOct2015\Manual_fromClass\summary\count_manual_13Jan2016;
[ ind_diatom, class_label ] = get_diatom_ind( class2use, class2use ); %get diatom ind to plot sum of all diatom counts together.
diatom_abundance = sum(classcount(:,ind_diatom),2)./ml_analyzed; % sum diatom abundance/ml
hd = scatter(X,Y, 30, diatom_abundance, 'filled'); %plot IFCB positions, marker size, and abundance.
colorbar; 
caxis([0 100]);

legend(hc, 'Oct 2015 diatom counts/ml', 'Location', 'NorthWest');
