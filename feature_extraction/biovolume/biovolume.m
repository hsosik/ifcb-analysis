function [ target ] = biovolume( target )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
% Modify from biovolume.m to compute along with other features
% Heidi M. Sosik, Woods Hole Oceanographic Institution

volume = NaN;
t = target.blob_props;

area_ratio = [t.ConvexArea]./[t.Area];
p = [t.EquivDiameter]./[t.MajorAxisLength];
for ii = 1:length(t.Area),
    volume(ii) = NaN;
    if t.Area(ii), %skip if no blob (area = 0) 
        blob_now = target.blob_images{ii};
        if area_ratio(ii) < 1.2 || (t.Eccentricity(ii) < 0.8 && p(ii) > 0.8), %solid of revolution cases
            theta = -1*t.Orientation(ii);
            blob_rot = imrotate(blob_now, theta, 'bilinear'); % rotates the filled image
            %volume(ii) = volumewalk(blob_rot);
            [volume(ii) xr(ii) surface_area(ii)] = surface_area_revolve_2e(blob_rot); 
        else %distance map cases
           b =  bwboundaries(blob_now,8,'noholes');
           [M N] = size(blob_now);
           perim_img = bound2im(b{1},M,N);
            [volume(ii) xr(ii) surface_area(ii)] = distmap_volume(perim_img);
        end;
    end;
end;
target.blob_props.Biovolume = volume;
target.blob_props.SurfaceArea = surface_area;
target.blob_props.RepresentativeWidth = xr;
end

