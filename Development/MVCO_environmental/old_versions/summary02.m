X=load ('c:\work\mvco\otherdata\2002_OcnDat_s.C99','ascii');
loadOcnDat
yd_ocn2002 = yd_ocn;
Temp2002 = Temp;
Saln2002 = Saln;
ind = find(~isnan(Temp)& ~isnan(Temp_adcp));
fit = polyfit(Temp_adcp(ind), Temp(ind), 1);
ind = find(isnan(Temp));
Temp2002(ind) = Temp_adcp(ind)*fit(1)+fit(2);

X=load('c:\work\mvco\otherdata\2002_MetDat_s.C99','ascii');
loadMetDat
CalcDailySolar
DailySolar2002 = DailySolar;
yd_met2002 = yd_met;
Solar2002 = Solar_campmt_median;
Wspd2002 = Wspd_son3D_mean;
Wdir2002 = Wdir_son3D_mean;

X=load ('c:\work\mvco\otherdata\2002_ADCP_s.C11','ascii');
loadAdcp
yd_adcp2002 = yd_adcp;
vE_mean2002 = vE_mean;
vN_mean2002 = vN_mean;

save other02 *2002
clear all
load other02

