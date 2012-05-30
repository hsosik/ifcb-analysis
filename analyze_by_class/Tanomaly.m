load Tday
Tmean = nanmean(Tday,2);
Tanom = Tday - repmat(Tmean,1,length(yearall));

return

[~,~,ii] = intersect(year_ifcb,yearall);
Tmean_ifcb = nanmean(Tday(:,ii),2);
Tanom_ifcb = Tday(:,ii) - repmat(Tmean_ifcb,1,length(year_ifcb));

xanom = Tanom;
yanom = Tanom;  %this is where you put your ciliate mat 366 by years
subplotwidth = 4;
month_bins = (1:2)';
[r,slope,n,p,r_sig,slope_sig] = anomaly_corr(xanom, yanom, yd, month_bins, subplotwidth, yearall);

