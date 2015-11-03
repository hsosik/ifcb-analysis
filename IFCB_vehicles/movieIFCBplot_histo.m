%assumes only using "new" IFCB adc file format. Both adc formats are listed
%below
%to analyze/compare vertically stanging IFCB vs horizontally laying
%mostly look at core position over time. also missed roi rate, beads
%signal,
%see movies of xpos vs ypos, and long cells position

%NOT GOING TO WORK TO SELECT MULTIPLE FILES ON INSTR, NOT ORG INTO DIRs
%data on instrument IP
% path = '\\128.128.108.51\data\'; %ifcb10 IP on instr
% path = '\\128.128.108.82\data\beads\'; %ifcb10 beads

%IFCB 101
path = '\\128.128.110.139\data\'; %IFCB101 IP instr
% path = '\\128.128.110.139\data\beads\'; %IFCB101 beads

startfile = 'D20141121T043217_IFCB101';
startday  = str2num([startfile(2:9) startfile(11:16)]);
endfile   = 'D20141125T191323_IFCB101';
endday    = str2num([endfile(2:9) endfile(11:16)]);

allfiles  = dir([path 'D2014*.adc']);
allfiles  = {allfiles.name}';
temp      = char(allfiles);
temp      = [temp(:,2:9) temp(:,11:16)];
temp      = str2num(temp);
files     = allfiles(temp>startday & temp<endday); %find all files between start and end date/time

clear temp ind allfiles startfile endfile

%only need 1 for loop when all files located in 1 dir next for loop set for
%when data roganized by dir days
for count = 1:length(files);
    adcdata = load([path char(files(count))]);
    xpos = adcdata(:,14);
    ypos = adcdata(:,15);
%     isroi = xpos>0;
%     end_y = max(ypos(isroi));
%     start_y = unique(min(ypos(isroi)'));
    end_y = max(ypos);
    start_y = unique(min(ypos));
    bins_y = linspace(start_y,end_y,256);
%     histo_y = hist([start_y; end_y; ypos(isroi)],bins_y);
    histo_y = hist([start_y; end_y; ypos],bins_y);
    plot(bins_y,histo_y,'.-')
    
    
    plot(adcdata(:,14), adcdata(:,15), 'r.') %xpos/ypos column location in new file format
    
        subplot(121)
        endch = max(A2plot(isin));
        startch = unique(min(A2plot(isin)'));
%         if linearplot == 1,
            binsA = linspace(startch, endch, 256);
%         else
%             binsA = logspace(startch, endch, 256);
%         end
        histChA = hist([startch; endch; A2plot(isin)], binsA); 
        histChA_raw = histChA;  %save original 
        plot(binsA, histChA_raw,'.-');
        histChA = fastsmooth(histChA,3);
        hold on
        plot(binsA, histChA, 'linewidth', 2)

    
    
    axis([0 1381 0 1000])
    title(files(count));
    pause(.3);
end

%{
for i = 1:length(files);
adc_location = char(strcat('\\demi\vol1\', dirlist(i), '\'));
adclist = dir(strcat(adc_location, '*.adc')); 
adclist = {adclist(:).name}';
    for j = 1:length(adclist);
        adcdata = load(strcat(adc_location,  char(adclist(j))));
        plot(adcdata(:,10), adcdata(:,11), 'r.')
        axis([0 1381 0 1000])
        title(adclist(j));
        pause(.3);
    end
end
%}

%for IFCB1 through IFCB6, adcdata have the following format:
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
        %for IFCB7 on, peak values were added (and high/low gain no longer), so adcdata have the following format:
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
        
