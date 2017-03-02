X=load ('c:\work\mvco\otherdata\2008_OcnDat_s.C99','ascii');
loadOcnDat
yd_ocn2008 = yd_ocn;
Temp2008 = Temp;
Saln2008 = Saln;

 X=load('c:\work\mvco\otherdata\2008_MetDat_s.C99','ascii');
 loadMetDat
 CalcDailySolar
 DailySolar2008 = DailySolar;
 yd_met2008 = yd_met;
 Solar2008 = Solar_campmt_median;
 Wspd2008 = Wspd_son3D_mean;
 Wdir2008 = Wdir_son3D_mean;
 
 X=load ('c:\work\mvco\otherdata\2008_ADCP_s.C11','ascii');
 loadAdcp
 yd_adcp2008 = yd_adcp;
 vE_mean2008 = vE_mean;
 vN_mean2008 = vN_mean;
 
save other08 *2008
clear all
load other08

