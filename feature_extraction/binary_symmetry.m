function [ b180, b90, bflip ] = binary_symmetry( blob_image )
% computes binary symmetry at 180 degrees, 90 degrees, and flipped
% along horizontal axis
% binary symmetry is the the number of overlapping pixels
% between the blob and a rotated/reflected version of the blob,
% divided by the area of the blob.
%
% the blob image passed in must be centered
% and oriented so that its major axis
% is horizontal

C = blob_image; % a convenient name
% compute area
area = sum(C(:));

% now perform rotations and compute overlap
o180 = C & rot90(C,2);
o90 = C & rot90(C);
oflip = C & flipud(C);

% compute area ratios of overlap
b180 = sum(o180(:)) / area;
b90 = sum(o90(:)) / area;
bflip = sum(oflip(:)) / area;

end

