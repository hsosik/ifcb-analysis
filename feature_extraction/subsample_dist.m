function [ D ] = subsample_dist( points, max_n )
% Computes pairwise euclidean distances between points, but
% subsamples them up to a certain number of pairs (max_n)
if nargin < 2
    max_n = 10000;
end

n = size(points,2);
% now we need to sort pp
key = sum(points .* repmat([max(points(2,:)) 1]',[1 n]),1);
[~,six] = sort(key);
pp = points(:,six);
% now subsample it
m = min(n^2,max_n);
ix = simple_prng(n,[m 2]);
spp_a = pp(:,ix(:,1)+1);
spp_b = pp(:,ix(:,2)+1);

D = sqrt(sum((spp_a - spp_b).^2,1));

end

