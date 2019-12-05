function [ ml_analyzed ] = IFCB_volume_analyzed_fromADC( adcfilename )
%function [ ml_analyzed ] = IFCB_volume_analyzed( hdrfilename )
% hdrfilename input as char or cell complete with path (or url)
% reads sample run time and "inhibit" time from IFCB hdr file 
% returns associated estimate of sample volume analyzed (in milliliters)
% assuming standard IFCB configuration with sample syringe operating 
% at 0.25 mL per minute
% Applies only to IFCB instruments after 007 and higher (except 008)
% Heidi M. Sosik, Woods Hole Oceanographic Institution, September 2012

flowrate = 0.25; %milliliters per minute for syringe pump
if ischar(adcfilename), adcfilename = cellstr(adcfilename); end;
ml_analyzed = NaN(size(adcfilename));
for count = 1:length(adcfilename),
    %hdr = IFCBxxx_readhdr(hdrfilename{count});
    if startsWith(adcfilename{count}, 'http')
        adc = webread(adcfilename{count}, 'FileType', 'csv');
    else
        adc = readtable(adcfilename{count}, 'FileType', 'text');       
    end
    if ~isempty(adc)
        runtime = adc.Var23(end);
        inhibittime = adc.Var24(end);
        looktime = runtime - inhibittime; %seconds
        ml_analyzed(count) = flowrate.*looktime/60;
        if ml_analyzed(count) <= 0 %minor case for some files with bad last adc line
            runtime = adc.Var23(end-1);
            inhibittime = adc.Var24(end-1);
            looktime = runtime - inhibittime; %seconds
            ml_analyzed(count) = flowrate.*looktime/60;
        end
        if ml_analyzed(count) <= 0 %minor case for some files with 0 runtime and inhibit time in numerous rows at file end
           runtime = adc.Var2(end-1); %next best info after runtime
           ii = find(adc.Var23);
           modeinhibittime = mode(diff(adc.VarName24(ii)));
           inhibittime = adc.Var23(ii) + size(adc,1)-ii * modeinhibittime;
        end
    end
end

end

