function [ ml_analyzed ] = IFCB_volume_analyzed( hdrfilename, sec2event2, fluidicsActive ) %fluidicsActive=1 normally but 0 for testing with signal generator
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
    hdr = IFCBxxx_readhdr_acoustic(hdrfilename{count});
    if ~isfield(hdr, 'RunFastFactor') %if it doesn't exist in hdr, set it here
        hdr.RunFastFactor = 1;
    end
    if ~isfield(hdr, 'fluidsActive') %if it doesn't exist in hdr, set it here
        hdr.fluidsActive = 1;
    end
    if hdr.RunFastFactor==0,
        hdr.RunFastFactor = 1;
    end
    if ~isempty(hdr),
        if hdr.fluidsActive == 0
            startlag = 0;
            endlag = 0;
        else
            startlag = 14; %instrument-specific: seconds to first real trigger. Measured 14 s on ifcb9.
            endlag = 11; %software-specific???: seconds btween last real (linear portion) trigger and file closing. Measured 11 s on ifcb9.
        end
        if ~isfield(hdr, 'runSampleFast') %if it doesn't exist in hdr, set it here
            hdr.runSampleFast = 0;
        end
        if hdr.runSampleFast == 1
            flowrate = flowrate * hdr.RunFastFactor;
            startlag = startlag / hdr.RunFastFactor;
            endlag = endlag / hdr.RunFastFactor;
        end
        %         looktime = hdr.runtime - hdr.inhibittime - startlag - endlag; %ignore time with no triggers at start of sample (14 s in ifcb9 with long acoustic needle) and at end (software delay?)
        %         looktime = hdr.runtime - hdr.inhibittime; %seconds
%         % start sample time from 2nd event (first event is artificial)
%         if hdr.fluidsActive == 0
%             sec2event2 = 0;
%         end
        looktime = hdr.runtime - sec2event2 - hdr.inhibittime; %seconds
            
        ml_analyzed(count) = flowrate.*looktime/60;
%         keyboard
    end;
end;
end
