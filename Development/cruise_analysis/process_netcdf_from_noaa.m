%  Emily writing to compile position/time data from NOAA cruises from
%Netcdf files provided in standard format at: https://samos.coaps.fsu.edu/html/data_availability.php
% first download the data and then enter then unzip and enter in the path
% below where it is saved. 
close all; clear all;
datapath = '\\sosiknas1\Lab_data\LTER\NESLTER_broadscale\20160808_PC1607\samos_netcdf\netcdf\';
filelist = dir([datapath, '*.nc']);
filelist = {filelist.name}';
latitude= [];
longitude = [];
matdate =[];

for i = 1:length(filelist)
    latitude_temp = ncread(([datapath, char(filelist(i))]), 'lat');
    longitude_temp = ncread(([datapath, char(filelist(i))]), 'lon');
    longitude_temp = longitude_temp -360;
    time_of_day_temp = ncread(([datapath, char(filelist(i))]), 'time_of_day');
    time_of_day_temp = num2str(time_of_day_temp, '%06.f');
    date_temp = ncread(([datapath, char(filelist(i))]), 'date');
    date_temp = num2str(date_temp);
    
    yr = date_temp(:,1:4); year = str2num(yr);
    month = date_temp(:,5:6); month = str2num(month);
    day = date_temp(:,7:8); day = str2num(day);
      
    hour = time_of_day_temp(:,3:4);hour = str2num(hour);
    minute = time_of_day_temp(:,3:4); minute = str2num(minute);
    second = time_of_day_temp(:,5:6); second = str2num(second);
    
    date_temp = datenum(year, month, day, hour, minute, second);
    
    latitude = [latitude; latitude_temp];
    longitude = [longitude; longitude_temp];
    matdate = [matdate; date_temp];
    
    
%     temp = datevec(matdate); year = temp(:,1); month = temp(:,2);
%     day = temp(:,3); hour = temp(:,4); minute = temp(:,5); second = temp(:,6);
    
    clear time* date* yr month day hour minute second
    
end
    clear i  longitude_temp latitude_temp
    
    uw.lat = latitude;
    uw.lon = longitude;
    uw.mdate = matdate;
    
%save \\sosiknas1\IFCB_data\IFCB101_GordonGunterMay2017\metadata\metadata_raw matlab_date latitude longitude hour minute second day month year;


% 
%   for j = 1:length(time_of_day_temp);
%         hour(j,1:2) = time_of_day_temp(j,1:2);
%         if strmatch(hour(j, 1:2), '  ')
%             hour(j, 1:2) = '00';
%         else
%             continue
%         end
%     end