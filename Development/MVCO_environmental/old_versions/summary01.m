X=load ('c:\work\mvco\otherdata\2001_OcnDat_s.C99','ascii');
loadOcnDat
yd_ocn2001 = yd_ocn;
Temp2001 = Temp;
Saln2001 = Saln;
ind = find(~isnan(Temp)& ~isnan(Temp_adcp));
fit = polyfit(Temp_adcp(ind), Temp(ind), 1);
ind = find(isnan(Temp));
Temp2001(ind) = Temp_adcp(ind)*fit(1)+fit(2);

X=load('c:\work\mvco\otherdata\2001_MetDat_s.C99','ascii');
loadMetDat
CalcDailySolar
DailySolar2001 = DailySolar;
yd_met2001 = yd_met;
Solar2001 = Solar_campmt_median;
Wspd2001 = Wspd_son3D_mean;
Wdir2001 = Wdir_son3D_mean;

X=load ('c:\work\mvco\otherdata\2001_ADCP_s.C11','ascii');
loadAdcp
yd_adcp2001 = yd_adcp;
vE_mean2001 = vE_mean;
vN_mean2001 = vN_mean;

save other01 *2001
clear all
load other01

