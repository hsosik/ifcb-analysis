function [ C ] = center_blob(blob_image, centroid)

% if centroid is not provided, compute it
if ~exist('centroid','var')
    rp = regionprops(blob_image,'Centroid');
    centroid = rp.Centroid;
end;

% pad and center the blob in a square image large enough to support
% rotation and reflection operations
[h, w] = size(blob_image);
xc = centroid(1)-1;
yc = centroid(2)-1;
s = max([yc,h-yc,xc,w-xc]);
m = ceil(s*2);
C = zeros(m,m);
y0 = floor(s-yc);
x0 = floor(s-xc);
C(y0+1:y0+h,x0+1:x0+w) = blob_image;

end