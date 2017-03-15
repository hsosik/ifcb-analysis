X=load ('c:\work\mvco\otherdata\2012_OcnDat_s.C99','ascii');
loadOcnDat
yd_ocn2012 = yd_ocn;
Temp2012 = Temp; 
Saln2012 = Saln;

 X=load('c:\work\mvco\otherdata\2012_MetDat_s.C99','ascii');
 loadMetDat
 CalcDailySolar
 DailySolar2012 = DailySolar;
 yd_met2012 = yd_met;
 Solar2012 = Solar_campmt_median;
 Wspd2012 = Wspd_son3D_mean;
 Wdir2012 = Wdir_son3D_mean;
 
 X=load ('c:\work\mvco\otherdata\2012_ADCP_s.C11','ascii');
 loadAdcp
 yd_adcp2012 = yd_adcp;
 vE_mean2012 = vE_mean;
 vN_mean2012 = vN_mean;
 
save other12 *2012
clear all
load other12

