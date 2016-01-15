%assumes only using "new" IFCB adc file format. Both adc formats are listed
%below
%to see movies of xpos vs ypos over time, could help determine if flow is
%getting bad

startday = 1203;
endday   = 1204;
year = '2015';
days2look = startday:endday;

allfiles = [];
path = ['\\sosiknas1\IFCB_data\IFCB102_Dock_Horiz_Nov15\data\' year '\'];
% path = ['\\sosiknas1\Lab_data\IFCB_forVehicles\IFCB102\data\' year '\'];
for count = 1:length(days2look)
    datadir  = [path 'D' year num2str(days2look(count)) '\'];
    files = dir([datadir 'D*.adc']);
if ~isempty(files)
    allfiles = [allfiles; cellstr([repmat(datadir ,length(files),1) char(files.name)])];
end
end
clear files

figure
for count = 1:length(allfiles);
    adcdata = load(cell2mat(allfiles(count)));
    plot(adcdata(:,14), adcdata(:,15), 'r.') %xpos/ypos column location in new file format
    axis([0 1381 0 1034]) %exact size of camera FOV
    temp=char(allfiles(count));
    title(temp(55:end-4));
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
        
