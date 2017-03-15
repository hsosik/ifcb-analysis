X=load ('c:\work\mvco\otherdata\2009_OcnDat_s.C99','ascii');
loadOcnDat
yd_ocn2009 = yd_ocn;
Temp2009 = Temp;
Saln2009 = Saln;

 X=load('c:\work\mvco\otherdata\2009_MetDat_s.C99','ascii');
 loadMetDat
 CalcDailySolar
 DailySolar2009 = DailySolar;
 yd_met2009 = yd_met;
 Solar2009 = Solar_campmt_median;
 Wspd2009 = Wspd_son3D_mean;
 Wdir2009 = Wdir_son3D_mean;
 
 X=load ('c:\work\mvco\otherdata\2009_ADCP_s.C11','ascii');
 loadAdcp
 yd_adcp2009 = yd_adcp;
 vE_mean2009 = vE_mean;
 vN_mean2009 = vN_mean;
 
save other09 *2009
clear all
load other09

