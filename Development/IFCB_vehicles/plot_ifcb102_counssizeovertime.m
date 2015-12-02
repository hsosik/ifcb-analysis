%plot frames per sec over course of one file (20min sample)
%plot mean area of rois for given bins of time over course of one file (20min sample)
%T Crockford Dec2014

%%%%%%%%%%%%%%%%%%%%%%%%
%NEED TO ADJUST FOLLOWING 2 SCRIPTS AS NEW EXPS ADDED OR FILE LOCS CHAGNE
%%%%%%%%%%%%%%%%%%%%%%%%
%make_pathfile2load.m - prompts question of what you'd like to plot 
%set path to data, start & end file, name for saved mat file
%
%mat_expdir.m - fxn to find corresponding matching exp of horz vs vert,
%basicaly reverse switch statement of make_pathfiles2load.m
%%%%%%%%%%%%%%%%%%%%%%%%
% make_pathfiles2load
% clear startfile endfile

%hand pick specific file from dir chosen by make_pathfiles2load.m above
% HORZ###################################################

%#1 - not that good a compare, horz not many beads
filename = 'D20151105T210041_IFCB102.adc';
dirpath = '\\sosiknas1\Lab_data\IFCB_forVehicles\IFCB102\';
% filename = 'D20150316T154344_IFCB102.adc'; 
% dirpath = '\\sosiknas1\Lab_data\IFCB_forVehicles\IFCB102\data\2015\D20150316\';
celltype = '9um beads';
savefilename = 'Horz5mL';

% #2

% [filename,dirpath] = uigetfile([dirpath '*.adc']);
% a = dir([dirpath filename]);
% filetime = a.datenum;
% clear a
adcdata = load([dirpath filename]);

%VERT#####################################################
%#2
matchfile = 'D20151105T202915_IFCB102.adc';
path2 = '\\sosiknas1\Lab_data\IFCB_forVehicles\IFCB102\';
% matchfile = 'D20150316T152435_IFCB102.adc'; %beads vert in lab
% path2 = '\\sosiknas1\Lab_data\IFCB_forVehicles\IFCB102\data\2015\D20150316\';
savefilename2 = 'VertBeads5mL';
% [path2, savefilename2] = match_expdir(answer);
% allfiles = dir([path2 '*.adc']);
% alltimes = [allfiles.datenum];
% abstimediff = abs(alltimes - filetime);
% matchfile = allfiles(abstimediff==min(abstimediff)).name;
adcdata2 = load([path2 matchfile]);

sprintf('%s \n %s \n %s \n \n %s','Files chosen to compare:', [dirpath filename], [path2 matchfile], 'Press enter to continue')
pause
%only look at triiger with rois i.e.)triggers with roisizeX (length) greater than zero
%parse down adcdata matrix to get ride of zerosize rois
% ind1 = find(adcdata(:,16)>0);
% zerorois1 = length(ind1);
% adcdata = adcdata(ind1,:);
% ind2 = find(adcdata2(:,16)>0);
% zerorois2 = length(ind2);
% adcdata2 = adcdata2(ind2,:);
% clear ind*

bin_steps = 0:30:1200;%adctime? 10 sec?
[n1,bin1] = histc(adcdata(:,2),bin_steps);
[n2,bin2] = histc(adcdata2(:,2),bin_steps);
% avgs1 = nan(length(bin_steps),2);
% avgs2 = avgs1;
avglength1 = nan(length(bin_steps),1);
avglength2 = avglength1;
avgarea1   = avglength1;
avgarea2   = avglength1;
numtrig1 = avgarea2;
zeroroi1 = avgarea2;
numrois1 = avgarea2;
trigcounts = nan(length(bin_steps),6);
header_trigcounts = {'numtrig1','zerorois1','numrois1','numtrig2','zerorois2','numrois2'};
for count = 1:length(bin_steps)
%     avgs1(count,:) = [mean(adcdata(bin==count,16)) mean(adcdata(bin==count,16).*adcdata(bin==count,17)) ];
%     avgs2(count,:) = [mean(adcdata2(bin2==count,16)) mean(adcdata2(bin2==count,16).*adcdata2(bin2==count,17)) ];
%     numtrig1(count)     = length(find(bin1==count));
%     zeroroi1(count)     = length(find(adcdata(bin1==count,16)==0));
%     numrois1(count)     = numtrig1(count) - zeroroi1(count);
%     numtrig2(count)     = length(find(bin2==count));
%     zeroroi2(count)     = length(find(adcdata2(bin2==count,16)==0));
%     numrois2(count)     = numtrig2(count) - zeroroi2(count);
    trigcounts(count,:) = [length(find(bin1==count)) length(find(adcdata(bin1==count,16)==0)) (length(find(bin1==count))-length(find(adcdata(bin1==count,16)==0)))  length(find(bin2==count)) length(find(adcdata2(bin2==count,16)==0)) (length(find(bin2==count))-length(find(adcdata2(bin2==count,16)==0)))];
    avglength1(count)   = mean(adcdata(adcdata(bin1==count,16)~=0,16));
    avglength2(count)   = mean(adcdata2(adcdata2(bin2==count,16)~=0,16));
    avgarea1(count)     = mean(adcdata(adcdata(bin1==count,16)~=0,16).*adcdata(adcdata(bin1==count,16)~=0,17));
    avgarea2(count)     = mean(adcdata2(adcdata2(bin2==count,16)~=0,16).*adcdata2(adcdata2(bin2==count,16)~=0,17));
end
% roilength = adcdata(:,16);
% roiarea = adcdata(:,16).*adcdata(:,17); %roiSizeX*roiSizeY
% pmtClow = adcdata(:,9);
% pmtChi  = adcdata(:,10);
figure
subplot(3,1,1)
plot(trigcounts(:,3),'b')
hold on
plot(trigcounts(:,2),'b.:')
plot(trigcounts(:,6),'r')
plot(trigcounts(:,5),'r.:')
set(gca,'xlim',[0 120])
xlabel(['time bin (' num2str(bin_steps(2)) 'sec)'],'fontweight','bold'); ylabel('Count of triggers');
title('Rois Counts & ZeroRoi Counts in a single file over full run time','fontweight','bold');
legend(['RoiCount ' savefilename], ['ZeroRois ' savefilename], ['RoiCount ' savefilename2], ['ZeroRois ' savefilename2]);
subplot(3,1,2)
plot(avglength1,'b')%#triggers binned per 10 sec
hold on
plot(avglength2,'r')%#triggers binned per 10 sec
set(gca,'xlim',[0 120])
xlabel(['time bin (' num2str(bin_steps(2)) 'sec)'],'fontweight','bold'); ylabel('Length=roisizeX (pix)','fontweight','bold');
title(['Avg Length - ' celltype])
legend(savefilename, savefilename2)
subplot(3,1,3)
plot(avgarea1,'b')
hold on
plot(avgarea2,'r')
set(gca,'xlim',[0 120])
xlabel(['time bin (' num2str(bin_steps(2)) 'sec)'],'fontweight','bold'); ylabel('Area=roisizeX*roisizeY (pix)','fontweight','bold');
title(['Avg Area - ' celltype])

%{
%not really helpful
figure
subplot(2,1,1)
plot(avglength1,avglength2,'.')
xlabel(savefilename); ylabel(savefilename2);
title('Avg Length- Vert vs Horz')
subplot(2,1,2)
plot(avgarea1,avgarea2,'.')
xlabel(savefilename); ylabel(savefilename2);
title('Avg Area - Vert vs Horz')
%}
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
        
