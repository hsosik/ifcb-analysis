function [ cellC ] = biovol2carbon( cellbiovol, diatom_flag )
%Convert vector or matrix of cell volume values to cell carbon values
%according to the relationships in Menden-Deuer and Lessard 2000 for
%general protists and large diatoms
%assumes biovolumes in cubic microns per cell
%outputs carbon as picograms per cell
%Heidi M. Sosik, Woods Hole Oceanographic Institution, March 2012

cellC = NaN(size(cellbiovol));
cellC(:) = vol2C_nondiatom(cellbiovol(:));
if diatom_flag,
    ii = find(cellbiovol(:) >= 3000);
    cellC(ii) = vol2C_lgdiatom(cellbiovol(ii));
end;

end

