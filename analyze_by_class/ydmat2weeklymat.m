function [  y_wkmat, mdate_wkmat, yd_wk ] = ydmat2weeklymat( y_ydmat, yearlist )
%function [ y_wkmat, mdate_wkmat, yd_wk ] = ydmat2weeklymat( y_ydmat, yearlist )
%accept an input matrix of mean values for each yearday by year (y_ydmat)
%output a matrix of mean values for each week by year (y_wkmat) 
%Heidi M. Sosik, Woods Hole Oceanographic Institution, May 2012

numyrs = length(yearlist);
mdate_year = datenum(yearlist,0,0);
yd_wk = (1:7:364)';
mdate_wkmat = repmat(yd_wk,1,numyrs)+repmat(mdate_year,length(yd_wk),1);
%yearday_all = mdate-datenum(dv(:,1),0,0);
y_wkmat = NaN(52,numyrs);
for count = 1:52-1,
    iii = count*7-6:count*7;
    y_wkmat(count,:) = nanmean(y_ydmat(iii,:));
end;
%include last day (or two if leap year) in final week
iii = yd_wk(end):366;
y_wkmat(count+1,:) = nanmean(y_ydmat(iii,:));
end


