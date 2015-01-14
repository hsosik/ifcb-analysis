
clear all
%%%%%%%%%%%%%%%%%%%%%%%%
%make_pathfiles2load.m - prompts question of what you'd like to plot 
%set path to data, start & end file, name for saved mat file
%%%%%%%%%%%%%%%%%%%%%%%%
make_pathfiles2load

startday  = str2num([startfile(2:9) startfile(11:16)]);
endday    = str2num([endfile(2:9) endfile(11:16)]);
allfiles  = dir([dirpath 'D2014*.hdr']);%get all files from set dir
alladc  = dir([dirpath 'D2014*.adc']);
allfiles  = {allfiles.name}';
temp      = char(allfiles);
temp      = [temp(:,2:9) temp(:,11:16)];
%make matdate for each adc file
matdate   = datenum(temp(:,:),'yyyymmddHHMMSS'); %get matdate from filenames
temp      = str2num(temp);
%only use files of interest - start/end day set above
ind       = find(temp>=startday & temp<=endday);
files     = allfiles(ind); 
adcfiles  = alladc(ind);    
matdate   = matdate(ind);
clear temp ind allfiles startfile endfile alladcd

fastfactor = nan(length(files),1);
runSampleFast = fastfactor;
samplevol = fastfactor;
flowrate = fastfactor;
runtime = fastfactor;
inhibittime = fastfactor;
ml_analyzed  = fastfactor;
numtriggers = fastfactor;
cellconc = fastfactor;
for count = 1:length(files)
    hdr = IFCBxxx_readhdr_Rob([dirpath char(files(count))]);
    adcdata = load([dirpath adcfiles(count).name]);
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
    ml_analyzed(count) = IFCB_volume_analyzed_Rob2([dirpath char(files(count))], sec2event2);
    numtriggers(count) = length(unique(adcdata(:,1)));
    cellconc(count) = numtriggers(count)/ml_analyzed(count);
    disp([num2str(count) ' of ' num2str(length(files))])
end
    
%     disp(['runSampleFast  = ' num2str(runSampleFast)])
%     disp(['fastfactor  = ' num2str(fastfactor)])
%     disp(['sec2event2  = ' num2str(sec2event2)])
%     disp(['flowrate  = ' num2str(flowrate)])
%     disp(['samplevol  = ' num2str(samplevol)])
%     disp(['runtime  = ' num2str(runtime)])
%     disp(['inhibittime  = ' num2str(inhibittime)])
%     disp(['ml_analyzed  = ' num2str(ml_analyzed)])
%     disp(['numtriggers  = ' num2str(numtriggers)])
%     disp(['cellconc  = ' num2str(cellconc)])