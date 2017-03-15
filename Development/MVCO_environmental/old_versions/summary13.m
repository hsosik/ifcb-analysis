X=load ('c:\work\mvco\otherdata\2013_OcnDat_s.C99','ascii');
loadOcnDat
yd_ocn2013 = yd_ocn;
Temp2013 = Temp; 
Saln2013 = Saln;

 X=load('c:\work\mvco\otherdata\2013_MetDat_s.C99','ascii');
 loadMetDat
 CalcDailySolar
 DailySolar2013 = DailySolar;
 yd_met2013 = yd_met;
 Solar2013 = Solar_campmt_median;
 Wspd2013 = Wspd_son3D_mean;
 Wdir2013 = Wdir_son3D_mean;
 
 X=load ('c:\work\mvco\otherdata\2013_ADCP_s.C11','ascii');
 loadAdcp
 yd_adcp2013 = yd_adcp;
 vE_mean2013 = vE_mean;
 vN_mean2013 = vN_mean;
 wave_height2013 = wave_height;
 wave_period2013 = wave_period;

 
save other13 *2013
clear all
load other13

