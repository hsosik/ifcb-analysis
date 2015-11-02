% Taylor 28Oct2015
%calculate cellsperml of size freactions or classifications or whatever of
%each sample. For comparing Horz vs Vert runnign in vehicle project. Is horz
%running getting correct communicaty composition or is it missing?


clear all

dirpath = '\\sosiknas1\Lab_data\IFCB_forVehicles\IFCB102\data\2015\D20151023\';
files = {'D20151023T191437_IFCB102'};        figtitle = {'D20151023T191437 Gui/Dun/Beads HORZ'};
files = [files; 'D20151023T185218_IFCB102']; figtitle = [figtitle; 'D20151023T185218 Gui/Dun/Beads HORZ'];
files = [files; 'D20151023T180105_IFCB102']; figtitle = [figtitle; 'D20151023T180105 Gui/Dun/Beads VERT'];
files = [files; 'D20151023T161217_IFCB102']; figtitle = [figtitle; 'D20151023T161217 Dun & beads VERT']; %Dun&9um beads in FSW in lab, VERT
files = [files; 'D20151023T152314_IFCB102']; figtitle = [figtitle; 'D20151023T152314 Dun & beads HORZ']; %Dun&9um beads in FSW in lab, VERT


% file = 'D20151015T181337_IFCB102.adc'; %dock water horz stationary in lab
% file = 'D20151015T181337_IFCB102.adc'; %dock water horz stationary in lab
% file = 'D20151006T192518_IFCB102.adc'; %dock water vert stationary in lab
% file = 'D20151006T195148_IFCB102.adc'; %dock water vert stationary in lab
% file = 'D20151006T200900_IFCB102.adc'; %dock water horz stationary in lab

%what size bins do you want? For roiwidth I chose 100pix bins
bins = 0:100:1400;
sizefrac_cellconc = NaN(length(files),length(bins)-1);

fastfactor = nan(length(files),1);
runSampleFast = fastfactor;
samplevol = fastfactor;
flowrate = fastfactor;
runtime = fastfactor;
inhibittime = fastfactor;
ml_analyzed  = fastfactor;
numtriggers = fastfactor;
cellconc = fastfactor;
exclude_small = 0;
answer = input('Do you want to exclude smallest size fraction of cells? answer y or n"','s');
if strcmp(answer,'y'), exclude_small = 1; end 
clear answer
for count = 1:length(files)
    hdr = IFCBxxx_readhdr_Rob([dirpath char(files(count)) '.hdr']);
    adcdata = load([dirpath char(files(count)) '.adc']);
    if exclude_small==1, adcdata = adcdata(adcdata(:,16)>20,:); end
%     hdrfilename(i) = {hdrdir(i).name};
    fastfactor(count) = hdr.RunFastFactor; if fastfactor(count) == 0, fastfactor(count) = 1; end
    runSampleFast(count) = hdr.runSampleFast;
    samplevol(count) = hdr.SyringeSampleVolume;
    if runSampleFast(count) > 0
        flowrate(count) = 0.25 * fastfactor(count); % ml/min
    else flowrate(count) = 0.25;
    end
    lasttriggertime = 60*samplevol(count)/flowrate(count); %sec to last trigger    
    runtime(count) = hdr.runtime;
    inhibittime(count) = hdr.inhibittime;
    sec2event2 = adcdata(2,2);
    ml_analyzed(count) = IFCB_volume_analyzed_Rob2([dirpath char(files(count)) '.hdr'], sec2event2);
    numtriggers(count) = length(unique(adcdata(:,1)));
    cellconc(count) = numtriggers(count)/ml_analyzed(count);
    h = histogram(adcdata(:,16),bins);
    sizefrac_cellconc(count,:) = h.Values./ml_analyzed(count);
    disp([num2str(count) ' of ' num2str(length(files))])
end
clear adcdata answer exp_list header lasttriggertime count hdr horz*
