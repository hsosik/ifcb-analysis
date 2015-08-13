%taylor 5Jun 2014
%try to compile all adc data into 1 mat file to be able to plot look times
%to try and troubleshoot currently deployed IFCB1 that keeps making small
%files all of a sudden or just stopped acq altogether once.
%file ='Z:\IFCB1_2014_160\IFCB1_2014_160_125311.adc'

%IFCB1 Sept deployment starts day 260

files   = dir(['.\temp\IFCB*.adc']);
% files   = dir(['.\tempadc2013\IFCB*.adc']);
filename = cell(length(files),1);
fileinfo = NaN(length(files),5);
adcdata = [];
matdate = [];

for count = 1:length(files)-1
%     if ~strcmp(files(count).name,'IFCB5_2013_213_085447.adc') & ~strcmp(files(count).name,'IFCB5_2013_222_064917.adc')
    tempdata = load(['.\temp\' files(count).name]);
%     tempdata = load(['.\tempadc2013\' files(count).name]);
if size(tempdata) > 1    
    filename(count) = {files(count).name};
    fileinfo(count,1) = datenum(files(count).date);
    fileinfo(count,2) = files(count).bytes;
    fileinfo(count,3) = length(tempdata);
    fileinfo(count,4) = sum(tempdata(:,10)<0);
    fileinfo(count,5) = sum(tempdata(:,10)<0)/length(tempdata);
    
    adcdata = [adcdata; tempdata];
    matdate = [matdate; repmat(datenum(files(count).date),length(tempdata),1)];
    
%     adcdata(place).fname          = files(count).name;
%      adcdata(place).adcdata        = tempdata;
%     adcdata(place).datenum        = datenum(files(count).date);
%     adcdata(place).size           = files(count).bytes;
%     adcdata(place).tot_events     = length(tempdata);
%     adcdata(place).zero_rois      = sum(tempdata(:,10)<0);
%     adcdata(place).percent_missed = sum(tempdata(:,10)<0)/length(tempdata);
end
clear tempdata
%     end
end

header_filedata={'datenum','bytes','triggers','zero rois','percent missed'}';
header_adc = {'count','time','PMTA low gain','PMTA high gain','PMTC low gain','PMTC high gain','pulse dur','grab start','grab end','xpos','ypos','SizeX','SizeY','startbyte'};
% start=adcdata(:,8);
% finish=adcdata(:,9);
% start(1:end-1)-finish(2:end)
% plot(ans(1:end-1),'.')
% 
% header_adc = {'nProcessingCount'; 'ADCtime'; 'pmtA low gain'; 'pmtA high gain'; 'pmtC low gain'; 'pmtC high gain';...
%     'duration of comparator pulse'; 'GrabtimeStart'; 'GrabtimeEnd'; 'xpos'; 'ypos'; 'roiSizeX'; 'roiSizeY'; 'StartByte';'?'};

clear count* tempdata files *day place 

% save('C:\IFCB1\percent_missed_roisFALL2013')
% save('percent_missed_roisFALL2013')


    % %adcdata: 1 = nProcessingCount
    %           2 = ADCtime
    %           3 = pmtA low gain
    %           4 = pmtA high gain
    %           5 = pmtC low gain
    %           6 = pmtC high gain
    %           7 = duration of comparator pulse
    %           8 = GrabtimeStart
    %           9 = GrabtimeEnd
    %           10 = x position
    %           11 = y position
    %           12 = roiSizeX
    %           13 = roiSizeY
    %           14 = StartByte

    %%% adcdata(1) = ADCresults(0)
    %             'ADCresults(0)  = nProcessingCount
    %             'ADCresults(1)  = ADCtime
    %             'ADCresults(2)  = AD0 = analog channel A_lowgain_integrated
    %             'ADCresults(3)  = AD1 = analog channel A_highgain_integrated
    %             'ADCresults(4)  = AD2 = analog channel C_lowgain_integrated
    %             'ADCresults(5)  = AD3 = analog channel C_highgain_integrated
    %             '                 AD4 = TempAveV
    %             '                 AD5 = HumAveV
    %             '                 AD6 = ChAAve
    %             '                 AD7 = ChCAve
    %             'ADCresults(6)  = AD8 = duration of comparator pulse (now from B_low_int; prev. from daughter board)
    %             'ADCresults(7)  = GRABtimeStart
    %             'ADCresults(8)  = GRABtimeEnd
    %             'ADCresults(9)  = xmin
    %             'ADCresults(10) = ymin
    %             'ADCresults(11) = roiSizeX
    %             'ADCresults(12) = roiSizeY
    %             'ADCresults(13) = StartByte
    %             'ADCresults(14) = AD9 = solenoid V (comparator_out)
    %             'ADCresults(15) = AD10 = peak_detect_2_analog channel A
    %             'ADCresults(16) = AD11 = peak_detect_1_trigger
    %             'ADCresults(17) = AD12 = B_hi_int (also duration, but with different time constant)

    %     %for merging low/high gain data...
    %     plot(-adcdata(:,3), -adcdata(:,4),'.'); axis([-.1 1 0 10]); %inspect chl high vs low gain
    %     plot(-adcdata(:,5), -adcdata(:,6),'.') %inspect chl high vs low gain

%     chl_overlap_region = [.1 .2]; %low gain values where high vs low seems ok
%     ssc_overlap_region = [.02 .04]; %low gain values where high vs low seems ok
%     overlapind_chl = intersect(find(chl>chl_overlap_region(1)),find(chl<chl_overlap_region(2)));% to calculate merging for chl
%     overlapind_ssc = intersect(find(ssc>ssc_overlap_region(1)),find(ssc<ssc_overlap_region(2)));% to calculate merging for chl
%     chl_factor = mean(adcdata(overlapind_chl,4)./adcdata(overlapind_chl,3));
%     ssc_factor = mean(adcdata(overlapind_ssc,4)./adcdata(overlapind_ssc,3));
%     if isnan(chl_factor), chl_factor = 28; end
%     if isnan(ssc_factor), ssc_factor = 28; end
%     chl(find(chl<chl_overlap_region(2))) = -adcdata(find(chl<chl_overlap_region(2)),4)./chl_factor;
%     ssc(find(ssc<ssc_overlap_region(2))) = -adcdata(find(ssc<ssc_overlap_region(2)),6)./ssc_factor;
    