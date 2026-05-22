function D = bwdist_scipy(BW)
% bwdist_scipy  Euclidean distance transform matching SciPy distance_transform_edt.
%   D = bwdist_scipy(BW) computes the exact Euclidean distance transform
%   of a binary image BW (nonzero = foreground, zero = background),
%   using the Felzenszwalb & Huttenlocher algorithm (2004) with a
%   finite sentinel to match SciPy's feature-transform pipeline.
%
%   Output D is double, matching SciPy distance_transform_edt default dtype.

BW = BW ~= 0;

% f = 0 where BW is background (zeros), large elsewhere.
LARGE = 1.0e20;
f = LARGE * ones(size(BW), 'double');
f(BW == 0) = 0;

% First pass: along rows, store squared distances and nearest column indices.
[h, w] = size(f);
d = zeros(h, w, 'double');
idx_col = zeros(h, w, 'double');
for y = 1:h
    [d(y, :), idx_col(y, :)] = edt_1d(f(y, :)');
end

% Second pass: along columns, compute final squared distances.
D2 = zeros(h, w, 'double');
for x = 1:w
    [D2(:, x), ~] = edt_1d(d(:, x));
end

D = sqrt(D2);
end


function [d, idx] = edt_1d(f)
% edt_1d  One-dimensional squared distance transform with indices.
% Input f is a column vector with 0 at features, LARGE elsewhere.
% Output d is squared distance; idx is the nearest feature index.

f = double(f(:));
n = numel(f);
v = zeros(n, 1);
z = zeros(n + 1, 1);
idx = zeros(n, 1);
k = 1;
v(1) = 1;
z(1) = -inf;
z(2) = inf;

for q = 2:n
    s = ((f(q) + (q - 1)^2) - (f(v(k)) + (v(k) - 1)^2)) / (2 * (q - v(k)));
    while s <= z(k)
        if k == 1
            break;
        end
        k = k - 1;
        s = ((f(q) + (q - 1)^2) - (f(v(k)) + (v(k) - 1)^2)) / (2 * (q - v(k)));
    end
    k = k + 1;
    v(k) = q;
    z(k) = s;
    z(k + 1) = inf;
end

d = zeros(n, 1);
k = 1;
for q = 1:n
    while z(k + 1) < (q - 1)
        k = k + 1;
    end
    dq = (q - 1) - (v(k) - 1);
    d(q) = dq * dq + f(v(k));
    idx(q) = v(k);
end

end
