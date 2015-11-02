X=load ('c:\work\mvco\otherdata\2006_OcnDat_s.C99','ascii');
loadOcnDat
yd_ocn2006 = yd_ocn;
Temp2006 = Temp;
Saln2006 = Saln;

X=load('c:\work\mvco\otherdata\2006_MetDat_s.C99','ascii');
loadMetDat
CalcDailySolar
DailySolar2006 = DailySolar;
yd_met2006 = yd_met;
Solar2006 = Solar_campmt_median;
Wspd2006 = Wspd_son3D_mean;
Wdir2006 = Wdir_son3D_mean;

X=load ('c:\work\mvco\otherdata\2006_ADCP_s.C11','ascii');
loadAdcp
yd_adcp2006 = yd_adcp;
vE_mean2006 = vE_mean;
vN_mean2006 = vN_mean;

save other06 *2006
clear all
load other06

