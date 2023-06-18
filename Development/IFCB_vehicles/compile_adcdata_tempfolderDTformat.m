%edited taylor 2Nov2015
%use for Vehicle testing on 102. could arguably use same file but in case
%want to do specific things with adc columns they are different. also
%different header for names of fields. 
%taylor 5Jun 2014
%try to compile all adc data into 1 mat file to be able to plot look times
%to try and troubleshoot currently deployed IFCB1 that keeps making small
%files all of a sudden or just stopped acq altogether once.
%file ='Z:\IFCB1_2014_160\IFCB1_2014_160_125311.adc'
clear all
%IFCB1 Sept deployment starts day 260
datadir = '\\sosiknas1\Lab_data\IFCB_forVehicles\IFCB102\TowTest3_26Oct2015\';
files   = dir([datadir '*.adc']);
answer = input('Do you want to exclude initial dock test file before prior to towing? (answer y or n)','s');
if strcmp(answer,'y')
    excludelab = find(~strcmp({files.name},'D20151026T150619_IFCB102.adc'));
    files = files(excludelab);
elseif strcmp(answer,'n')
        return
else error('You must enter y or n');
end
   
% files   = dir(['.\tempadc2013\IFCB*.adc']);
filename = cell(length(files),1);
fileinfo = NaN(length(files),5);
adcdata = [];
matdate = [];

for count = 1:length(files)
    tempdata = load([datadir files(count).name]);
    if strcmp(files(count).name,'D20151026T165236_IFCB102.adc')
        tempdata = tempdata(2:end,:);
    end
    tempdate = datenum([files(count).name(2:9) files(count).name(11:16)],'yyyymmddHHMMSS');
if size(tempdata) > 1    
    filename(count) = {files(count).name};
    fileinfo(count,1) = tempdate;
    fileinfo(count,2) = files(count).bytes;
    fileinfo(count,3) = length(tempdata);
    fileinfo(count,4) = sum(tempdata(:,16)==0);
    fileinfo(count,5) = sum(tempdata(:,16)==0)/length(tempdata);
    
    adcdata = [adcdata; tempdata];
    matdate = [matdate; repmat(tempdate,length(tempdata),1)];
    
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
header_adc = {'trigger#','ADCtime','PMTA', 'PMTB', 'PMTC', 'PMTD', 'peakA', 'peakB', 'peakC', 'peakD', 'time_of_flight', 'grabtimestart', 'grabtimeend', 'ROIx', 'ROIy', 'ROIxizeX-width', 'ROIsizeY-height','start_byte', 'comparator_out', 'STartPoint', 'SignalLength', 'status', 'runTime', 'inhibitTime'};
% start=adcdata(:,8);
% finish=adcdata(:,9);
% start(1:end-1)-finish(2:end)
% plot(ans(1:end-1),'.')
% 
% header_adc = {'nProcessingCount'; 'ADCtime'; 'pmtA low gain'; 'pmtA high gain'; 'pmtC low gain'; 'pmtC high gain';...
%     'duration of comparator pulse'; 'GrabtimeStart'; 'GrabtimeEnd'; 'xpos'; 'ypos'; 'roiSizeX'; 'roiSizeY'; 'StartByte';'?'};

clear count* tempdata files *day place 

%plot ypos over time across multiple files, helpful for multi tow files
adctime_matdate_decimal = adcdata(:,2)/60/60/24;
xpos        = adcdata(:,14);
ypos        = adcdata(:,15);
roisizeX    = adcdata(:,16);
roisizeY    = adcdata(:,17);
figure
plot(matdate + adctime_matdate_decimal,ypos,'.')
datetick('x','keeplimits')
xlabel('Time of day (to show complete of samples from towing','fontweight','bold');
ylabel('ypos','fontweight','bold')
title('Ypos over duration of 2.5mL samples for all of Tow Test 3');
set(gca,'ylim',[0 1030])
unq_time = unique(matdate);
for count = 1:length(unq_time)
    if strcmp(filename(count),'D20151026T160616_IFCB102.adc')
        text(unq_time(count),100,'Sample Sucked Vert','fontweight','bold')
        text(unq_time(count),50,'then start towing','fontweight','bold')
    elseif strcmp(filename(count),'D20151026T171826_IFCB102.adc')
        text(unq_time(count),100,'Beads Internal','color','r','fontweight','bold')
        text(unq_time(count),50,'Run While Towing','color','r','fontweight','bold')
    else text(unq_time(count),100,['Sample # ' num2str(count)],'fontweight','bold')
    end
end


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
    