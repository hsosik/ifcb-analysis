load \\sosiknas1\IFCB_products\IFCB102_PiscesNov2014\class\summary\summary_biovol_allTB.mat
load \\sosiknas1\IFCB_data\IFCB102_PiscesNov2014\metadata\IFCB102_PiscesNov2014_ifcb_locations
lat_IFCB_TB = latitude; lon_IFCB_TB = longitude;
pid_path = [fileparts(pid{1}) '/'];
pid = regexprep(pid, pid_path, '')';
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
diatomZ = sum(Z(ifcb_ind2plot,ind_diatomTB),2)./ml_analyzedTB(ifcb_ind2plot);
dinoZ = sum(Z(ifcb_ind2plot,ind_dinoTB),2)./ml_analyzedTB(ifcb_ind2plot);

mdateTB2 = mdateTB(ifcb_ind2plot);
T = table(cellstr(datestr(mdateTB2)),lat_IFCB_TB', lon_IFCB_TB', diatomZ, dinoZ,  'VariableNames',{'date_time' 'latitude' 'longitude' 'diatomC_microgm_per_l' 'dinoflagellateC_microgm_per_l'});
writetable(T, 'c:\work\IFCB102_PiscesNov2014_diatomC_dinoC.csv')
