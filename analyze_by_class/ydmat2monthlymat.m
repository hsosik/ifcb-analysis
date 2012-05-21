function [  y_monthmat, mdate_monthmat] = ydmat2monthlymat( y_ydmat, yearlist )
%function [  y_monthmat, mdate_monthmat] = ydmat2monthlymat( y_ydmat, yearlist )
%accept an input matrix of mean values for each yearday by year (y_ydmat)
%output a matrix of mean values for each month by year (y_monthmat) 
%Heidi M. Sosik, Woods Hole Oceanographic Institution, May 2012

numyrs = length(yearlist);
mdate_year = datenum(yearlist,0,0);
yd = (1:366)';
mdate = repmat(yd,1,numyrs)+repmat(mdate_year,length(yd),1);
[~,month,~,~,~,~] = datevec(mdate);
mdate_monthmat = datenum(repmat(yearlist,12,1),repmat((1:12)',1,length(yearlist)),1);
y_monthmat = NaN(12,numyrs);
for count = 1:12,
    mask = ones(size(month));
    mask(month~=count) = NaN;
    y_monthmat(count,:) = nanmean(y_ydmat.*mask);
end;
end


