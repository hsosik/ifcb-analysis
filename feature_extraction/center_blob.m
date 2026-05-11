function [ C ] = center_blob(blob_image, centroid)

% if centroid is not provided, compute it
if ~exist('centroid','var')
    rp = regionprops(blob_image,'Centroid');
    centroid = rp.Centroid;
end;

[ys, xs] = find(blob_image);
h = size(blob_image,1); w = size(blob_image,2);
n = numel(ys);

% Integer-exact centering
sum_y = sum(ys) - n;
sum_x = sum(xs) - n;

hN = h * n;
wN = w * n;
ycN = sum_y;
xcN = sum_x;
sN = max([ycN, hN - ycN, xcN, wN - xcN]);

m  = floor((2 * sN + n - 1) / n);
y0 = floor((sN - ycN) / n);
x0 = floor((sN - xcN) / n);

C = false(m, m);
C(y0+1:y0+h, x0+1:x0+w) = blob_image;

end
