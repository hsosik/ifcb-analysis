function [IFCB_match] =  IFCB_match_uw(IFCB_files, uw)
% function IFCB_match = IFCB_match_uw(IFCB_mdate, uw);
% input a list of IFCB filenames and a table of underway ship's info
% (mdate, lat, lon)
% output a table of closest match lat/lon for the IFCB files (interpolate
% if larger than 5 minute gap in the underway data)
% Heidi M. Sosik, Woods Hole Oceanographic Instition, Decemeber 2020
%
IFCB_mdate = IFCB_file2date(cellstr(IFCB_files));
for count = 1:length(IFCB_mdate)
    [m,ia] = min(abs(IFCB_mdate(count)-uw_mdate));
    if m < 5/60/24 %5 minutes as days
        IFCB_match.Lat(count) = uw.lat(ia);
        IFCB_match.Lon(count) = uw.lon(ia);
    else
        if IFCB_mdate(count) > uw_mdate(ia) %closest to end of gap
            it = ia;
        else %closest to start of gap
            it = ia-1;
        end
        step = floor((uw_mdate(it+1)- uw_mdate(it))*24*60); %one minute interpolation
        [lat,lon] = track2(uw_lat(it), uw_lon(it),uw_lat(it+1), uw_lon(it+1),[],[], step);
        it2 = round((IFCB_mdate(count)-uw_mdate(it))/(uw_mdate(it+1)-uw_mdate(it))*step); %index of closest interpolated minute
        IFCB_match.Lat(count) = lat(it2);
        IFCB_match.Lon(count) = lon(it2);
    end
end

end

