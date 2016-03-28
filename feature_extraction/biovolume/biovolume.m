function [ target ] = biovolume( target )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
% Modify from biovolume.m to compute along with other features
% Heidi M. Sosik, Woods Hole Oceanographic Institution

t = target.blob_props;
volume = NaN(size(t));
surface_area = volume;
xr = volume;

area_ratio = [t.ConvexArea]./[t.Area];
p = [t.EquivDiameter]./[t.MajorAxisLength];
for ii = 1:length(t.Area),
    if t.Area(ii), %skip if no blob (area = 0) 
        if area_ratio(ii) < 1.2 || (t.Eccentricity(ii) < 0.8 && p(ii) > 0.8), %solid of revolution cases
            blob_now = target.rotated_blob_images{ii};
            [volume(ii) xr(ii) surface_area(ii)] = surface_area_revolve_2e(blob_now); 
        else %distance map cases
           [volume(ii) xr(ii) surface_area(ii)] = distmap_volume(target.blob_perimeter_images{ii});
        end;
    end;
end;
target.blob_props.Biovolume = volume;
target.blob_props.SurfaceArea = surface_area;
target.blob_props.RepresentativeWidth = xr;
end

