%first import columns A, B, H and J as text

temp = char(Date(2:end));
temp2= char(Time(2:end));
%temp = char(Date([2:21232 21234:46442 46444:end]));%special case for bad
%data in second elg file of GGMAy2016 data.
%temp2= char(Time([2:21232 21234:46442 46444:end]));

yr = cellstr(temp(:, 7:10));
year = str2num(char(yr));
month = cellstr(temp(:, 1:2));
month = str2num(char(month));
day = cellstr(temp(:, 4:5));
day = str2num(char(day));

hr= cellstr(temp2(:,1:2));
hour = str2num(char(hr));
min = cellstr(temp2(:,4:5));
minute = str2num(char(min));
sec = cellstr(temp2(:, 7:8));
second = str2num(char(sec));

date = datenum(year, month, day, hour, minute, second);

cruise_start = datevec(date(1))
cruise_end = datevec(date(end))

lat = char(lat);
lat = lat(2:end ,1:10);
%lat = lat([2:21232 21234:46442 46444:end], 1:10);
deg = lat(:,1:2);
deg= str2num(deg);
min = lat(:,3:9);
min = (str2num(min))/60;
lat = deg+min;


lon = char(lon);
lon = lon(2:end, 1:10);
%lon = lon([2:21232 21234:46442 46444:end], 1:10);
deg = lon(:,1:3);
deg= str2num(deg);
deg = -(deg);
min = lon(:,4:9);
min = (str2num(min));
min = -(min)/60;
lon = deg+min;

latitude = lat;
longitude = lon;
matlab_date = date;
save \\sosiknas1\IFCB_data\NESLTER_broadscale\metadata\Bigelow_May2018\metadata_raw matlab_date latitude longitude hour minute second day month year;

%to combine 3 metadatafiles.
% load('\\sosiknas1\IFCB_data\IFCB101_GordonGunterMay2016\metadata\metadata1.mat')
% load('\\sosiknas1\IFCB_data\IFCB101_GordonGunterMay2016\metadata\metadata2.mat')
% load('\\sosiknas1\IFCB_data\IFCB101_GordonGunterMay2016\metadata\metadata3.mat')
% 
% lat_full = [lat1; lat2; lat3];
% lon_full = [lon1; lon2; lon3];
% date_full = [date1; date2; date3];
%clear *1 *2 *3
%save \\sosiknas1\IFCB_data\IFCB101_GordonGunterMay2016\metadata\metadata_raw

 for i = 2:length(LOG_DATE)
     b(i,1:5)= sscanf(LOG_DATE{i}, '%d/%d/%d %d:%d');
 end
 
 
 % Code from Taylor that worked well on date/time from ARMSTRONG data
 % output 
 
 matdate = cell2mat(Date(3:end));
 mattime = cell2mat(Time(3:end));
 matlab_date = datenum([matdate mattime]);
 
 full_date = datevec(matlab_date);
 
 year = full_date(:,1);
 month = full_date(:,2);
 day = full_date(:,3);
 hour = full_date(:,4);
 minute = full_date(:,5);
 second = full_date(:,6);
 
save \\sosiknas1\IFCB_data\IFCB109_ArmstrongSep2017\metadata\metadata_raw matlab_date latitude longitude hour minute second day month year;
