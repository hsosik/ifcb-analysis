function [ carbon ] = vol2C_nondiatom( volume )
%function [ carbon ] = vol2C_nondiatom( volume )
%conversion from biovolume in microns^3 to carbon in picograms
%for protists besides large diatoms (> 3000 um^3) 
%according to Menden-Deuer and Lessard 2000
%log pgC cell-1 = log a + b * log V (um3)
%log a = -0.665, b = 0.939
%Heidi M. Sosik, Woods Hole Oceanographic Institution, March 2012

loga = -0.665;
b = 0.939;
logC = loga + b.*log10(volume);
carbon = 10.^logC;

end

