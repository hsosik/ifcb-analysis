function [ target ] = biovolume( target )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

volume = NaN;
eqvdiam = NaN;
majoraxis = NaN;
minoraxis = NaN;
t = regionprops(target.blob_image, 'Area', 'Orientation','ConvexArea','Eccentricity', 'EquivDiameter','MajorAxisLength', 'MinorAxisLength');
if length(t) > 1,
    bwl = bwlabel(target.blob_image);
else
    bwl = target.blob_image;
end;
area_ratio = [t.ConvexArea]./[t.Area];
p = [t.EquivDiameter]./[t.MajorAxisLength];
for ii = 1:length(t),
    blob_now = bwl; blob_now(blob_now ~= ii) = 0;
    blob_now = logical(blob_now); %needed for cases with bwlabel applied above    
    eqvdiam(ii) = t(ii).EquivDiameter;
    majoraxis = t(ii).MajorAxisLength;
    minoraxis = t(ii).MinorAxisLength;
    if area_ratio(ii) < 1.2 || (t(ii).Eccentricity < 0.8 && p(ii) > 0.8), %solid of revolution cases
        theta = -1*t(ii).Orientation;
        blob_rot = imrotate(blob_now, theta, 'bilinear'); % rotates the filled image
        volume(ii) = volumewalk(blob_rot);
    else %distance map cases
       b =  bwboundaries(blob_now,8,'noholes');
       [M N] = size(blob_now);
       perim_img = bound2im(b{1},M,N);
       volume(ii) = rep_dist(perim_img);
    end;
end;
target.Biovolume = volume;
target.EquivDiameter = eqvdiam;
target.MajorAxisLength = majoraxis;
target.MinorAxisLength = minoraxis;
end

