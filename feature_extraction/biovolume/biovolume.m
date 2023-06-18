function [ target ] = biovolume( target )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
% Modify from biovolume.m to compute along with other features
% Heidi M. Sosik, Woods Hole Oceanographic Institution

volume = NaN;
t = target.blob_props;

if length(t.Area) > 1,
    bwl = bwlabel(target.blob_image);
else
    bwl = target.blob_image;
end;

area_ratio = [t.ConvexArea]./[t.Area];
p = [t.EquivDiameter]./[t.MajorAxisLength];
for ii = 1:length(t.Area),
    volume(ii) = NaN;
    if t.Area(ii), %skip if no blob (area = 0) 
        blob_now = bwl; blob_now(blob_now ~= ii) = 0;
        blob_now = logical(blob_now); %needed for cases with bwlabel applied above    
        if area_ratio(ii) < 1.2 || (t.Eccentricity(ii) < 0.8 && p(ii) > 0.8), %solid of revolution cases
            theta = -1*t.Orientation(ii);
            blob_rot = imrotate(blob_now, theta, 'bilinear'); % rotates the filled image
            volume(ii) = volumewalk(blob_rot);
        else %distance map cases
           b =  bwboundaries(blob_now,8,'noholes');
           [M N] = size(blob_now);
           perim_img = bound2im(b{1},M,N);
           volume(ii) = distmap_volume(perim_img);
        end;
    end;
end;
target.blob_props.Biovolume = volume;
end

