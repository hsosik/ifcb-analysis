function [LON LAT HH]=read_GridOne

GD=netcdf_PaulSpencer('GridOne.grd'); 
% GD = 
% 
%      NumRecs: 0
%     DimArray: [1x2 struct]
%     AttArray: [1x2 struct]
%     VarArray: [1x6 struct]

lon_range=double(GD.VarArray(1).Data);
lat_range=double(GD.VarArray(2).Data);
space=GD.VarArray(4).Data;
LON=[lon_range(1):space(1):lon_range(2)];
LAT=[lat_range(2):-space(2):lat_range(1)];
HH=double(GD.VarArray(6).Data);
HH=reshape(HH, length(LON), length(LAT));
HH=HH.';
%contour(LON(1:60:end), LAT(1:60:end), HH(1:60:end, 1:60:end))

%% Note:
% 1) GridOne.grd can be downloaded from http://www.bodc.ac.uk/data/online_delivery/gebco/
