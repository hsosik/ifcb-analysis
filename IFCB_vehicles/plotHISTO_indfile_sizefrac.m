% Edited from plotHISTOpos
%IS SIZE FRACTIONATION SKEWED? or incorrect in vert vs horz. need same sample
%water for both orientations in order to compare.

%edits T Crockford Dec2014
%org code written M Brosnahan Nov2014 - redmine IFCB_forVehicles Task#3259
%tool to compare horz vs vert ifcb
%make histogram plot over time of x/ypos to see if core moves around
%sort of like heat map, includes missed rois at bottom (pos zero)
%assumes only using "new" IFCB adc file format. Both adc formats are listed

clear all

[file path] = uigetfile('\\sosiknas1\Lab_data\IFCB_forVehicles\IFCB102\TowTest3_26Oct2015\*.adc'); %hanging_in_lab\*.roi'); %ifcb101
figtitle = 'towing'

% file = 'D20151023T191437_IFCB102.adc'; figtitle = 'D20151023T191437 Gui/Dun/Beads HORZ';
%  path = ['\\sosiknas1\Lab_data\IFCB_forVehicles\IFCB102\data\' file(2:5) '\' file(1:9) '\'];
% file = 'D20151023T185218_IFCB102.adc'; figtitle = 'D20151023T185218 Gui/Dun/Beads HORZ';
% file = 'D20151023T180105_IFCB102.adc'; figtitle = 'D20151023T180105 Gui/Dun/Beads VERT';
% file = 'D20151023T161217_IFCB102.adc'; figtitle = 'D20151023T161217 Dun & beads VERT'; %Dun&9um beads in FSW in lab, VERT
% file = 'D20151023T152314_IFCB102.adc'; figtitle = 'D20151023T152314 Dun & beads HORZ'; %Dun&9um beads in FSW in lab, VERT
% file = 'D20151015T181337_IFCB102.adc'; %dock water horz stationary in lab
% file = 'D20151015T181337_IFCB102.adc'; %dock water horz stationary in lab
% file = 'D20151006T192518_IFCB102.adc'; %dock water vert stationary in lab
% file = 'D20151006T195148_IFCB102.adc'; %dock water vert stationary in lab
% file = 'D20151006T200900_IFCB102.adc'; %dock water horz stationary in lab

%IFCB10 - horz - early on exp
% datadir = '\\sosiknas1\Lab_data\IFCB_forVehicles\IFCB10\horizontal_sw\';
% file = 'D20141126T014154_IFCB010.adc'; %dock water horz stationary in lab

%make matdate from filename
temp      = char(file);
temp      = [temp(:,2:9) temp(:,11:16)];
matdate   = datenum(temp,'yyyymmddHHMMSS');
clear temp 

adcdata     = load([path file]);
time        = adcdata(:,2);
xpos        = adcdata(:,14); 
ypos        = adcdata(:,15);
roiwidth    = adcdata(:,16); %xpos length
roiheight    = adcdata(:,17); %ypos length
roiarea     = adcdata(:,16).*adcdata(:,17);
peakB       = adcdata(:,8);


% initialize var for histc POS counts NaN(x,y)
timebins = 10:30:1200;
hypos  = NaN(length(timebins),length(0:8:1023)); %how many files along x-axis, how many ypos bins on y-axis
hxpos  = NaN(length(timebins),length(0:8:1380)); 
hwidth = NaN(length(timebins),length(1:25:1030));
hheight= NaN(length(timebins),length(0:25:1380));
harea  = NaN(length(timebins),length(1:2000:100000));
hpeakB = NaN(length(timebins),length(0:1:4));
tot_bintime  = NaN(length(timebins),1); 
inhibit4bin  = tot_bintime;
looktime4bin = tot_bintime;

for count=1:length(timebins)-1
    maxtime = timebins(count+1);
    mintime = timebins(count);
    hi              = find(time<maxtime & time>mintime); 
if ~isempty(hi)
%figure out concentration??
%amount of time total in bin
    tot_bintime(count) = adcdata(hi(end),13)-adcdata(hi(1),12);
%inhibit time??
    inhibit4bin(count) = sum([adcdata(hi,13)-adcdata(hi,12)]);
    looktime4bin(count) = tot_bintime(count) - inhibit4bin(count);

    
    hypos(count,:)  = histc(ypos(hi),0:8:1023);
    hxpos(count,:)  = histc(xpos(hi),0:8:1380);
    hwidth(count,:) = histc(roiwidth(hi),1:25:1030);
    hheight(count,:)= histc(roiheight(hi),1:25:1380);
    harea(count,:)  = histc(roiarea(hi),1:2000:100000);
    hpeakB(count,:)  = histc(peakB(hi),0:1:4);
end
end



%not all samples are a full 20 min, only plot times of run
isin = find(timebins<=time(end));

figure
pcolor(timebins(isin),1:2000:100000,harea(isin,:)');
shading flat
xlabel('Time During Sample(sec)','fontweight','bold');ylabel('Roi Area = width*height (# pix)','fontweight','bold');title(['Roi Area - ' figtitle]);% ' color max 95%'])
caxis([0 prctile(harea(:),96)]);
colorbar


figure
%for guinardian get rid of small cells to actual see colors of long cell counts
wbins = 1:25:1030;
pcolor(timebins(isin),wbins(5:end),hwidth(isin,5:end)');
xlabel('Time During Sample(sec)','fontweight','bold');ylabel('Roi Width along xpos (# pix)','fontweight','bold');title(['RoiWidth excluding <100pix bins - ' figtitle]);% ' color max 95%'])

figure
pcolor(timebins(isin),1:25:1030,hwidth(isin,:)');
shading flat
xlabel('Time During Sample(sec)','fontweight','bold');ylabel('Roi Width along xpos (# pix)','fontweight','bold');title(['RoiWidth - ' figtitle ' color max 98%'])
caxis([0 prctile(hwidth(:),98)])
colorbar

figure
pcolor(timebins(isin),1:25:1380,hheight(isin,:)');
shading flat
xlabel('Time During Sample(sec)','fontweight','bold');ylabel('Roi Height along ypos (# pix)','fontweight','bold');title(['RoiHeight - ' figtitle]);% ' color max 95%'])
colorbar

figure
% pcolor(timebins(isin),0:1:4,hpeakB(isin,:)')
pcolor(timebins(isin),1:1:4,hpeakB(isin,2:end)'); %only look at beads, not Dun
xlabel('Time During Sample(sec)','fontweight','bold');ylabel('Peak B','fontweight','bold');title(['Peak B - ' figtitle]);% ' color max 95%'])
caxis([0 prctile(hpeakB(:),95)]) %set colorbar range - without max concentrations get washed out


%plot histo with time on x-axis
% figure('position',[204 147 1293 905]) 
% subplot(2,1,1);
% pcolor(unq_matdate,[0:8:1023],hypos');
% shading flat
% caxis([0 prctile(hypos(:),95)]) %set colorbar range - without max concentrations get washed out
% datetick('x','mm/dd HH:MM','keepticks')
% xlabel('Time','fontweight','bold');ylabel('ypos','fontweight','bold');title(['YPOS - ' savefilename ' color max 95%'])
% colorbar

%plot histo with time on x-axis
% figure; 
% subplot(2,1,2)
% pcolor(unq_matdate,[0:8:1380],hxpos');
% shading flat
% caxis([0 prctile(hxpos(:),95)]) %set colorbar range - without max concentrations get washed out
% datetick('x','mm/dd HH:MM','keepticks')
% xlabel('Time','fontweight','bold');ylabel('xpos','fontweight','bold');title(['XPOS - ' savefilename ' color max 95%'])
% colorbar

%not done.
% % initialize var for histc area and size counts
% harea = NaN(length(unq_matdate),length(0:8:1023)); 
% % hyarea = NaN(length(unq_matdate),length(0:8:1023)); 
% % hxarea = NaN(length(unq_matdate),length(0:8:1380)); 
% for count=1:length(unq_matdate)
%     hi              = find(mattime==unq_matdate(count)); 
%     harea(count,:)  = histc(roisizeY(hi),[0:8:1023]);
% %     hyarea(count,:)  = histc(roisizeY(hi),[0:8:1023]);
% %     hxarea(count,:)  = histc(roisizeX(hi),[0:8:1380]);
% end
% 
% %plot histo with time on x-axis
% figure; pcolor(unq_matdate,[0:8:1380],hxarea');
% caxis([0 prctile(hxarea(:),95)]) %set colorbar range - without max concentrations get washed out
% datetick('x','mm/dd HH:MM','keepticks')
% xlabel('Time','fontweight','bold');ylabel('xpos','fontweight','bold');title(['XPOS - ' savefilename ' color max 95%'])
% colorbar
% 

