function [ ml_analyzed ] = IFCB_volume_analyzed( hdrfile )
%function [ ml_analyzed ] = IFCB_volume_analyzed( hdrfile )
% reads sample run time and "inhibit" time from IFCB hdr file 
% returns associated estimate of sample volume analyzed (in milliliters)
% assuming standard IFCB configuration with 5 mL syringe and pump
% operating at 40 steps per second and 48000 steps per syringe
% Applies only to IFCB instruments after 007 and higher (except 008)
% Heidi M. Sosik, Woods Hole Oceanographic Institution, September 2012

steps_per_sec = 40;
ml_per_step = 5/48000;
flowrate = ml_per_step * steps_per_sec;  %ml/sec
ml_analyzed = NaN;
hdr = IFCBxxx_readhdr(hdrfile); 
if ~isempty(hdr),
    looktime = hdr.runtime - hdr.inhibittime;
    ml_analyzed = flowrate.*looktime;
end;

end

