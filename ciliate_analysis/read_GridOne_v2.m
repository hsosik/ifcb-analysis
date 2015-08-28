function [LON LAT HH]=read_GridOne_v2(dec)
%
%Where:
%
% 1) The optional input, dec, is to decimate the data, its default value
%    is 1, which means that you will read the GridOne data without any
%    decimation.
%
% 2) The first and the second outputs, LON and LAT, are vectors for 
%    longitude and latitude, and the third output HH is a matrix containing
%    the topographic data. You can call contour(LON, LAT, HH) to view the 
%    data.
%
% 3) When dec > 1, the output of HH is in double precision. However when 
%    dec=1, the output H is int16 for the sake of possible RAM constraint 
%    that your computer might have. In both case, LON and LAT are always 
%    output in double precision.
%
% 4) You may have to manage to convert int16 HH to double HH outside of 
%    this program if you need to do further arithmatic operations on HH;
%    otherwise inaccurate results will happen, due to the fact that in 
%    Matlab operations on mix types of data are erroneous 
%    (try int16(2)*pi versus 2*pi).
%    

if nargin == 0
    dec=1;
end

GD=netcdf_PaulSpencer('GridOne.grd'); 
% GD = 
% 
%      NumRecs: 0
%     DimArray: [1x2 struct]
%     AttArray: [1x2 struct]
%     VarArray: [1x6 struct]

len_lon=21601;
len_lat=10801;
lon_range=GD.VarArray(1).Data;
lat_range=GD.VarArray(2).Data;
space=GD.VarArray(4).Data;
HH=GD.VarArray(6).Data; clear GD
HH=reshape(HH, len_lon, len_lat);

LON=[lon_range(1):space(1):lon_range(2)];
LAT=[lat_range(2):-space(2):lat_range(1)];
if length(LON)~=len_lon || length(LAT) ~=len_lat
    error('Something wrong!');
end

if dec > 1
    HH=HH(1:dec:end, 1:dec:end);
    LON=LON(1:dec:end);
    LAT=LAT(1:dec:end);
end

%%
%HH=HH.'; % This will requie a lot of temporary memory if dec=1. Take a
%devide-and-conquor approach:

if dec==1
    HH1=HH(1:10000,:);
    HH(1:10000,:)=[];
    HH1=HH1.';
    HH=HH.';
    HH=[HH1 HH];
    clear HH1
    disp('I am packing up the memory. It takes time ...')
    save read_GridOne_tmptmp.mat 
    clear 
    load read_GridOne_tmptmp.mat
    delete read_GridOne_tmptmp.mat
    disp('Memory packing is finished. Contiune ...')
else
    HH=HH.';
end

%% Note: The original data come such that LON(end)==LON(1)+360 is true.
 % This means that HH(:,1) and HH(:, end) actually describe the 
 % topographic data on the same meridian line. We  therefore expect
 % that HH(:,1)==H(:,end) should be true. I find this is true except for 
 % two points where there are difference of 1 m. You can find out by doing
 %  j=find(HH(:,1)-HH(:,end))
 % j =
 %         5401
 %         7724
 % HH(j, [1 end])
 % ans =
 %   -5446  -5447
 %   -3529  -3530
 % 
 % In contrast, ETOPO2v2g_f4_nc data set is much worth; there are much
 % more data points on the same meridian line whose values are differant 
 % ranging and from 1 m to 2000 m plus. See my note in
 % read_etopo2v2g_f4_nc_v2.m.
 %
 %
 %
%% We need to delete one of the lines anyway as we will do in the
% following.

     if LON(end)==LON(1)+360
        if dec > 1
            HH(:,end)=[];  
        else
            HH1=HH(:,1:10000);
            HH(:,1:10000)=[];
            HH(:,end)=[];
            HH=[HH1 HH];
            clear HH1 
        end
            LON(end)=[];
     end

%%
if dec > 1
    HH=double(HH);
else
    warning(' ')
msg1='Due to the memory constraint, HH is output as int16. Converting it';
msg2='to doulble may be needed for further arithmatic operations.';
disp(msg1);    
disp(msg2);
end


%% Note:
% 1) GridOne.grd can be downloaded from http://www.bodc.ac.uk/data/online_delivery/gebco/
