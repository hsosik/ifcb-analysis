function [ ml_analyzed, inhibittime, runtime ] = IFCB_volume_analyzed_fromADC( adcfilename )
%function [ ml_analyzed ] = IFCB_volume_analyzed_fromADC( hdrfilename )
% hdrfilename input as char or cell complete with path (or url)
% reads sample run time and "inhibit" time from IFCB hdr file 
% returns associated estimate of sample volume analyzed (in milliliters)
% assuming standard IFCB configuration with sample syringe operating 
% at 0.25 mL per minute
% Applies only to IFCB instruments after 007 and higher (except 008)
% Heidi M. Sosik, Woods Hole Oceanographic Institution, September 2012
% updated to address newly discovered cases in failure to log good values
% in adc files (see https://github.com/hsosik/ifcb-analysis/issues/33)
% Heidi M. Sosik, Woods Hole Oceanographic Institution, November 2022

flowrate = 0.25; %milliliters per minute for syringe pump
if ischar(adcfilename), adcfilename = cellstr(adcfilename); end
ml_analyzed = NaN(size(adcfilename));
inhibittime = ml_analyzed;
runtime = ml_analyzed;
for count = 1:length(adcfilename)
    if startsWith(adcfilename{count}, 'http')
        adc = webread(adcfilename{count}, 'FileType', 'csv');
    else
        adc = readtable(adcfilename{count}, 'FileType', 'text');       
    end
    if ~isempty(adc)
        %find indices of rows where inhibitime is not 0 and not less than the previous value (within 0.1 second)
        diffinh = diff(adc.Var24);
        iii = [1; find(adc.Var24(2:end)>0 & diffinh>-.1 & diffinh<5) + 1];
        %calculate the mode differential inhibittime from the good records, round to nearest 4 digits before finding mode
        modeinhibittime = mode(round(diff(adc.Var24(iii)),4)); %this will be used for the "second best" estimate
        %now see if there should be any offsets applied for adc files with strange non-zero starts to the time counting
        runtime_offset = 0;
        inhibittime_offset = 0;
        if size(adc,1)>1 % only do this if there is more than one line in the adc file
        %now check if the inhibit and runtime columns have a large offset
            runtime_offset_test = adc.Var23(2)-adc.Var2(2);
            if runtime_offset_test > 10 %when the difference is small there is no problem keep at 0, if big do this
                runtime_offset = runtime_offset_test;
                %large runtime and inhibit time offsets seem to come and go together
                inhibittime_offset = adc.Var24(2) + modeinhibittime*2; %use the second row since the first one is bad occasionally, add two mode increments to account for that
            end
               
            % if ~isempty(setdiff(1:size(adc,1), iii)) %check if there are bad rows
            if size(adc,1)==length(iii)
                %this is the best value--if it's not bad
                inhibittime(count) = adc.Var24(end)-inhibittime_offset;
            else
                %second best estimate, last good row, plus mode as best guess for each bad row
                inhibittime(count) = adc.Var24(iii(end)) + (size(adc,1)-length(iii)) * modeinhibittime-inhibittime_offset;
            end
            %this is the best value--if it's not bad
            runtime(count) = adc.Var23(end)-runtime_offset;
            %grabstart values in col2 are not corrupted when the runtime values in later columns sometimes are towards the file end
            %but col2 starts off a bit after col23, so adjust with the median difference estimated from the top 50 rows
            n = min(size(adc,1),50); % use 50 rows or all that exist if fewer than 50
            runtime2 = adc.Var2(end)+median(adc.Var23(1:n)-adc.Var2(1:n))-runtime_offset;
            if abs(runtime-runtime2)>0.2 %if the estimates are not close, use the second best
                runtime(count) = runtime2;
            end
        end
    end
end
looktime = runtime-inhibittime;
ml_analyzed(count) = flowrate.*looktime/60;
end
