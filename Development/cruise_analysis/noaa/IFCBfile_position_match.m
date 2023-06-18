clear all;

load \\sosiknas1\IFCB_data\IFCB010_OkeanosExplorerAug2013\metadata\metadata_raw.mat;
%load \\sosiknas1\IFCB_data\IFCB102_PiscesNov2014\metadata\metadata_piscesNov2014.mat;
%load \\sosiknas1\IFCB_products\IFCB101_GordonGunterOct2015\Manual_fromClass\summary\count_manual_13Jan2016;
load('\\sosiknas1\IFCB_products\IFCB010_OkeanosExplorerAug2013\class\summary\summary_allTB.mat');

%Lat=lat/100;
Lat=lat_full;
%Lon=lon/100;
Lon =lon_full;

matdate = mdateTB;

min_diff= 1/1500;

match_ind = NaN(size(matdate));


for ii=1:length(matdate);
    [min_ii, i2]=min(abs(matdate(ii)-date_full));
 
    if min_ii <= min_diff
        match_ind(ii)=i2;
        %i2=match_ind(ii);
    end
end;



match_ind(find(isnan(match_ind))) = [];
ifcb_ind2plot = (find(~isnan(match_ind))); %indices for IFCB file list that have matching positions.


 lat_IFCB = Lat(match_ind);
% lat_IFCB_TB = Lat(match_ind)*100;
 lat_IFCB_TB = Lat(match_ind);
 lon_IFCB = Lon(match_ind);
% lon_IFCB_TB = Lon(match_ind)*100;
 lon_IFCB_TB = Lon(match_ind);
%watertemp_IFCB_TB = SAMOSWaterTempExternalVALUE(match_ind);

save \\sosiknas1\IFCB_data\IFCB010_OkeanosExplorerAug2013\metadata\metadata_TB lat_IFCB_TB lon_IFCB_TB ifcb_ind2plot %watertemp_IFCB_TB