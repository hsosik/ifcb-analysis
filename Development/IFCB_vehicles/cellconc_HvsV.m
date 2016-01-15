% Taylor 28Oct2015
%calculate cellsperml of size freactions or classifications or whatever of
%each sample. For comparing Horz vs Vert runnign in vehicle project. Is horz
%running getting correct communicaty composition or is it missing?


clear all

% dirpath = '\\sosiknas1\Lab_data\IFCB_forVehicles\IFCB102\data\2015\D20151023\';
% files = {'D20151023T191437_IFCB102'};        figtitle = {'D20151023T191437 Gui/Dun/Beads HORZ'};
% files = [files; 'D20151023T185218_IFCB102']; figtitle = [figtitle; 'D20151023T185218 Gui/Dun/Beads HORZ'];
% files = [files; 'D20151023T180105_IFCB102']; figtitle = [figtitle; 'D20151023T180105 Gui/Dun/Beads VERT'];
% files = [files; 'D20151023T161217_IFCB102']; figtitle = [figtitle; 'D20151023T161217 Dun & beads VERT']; %Dun&9um beads in FSW in lab, VERT
% files = [files; 'D20151023T152314_IFCB102']; figtitle = [figtitle; 'D20151023T152314 Dun & beads HORZ']; %Dun&9um beads in FSW in lab, VERT

%beads exp of horz vs vert do you get same concentrations? if not, if you
%run less volume when horz do you get same cellconc as vertcal? maybe just
%need to run samples more frequently as less volume?
dirpath = '\\sosiknas1\Lab_data\IFCB_forVehicles\IFCB102\';
% dirpath = '\\sosiknas1\IFCB_data\IFCB102_Dock_Horiz_Nov15\data\2015\D20151203\';
%following files not great because didn't debubble between samples so exp is useless
%DO NOT USE, EXP NOT DONE CORRECTLY
%{
files = {'D20151029T193910'};           figtitle = {'5mL Vert'};            volfilt = 5;             isvert = 1;
files = [files; 'D20151029T200203'];    figtitle = [figtitle; '5mL Vert'];volfilt = [volfilt; 5];  isvert = [isvert; 1];
files = [files; 'D20151029T202442'];    figtitle = [figtitle; '2mL Horz'];volfilt = [volfilt; 2];  isvert = [isvert; 1];
files = [files; 'D20151029T203651'];    figtitle = [figtitle; '5mL Horz'];volfilt = [volfilt; 5];  isvert = [isvert; 0];
files = [files; 'D20151029T210223'];    figtitle = [figtitle; '4mL Horz'];volfilt = [volfilt; 4];  isvert = [isvert; 0];
files = [files; 'D20151029T213311'];    figtitle = [figtitle; '3mL Horz'];volfilt = [volfilt; 3];  isvert = [isvert; 0];
files = [files; 'D20151029T214652'];    figtitle = [figtitle; '2mL Horz'];volfilt = [volfilt; 2];  isvert = [isvert; 0];
files = [files; 'D20151029T215618'];    figtitle = [figtitle; '1mL Horz'];volfilt = [volfilt; 1];  isvert = [isvert; 0];
files = [files; 'D20151029T220128'];    figtitle = [figtitle; '1mL Horz'];volfilt = [volfilt; 1];  isvert = [isvert; 0];
files = [files; 'D20151029T220740'];    figtitle = [figtitle; '2mL Horz'];volfilt = [volfilt; 2];  isvert = [isvert; 0];
files = [files; 'D20151029T221754'];    figtitle = [figtitle; '3mL Horz'];volfilt = [volfilt; 3];  isvert = [isvert; 0];
files = [files; 'D20151029T223228'];    figtitle = [figtitle; '2mL Vert - immediate after Horz'];  volfilt = [volfilt; 2];  isvert = [isvert; 1];
files = [files; 'D20151029T225342'];    figtitle = [figtitle; '5mL Vert'];volfilt = [volfilt; 5];  isvert = [isvert; 1];
files = [files; 'D20151029T231617'];    figtitle = [figtitle; '1mL Vert'];volfilt = [volfilt; 1];  isvert = [isvert; 1];
files = [files; 'D20151029T232145'];    figtitle = [figtitle; '5mL Vert'];volfilt = [volfilt; 5];  isvert = [isvert; 1];
% file = 'D20151015T181337_IFCB102.adc'; %dock water horz stationary in lab
% file = 'D20151015T181337_IFCB102.adc'; %dock water horz stationary in lab
% file = 'D20151006T192518_IFCB102.adc'; %dock water vert stationary in lab
% file = 'D20151006T195148_IFCB102.adc'; %dock water vert stationary in lab
% file = 'D20151006T200900_IFCB102.adc'; %dock water horz stationary in lab
%}

%BEADS 9um
% first round of clean beads 5ml runs vert to horz to vert, same vol, same clean soln
%{
figtitle = {'9um beads first run'};
files = {'D20151104T171015'};     volfilt = 5;  isvert = 1;
files = [files; 'D20151104T173233'];    volfilt = [volfilt; 5];  isvert = [isvert; 1];
files = [files; 'D20151104T175453'];    volfilt = [volfilt; 5];  isvert = [isvert; 1];
files = [files; 'D20151104T182649'];    volfilt = [volfilt; 5];  isvert = [isvert; 0];
files = [files; 'D20151104T184948'];    volfilt = [volfilt; 5];  isvert = [isvert; 0];
files = [files; 'D20151104T191208'];    volfilt = [volfilt; 5];  isvert = [isvert; 0];
files = [files; 'D20151104T193427'];    volfilt = [volfilt; 5];  isvert = [isvert; 0];
files = [files; 'D20151104T200201'];    volfilt = [volfilt; 5];  isvert = [isvert; 1];
files = [files; 'D20151104T202421'];    volfilt = [volfilt; 5];  isvert = [isvert; 1];
files = [files; 'D20151104T204641'];    volfilt = [volfilt; 5];  isvert = [isvert; 1];
files = [files; 'D20151104T210900'];    volfilt = [volfilt; 5];  isvert = [isvert; 1];
files = [files; 'D20151104T213356'];    volfilt = [volfilt; 5];  isvert = [isvert; 1];
%}
%BEADS 9um
%~~~next round LOWER CONCENTRATION
% 5mL
%{
figtitle = 'Beads Low Conc Vert vs Horz';
files = {'D20151105T194435'};           volfilt = 5;  isvert = 1;
files = [files; 'D20151105T200655'];    volfilt = [volfilt; 5];  isvert = [isvert; 1];
files = [files; 'D20151105T202915'];    volfilt = [volfilt; 5];  isvert = [isvert; 1];
files = [files; 'D20151105T210041'];    volfilt = [volfilt; 5];  isvert = [isvert; 0];
files = [files; 'D20151105T212301'];    volfilt = [volfilt; 5];  isvert = [isvert; 0];
files = [files; 'D20151105T214520'];    volfilt = [volfilt; 5];  isvert = [isvert; 0];
files = [files; 'D20151105T221748'];    volfilt = [volfilt; 5];  isvert = [isvert; 1];
files = [files; 'D20151105T224008'];    volfilt = [volfilt; 5];  isvert = [isvert; 1];
files = [files; 'D20151105T230227'];    volfilt = [volfilt; 5];  isvert = [isvert; 1];
files = [files; 'D20151105T232446'];    volfilt = [volfilt; 5];  isvert = [isvert; 1];
% 1mL
files = [files; 'D20151106T165810'];    volfilt = [volfilt; 1];  isvert = [isvert; 1];
files = [files; 'D20151106T170409'];    volfilt = [volfilt; 1];  isvert = [isvert; 1];
files = [files; 'D20151106T171009'];    volfilt = [volfilt; 1];  isvert = [isvert; 1];
files = [files; 'D20151106T171609'];    volfilt = [volfilt; 1];  isvert = [isvert; 1];
files = [files; 'D20151106T172529'];    volfilt = [volfilt; 1];  isvert = [isvert; 0];
files = [files; 'D20151106T173129'];    volfilt = [volfilt; 1];  isvert = [isvert; 0];
files = [files; 'D20151106T173728'];    volfilt = [volfilt; 1];  isvert = [isvert; 0];
files = [files; 'D20151106T174328'];    volfilt = [volfilt; 1];  isvert = [isvert; 0];
files = [files; 'D20151106T175234'];    volfilt = [volfilt; 1];  isvert = [isvert; 1];
files = [files; 'D20151106T175834'];    volfilt = [volfilt; 1];  isvert = [isvert; 1];
files = [files; 'D20151106T180434'];    volfilt = [volfilt; 1];  isvert = [isvert; 1];
files = [files; 'D20151106T181034'];    volfilt = [volfilt; 1];  isvert = [isvert; 1];

files = [files; 'D20151106T182613'];    volfilt = [volfilt; 1];  isvert = [isvert; 1];
files = [files; 'D20151106T183213'];    volfilt = [volfilt; 1];  isvert = [isvert; 1];
files = [files; 'D20151106T184309'];    volfilt = [volfilt; 1];  isvert = [isvert; 1];
files = [files; 'D20151106T184909'];    volfilt = [volfilt; 1];  isvert = [isvert; 1];
files = [files; 'D20151106T185928'];    volfilt = [volfilt; 1];  isvert = [isvert; 0];
files = [files; 'D20151106T190528'];    volfilt = [volfilt; 1];  isvert = [isvert; 0];
files = [files; 'D20151106T191128'];    volfilt = [volfilt; 1];  isvert = [isvert; 0];
files = [files; 'D20151106T191728'];    volfilt = [volfilt; 1];  isvert = [isvert; 0];
files = [files; 'D20151106T192541'];    volfilt = [volfilt; 1];  isvert = [isvert; 1];
files = [files; 'D20151106T193141'];    volfilt = [volfilt; 1];  isvert = [isvert; 1];
files = [files; 'D20151106T193741'];    volfilt = [volfilt; 1];  isvert = [isvert; 1];
%}
%~~~~~~~~~~~~NEW MIDDLE CONCENTRATION BEADS - WANTED HIGHER******************************
%only 1 ml samples
%{
figtitle = 'Beads Med Conc Vert vs Horz';
files = {'D20151106T204549'};           volfilt = 5;  isvert = 1;
files = [files; 'D20151106T205147'];    volfilt = [volfilt; 1];  isvert = [isvert; 1];
files = [files; 'D20151106T205747'];    volfilt = [volfilt; 1];  isvert = [isvert; 1];
files = [files; 'D20151106T210347'];    volfilt = [volfilt; 1];  isvert = [isvert; 1];
files = [files; 'D20151106T211107'];    volfilt = [volfilt; 1];  isvert = [isvert; 1];
files = [files; 'D20151106T212126'];    volfilt = [volfilt; 1];  isvert = [isvert; 0];
files = [files; 'D20151106T212725'];    volfilt = [volfilt; 1];  isvert = [isvert; 0];
files = [files; 'D20151106T213325'];    volfilt = [volfilt; 1];  isvert = [isvert; 0];
files = [files; 'D20151106T213925'];    volfilt = [volfilt; 1];  isvert = [isvert; 0];
files = [files; 'D20151106T215008'];    volfilt = [volfilt; 1];  isvert = [isvert; 1];
files = [files; 'D20151106T215608'];    volfilt = [volfilt; 1];  isvert = [isvert; 1];
files = [files; 'D20151106T220208'];    volfilt = [volfilt; 1];  isvert = [isvert; 1];
files = [files; 'D20151106T220808'];    volfilt = [volfilt; 1];  isvert = [isvert; 1];
files = [files; 'D20151106T221408'];    volfilt = [volfilt; 1];  isvert = [isvert; 1];
files = [files; 'D20151106T222008'];    volfilt = [volfilt; 1];  isvert = [isvert; 1];
%}
%~~~~~~~~~~~~NEW HIGHER CONCENTRATION******************************
%3ml vs 1ml - no 5ml
%{
figtitle = 'Beads High Conc Vert vs Horz';
files = {'D20151110T183541'};           volfilt = 3;  isvert = 1;
files = [files; 'D20151110T184951'];    volfilt = [volfilt; 3];  isvert = [isvert; 1];
files = [files; 'D20151110T190401'];    volfilt = [volfilt; 3];  isvert = [isvert; 1];
files = [files; 'D20151110T192143'];    volfilt = [volfilt; 3];  isvert = [isvert; 0];
files = [files; 'D20151110T193553'];    volfilt = [volfilt; 3];  isvert = [isvert; 0];
files = [files; 'D20151110T195003'];    volfilt = [volfilt; 3];  isvert = [isvert; 0];
files = [files; 'D20151110T202517'];    volfilt = [volfilt; 3];  isvert = [isvert; 1];
files = [files; 'D20151110T203926'];    volfilt = [volfilt; 3];  isvert = [isvert; 1];
files = [files; 'D20151110T205336'];    volfilt = [volfilt; 3];  isvert = [isvert; 1];

%outlier discard puased and i think sheath swept away residual beads in flow % files = [files; 'D20151110T213232'];    volfilt = [volfilt; 1];  isvert = [isvert; 1];
files = [files; 'D20151110T213832'];    volfilt = [volfilt; 1];  isvert = [isvert; 1];
files = [files; 'D20151110T214432'];    volfilt = [volfilt; 1];  isvert = [isvert; 1];
files = [files; 'D20151110T215032'];    volfilt = [volfilt; 1];  isvert = [isvert; 1];
files = [files; 'D20151110T215632'];    volfilt = [volfilt; 1];  isvert = [isvert; 1];
files = [files; 'D20151110T220525'];    volfilt = [volfilt; 1];  isvert = [isvert; 0];
files = [files; 'D20151110T221125'];    volfilt = [volfilt; 1];  isvert = [isvert; 0];
files = [files; 'D20151110T221725'];    volfilt = [volfilt; 1];  isvert = [isvert; 0];
files = [files; 'D20151110T222325'];    volfilt = [volfilt; 1];  isvert = [isvert; 0];
files = [files; 'D20151110T222925'];    volfilt = [volfilt; 1];  isvert = [isvert; 0];
files = [files; 'D20151110T224414'];    volfilt = [volfilt; 1];  isvert = [isvert; 1];
files = [files; 'D20151110T225014'];    volfilt = [volfilt; 1];  isvert = [isvert; 1];
files = [files; 'D20151110T225614'];    volfilt = [volfilt; 1];  isvert = [isvert; 1];
files = [files; 'D20151110T230214'];   volfilt = [volfilt; 1];  isvert = [isvert; 1];
%}

%GUINARDIA 5ML
%{
% files = {'D20151112T164628'};           figtitle = {'5mL Vert'};            volfilt = 5;             isvert = 1;
% files = [files; 'D20151112T170931'];    figtitle = [figtitle; '5mL Vert'];volfilt = [volfilt; 5];  isvert = [isvert; 1];
% files = [files; 'D20151112T173151'];    figtitle = [figtitle; '5mL Vert'];volfilt = [volfilt; 5];  isvert = [isvert; 1];
figtitle = 'Guinardia Vert vs Horz'; 
files = {'D20151112T175410'};           volfilt = 5;  isvert = 1;
files = [files; 'D20151112T181728'];    volfilt = [volfilt; 5];  isvert = [isvert; 1];
files = [files; 'D20151112T184118'];    volfilt = [volfilt; 5];  isvert = [isvert; 1];
files = [files; 'D20151112T191233'];    volfilt = [volfilt; 5];  isvert = [isvert; 0];
files = [files; 'D20151112T193452'];    volfilt = [volfilt; 5];  isvert = [isvert; 0];
files = [files; 'D20151112T195712'];    volfilt = [volfilt; 5];  isvert = [isvert; 0];
files = [files; 'D20151112T201931'];    volfilt = [volfilt; 5];  isvert = [isvert; 0];
files = [files; 'D20151112T204151'];    volfilt = [volfilt; 5];  isvert = [isvert; 0];
files = [files; 'D20151112T210954'];    volfilt = [volfilt; 5];  isvert = [isvert; 1];
files = [files; 'D20151112T213214'];    volfilt = [volfilt; 5];  isvert = [isvert; 1];
files = [files; 'D20151112T215433'];    volfilt = [volfilt; 5];  isvert = [isvert; 1];
%GUINARDIA 1ML
files = [files; 'D20151112T224220'];    volfilt = [volfilt; 1];  isvert = [isvert; 1];
files = [files; 'D20151112T224924'];    volfilt = [volfilt; 1];  isvert = [isvert; 1];
files = [files; 'D20151112T225523'];    volfilt = [volfilt; 1];  isvert = [isvert; 1];
files = [files; 'D20151112T230123'];    volfilt = [volfilt; 1];  isvert = [isvert; 1];
files = [files; 'D20151112T230723'];    volfilt = [volfilt; 1];  isvert = [isvert; 1];
files = [files; 'D20151112T231706'];    volfilt = [volfilt; 1];  isvert = [isvert; 0];
files = [files; 'D20151112T232306'];    volfilt = [volfilt; 1];  isvert = [isvert; 0];
files = [files; 'D20151112T232906'];    volfilt = [volfilt; 1];  isvert = [isvert; 0];
files = [files; 'D20151112T233506'];    volfilt = [volfilt; 1];  isvert = [isvert; 0];
files = [files; 'D20151112T234106'];    volfilt = [volfilt; 1];  isvert = [isvert; 0];
files = [files; 'D20151112T235221'];    volfilt = [volfilt; 1];  isvert = [isvert; 1];
files = [files; 'D20151112T235821'];    volfilt = [volfilt; 1];  isvert = [isvert; 1];
files = [files; 'D20151113T000421'];    volfilt = [volfilt; 1];  isvert = [isvert; 1];
files = [files; 'D20151113T001020'];    volfilt = [volfilt; 1];  isvert = [isvert; 1];
files = [files; 'D20151113T001620'];    volfilt = [volfilt; 1];  isvert = [isvert; 1];
files = [files; 'D20151113T003006'];    volfilt = [volfilt; 1];  isvert = [isvert; 1];
%}

%Dock Horz 102 vs Vert/Staining 14
%{
figtitle = 'Dock Horz 102 vs Vert/Staining 14';
files = {'D20151203T150259_IFCB102.adc'};           volfilt = 3;  isvert = 0;
files = [files; 'D20151203T140621_IFCB102.adc'];    volfilt = [volfilt; 3];  isvert = [isvert; 0];
files = [files; 'D20151203T142031_IFCB102.adc'];    volfilt = [volfilt; 3];  isvert = [isvert; 0];
files = [files; 'D20151203T143440_IFCB102.adc'];    volfilt = [volfilt; 3];  isvert = [isvert; 0];
files = [files; 'D20151203T144850_IFCB102.adc'];    volfilt = [volfilt; 3];  isvert = [isvert; 0];
files = [files; 'D20151203T150259_IFCB102.adc'];    volfilt = [volfilt; 3];  isvert = [isvert; 0];
%}

%#######################################################################
%#######################################################################
%USE XLSREAD INSTEAD OF INPUTING EACH FILE
%NEED TO SPECIFY SPREAD SHEET
%#######################################################################
%#######################################################################

[num,txt,raw]=xlsread('F:\from_Samwise\ifcb-analysis\Development\IFCB_vehicles\VehicleLabExperimentFiles.xlsx','9um_debubcart');
files = raw(2:end,1);
volfilt = num(2:end,1);
isvert = zeros(length(volfilt),1);
isvert(strcmp(txt(2:end,3),'V'))=1;
clear num txt

%what size bins do you want? For roiwidth I chose 100pix bins
bins_size = 0:100:1400; %pixels
bins_time = 10:30:1200;%adctime? 30 sec good? *30nov15 when end was 1200 last bin only went to 1180 so were missing last 18 sec of 5ml samples
if bins_time(end)<1200, bins_time = [bins_time 1200]; end 

sizefrac_cellconc    = zeros(length(files),length(bins_size)-1);
counts_timebins      = zeros(length(files),length(bins_time)-1);
runtimes_timebins    = counts_timebins;
inhibittime_timebins = counts_timebins;
looktime_timebins    = counts_timebins;
mlanal_timebins      = counts_timebins; 
cellconc_timebins    = counts_timebins;

samplevol       = NaN(length(files),1);
runtime         = samplevol;
inhibittime     = samplevol;
looktime        = samplevol;
ml_analyzed     = samplevol;
numtriggers     = samplevol;
cellconc        = samplevol;
sec2event2      = samplevol; 

% exclude_small = 0;
% answer = input('Do you want to exclude smallest size fraction of cells? answer y or n"','s');
% if strcmp(answer,'y'), exclude_small = 1; end 
% clear answer

% [n1,bin1] = histc(adcdata(:,2),bins_time);
% [n2,bin2] = histc(adcdata2(:,2),bins_time);
flowrate = 0.25;
    
for count = 1:length(files)
    hdr                  = IFCBxxx_readhdr_Rob([dirpath char(files(count)) '_IFCB102.hdr']);
    adcdata              = load([dirpath char(files(count)) '_IFCB102.adc']);
%     if exclude_small==1, adcdata = adcdata(adcdata(:,16)>20,:); end
%     hdrfilename(i) = {hdrdir(i).name};
    runSampleFast        = hdr.runSampleFast;
    if runSampleFast > 0, error('This sample was run fast, you should not be using it silly!!'); end
    samplevol(count)     = hdr.SyringeSampleVolume;
    runtime(count)       = hdr.runtime;
    inhibittime(count)   = hdr.inhibittime;
    sec2event2(count)    = adcdata(2,2);
    looktime(count)      = hdr.runtime - sec2event2(count) - hdr.inhibittime; %seconds - directly copied from IFCB_volume_analyzed_Rob2, don't really need to call function because already doing half the things in this loop that the function does
    ml_analyzed(count)   = flowrate.*looktime(count)/60;
    numtriggers(count)   = length(adcdata(2:end,1)); %took out unique(adcdata(2:end,1)) - copied from roi_position_IFCB_DTformat_7, why is it included there?
    cellconc(count)      = numtriggers(count)/ml_analyzed(count);
    [h]                  = histogram(adcdata(:,16),bins_size); %this is not accounting for last bin possibly being cut off, not focusing on this calc right now
    sizefrac_cellconc(count,:) = h.Values./ml_analyzed(count); %see above line comment
    
    [counts_timebins(count,:),edges,tempbins] = histcounts(adcdata(:,2),bins_time);
%     clear edges
    for count2 = 1:length(bins_time)-1 %if sample not 5ml then looping through extra bins but rather thorough than miss something
        ind_inhibittimes = adcdata(tempbins==count2,end);
        if ~isempty(ind_inhibittimes)>0,
        inhibittime_timebins(count,count2) = ind_inhibittimes(end) - ind_inhibittimes(1);
        end
    end
    clear ind_* count2
%which way is better to calculate runtime??? we force run time by binning time, so above loop is not needed?    
    sample_ended          = find(bins_time>runtime(count)); %end of run is not necessarily included as last bin, need to account
    temptime = bins_time; temptime(sample_ended) = runtime(count); %set all subsequent bins with same time, easier to zero out non-data later on
    runtimes_timebins(count,:)  = temptime(2:end)-[sec2event2(count) bins_time(2:end-1)]; %first tigger isn't exactly at 0sec, sec2event2 is first trigger time, use that as start time of first bin
    %looktime = runtime - inhibittime
    mlanal_timebins(count,:)    = flowrate.*(runtimes_timebins(count,:)-inhibittime_timebins(count,:))/60; %flow rate ml/min
    cellconc_timebins (count,:) = counts_timebins(count,:)./mlanal_timebins(count,:);%cells per ml
    
    runtimes_timebins(runtimes_timebins<0)  = 0; %zero out columns that are extra
    mlanal_timebins(mlanal_timebins<0)      = 0;
    cellconc_timebins(cellconc_timebins<0)  = 0;
    disp([num2str(count) ' of ' num2str(length(files))])
    clear hdr adcdata 
end
clear adcdata answer exp_list header lasttriggertime count hdr horz*

disp([{'filename','cellconc','volfilt','is vert?'}; files num2cell(cellconc) num2cell(volfilt) num2cell(isvert)])

figure %compare cell conc of diff vol runs
plot(samplevol(isvert==1),cellconc(isvert==1),'b*','markersize',9)
hold on
plot(samplevol(isvert==0),cellconc(isvert==0),'r*','markersize',9)
set(gca,'xlim',[0 6])
xlabel('Sample Volume Run','fontweight','bold'); ylabel('Cell Conc (cells/ml)','fontweight','bold');
title(['Concentration by Volumes - ' figtitle])
legend('Vert','Horz','location',[0.5534 0.8025 0.1452 0.0814])

temp=1:35; %arbitrary number to plot all files
figure %cell conc over duration of exp, cell conc should stay constant over course of lab exp
plot(cellconc,'b*','markersize',9)
hold on
plot(temp(isvert==0),cellconc(isvert==0),'r*','markersize',9)
xlabel('Run # in Sequence','fontweight','bold'); ylabel('Cell Conc (cells/ml)','fontweight','bold');
title(['Concentration Over Course of Runs - ' figtitle])
legend('Vert','Horz','location','northwest')
%{
figure
hold on
for count = 1:size(sizefrac_cellconc,2)
    plot(sizefrac_cellconc(:,count),'*','markersize',9)
end
xlabel('Sample Run #','fontweight','bold'); ylabel('Cell Concentration in each size bin','fontweight','bold')
title('Bin Size = 0:100:1400, Histogram: Cell Concentration for each size fraction')
if strcmp(files(1),'D20151112T164628'), 
    line([6.5 6.5],[0 450],'linewidth',2,'color','k'); 
    text(1.3,425,'Vert-5ml','fontsize',16,'fontweight','bold','color','r')
    text(7,425,'Horz-5ml','fontsize',16,'fontweight','bold','color','r')
    line([11.5 11.5],[0 450],'linewidth',2,'color','k'); 
    text(12,425,'Vert-5ml','fontsize',16,'fontweight','bold','color','r')
    line([15.5 15.5],[0 450],'linewidth',3,'linestyle','--','color','r'); 
    text(16,425,'Vert-1ml','fontsize',16,'fontweight','bold','color','r')
    line([19.5 19.5],[0 450],'linewidth',2,'color','k'); 
    text(20,425,'Horz-1ml','fontsize',16,'fontweight','bold','color','r')
    line([24.5 24.5],[0 450],'linewidth',2,'color','k'); 
    text(25,425,'Vert-1ml','fontsize',16,'fontweight','bold','color','r')
end
%}
indh5 = find(isvert==0 & volfilt>2);
indv5 = find(isvert==1 & volfilt>2);
indh1 = find(isvert==0 & volfilt==1);
indv1 = find(isvert==1 & volfilt==1);
%{
figure %plot counts for each time bin
subplot(2,1,1)
h1 = plot(counts_timebins(indv5,:)','.b','markersize',9);
hold on
h2 = plot(counts_timebins(indh5,:)','or');
legend([h1(1),h2(1)],'Vert','Horz')
xlabel('bins of secs over sample','fontweight','bold'); ylabel('count','fontweight','bold');
title(['Counts Large Vol - ' figtitle])
subplot(2,1,2)
h3 = plot(counts_timebins(indv1,:)','.b','markersize',9);
hold on
h4 = plot(counts_timebins(indh1,:)','or');
legend([h3(1), h4(1)],'vert','horz')
xlabel('bins of secs over sample','fontweight','bold'); ylabel('count','fontweight','bold');
title(['Counts - Small Vol ' figtitle])
%}

figure %plot cell concentration for each time bin
subplot(2,1,1)
h1 = plot(cellconc_timebins(indv5,:)','.b','markersize',9);
hold on
h2 = plot(cellconc_timebins(indh5,:)','or');
legend([h1(1), h2(1)],'vert','horz')
xlabel('bins of secs over sample','fontweight','bold'); ylabel('Concentration (cells/ml)','fontweight','bold');
title(['CellConc Large Vol - ' figtitle])
subplot(2,1,2)
h3 = plot(cellconc_timebins(indv1,:)','.b','markersize',9);
hold on
h4 = plot(cellconc_timebins(indh1,:)','or');
legend([h3(1), h4(1)],'vert','horz')
xlabel('bins of secs over sample','fontweight','bold'); ylabel('Concentration(cells/ml)','fontweight','bold');
title(['CellConc Small Vol - ' figtitle])


%to get cell conc per ml take flow rate which is always 0.25 and multiply
%by look time. For this script look time is timebin(count)-timebin(count-1)