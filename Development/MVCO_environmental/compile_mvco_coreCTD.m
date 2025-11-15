yr = 2021:2025;

base_bottom = "\\sosiknas1\Lab_data\MVCO\EnvironmentalData\asit.ctd_YYYY.csv";
base_beam = "\\sosiknas1\Lab_data\MVCO\EnvironmentalData\asit.beam.ctd_YYYY.csv";

ctdTable_beam = timetable;
ctdTable_bot = timetable;

for ii = 2:numel(yr)
    Ystr = num2str(yr(ii));
    T = readtimetable(regexprep(base_bottom, 'YYYY' , Ystr));
    ctdTable_bot = [ctdTable_bot; T];
    T = readtimetable(regexprep(base_beam, 'YYYY' , Ystr));
    ctdTable_beam = [ctdTable_beam; T];
end


beam_day = retime(ctdTable_beam, 'daily', 'mean');
bot_day = retime(ctdTable_bot, 'daily', 'mean');
T = outerjoin(beam_day, bot_day);

CTD_day = T(:,{'depth_mean_beam_day' 'water_temperature_mean_beam_day' 'salinity_mean_beam_day' 'depth_median_bot_day' 'water_temperature_mean_bot_day' 'salinity_mean_bot_day'});

CTD_day.water_temperature_mean_beam_day_gap_filled = CTD_day.water_temperature_mean_beam_day;
%don't fill gaps with bottom temp for days in Sept 2022 (those are fine in Sosik lab beam CTD) and still stratified so bot temp is too low
%don't fill short gap with bottom temp for days in Aug 2025 (stratified, bot temp too low)
iin = isnan(CTD_day.water_temperature_mean_beam_day) & CTD_day.timestamp>datetime(2022,9,31) & CTD_day.timestamp<datetime(2025,7,29);
CTD_day.water_temperature_mean_beam_day_gap_filled(iin) = CTD_day.water_temperature_mean_bot_day(iin);

Notes = {'Compiled from MVCO core CTDs at ASIT, beam CTD when available, gap fill with bottom CTD when not stratified';...
    'Compilation for periods after Sept 2022; can be merged with MVCO_Daily_temperature.mat for earlier dates';...
    'NOTE:MVCO_Daily_temperature likely has days binned by local time, while this file is UTC';...
    'Produced with \ifcb-analysis\Development\MVCO_environmental\compile_mvco_coreCTD.m';...
    'Heidi M. Sosik, Woods Hole Oceanographic Institution, Nov 2025'};

%save('\\sosiknas1\Lab_data\MVCO\EnvironmentalData\MVCO_Daily_CTD_post2022.mat', 'CTD_day', 'Notes')
%disp('Results saved:')
%disp('\\sosiknas1\Lab_data\MVCO\EnvironmentalData\MVCO_Daily_CTD_post2022.mat')



