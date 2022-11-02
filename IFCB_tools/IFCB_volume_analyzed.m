function [ ml_analyzed ] = IFCB_volume_analyzed( hdrfilename , hdrOnly_flag)
%function [ ml_analyzed ] = IFCB_volume_analyzed( hdrfilename, hdrOnly_flag )
% hdrfilename input as char or cell complete with path (or url)
% hdrOnly_flag, optional 0 (default) or 1 (case to skip adc file estimate)
%
% reads sample run time and "inhibit" time from IFCB hdr file 
% returns associated estimate of sample volume analyzed (in milliliters)
% assuming standard IFCB configuration with sample syringe operating 
% at 0.25 mL per minute
% Applies only to IFCB instruments after 007 and higher (except 008)
% Heidi M. Sosik, Woods Hole Oceanographic Institution, September 2012
%
% update for default to always compute from hdr file info AND estimate from
% adc file info (with call to IFCB_volume_analyzed_fromADC.m); then use
% adhoc criteria to select cases when hdr info is not good and adc should
% be used as next best estimate (derived from analysis of thousands of
% files over NES-LTER transect cruises and OTZ cruises and numerous IFCB 
% instrument numbers and revisions of acquisition software from McLane)
% Set optional hdrOnly_flag = 1 for quicker performance but *ONLY* if you are sure 
% that your hdr file info is all robust (not recommended for most users
% as of 2022
% Heidi M. Sosik, Woods Hole Oceanographic Institution, November 2022
if ~exist('hdrOnly_flag', 'var')
    hdrOnly_flag = 0; %default
end
flowrate = 0.25; %milliliters per minute for syringe pump
if ischar(hdrfilename), hdrfilename = cellstr(hdrfilename); end
ml_analyzed = NaN(size(hdrfilename));
for count = 1:length(hdrfilename)
    hdr = IFCBxxx_readhdr(hdrfilename{count});
    %if ~isempty(hdr)
    %    [~, inhibittime_adc, runtime_adc] = IFCB_volume_analyzed_fromADC (regexprep(hdrfilename{count}, '.hdr', '.adc'));
    %end
    runtime = hdr.runtime;
    inhibittime = hdr.inhibittime;
    if ~hdrOnly_flag
        [~, inhibittime_adc, runtime_adc] = IFCB_volume_analyzed_fromADC (regexprep(hdrfilename{count}, '.hdr', '.adc'));
        if (hdr.runtime./runtime_adc < 0.98 || hdr.runtime./runtime_adc > 1.02)
            runtime = runtime_adc;
        end
        if (hdr.inhibittime./inhibittime_adc < 0.98 || hdr.inhibittime./inhibittime_adc > 1.02)
            inhibittime = inhibittime_adc;
        end
    end
    looktime = runtime-inhibittime; %seconds
    ml_analyzed(count) = flowrate.*looktime/60;
end

end

