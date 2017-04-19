X=load ('c:\work\mvco\otherdata\2010_OcnDat_s.C99','ascii');
loadOcnDat
yd_ocn2010 = yd_ocn;
Temp2010 = Temp;
Saln2010 = Saln;

 X=load('c:\work\mvco\otherdata\2010_MetDat_s.C99','ascii');
 loadMetDat
 CalcDailySolar
 DailySolar2010 = DailySolar;
 yd_met2010 = yd_met;
 Solar2010 = Solar_campmt_median;
 Wspd2010 = Wspd_son3D_mean;
 Wdir2010 = Wdir_son3D_mean;
 
 X=load ('c:\work\mvco\otherdata\2010_ADCP_s.C11','ascii');
 loadAdcp
 yd_adcp2010 = yd_adcp;
 vE_mean2010 = vE_mean;
 vN_mean2010 = vN_mean;
 
save other10 *2010
clear all
load other10

