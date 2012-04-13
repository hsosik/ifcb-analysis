function [ lat, lon ] = get_healy2010_latlon( mdate )
%function [ lat, lon ] = get_healy2010_latlon( mdate )
%   get matching lat/lon for underway sampling on Healy2010 from input
%   date/time in matlab format; use simple interpolation independently for
%   lat and lon
load \\floatcoat\laneylab\projects\HLY1001\analysis\ships_underway\posmv_gga
lat = interp1(posmv_ggaData(:,1), posmv_ggaData(:,2), mdate);
lon = interp1(posmv_ggaData(:,1), posmv_ggaData(:,3), mdate);

end

