%Emily P. January 2016. 
%Plots abundances over time - not super useful, just a place to start
%before learning how to plot on maps.

clear all;

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
     figure(i)
    plot(mdateTB, sum(classcountTB(:,ind_diatomTB),2), 'k.');
      hold on;
        plot(matdate, sum(classcount(:,ind_diatom),2), 'r*');
    datetick('x',2);
    hold on
end 

for i = 5:6;
    %load(char(strcat('\\sosiknas1\IFCB_products\', cruise_list(i), '\Manual_fromClass\summary\count_manual_current.mat')));
    load(char(strcat('\\sosiknas1\IFCB_products\', cruise_list(i), '\class\summary\summary_allTB.mat')));
    %load(char(strcat('\\sosiknas1\IFCB_data\', cruise_list(i),'\metadata\metadata_manual.mat')));
    load(char(strcat('\\sosiknas1\IFCB_data\', cruise_list(i),'\metadata\metadata_TB.mat')));
    load(char(strcat('\\sosiknas1\IFCB_data\', cruise_list(i),'\metadata\metadata_raw.mat')));
    [ ind_diatomTB, class_label ] = get_diatom_ind( class2useTB, class2useTB );
     figure(i)
     plot(mdateTB, sum(classcountTB(:,ind_diatomTB),2), 'k.');
    datetick('x',2);
    hold on
end 


% clear classcount filelist matdate ml_analyzed
% 
% [ ind_diatom, class_label ] = get_diatom_ind( class2use, class2use );
% 
% for i = 1:length(cruise_list);
%     figure(i)
%     ml_analyzed = eval(char(strcat('ml_analyzed_', cruise_list(i))));
%     classcount = eval(char(strcat('classcount_', cruise_list(i))));
%     matdate = eval(char(strcat('matdate_', cruise_list(i))));
%     plot(matdate, sum(classcount(:,ind_diatom),2), '.');
%     datetick
%     hold on
%     datetick('x',2);
% end
 
% load('\\sosiknas1\IFCB_products\IFCB101_OkeanosExplorerNov2013\Manual_fromClass\summary\count_manual_13Jan2016');
%                  
% classcount_OkeanosExplorerNov2013 = classcount;
% filelist_OkeanosExplorerNov2013 = filelist;
% matdate_OkeanosExplorerNov2013 = matdate;
% ml_analyzed_OkeanosExplorerNov2013 = ml_analyzed;


% load('\\sosiknas1\IFCB_products\IFCB102_PiscesNov2014\Manual_fromClass\summary\count_manual_13Jan2016');
%                  
% classcount_PiscesNov2014 = classcount;
% filelist_PiscesNov2014 = filelist;
% matdate_PiscesNov2014 = matdate;
% ml_analyzed_PiscesNov2014 = ml_analyzed;
% 
% 
% load('\\sosiknas1\IFCB_products\IFCB101_BigelowMay2015\Manual_fromClass\summary\count_manual_13Jan2016');
%                  
% classcount_BigelowMay2015 = classcount;
% filelist_BigelowMay2015 = filelist;
% matdate_BigelowMay2015 = matdate;
% ml_analyzed_BigelowMay2015 = ml_analyzed;
% 
% load('\\sosiknas1\IFCB_products\IFCB101_GordonGunterOct2015\Manual_fromClass\summary\count_manual_13Jan2016');
%                  
% classcount_GordonGunterOct2015 = classcount;
% filelist_GordonGunterOct2015 = filelist;
% matdate_GordonGunterOct2015 = matdate;
% ml_analyzed_GordonGunterOct2015 = ml_analyzed;

% load('\\sosiknas1\IFCB_products\IFCB101_BigelowNov2015\Manual_fromClass\summary\count_manual_13Jan2016');
%                  
% classcount_BigelowNov2015 = classcount;
% filelist_BigelowNov2015 = filelist;
% matdate_BigelowNov2015 = matdate;
% ml_analyzed_BigelowNov2015 = ml_analyzed;

