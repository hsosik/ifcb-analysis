yd = (1:366)';
yearlist = (2003:2014);

Temp = []; Saln = []; Wspd = []; Wdir = []; waveh_swell = []; wavep_swell = [];  waveh_windwave = []; wavep_windwave = [];
vE = []; vN = []; DailySolar = []; ocnmdate = []; metmdate = []; adcpmdate = []; dailymdate = [];
for ii = 2003:2014, 
    ystr = num2str(ii);
    if ii == 2003 | ii == 2004, %end up with average of node and seacat where overlap
        other = load('c:\work\mvco\otherData\other03_04');
        eval(['other.Temp' ystr '= [other.Temp' ystr '; other.temp_seacat' ystr '];'])
        eval(['other.Saln' ystr '= [other.Saln' ystr '; other.saln_seacat' ystr '];'])
        eval(['other.yd_ocn' ystr '= [other.yd_ocn' ystr '; other.yd_seacat' ystr '];'])
    else
        other = load(['c:\work\mvco\otherData\other' ystr(3:4)]);
    end;
    eval(['Temp = [Temp;  other.Temp' ystr '];'])
    eval(['Saln = [Saln;  other.Saln' ystr '];'])
    eval(['Wspd = [Wspd;  other.Wspd' ystr '];'])
    eval(['Wdir = [Wdir;  other.Wdir' ystr '];'])
    eval(['waveh_swell = [waveh_swell;  other.wave_height' ystr '(:,2)];'])
    eval(['wavep_swell = [wavep_swell;  other.wave_period' ystr '(:,2)];'])
    eval(['waveh_windwave = [waveh_windwave;  other.wave_height' ystr '(:,2)];'])
    eval(['wavep_windwave = [wavep_windwave;  other.wave_period' ystr '(:,2)];'])
    eval(['vE = [vE;  other.vE_mean' ystr '(:,10)];']) %I think this is about ~8 m off the bottom
    eval(['vN = [vN;  other.vN_mean' ystr '(:,10)];'])
    eval(['DailySolar = [DailySolar;  other.DailySolar' ystr '];'])
    eval(['ocnmdate = [ocnmdate;  other.yd_ocn' ystr '+datenum(' ystr ',1,0)];'])
    eval(['metmdate = [metmdate;  other.yd_met' ystr '+datenum(' ystr ',1,0)];'])
    eval(['adcpmdate = [adcpmdate;  other.yd_adcp' ystr '+datenum(' ystr ',1,0)];'])
    t = eval(['datenum((1:366) + datenum(' ystr ',1,0));']);
    eval(['dailymdate = [dailymdate;  ((1:366) +datenum(' ystr ',1,0))''];'])
end;
clear other ystr ii t

mdate = ocnmdate; y = Temp; y2 = Saln;
[ mdate_mat, Temp, yearlist, yd ] = timeseries2ydmat( mdate, y );
[ mdate_mat, Saln, yearlist, yd ] = timeseries2ydmat( mdate, y2 );

mdate = metmdate; y = Wspd; y2 = Wdir;
[ mdate_mat, Wspd, yearlist, yd ] = timeseries2ydmat( mdate, y );
[ mdate_mat, Wdir, yearlist, yd ] = timeseries2ydmat( mdate, y2 );

mdate = adcpmdate; y = vE; y2 = vN; y3 = wavep_swell; y4 = waveh_swell; y5 = wavep_windwave; y6 = waveh_windwave;
[ mdate_mat, vE, yearlist, yd ] = timeseries2ydmat( mdate, y );
[ mdate_mat, vN, yearlist, yd ] = timeseries2ydmat( mdate, y2 );
[ mdate_mat, wavep_swell, yearlist, yd ] = timeseries2ydmat( mdate, y3 );
[ mdate_mat, waveh_swell, yearlist, yd ] = timeseries2ydmat( mdate, y4 );
[ mdate_mat, wavep_windwave, yearlist, yd ] = timeseries2ydmat( mdate, y5 );
[ mdate_mat, waveh_windwave, yearlist, yd ] = timeseries2ydmat( mdate, y6 );

mdate = mdate_mat(:);
Temp = Temp(:); Saln = Saln(:);
Wspd = Wspd(:); Wdir = Wdir(:);
vE = vE(:); vN = vN(:);
wavep_swell = wavep_swell(:); waveh_swell = waveh_swell(:);
wavep_windwave = wavep_windwave(:); waveh_windwave = waveh_windwave(:);
DailySolar = DailySolar(:);

%omit the double 1 Jan after non-leap years
ii = find(diff(mdate(:))==0);
mdate(ii) = [];
Temp(ii) = [];
Saln(ii) = [];
Wspd(ii) = [];
Wdir(ii) = [];
vE(ii) = [];
vN(ii) = [];
wavep_swell(ii) = [];
waveh_swell(ii) = [];
wavep_windwave(ii) = [];
waveh_windwave(ii) = [];
DailySolar(ii) = [];


notes = {'Temp, temperature in degrees C' 'Saln, salinity' 'Wspd, wind speed in meters per second' 'Wdir, wind direction in degrees'...
    'DailySolar, incident shortwave radiation in megajoules per meter squared per day'...
    'vE, eastward water velocity in cm per second' 'vN, northward water velocity in cm per second' 'wavep, wave period in seconds' 'waveh, wave height in cm'}';
clear ii y* adcpmdate dailymdate metmdate ocnmdate mdate_mat

save Other_day mdate notes Temp Saln Wspd Wdir vE vN wavep_swell waveh_swell wavep_windwave waveh_windwave DailySolar


return
t = load('C:\work\mvco\Carbon\conc_summary_fcb');
mdate2 = t.mdate(:);
synperml = t.synperml(:);

ii = find(diff(mdate2(:))==0);
mdate2(ii) = [];
synperml(ii) = [];

save Other_day synperml -append