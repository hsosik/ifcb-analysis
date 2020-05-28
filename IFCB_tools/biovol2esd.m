function [esd] = biovol2esd(biovol)
%function [esd] = biovol2esd(biovol)
% compute equivalent spherical diameter from volume
%
% Heidi M. Sosik, Woods Hole Oceanographic Institution, May 2020
esd = 2*(biovol*3/pi/4).^(1/3);;
end

