X=load ('c:\work\mvco\otherdata\2014_OcnDat_s.C99','ascii');
loadOcnDat
yd_ocn2014 = yd_ocn;
Temp2014 = Temp; 
Saln2014 = Saln;

 X=load('c:\work\mvco\otherdata\2014_MetDat_s.C99','ascii');
 loadMetDat
 CalcDailySolar
 DailySolar2014 = DailySolar;
 yd_met2014 = yd_met;
 Solar2014 = Solar_campmt_median;
 Wspd2014 = Wspd_son3D_mean;
 Wdir2014 = Wdir_son3D_mean;
 
 X=load ('c:\work\mvco\otherdata\2014_ADCP_s.C11','ascii');
 loadAdcp
 yd_adcp2014 = yd_adcp;
 vE_mean2014 = vE_mean;
 vN_mean2014 = vN_mean;
 wave_height2014 = wave_height;
 wave_period2014 = wave_period;

 
save other14 *2014
clear all
load other14

