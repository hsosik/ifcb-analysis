function [ yearday, year ] = datenum2yearday( mdate )
%[ yearday, year ] = datenum2yearday( mdate )
%convert matlab date number into corresponding yearday (Jan 1 00:00 = 1.0)
% Heidi M. Sosik, Woods Hole Oceanographic Institution, Jan 2012
    dv = datevec(mdate(:));
    year = dv(:,1);
    yearday = mdate(:) - datenum(year,0,0);
end

