function out = imrotate_nearest_crop_explicit(img, angle_deg)
% Deterministic nearest-neighbor crop rotation for MATLAB/Python parity.
%
% angle_deg is the blob orientation, matching Python
% ifcb_features.blobs.imrotate_nearest_crop. Internally this applies the
% opposite sign because the original MATLAB pipeline used
% imrotate(centered, -Orientation, 'nearest', 'crop').

img = logical(img);
[h, w] = size(img);

ang = double(-angle_deg) * pi / 180.0;
cos_a = cos(ang);
sin_a = sin(ang);

x_limits = [0.5, double(w) + 0.5];
y_limits = [0.5, double(h) + 0.5];
corners = [
    x_limits(1), y_limits(1);
    x_limits(1), y_limits(2);
    x_limits(2), y_limits(1);
    x_limits(2), y_limits(2)
];

x_out = corners(:,1) .* cos_a + corners(:,2) .* sin_a;
y_out = -corners(:,1) .* sin_a + corners(:,2) .* cos_a;
x_trans = (double(min(x_out)) + double(max(x_out))) / 2.0 - ...
    (x_limits(1) + x_limits(2)) / 2.0;
y_trans = (double(min(y_out)) + double(max(y_out))) / 2.0 - ...
    (y_limits(1) + y_limits(2)) / 2.0;

x_world_min = nextafter_down(nextafter_down(x_limits(1) + x_trans));
y_world_min = nextafter_down(nextafter_down(y_limits(1) + y_trans));

[cols0, rows0] = meshgrid(0:w-1, 0:h-1);
x_world = x_world_min + (double(cols0) + 0.5);
y_world = y_world_min + (double(rows0) + 0.5);

x_in = x_world .* cos_a - y_world .* sin_a;
y_in = x_world .* sin_a + y_world .* cos_a;

x_idx = sign(x_in) .* floor(abs(x_in) + 0.5);
y_idx = sign(y_in) .* floor(abs(y_in) + 0.5);

out = false(h, w);
mask = x_idx >= 1 & x_idx <= w & y_idx >= 1 & y_idx <= h;
if any(mask(:))
    in_idx = sub2ind([h, w], y_idx(mask), x_idx(mask));
    out(mask) = img(in_idx);
end

end

function y = nextafter_down(x)
% One representable double toward -Inf, scalar-only.

x = double(x);
if isnan(x) || (isinf(x) && x < 0)
    y = x;
    return
end

if x > 0
    bits = typecast(x, 'uint64');
    bits = bits - uint64(1);
elseif x < 0
    bits = typecast(x, 'uint64');
    bits = bits + uint64(1);
else
    bits = bitset(uint64(1), 64, 1);
end

y = typecast(bits, 'double');

end
