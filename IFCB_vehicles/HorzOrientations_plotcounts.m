
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%     FRESHER WATER 9um beads   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%    IFCB102 out of can on lab bench   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all

datadir = '\\sosiknas1\Lab_data\IFCB_forVehicles\IFCB102\';

files = {'D20150304T201610_IFCB102-beads normal salt pump2'; %1 - normal Pump2
        'D20150304T203939_IFCB102-beads saltier pump2'; %2 - saltier Pump2
        'D20150304T210650_IFCB102-beads fresher pump2'; %3 - fresher Pump2
        'D20150305T214337_IFCB102-Dun in FSW pump2'; %4 - Dun in regular FSW Pump2
        'D20150306T175156_IFCB102-Dun in FSW pump1'; %5 - Dun in regular FSW next day Pump1
        'D20150306T195236_IFCB102-Dun in FSW with USD start of run'; %6 - Dun reg FSW Pump1 USD run
        'D20150309T193823_IFCB102-beads run on Mon after made Fri capped over wknd'; %7 - beads reg FSW Pump1 soln made fri, it's monday was capped over wknd
        'D20150309T195955_IFCB102-Dun FSW pump1 soln made fri, capped over wknd'; %8 - Dun reg FSW Pump1  soln made fri, it's monday was capped over wknd
        'D20150311T205816_IFCB102-beads p1 after wire/spring around focus objective'; %9 - 
        'D20150311T212847_IFCB102-out of focus spots on flow cell test if objective still moving';%10
        'D20150311T214230_IFCB102-fresh Dun after wire/spring around focus objective';%11
        'D20150312T144251_IFCB102-Dun from yesterday exact same as above file D20150311T2114230';%12
        'D20150312T151304_IFCB102-beads from yesterday exact orientation&counts as above file D20150311T2114230';%13
        'D20150312T153336_IFCB102-beads/Dun mix from last week exact orientation&counts as above file D20150311T2114230';%14
        'D20150313T172345_IFCB102-Gui Emilys culture';%15 culture in F/2
        'D20150313T192601_IFCB102-concentrated new dock water';%16
        'D20150313T201439_IFCB102-beads IN CAN';%17
        'D20150327T160231_IFCB102-beads miliQ filters out of can';%18
        'D20150327T173745_IFCB102-beads miliQ after lunch out of can';%19
        'D20150327T201435_IFCB102-beads miliQ filt end of day out of can'};%20
for n=1:length(files),fprintf('%2d    %s\n',n,char(files(n))),end
fprintf('\n')
fileno = input('Pick the file to plot by entering the corresponding number in the filelist above:');
tempfile = char(files(fileno));
ind = strfind(tempfile,'-');
filename = tempfile(1:ind-1);
adcdata = load([datadir filename '.adc']);
clear ind tempfile
rolling = [];
updown = [];
%{
%block gray in figure when holding still between movement tests - file specific
% still_points = [1 230; 231 450; 650 850; 851 1000; 1200 1400; 1401 1875; 1876 2200; 2450 2650; 2850 3050; 3250 3700; 3701 3900; 4120 4320]; %file specific!!!
xlines = [1 200 330 726 1167 1300 1414 1873 2000 2380 2420];
for coun1 = 
figure
% subplot(3,1,1)%xpos
hold on

%syringe down  330-730
color = [0.8 0.45 0.8 ]; %light pink
area([adcdata(adcdata(:,1)==330,2) adcdata(adcdata(:,1)==730,2)], [1380 1380],'facecolor',color,'linestyle','none');
text(340,100,'Syringe D','fontweight','bold')
%strobe down   730 - 1300
color = [0.4 0.9 0.4]; %light green
area([adcdata(adcdata(:,1)==730,2) adcdata(adcdata(:,1)==1300,2)], [1380 1380],'facecolor',color,'linestyle','none');
text(740,100,'Strobe D','fontweight','bold')
%laser down    1414-2000
color = [1 0.2 0.2]; %light red
area([adcdata(adcdata(:,1)==1414,2) adcdata(adcdata(:,1)==2000,2)], [1380 1380],'facecolor',color,'linestyle','none');
text(1425,100,'Laser D','fontweight','bold')
%camera down   2000-2380
color = [0.2 0.7 0.7]; %lihgt blue
area([adcdata(adcdata(:,1)==2000,2) adcdata(adcdata(:,1)==2380,2)], [1380 1380],'facecolor',color,'linestyle','none');
text(2010,100,'Cam D','fontweight','bold')

for count = 1:length(xlines)
    line([adcdata(adcdata(:,1)==xlines(count),2) adcdata(adcdata(:,1)==xlines(count),2)],[0 1380],'color','k')
end
plot(adcdata(:,2),adcdata(:,14),'.') %plot xpos over time

segments = [1 300; 330 730; 731 1300; 1414 2000; 2420 length(adcdata(:,1))];
missedrois = [];
for count = 1:length(segments)
    missedrois = [missedrois; length(find(adcdata(segments(count,1):segments(count,2),16)==0))];
    text(adcdata(adcdata(:,1)==segments(count,1),2), 1350,['bad=' num2str(missedrois(end))],'color','k','fontweight','bold','fontsize',12)
end
%}

switch fileno
    case 1
        titlename = 'NORMAL FSW beads (32.5 o/oo) IFCB102 out of can on lab bench  -  ';
        xlines = [1 100 200 350 600 670 1000 1100 1400 1770 2300 2700 3200 3600]; %any noted change during file, not always change in orientaiton
        segments = [350 670; 700 1050; 1100 1700; 1770 2250; 2300 2750; 2750 3250; 3200 3650; 3650 adcdata(end,1)]; %to calculate # missed rois within each orientation
        syrdownarea = [700 1050; 2300 2750];
        strdownarea = [350 670; 2750 3200];
        lasdownarea = [1100 1700; 3200 3650];
        camdownarea = [1770 2250; 3650 adcdata(end,1)];
        legendname = {'Syr D','Str D', 'Las D','Cam D'};
        rolling = [2300 2700 3200];
    case 2
        titlename = 'SALTIER beads (39 o/oo) IFCB102 out of can on lab bench  -  ';
        xlines = [1 300 460 615 630 949 1200 1380 1700]; %any noted change during file, not always change in orientaiton
        segments = [1 300; 460 615; 630 1200; 1380 adcdata(end,1)]; %to calculate # missed rois within each orientation
        syrdownarea = [460 615];
        strdownarea = [630 1200];
        lasdownarea = [1380 adcdata(end,1)];
        camdownarea = [1 1]; %did not do cam down for this run, need 1's to avoid crashing script, does not make any colored area
        legendname = {'Syr D','Str D', 'Las D'};
    case 3
        titlename = 'FRESHER beads (26 o/oo) IFCB102 out of can on lab bench  -  ';
        xlines = [1 200 330 726 1167 1300 1414 1873 2000 2380 2420]; %any noted change during file, not always change in orientaiton
        segments = [1 300; 330 730; 731 1300; 1414 2000; 2420 length(adcdata(:,1))]; %to calculate # missed rois within each orientation
        syrdownarea = [330 730];
        strdownarea = [730 1300];
        lasdownarea = [1414 2000];
        camdownarea = [2010 2380];
        legendname = {'Syr D','Str D', 'Las D','Cam D'};
    case {4, 8}
        titlename = 'DUN in fresh FSW Pump2 IFCB102 out of can on lab bench  -  ';
        xlines = [1 400 800 1200 1600 2000 2400 2800 3200 3600 4000 4400]; %any noted change during file, not always change in orientaiton
        segments = [1 400; 400 800; 800 1200; 1200 1600; 1600 2000; 2000 2400; 2400 2800; 2800 3200; 3200 3600; 3600 4000; 4000 4400; 4400 adcdata(end,1)]; %to calculate # missed rois within each orientation
        syrdownarea = [400 800; 3200 4000];
        strdownarea = [1600 2400; 4000 4400];
        lasdownarea = [1200 1600; 2400 2800];
        camdownarea = [800 1200; 2800 3200];
        legendname = {'Syr D','Str D', 'Las D','Cam D'};
        rolling = [2000 2400 2800 3200];
        updown = [3600 4000];
    case 5
        titlename = 'DUN in fresh FSW Pump1 IFCB102 out of can on lab bench  -  ';
        xlines = [1 400 800 1200 1600 2000 2400 2800 3200 3600 4000 4400]; %any noted change during file, not always change in orientaiton
        segments = [1 400; 400 800; 800 1200; 1200 1600; 1600 2000; 2000 2400; 2400 2800; 2800 3200; 3200 3600; 3600 4000; 4000 4400; 4400 adcdata(end,1)]; %to calculate # missed rois within each orientation
        syrdownarea = [400 800; 3200 4000];
        strdownarea = [1600 2400; 4000 4400];
        lasdownarea = [1200 1600; 2400 2800];
        camdownarea = [800 1200; 2800 3200];
        legendname = {'Syr D','Str D', 'Las D','Cam D'};
        rolling = [2000 2400 2800 3200];
        updown = [3600 4000];
    case 10
        titlename = 'focus channel wall after adding spring IFCB102 out of can on lab bench  -  ';
        xlines = [1 75 150 225 350 425 500 575 650]; %any noted change during file, not always change in orientaiton
        segments = [1 75; 75 150; 150 225; 225 350; 350 425; 425 500; 500 575; 575 650; 650 adcdata(end,1)]; %to calculate # missed rois within each orientation
        syrdownarea = [150 225; 425 500];
        strdownarea = [75 150; 500 575];
        lasdownarea = [1 75; 575 650];
        camdownarea = [225 350; 350 425];
        legendname = {'Syr D','Str D', 'Las D','Cam D'};
        rolling = [350 425 500 575];
        updown = []; 
    case {11, 12}
        titlename = 'DUN in FSW Pump1 IFCB102 out of can on lab bench  -  ';
        xlines = [1 300 600 900 1200 1500 1800 2100 2400 2700]; %any noted change during file, not always change in orientaiton
        segments = [1 300; 300 600; 600 900; 900 1200; 1200 1500; 1500 1800; 1800 2100; 2100 2400; 2400 2700; 2700 adcdata(end,1)]; %to calculate # missed rois within each orientation
        syrdownarea = [600 900; 2100 2400];
        strdownarea = [300 600; 2400 2700];
        lasdownarea = [1200 1500; 1500 1800];
        camdownarea = [900 1200; 1800 2100];
        legendname = {'Las Up','Cam Up', 'Las D','Cam D'};
        rolling = [1500 1800 2100 2400];
        updown = [];
    case {13, 14, 15}
        if fileno==15
            titlename = 'Gui culture in F/2 P1 IFCB102 out of can in lab - ';
        else titlename = 'yest old BEADS in FSW Pump1 IFCB102 out of can on lab bench  -  ';
        end
        xlines = [1 300 600 900 1200 1500 1800 2100 2400 2700]; %any noted change during file, not always change in orientaiton
        segments = [1 300; 300 600; 600 900; 900 1200; 1200 1500; 1500 1800; 1800 2100; 2100 2400; 2400 2700; 2700 adcdata(end,1)]; %to calculate # missed rois within each orientation
        syrdownarea = [600 900; 2100 2400];
        strdownarea = [300 600; 2400 2700];
        lasdownarea = [1200 1500; 1500 1800];
        camdownarea = [900 1200; 1800 2100];
        legendname = {'Las Up','Cam Up', 'Las D','Cam D'};
        rolling = [1500 1800 2100 2400];
        updown = [];
    case 16
        titlename = 'Dock Water new Pump1 IFCB102 out of can on lab bench  -  ';
        xlines = [1 210 420 620 850 1050 1250 1450 1650 1850]; %any noted change during file, not always change in orientaiton
        segments = [1 210; 210 420; 420 620; 620 850; 850 1050; 1050 1250; 1250 1450; 1450 1650; 1650 1850; 1850 adcdata(end,1)]; %to calculate # missed rois within each orientation
        syrdownarea = [420 620; 1450 1650];
        strdownarea = [210 420; 1650 1850];
        lasdownarea = [850 1050; 1050 1250];
        camdownarea = [620 850; 1250 1450];
        legendname = {'Las Up','Cam Up', 'Las D','Cam D'};
        rolling = [1050 1250 1450 1650];
        updown = [];
    case 17
        titlename = 'beads FSW Pump1 IFCB102 IN CAN in lab  -  ';
        xlines = [1 300 412 600 900 1200 1500 1800 2100 2400 2700]; %any noted change during file, not always change in orientaiton
        segments = [1 300; 300 412; 412 600; 600 900; 900 1200; 1200 1500; 1500 1800; 1800 2100; 2100 2400; 2400 2700; 2700 adcdata(end,1)]; %to calculate # missed rois within each orientation
        syrdownarea = [600 900; 2100 2400];
        strdownarea = [412 600; 2400 2700];
        lasdownarea = [1200 1500; 1500 1800];
        camdownarea = [900 1200; 1800 2100];
        legendname = {'Las Up','Cam Up', 'Las D','Cam D'};
        rolling = [1500 1800 2100 2400];
        updown = [];
    case 18
        titlename = 'miliQ filters beads Qwater Pump1 IFCB102 on lab bench -  ';
        xlines = [1 250 600 950 1350 1730 2150 2700 3250 3800]; %any noted change during file, not always change in orientaiton
        segments = [1 250; 250 600; 600 950; 950 1350; 1350 1730; 1730 2150; 2150 2700; 2700 3250; 3250 3800; 3800 adcdata(end,1)]; %to calculate # missed rois within each orientation
        syrdownarea = [1350 1730; 1730 2150];
        strdownarea = [250 600; 3250 3800];
        lasdownarea = [600 950; 2700 3250];
        camdownarea = [950 1350; 2150 2700];
        legendname = {'Las Up','Cam Up', 'Las D','Cam D'};
        rolling = [1730 2150 2700 3250];
        updown = [];
    case 19
        titlename = 'miliQ filters beads Qwater Pump1 IFCB102 on lab bench -  ';
        xlines = [1 275 600 950 1300 1650 2100 2500 3100 3600]; %any noted change during file, not always change in orientaiton
        segments = [1 275; 275 600; 600 950; 950 1300; 1300 1650; 1650 2100; 2100 2500; 2500 3100; 3100 3600; 3600 adcdata(end,1)]; %to calculate # missed rois within each orientation
        syrdownarea = [600 950; 2500 3100];
        strdownarea = [275 600; 3100 3600];
        lasdownarea = [1300 1650; 1650 2100];
        camdownarea = [950 1300; 2100 2500];
        legendname = {'Las Up','Cam Up', 'Las D','Cam D'};
        rolling = [1650 2100 2500 3100];
        updown = [];
    case 20
        titlename = 'miliQ filters beads Qwater Pump1 IFCB102 on lab bench -  ';
        xlines = [1 250 650 1000 1350 1750 2050 2450 2950 3250]; %any noted change during file, not always change in orientaiton
        segments = [1 250; 250 650; 650 1000; 1000 1350; 1350 1750; 1750 2050; 2050 2450; 2450 2950; 2950 3250; 3250 adcdata(end,1)]; %to calculate # missed rois within each orientation
        syrdownarea = [650 1000; 2450 2950];
        strdownarea = [250 650; 2950 3250];
        lasdownarea = [1350 1750; 1750 2050];
        camdownarea = [1000 1350; 2050 2450];
        legendname = {'Las Up','Cam Up', 'Las D','Cam D'};
        rolling = [1750 2050 2450 2950];
        updown = [];
end

        

for count1 = 1:2
figure
switch count1
    case 1
        ymax = 1380;
        ytext = 1350;
        points = 14;
        labelname = 'xpos';
    case 2
        ymax = 1050;
        ytext = 1350;
        points = 15;
        labelname = 'ypos';
end
% subplot(3,1,1)%xpos
hold on

%syringe down  330-730
color = [0.8 0.45 0.8 ]; %light pink
area(syrdownarea(1,:), [1380 1380],'facecolor',color,'linestyle','none');
text(syrdownarea(1,1),100,'Laser Up','fontweight','bold')
%strobe down   730 - 1300
color = [0.4 0.9 0.4]; %light green
area(strdownarea(1,:), [1380 1380],'facecolor',color,'linestyle','none');
text(strdownarea(1,1),100,'Cam Up','fontweight','bold')
%laser down    1414-2000
color = [1 0.2 0.2]; %light red
area(lasdownarea(1,:), [1380 1380],'facecolor',color,'linestyle','none');
text(lasdownarea(1,1),100,'Laser D','fontweight','bold')
%camera down   2000-2380
color = [0.2 0.7 0.7]; %lihgt blue
area(camdownarea(1,:), [1380 1380],'facecolor',color,'linestyle','none');
text(camdownarea(1,1),100,'Cam D','fontweight','bold')
legend(legendname)
if fileno==1 || fileno==4 || fileno==5 || fileno>=11 
    color = [0.8 0.45 0.8 ]; %light pink
    area(syrdownarea(2,:), [1380 1380],'facecolor',color,'linestyle','none');
    color = [0.4 0.9 0.4]; %light green
    area(strdownarea(2,:), [1380 1380],'facecolor',color,'linestyle','none');
    color = [1 0.2 0.2]; %light red
    area(lasdownarea(2,:), [1380 1380],'facecolor',color,'linestyle','none');
    color = [0.2 0.7 0.7]; %lihgt blue
    area(camdownarea(2,:), [1380 1380],'facecolor',color,'linestyle','none');
end

for count = 1:length(xlines)
    line([xlines(count) xlines(count)],[0 1380],'color','k')
end
plot(adcdata(:,1),adcdata(:,points),'b.') %plot pos over time
axis([0 adcdata(end,1) 0 ymax])
xlabel('count','fontweight','bold'); ylabel(labelname,'fontweight','bold');
title([titlename filename],'fontweight','bold')

missedrois = [];
for count = 1:length(segments)
    missedrois = [missedrois; length(find(adcdata(find(adcdata(:,1)==segments(count,1)):find(adcdata(:,1)==segments(count,2)),16)==0))];
    text(segments(count,1), ytext,['bad=' num2str(missedrois(end))],'color','k','fontweight','bold','fontsize',12)
end
if ~isempty(rolling)
    for count = 1:length(rolling)
        text(min(adcdata(adcdata(:,1)==rolling(count),1)),50,'Rolling','color','k','fontweight','bold')
    end
end
if ~isempty(updown)
    for count = 1:length(updown)
        text(min(adcdata(adcdata(:,1)==updown(count),1)),50,'Up/Down','color','k','fontweight','bold')
    end
end
end




