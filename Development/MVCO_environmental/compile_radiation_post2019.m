f = dir('\\sosiknas1\Lab_data\MVCO\EnvironmentalData\asit.mininode.CLRohn_rad_*.csv');
dat = [];
for ii = 1:length(f)
    dat = [dat; readtable(fullfile(f(ii).folder, f(ii).name))];
end
dat = table2timetable(dat);
dat.Properties.DimensionNames(1) = {'Time'};

%%
f = dir("\\sosiknas1\Lab_data\MVCO\EnvironmentalData\*_Radiation_asit.txt");
dat2 = [];
for ii = 1:length(f)
    dat2 = [dat2; readtable(fullfile(f(ii).folder, f(ii).name))];
end
dat2 = table2timetable(dat2);
dat2 = removevars(dat2, 'Var3');
dat2 = renamevars(dat2, 'Var2','solar');
dat2.Properties.DimensionNames(1) = {'Time'};

%%

T = load("\\sosiknas1\Lab_data\MVCO\EnvironmentalData\MVCO_Environmental_Tables.mat");
a = T.MVCO_Env_Table(:,'solar');
t = a.time_local;
t.TimeZone = 'America/New_York';
dt = tzoffset(t);
b = timetable(a.time_local-dt);
b.solar = a.solar;
b.Time.TimeZone = ''; %now it's UTC
dat = renamevars(dat, 'solar_rad_mean', 'solar');
dat = removevars(dat, 'ir_rad_mean');

solar_all = [b; dat2; dat];
solar_all.solar(solar_all.solar<0) = 0;
solar_daily = retime(solar_all, 'daily', 'mean');
%rough cut QC
solar_daily.solar(solar_daily.solar>400) = NaN; %few points when night is missing
solar_daily.solar(solar_daily.solar<5) = NaN; %few points when day is missing

save("\\sosiknas1\Lab_data\MVCO\EnvironmentalData\compiled_solar_post2018", 'solar_all', 'solar_daily');
