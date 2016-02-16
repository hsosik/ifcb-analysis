datadir = '\\sosiknas1\Lab_data\MVCO\EnvironmentalData\';
%datadir = 'C:\work\mvco\OtherData\';
ystr = '2016';

X=load ([datadir ystr '_OcnDat_s.C99'],'ascii');
loadOcnDat
eval(['yd_ocn' ystr '= yd_ocn;']);
eval(['Temp' ystr '= Temp;']); 
eval(['Saln' ystr '= Saln;']);

X=load([datadir ystr '_MetDat_s.C99'],'ascii');
loadMetDat
CalcDailySolar
eval(['DailySolar' ystr '= DailySolar;']);
eval(['yd_met' ystr '= yd_met;']);
eval(['Solar' ystr '= Solar_campmt_median;']);
eval(['Wspd' ystr '= Wspd_son3D_mean;']);
eval(['Wdir' ystr '= Wdir_son3D_mean;']);

X=load ([datadir ystr '_ADCP_s.C11'],'ascii');
loadAdcp
eval(['yd_adcp' ystr ' = yd_adcp;']);
eval(['vE_mean' ystr ' = vE_mean;']);
eval(['vN_mean' ystr ' = vN_mean;']);
eval(['wave_height' ystr ' = wave_height;']);
eval(['wave_period' ystr ' = wave_period;']);

%fill missing ocn T with adcp T
if strmatch('2015',ystr), 
    Temp_adcp = Temp_adcp_mean;
    ii = find(isnan(Temp2015));
    [~,aa] = unique(yd_adcp);
    Tinterp = interp1(yd_adcp(aa), Temp_adcp(aa), yd_ocn(ii));
    Temp2015(ii) = Tinterp;
end;

save([datadir 'other' ystr ], ['*' ystr]')
clear all
%load([datadir 'other' ystr])

