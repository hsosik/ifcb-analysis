function [ mdate_mat, y_mat, yearlist, yd ] = timeseries2ydmat_sum( mdate, y )
%function [ mdate_mat, y_mat, yearlist, yd ] = timeseries2ydmat( mdate, y )
%accept an input time series (vector of dates in mdate; vector of y-values
%in y) and output a matrix of summed values for each yearday by year 
%Heidi M. Sosik, Woods Hole Oceanographic Institution, March 2012

yd = (1:366)';
dv = datevec(mdate); 
yearlist = (dv(1,1):dv(end,1));
mdate_year = datenum(yearlist,0,0);
mdate_mat = repmat(yd,1,length(yearlist))+repmat(mdate_year,length(yd),1);
yearday_all = mdate-datenum(dv(:,1),0,0);
y_mat = NaN(size(mdate_mat));

for count = 1:length(yearlist),    
    iii = find(dv(:,1) == yearlist(count));
    for day = yd(1):yd(end),
        ii = find(floor(yearday_all(iii)) == day);
        if ~isempty(ii),
            y_mat(day,count) = nansum(y(iii(ii)),1);
        end;
    end;
end;
end
