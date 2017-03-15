X=load ('c:\work\mvco\otherdata\2005_OcnDat_s.C99','ascii');
loadOcnDat
yd_ocn2005 = yd_ocn;
Temp2005 = Temp;
Saln2005 = Saln;
ind = find(~isnan(Temp)& ~isnan(Temp_adcp));
fit = polyfit(Temp_adcp(ind), Temp(ind), 1);
ind = find(isnan(Temp));
Temp2005(ind) = Temp_adcp(ind)*fit(1)+fit(2);

X=load('c:\work\mvco\otherdata\2005_MetDat_s.C99','ascii');
loadMetDat
CalcDailySolar
DailySolar2005 = DailySolar;
yd_met2005 = yd_met;
Solar2005 = Solar_campmt_median;
Wspd2005 = Wspd_son3D_mean;
Wdir2005 = Wdir_son3D_mean;

X=load ('c:\work\mvco\otherdata\2005_ADCP_s.C11','ascii');
loadAdcp
yd_adcp2005 = yd_adcp;
vE_mean2005 = vE_mean;
vN_mean2005 = vN_mean;

save other05 *2005
clear all
load other05

