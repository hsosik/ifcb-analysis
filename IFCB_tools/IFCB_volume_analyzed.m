function [ ml_analyzed ] = IFCB_volume_analyzed( hdrfilename )
%function [ ml_analyzed ] = IFCB_volume_analyzed( hdrfilename )
% hdrfilename input as char or cell complete with path (or url)
% reads sample run time and "inhibit" time from IFCB hdr file 
% returns associated estimate of sample volume analyzed (in milliliters)
% assuming standard IFCB configuration with sample syringe operating 
% at 0.25 mL per minute
% Applies only to IFCB instruments after 007 and higher (except 008)
% Heidi M. Sosik, Woods Hole Oceanographic Institution, September 2012

flowrate = 0.25; %milliliters per minute for syringe pump
if ischar(hdrfilename), hdrfilename = cellstr(hdrfilename); end;
ml_analyzed = NaN(size(hdrfilename));
for count = 1:length(hdrfilename),
    hdr = IFCBxxx_readhdr(hdrfilename{count});
    if ~isempty(hdr),
        looktime = hdr.runtime - hdr.inhibittime; %seconds
        ml_analyzed(count) = flowrate.*looktime/60;
    end;
end;

end

