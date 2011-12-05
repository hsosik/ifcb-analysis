function [ target ] = blob_RingWedge( target )
% function [ target ] = blob_RingWedge( target )
% given blob mask, return relative power in rings and wedges in frequency
% space, as originally implemented by Kacie Li (WHOI SSF in 2005) in getRW.m
% Heidi M. Sosik, Woods Hole Oceanographic Institution, Oct 2011

fw = getRW_fast(target.blob_image);
target.blob_props.RWhalfpowerintegral = fw(1);
target.blob_props.RWcenter2total_powerratio = fw(2);
target.blob_props.Wedges = fw(3:50);
target.blob_props.Rings = fw(51:end);

end
