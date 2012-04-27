function [ carbon ] = vol2C_lgdiatom( volume )
%function [ carbon ] = vol2C_lgdiatom( volume )
%conversion from biovolume in microns^3 to carbon in picograms
%for large diatoms (> 2000 micron^3) 
%according to Menden-Deuer and Lessard 2000
%log pgC cell-1 = log a + b * log V (um3)
%diatoms > 3000 um3 log a = -0.933, b = 0.881
%Heidi M. Sosik, Woods Hole Oceanographic Institution, March 2012

loga = -0.933;
b = 0.881;
logC = loga + b.*log10(volume);
carbon = 10.^logC;

end

