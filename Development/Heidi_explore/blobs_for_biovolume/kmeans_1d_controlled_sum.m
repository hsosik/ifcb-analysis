function [idx, C, sumD, D] = kmeans_1d_controlled_sum(X, k, varargin)
%KMEANS_1D_CONTROLLED_SUM Minimal kmeans clone for Heidi's blob segmentation.
%
% This intentionally implements only the call used by kmean_segment:
%
%   kmeans_1d_controlled_sum(img(:), 2, 'emptyaction', 'singleton', ...
%       'Start', [0 1]')
%
% It follows MATLAB kmeans' batch update path for one-dimensional,
% single-replicate, sqeuclidean clustering with OnlinePhase off. The places
% where MATLAB delegates to built-in summation are replaced by explicit
% left-to-right single-precision accumulators.

if nargin < 2 || k ~= 2
    error('kmeans_1d_controlled_sum:UnsupportedK', ...
        'Only k=2 is supported.');
end

start = single([0; 1]);
emptyact = 'singleton';
maxit = 100;

i = 1;
while i <= numel(varargin)
    name = lower(char(varargin{i}));
    if i == numel(varargin)
        error('kmeans_1d_controlled_sum:BadArguments', ...
            'Name/value arguments must be paired.');
    end
    value = varargin{i + 1};
    switch name
        case 'start'
            start = single(value(:));
        case 'emptyaction'
            emptyact = lower(char(value));
        case 'maxiter'
            maxit = double(value);
        case 'onlinephase'
            if ~strcmpi(char(value), 'off')
                error('kmeans_1d_controlled_sum:UnsupportedOnlinePhase', ...
                    'Only OnlinePhase off is supported.');
            end
        case 'distance'
            if ~strcmpi(char(value), 'sqeuclidean')
                error('kmeans_1d_controlled_sum:UnsupportedDistance', ...
                    'Only sqeuclidean distance is supported.');
            end
        otherwise
            error('kmeans_1d_controlled_sum:UnsupportedArgument', ...
                'Unsupported argument: %s', name);
    end
    i = i + 2;
end

if numel(start) ~= k
    error('kmeans_1d_controlled_sum:BadStart', ...
        'Start must contain exactly k one-dimensional centers.');
end
if ~strcmp(emptyact, 'singleton')
    error('kmeans_1d_controlled_sum:UnsupportedEmptyAction', ...
        'Only EmptyAction singleton is supported.');
end

values = single(X(:));
n = numel(values);
if n < k
    error('kmeans_1d_controlled_sum:TooFewPoints', ...
        'X must contain at least k points.');
end

C = single(start(:));
D = zeros(n, k, 'like', values);
for c = 1:k
    D(:, c) = distance_to_center(values, C(c));
end
[~, idx] = min(D, [], 2);
m = initial_counts(idx, k);

changed = 1:k;
previdx = zeros(n, 1);
prevtotsumD = Inf;
iter = 0;

while true
    iter = iter + 1;

    for c = changed
        [C(c), m(c)] = centroid_for_cluster(values, idx, c);
    end

    for c = changed
        D(:, c) = distance_to_center(values, C(c));
    end

    empties = changed(m(changed) == 0);
    if ~isempty(empties)
        for c = empties
            d = assigned_distances(D, idx);
            [~, lonely] = max(d);
            from = idx(lonely);

            if m(from) < 2
                from = find(m > 1, 1, 'first');
                if isempty(from)
                    error('kmeans_1d_controlled_sum:NoDonorCluster', ...
                        'Could not find a non-singleton donor cluster.');
                end
                lonely = find(idx == from, 1, 'first');
            end

            C(c) = values(lonely);
            m(c) = 1;
            idx(lonely) = c;
            m(from) = m(from) - 1;
            D(:, c) = distance_to_center(values, C(c));

            [C(from), m(from)] = centroid_for_cluster(values, idx, from);
            D(:, from) = distance_to_center(values, C(from));
            changed = unique([changed from]);
        end
    end

    totsumD = controlled_assigned_total(D, idx);
    if prevtotsumD <= totsumD
        idx = previdx;
        for c = changed
            [C(c), m(c)] = centroid_for_cluster(values, idx, c);
        end
        iter = iter - 1; %#ok<NASGU>
        break;
    end

    if iter >= maxit
        break;
    end

    previdx = idx;
    prevtotsumD = totsumD;
    [d, nidx] = min(D, [], 2);

    moved = find(nidx ~= previdx);
    if ~isempty(moved)
        keep = false(size(moved));
        for ii = 1:numel(moved)
            point = moved(ii);
            keep(ii) = D(point, previdx(point)) > d(point);
        end
        moved = moved(keep);
    end

    if isempty(moved)
        break;
    end

    idx(moved) = nidx(moved);
    changed = unique([idx(moved); previdx(moved)])';
end

nonempties = find(m > 0);
for c = nonempties
    D(:, c) = distance_to_center(values, C(c));
end
sumD = controlled_cluster_totals(D, idx, k);
end


function m = initial_counts(idx, k)
m = zeros(1, k);
for i = 1:numel(idx)
    m(idx(i)) = m(idx(i)) + 1;
end
end


function [center, count_double] = centroid_for_cluster(values, idx, cluster)
total = single(0);
count_single = single(0);
for i = 1:numel(values)
    if idx(i) == cluster
        total = single(total + values(i));
        count_single = single(count_single + single(1));
    end
end

count_double = double(count_single);
if count_double > 0
    center = single(total / count_single);
else
    center = single(NaN);
end
end


function d = distance_to_center(values, center)
d = zeros(numel(values), 1, 'like', values);
for i = 1:numel(values)
    delta = values(i) - center;
    d(i) = single(delta * delta);
end
end


function d = assigned_distances(D, idx)
n = numel(idx);
d = zeros(n, 1, 'like', D);
for i = 1:n
    d(i) = D(i, idx(i));
end
end


function total = controlled_assigned_total(D, idx)
total = single(0);
for i = 1:numel(idx)
    total = single(total + D(i, idx(i)));
end
end


function totals = controlled_cluster_totals(D, idx, k)
totals = zeros(k, 1, 'like', D);
for i = 1:numel(idx)
    c = idx(i);
    totals(c) = single(totals(c) + D(i, c));
end
end
