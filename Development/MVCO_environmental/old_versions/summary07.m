X=load ('c:\work\mvco\otherdata\2007_OcnDat_s.C99','ascii');
loadOcnDat
yd_ocn2007 = yd_ocn;
Temp2007 = Temp;
Saln2007 = Saln;

X=load('c:\work\mvco\otherdata\2007_MetDat_s.C99','ascii');
loadMetDat
CalcDailySolar
DailySolar2007 = DailySolar;
yd_met2007 = yd_met;
Solar2007 = Solar_campmt_median;
Wspd2007 = Wspd_son3D_mean;
Wdir2007 = Wdir_son3D_mean;

X=load ('c:\work\mvco\otherdata\2007_ADCP_s.C11','ascii');
loadAdcp
yd_adcp2007 = yd_adcp;
vE_mean2007 = vE_mean;
vN_mean2007 = vN_mean;

save other07 *2007
clear all
load other06

