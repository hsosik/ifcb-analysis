%loadMetDat
DailySolar = NaN.*ones(366,1);
myDay = floor(yd_met);
for count = 1:366,
    ind = find(myDay == count & ~isnan(Solar_campmt_median));
    if ~isempty(ind) & (max(diff(yd_met(ind)))*24 <= 2),
        %DailySolar(count) = sum(Solar_campmt_median(ind));       
        DailySolar(count) = trapz(yd_met(ind), Solar_campmt_median(ind));       
    end;
end;
DailySolar = DailySolar*86400/1e6;  %(MJ m^{ -2})
    
    