%taylor 5Jun 2014
%try to compile all adc data into 1 mat file to be able to plot look times
%to try and troubleshoot currently deployed IFCB1 that keeps making small
%files all of a sudden or just stopped acq altogether once.
%file ='Z:\IFCB1_2014_160\IFCB1_2014_160_125311.adc'

%IFCB1 Sept deployment starts day 260
startday = 117;
endday   = 152;
year = '2015';
days2look = startday:endday;

allfiles = [];
bytes    = [];
for count = 1:length(days2look)
    datadir  = dir(['\\sosiknas1\IFCB_data\MVCO\data\' year '\IFCB*_' year '_' num2str(days2look(count))]);
%     datadir  = dir(['\\demi\ifcbnew\IFCB*' datestr(now,'yyyy') '_' num2str(days2look(count))]);
if ~isempty(datadir)
    datadir  = datadir.name;
    files    = dir(['\\sosiknas1\IFCB_data\MVCO\data\' year '\' datadir '\IFCB*.adc']);
%     files    = dir(['\\demi\ifcbnew\' datadir '\IFCB*.adc']);
if ~isempty(files)
    allfiles = [allfiles; cellstr([repmat(['\\sosiknas1\IFCB_data\MVCO\data\' year '\' datadir '\'],length(files),1) char(files.name)])];
%     allfiles = [allfiles; cellstr([repmat(['\\demi\ifcbnew\' datadir '\'],length(files),1) char(files.name)])];
    bytes    = [bytes; [files.bytes]'];
end
end
end
%make matdate from filename for each adc file, thus each row of compiled %missed data
temp      = char(allfiles);
temp2 = datenum(temp(:,end-18:end-15),'yyyy') + str2num(temp(:,end-13:end-11)) -1;%matdate year + yday
matdate = datenum([datestr(temp2,'yyyymmdd') temp(:,end-9:end-4)],'yyyymmddHHMMSS');
clear datadir files temp*

adcdata = NaN(length(allfiles),5);
place = 1;
for count = 1:length(allfiles)
% for count = 1:length(allfiles)
    tempdata = load(cell2mat(allfiles(count)));
    if size(tempdata,1)>1
    adcdata(place,3) = size(tempdata,1);
    adcdata(place,4) = sum(tempdata(:,10)<0);
    adcdata(place,5) = sum(tempdata(:,10)<0)/size(tempdata,1);
    if rem(count,50) == 0,
        disp(allfiles(count))
    end;

%     adcdata(place).fname          = files(count).name;
%     adcdata(place).adcdata        = tempdata;
%     adcdata(place).datenum        = datenum(files(count).date);
%     adcdata(place).size           = files(count).bytes;
%     adcdata(place).tot_events     = length(tempdata);
%     adcdata(place).zero_rois      = sum(tempdata(:,10)<0);
%     adcdata(place).percent_missed = sum(tempdata(:,10)<0)/length(tempdata);
    place = place + 1;
    end
    clear tempdata
end
adcdata(:,1) = matdate;
adcdata(:,2) = bytes;
clear count tempdata bytes matdate
header   = {'datenum','bytes','triggers','zero rois','percent missed'}';

% save('percent_missed_roisFALL2013')


%plot percent missed rois over time
figure
plot(adcdata(:,1),adcdata(:,5))
datetick('x')
ylabel('% missed rois')
title(['% missed rois -' allfiles(1) 'to' allfiles(end)])


%{
figure
subplot(3,1,1)
plot(adc15(:,1),adc15(:,5),'.-')
hold on
plot(adc14(:,1)+365,adc14(:,5),'r.-')
line([adc15(824,1) adc15(824,1)],[0 1],'color','k','linestyle','--','linewidth',2)
datetick('x','keeplimits')
set(gca,'xlim',[min(adc14(:,1))+365 max(adc14(:,1))+365])
datetick('x','keeplimits')
grid on
grid minor
legend('2015','2014','swap 2015')
title('% missed rois - 2015 vs 2014')
xlabel('date','fontweight','bold'); ylabel('% missed','fontweight','bold');

subplot(3,1,2)
plot(adc15(:,1),adc15(:,3),'.-')
hold on
plot(adc15(:,1),adc15(:,4),'r.-')
line([adc15(824,1) adc15(824,1)],[0 14000],'color','k','linestyle','--','linewidth',2)
title('2015 IFCB1')
xlabel('date','fontweight','bold'); ylabel('count','fontweight','bold');
legend('total trig','missed trig')
datetick('x','keeplimits')
set(gca,'xlim',[min(adc14(:,1))+365 max(adc14(:,1))+365])
text(adc15(1100,1), 12000,'IFCB1','fontweight','bold','fontsize',15)
text(adc15(550,1), 12000,'IFCB5','fontweight','bold','fontsize',15)

subplot(3,1,3)
plot(adc14(:,1),adc14(:,3),'.-')
hold on
plot(adc14(:,1),adc14(:,4),'r.-')
set(gca,'xlim',[min(adc14(:,1)) max(adc14(:,1))])
datetick('x','keeplimits')
title('2014 IFCB5')
xlabel('date','fontweight','bold'); ylabel('count','fontweight','bold');
line([adc15(824,1) adc15(824,1)],[0 14000],'color','k','linestyle','--','linewidth',2)
legend('total trig','missed trig')


%}

% header_adc = {'nProcessingCount'; 'ADCtime'; 'pmtA low gain'; 'pmtA high gain'; 'pmtC low gain'; 'pmtC high gain';...
%     'duration of comparator pulse'; 'GrabtimeStart'; 'GrabtimeEnd'; 'xpos'; 'ypos'; 'roiSizeX'; 'roiSizeY'; 'StartByte';'?'};


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
    