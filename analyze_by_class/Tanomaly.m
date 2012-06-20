load Tday
Tmean = nanmean(Tday,2);
Tanom = Tday - repmat(Tmean,1,length(yearall));
%Tanom_short= Tanom(:,4:10);


%[~,~,ii] = intersect(year_ifcb,yearall);
[~,~,ii] = intersect(yearlist,yearall);
Tmean_ifcb = nanmean(Tday(:,ii),2);
%Tanom_ifcb = Tday(:,ii) - repmat(Tmean_ifcb,1,length(year_ifcb));
Tanom_ifcb = Tday(:,ii) - repmat(Tmean_ifcb,1,length(yearlist));

xanom = Tanom_ifcb;
yanom = Tanom_ifcb;  %this is where you put your ciliate mat 366 by years
subplotwidth = 4;
month_bins = (1:2)';
[r,slope,n,p,r_sig,slope_sig] = anomaly_corr(xanom, yanom, yd, month_bins, subplotwidth, yearlist);

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

ciliate_biovol_fraction0_10_mean = nanmean(ciliate_biovol_fraction0_10, 2);
ciliate_biovol_fraction0_10_anom = ciliate_biovol_fraction0_10 - repmat(ciliate_biovol_fraction0_10_mean,1,length(yearlist));

ciliate_biovol_fraction10_20_mean = nanmean(ciliate_biovol_fraction10_20, 2);
ciliate_biovol_fraction10_20_anom = ciliate_biovol_fraction10_20 - repmat(ciliate_biovol_fraction10_20_mean,1,length(yearlist));

ciliate_biovol_fraction20_30_mean = nanmean(ciliate_biovol_fraction20_30, 2);
ciliate_biovol_fraction20_30_anom = ciliate_biovol_fraction20_30 - repmat(ciliate_biovol_fraction20_30_mean,1,length(yearlist));

ciliate_biovol_fraction30_40_mean = nanmean(ciliate_biovol_fraction30_40, 2);
ciliate_biovol_fraction30_40_anom = ciliate_biovol_fraction30_40 - repmat(ciliate_biovol_fraction30_40_mean,1,length(yearlist));

ciliate_biovol_fraction40_inf_mean = nanmean(ciliate_biovol_fraction40_inf, 2);
ciliate_biovol_fraction40_inf_anom = ciliate_biovol_fraction40_inf - repmat(ciliate_biovol_fraction40_inf_mean,1,length(yearlist));

figure
plot(yd, ciliate_biovol_fraction0_10_mean, 'b');
hold on
plot(yd, ciliate_biovol_fraction10_20_mean, 'g');
plot(yd, ciliate_biovol_fraction20_30_mean, 'r');
plot(yd, ciliate_biovol_fraction30_40_mean, 'y');
plot(yd, ciliate_biovol_fraction40_inf_mean, 'c');
datetick ('x', 4)
legend ('0-10 fraction', '10-20 fraction', '20-30 fraction', '30-40 fraction', '40-inf fraction')

xanom = Tanom_ifcb;
%yanom = biovol0_10ciliateanom;
%yanom = biovo110_20ciliateanom;
%yanom = biovol20_30ciliateanom;
%yanom = biovol30_40ciliateanom;
yanom = biovol40_infciliateanom;
%yanom = ciliate_biovol_fraction0_10_anom;
%yanom = ciliate_biovol_fraction10_20_anom;
%yanom = ciliate_biovol_fraction20_30_anom;
%yanom = ciliate_biovol_fraction30_40_anom;
%yanom = ciliate_biovol_fraction40_inf_anom;
subplotwidth = 4;
month_bins = (1:12)';
[r,slope,n,p,r_sig,slope_sig] = anomaly_corr(xanom, yanom, yd, month_bins, subplotwidth, yearlist);
set(gcf,'position',[405 80 900 585])


