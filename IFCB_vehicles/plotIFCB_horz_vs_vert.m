%T Crockford Nov14
%to analyze/compare vertically stanging IFCB vs horizontally laying
%plot core position over time. also missed roi rate
%
%assumes only using "new" IFCB adc file format. Both adc formats are listed below
%
%see movies of xpos vs ypos, and long cells position

clear all
%%%%%%%%%%%%%%%%%%%%%%%%
%make_pathfiles2load.m - prompts question of what you'd like to plot 
%set path to data, start & end file, name for saved mat file
%%%%%%%%%%%%%%%%%%%%%%%%
make_pathfiles2load

startday  = str2num([startfile(2:9) startfile(11:16)]);
endday    = str2num([endfile(2:9) endfile(11:16)]);
allfiles  = dir([dirpath 'D2014*.adc']);%get all files from set dir
allfiles  = {allfiles.name}';
temp      = char(allfiles);
temp      = [temp(:,2:9) temp(:,11:16)];
%make matdate for each adc file
matdate   = datenum(temp(:,:),'yyyymmddHHMMSS'); %get matdate from filenames
temp      = str2num(temp);
%only use files of interest - start/end day set above
ind       = find(temp>=startday & temp<=endday);
files     = allfiles(ind); 
matdate   = matdate(ind);
clear temp ind allfiles startfile endfile

%preallocate
xpos = nan(length(files),9);
ypos = xpos;
arealength = nan(length(files),2);
lengtharea = nan(length(files),2);
counts = nan(length(files),1);
%loop through files of interest
%make matrix with calculated mean,median,percentiles5,25,75,95,interquartilerange
for count = 1:length(files);
    adcdata = load([dirpath char(files(count))]); %load individual adcfile
    isroi = find(adcdata(:,16)~=0); %exclude missed rois from calculations - would skew locations and sizes
    xpos(count,:) = [length(adcdata) (length(adcdata)-length(isroi)) mean(adcdata(isroi,14)) median(adcdata(isroi,14)) prctile(adcdata(isroi,14),[5 25 75 95]) iqr(adcdata(isroi,14))];
    ypos(count,:) = [xpos(count,1) xpos(count,2) mean(adcdata(isroi,15)) median(adcdata(isroi,15)) prctile(adcdata(isroi,15),[5 25 75 95]) iqr(adcdata(isroi,15))];
    lengtharea(count,:) = [mean(adcdata(:,16)) mean(adcdata(:,16).*adcdata(:,17))];
    counts(count) = size(adcdata,1);
end

figure
subplot(3,1,1) %counts
plot(matdate,counts)
datetick('x')
ylabel('roi counts')
title('summed count of rois per adc file')
subplot(3,1,2) %mean length
plot(matdate,lengtharea(:,1))
datetick('x')
ylabel('mean length aka)Xsize (pix)')
title(['mean roi length per adc file ' savefilename])
subplot(3,1,3) %mean area
plot(matdate,lengtharea(:,2))
datetick('x')
ylabel('mean roi area - Xsize*Ysize (pix)')
title(['mean roi area per adc file ' savefilename])

%other possible metrics
% xpos = adcdata(:,14);
% ypos = adcdata(:,15);
% xize = adcdata(:,16);
%y = iqr(xpos); %interquartile range
%y = range(X); %just range of min to max of data not as functional since
%outloiers
%y = mad(xpos); %absolute deviation from MEAN (or mad(xpos,0) same thing
%y = mad(xpos,1); %absolute deviation from MEDIAN
%y = quantile(xpos,[0.025 0.25 0.50 0.75 0.975]); %quantiles of chosen value(s)
%y = skewness(xpos,flag); %?? skewness?flag=0 correct for bias, flag=1 do not correct for bias

%header for xpos & ypos variables
header_pos = {'no_rois','no_missed_rois','mean','median','percentile-5%','percentile-25%','percentile-75%','percentile-95','inter quartile range'};

figure %X POSITION
%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%
subplot(4,1,1:2)
plot(xpos(:,3),'b')%mean
hold on
plot(xpos(:,4),'b--')%median
plot(xpos(:,5),'r--')% 5%
plot(xpos(:,8),'r--')% 95%
plot(xpos(:,6),'g')% 25%
plot(xpos(:,7),'g')% 75%
% plot(xpos(:,9),'k')%inter quartile range
set(gca,'ylim',[0 1380])
xlabel('count','fontweight','bold'); ylabel('xpos - pix','fontweight','bold');
title(['Xpos ' savefilename]);
ax = get(gca,'children');
legend([ax(6) ax(6) ax(4) ax(2)],'mean','median','95%','25%') %plot without interquartile range
% legend([ax(7) ax(6) ax(5) ax(3) ax(1)],'mean','median','95%','25%','intqrt range') %when plotting inter quartile range on same plot
%%%%%%%%%%%%%%%%%%%%%%%%%%
%anomaly bar plot - positive red, negative blue
%%%%%%%%%%%%%%%%%%%%%%%%%%
subplot(4,1,3)
count=1:length(xpos);
tot_avgmedian = mean(xpos(:,4));%average median because median seems more representative
anomaly=xpos(:,4)-repmat(tot_avgmedian,length(xpos),1);%mean - avg_median
negative = find(xpos(:,4)-repmat(tot_avgmedian,length(xpos),1)<0);
figure
positive = find(xpos(:,4)-repmat(tot_avgmedian,length(xpos),1)>0);
bar(count(negative),anomaly(negative),'b')%plot negative in blue
hold on
bar(count(positive),anomaly(positive),'r')%plot positive in red
title('avg median')

figure
tot_avg = mean(xpos(:,3));%average median because median seems more representative
avganomaly=xpos(:,3)-repmat(tot_avg,length(xpos),1);%mean - avg_median
negative2 = find(xpos(:,3)-repmat(tot_avg,length(xpos),1)<0);
positive2 = find(xpos(:,3)-repmat(tot_avg,length(xpos),1)>0);
bar(count(negative2),avganomaly(negative2),'b')%plot negative in blue
hold on
bar(count(positive2),avganomaly(positive2),'r')%plot positive in red
title('avg avg')

% plot(anomaly)
% hold on
% line([1 length(xpos)],[0 0],'color','k')
xlabel('count','fontweight','bold'); ylabel('mean_xpos - tot_mean');
title('xpos anomaly','fontweight','bold');
%%%%%%%%%%%%%%%%%%%%%%%%%%
%missed rois
%%%%%%%%%%%%%%%%%%%%%%%%%%
subplot(4,1,4)
plot((xpos(:,2)./xpos(:,1))*100)
set(gca,'ylim',[0 100])
xlabel('count','fontweight','bold'); ylabel('% missed rois','fontweight','bold');
title('percent missed rois','fontweight','bold');

figure %Y POSITION
plot(ypos(:,3),'b.-')%mean
hold on
plot(ypos(:,4),'b--')%median
plot(ypos(:,5),'r--')% 5%
plot(ypos(:,8),'r--')% 95%
plot(ypos(:,6),'g')% 25%
plot(ypos(:,7),'g')% 75%
plot(ypos(:,9),'k')%inter quartile range
set(gca,'ylim',[0 1034])
xlabel('count','fontweight','bold'); ylabel('ypos - pix','fontweight','bold');
title(['Ypos ' savefilename]);
ax = get(gca,'children');
legend([ax(7) ax(6) ax(5) ax(3) ax(1)],'mean','median','95%','25%','intqrt range')

%ypos

%for IFCB1 through IFCB6, adcdata have the following format:
%             xsize = adcdata(:,16);  ysize = adcdata(:,17); startbyte = adcdata(:,18);
%             peakA = adcdata(:,7); peakB = adcdata(:,8); peakc = adcdata(:,9); peakD = adcdata(:,10);
%             xpos = adcdata(:,14); ypos = adcdata(:,15); PMTA = adcdata(:,3); PMTB = adcdata(:,4);
%             GrabtimeStart = adcdata(:,12); GrabtimeEnd = adcdata(:,13);
%
%"OLD" ADC FORMAT - IFCB1-6
        % %adcdata: 1 = nProcessingCount
        %           2 = ADCtime
        %           3 = pmtA int% pmtA low gain
        %           4 = pmtB int%pmtA high gain
        %           5 = ???pmtC low gain
        %           6 = ???pmtC high gain
        %           7 = duration of comparator pulse
        %           8 = GrabtimeStart
        %           9 = GrabtimeEnd
        %           10 = x position
        %           11 = y position
        %           12 = roiSizeX
        %           13 = roiSizeY
        %           14 = StartByte
%"NEW" FORMAT - IFCB7 on, peak values were added (and high/low gain no longer), so adcdata have the following format:
        % %adcdata: 1 = nProcessingCount
        %           2 = ADCtime  ( = same as GrabtimeStart...)
        %           3 = pmtA int (scattering)
        %           4 = pmtB int (fluorescence)
        %           5 = pmtC int
        %           6 = pmtD int
        %           7 = pmtA peak
        %           8 = pmtB peak
        %           9 = pmtC peak
        %           10 = pmtD peak
        %           11 = duration of comparator pulse
        %           12 = GrabtimeStart (= TriggerTickCount - StartTickCount).  TriggerTickCount = tick count when the camera callback occurred
        %                               (when the camera is ready for a new trigger)
        %           13 = GrabtimeEnd   (= GetTickCount() - StartTickCount , just before rearming trigger.
        %           14 = x position
        %           15 = y position
        %           16 = roiSizeX
        %           17 = roiSizeY
        %           18 = StartByte
        
