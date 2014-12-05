function [ ml_analyzed ] = IFCB_volume_analyzed( hdrfilename, sec2event2 )
%function [ ml_analyzed ] = IFCB_volume_analyzed( hdrfilename )
% hdrfilename input as char or cell complete with path (or url)
% reads sample run time and "inhibit" time from IFCB hdr file 
% returns associated estimate of sample volume analyzed (in milliliters)
% assuming standard IFCB configuration with sample syringe operating 
% at 0.25 mL per minute
% Applies only to IFCB instruments 007 and higher (except 008)
% Heidi M. Sosik, Woods Hole Oceanographic Institution, September 2012

flowrate = 0.25; %milliliters per minute for syringe pump
if ischar(hdrfilename), hdrfilename = cellstr(hdrfilename); end;
ml_analyzed = NaN(size(hdrfilename));
for count = 1:length(hdrfilename),
    hdr = IFCBxxx_readhdr_Rob(hdrfilename{count});
    if hdr.RunFastFactor==0,
        hdr.RunFastFactor =1;
    end
    if ~isempty(hdr),
        startlag = 14; %instrument-specific: seconds to first real trigger. Measured 14 s on ifcb9.
        endlag = 11; %software-specific???: seconds btween last real (linear portion) trigger and file closing. Measured 11 s on ifcb9.
        if hdr.runSampleFast == 1
            flowrate = flowrate * hdr.RunFastFactor;
            startlag = startlag / hdr.RunFastFactor;
            endlag = endlag / hdr.RunFastFactor;
        end
        %         looktime = hdr.runtime - hdr.inhibittime - startlag - endlag; %ignore time with no triggers at start of sample (14 s in ifcb9 with long acoustic needle) and at end (software delay?)
        %         looktime = hdr.runtime - hdr.inhibittime; %seconds
        % start sample time from 2nd event (first event is artificial)
        looktime = hdr.runtime - sec2event2 - hdr.inhibittime; %seconds
        ml_analyzed(count) = flowrate.*looktime/60;
%         keyboard
    end;
end;
end

