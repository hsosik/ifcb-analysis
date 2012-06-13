load Tday
Tmean = nanmean(Tday,2);
Tanom = Tday - repmat(Tmean,1,length(yearall));
Tanom_short= Tanom(:,4:10);
return

[~,~,ii] = intersect(year_ifcb,yearall);
Tmean_ifcb = nanmean(Tday(:,ii),2);
Tanom_ifcb = Tday(:,ii) - repmat(Tmean_ifcb,1,length(year_ifcb));

xanom = Tanom;
yanom = Tanom;  %this is where you put your ciliate mat 366 by years
subplotwidth = 4;
month_bins = (1:2)';
[r,slope,n,p,r_sig,slope_sig] = anomaly_corr(xanom, yanom, yd, month_bins, subplotwidth, yearall);

eqdiam0_10ciliatemean = nanmean(eqdiam0_10ciliate_mat,2);
eqdiam0_10ciliateanom = eqdiam0_10ciliate_mat - repmat(eqdiam0_10ciliatemean,1,length(yearlist));
biovol0_10ciliatemean = nanmean(biovol0_10ciliate_mat,2);
biovol0_10ciliateanom = biovol0_10ciliate_mat - repmat(biovol0_10ciliatemean,1,length(yearlist));

eqdiam10_20ciliatemean = nanmean(eqdiam10_20ciliate_mat,2);
eqdiam10_20ciliateanom = eqdiam10_20ciliate_mat - repmat(eqdiam10_20ciliatemean,1,length(yearlist));
biovo110_20ciliatemean = nanmean( biovol10_20ciliate_mat,2);
biovo110_20ciliateanom =  biovol10_20ciliate_mat - repmat(biovo110_20ciliatemean,1,length(yearlist));

eqdiam20_30ciliatemean = nanmean(eqdiam20_30ciliate_mat,2);
eqdiam20_30ciliateanom = eqdiam20_30ciliate_mat - repmat(eqdiam20_30ciliatemean,1,length(yearlist));
biovol20_30ciliatemean = nanmean(biovol20_30ciliate_mat,2);
biovol20_30ciliateanom = biovol20_30ciliate_mat - repmat(biovol20_30ciliatemean,1,length(yearlist));

eqdiam30_40ciliatemean = nanmean(eqdiam30_40ciliate_mat,2);
eqdiam30_40ciliateanom = eqdiam30_40ciliate_mat - repmat(eqdiam30_40ciliatemean,1,length(yearlist));
biovol30_40ciliatemean = nanmean(biovol30_40ciliate_mat,2);
biovol30_40ciliateanom = biovol30_40ciliate_mat - repmat(biovol30_40ciliatemean,1,length(yearlist));

eqdiam40_infciliatemean = nanmean(eqdiam40_infciliate_mat,2);
eqdiam40_infciliateanom = eqdiam40_infciliate_mat - repmat(eqdiam40_infciliatemean,1,length(yearlist));
biovol40_infciliatemean = nanmean(biovol40_infciliate_mat,2);
biovol40_infciliateanom = biovol40_infciliate_mat - repmat(biovol40_infciliatemean,1,length(yearlist));

xanom = Tanom_short;
%yanom = biovol0_10ciliateanom;
%yanom = biovo110_20ciliateanom;
%yanom = biovol20_30ciliateanom;
%yanom = biovol30_40ciliateanom;
yanom = biovol40_infciliateanom;
subplotwidth = 4;
month_bins = (1:12)';
[r,slope,n,p,r_sig,slope_sig] = anomaly_corr(xanom, yanom, yd, month_bins, subplotwidth, yearlist);
set(gcf,'position',[405 80 900 585])


