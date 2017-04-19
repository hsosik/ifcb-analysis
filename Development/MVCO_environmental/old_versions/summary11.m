X=load ('c:\work\mvco\otherdata\2011_OcnDat_s.C99','ascii');
loadOcnDat
yd_ocn2011 = yd_ocn;
%Temp2011 = Temp; 
Temp2011 = Temp_adcp;
Saln2011 = Saln;

 X=load('c:\work\mvco\otherdata\2011_MetDat_s.C99','ascii');
 loadMetDat
 CalcDailySolar
 DailySolar2011 = DailySolar;
 yd_met2011 = yd_met;
 Solar2011 = Solar_campmt_median;
 Wspd2011 = Wspd_son3D_mean;
 Wdir2011 = Wdir_son3D_mean;
 
 X=load ('c:\work\mvco\otherdata\2011_ADCP_s.C11','ascii');
 loadAdcp
 yd_adcp2011 = yd_adcp;
 vE_mean2011 = vE_mean;
 vN_mean2011 = vN_mean;
 
save other11 *2011
clear all
load other11

