function [pooled_ct, pooled_meta, clust_key1, clust_key_mod] = pool_underway_geocluster2(counts, vol, ...
    lat, lon, distthresh, centdistthresh, volthresh)
% D. Catlett 2022 - aggregates NES broadscale data spatially using a
% hierarchical clustering procedure based on geographic distances between
% ifcb samples. Goal is to smooth data for inspection of large-scale
% abundance, etc distributions
% this is the same as pool_underway_geocluster.m but uses a modified
% posthoc cluster merging procedure. When it encounters a cluster with a
% volume sampled < volthresh, rather than merge the cluster with the
% nearest cluster, it merges with the cluster with centroid within
% centdistthresh with the smallest volume sampled. The goal is to make
% each cluster/pool have more similar sampling effort. 
% (1) computes a pairwise great-circle-distance matrix between each
% discrete sample
% (2) places samples into geographic clusters using the 'average' linkage 
% method (see MATLAB's built-in linkage function for details) and the
% distthresh input argument
% (3) attempts to merge geographic clusters from (2) so that a minimum of
% volthresh volume has been sampled, under the constraint that clusters
% with centroids > centdistthresh km apart are not merged
% 
% INPUTS:
% (1) counts = count vector or matrix
% (2) vol = volume sampled
% (3) lat = latitude sampled
% (4) lon = longitude sampled
% (5) distthresh = distance threshold (km) for initial cluster generation
% (6) centdistthresh = distance threshold (km) for post-cluster merging
% (7) volthresh = volume threshold (ml) that the post-cluster merging
% attempts to satisfy for all clusters
% 
% OUTPUTS: 
% (1) pooled_ct = vector or matrix of pooled counts
% (2) pooled_meta = avg values of meta-data for pooled counts provided in a
% table array
% (3) clust_key1 = a numeric vector with corresponding cluster id's
% for each sample generated from the initial geographic clustering 
% (4) clust_key_mod = a numeric vector with corresponding cluster id's for
% each sample after both clustering and post-cluster merging

ddmat = nan(length(lat));
for i = 1:length(lat)
    ddmat(i,:) = deg2km(distance(lat(i), lon(i), lat, lon));
end

ddmat = squareform(ddmat);
ll = linkage(ddmat, 'average');
cs = cluster(ll, 'cutoff', distthresh, 'criterion', 'distance');
clust_key1 = cs;

[clust_lat, clust_lon] = splitapply(@meanm, lat, lon, cs);
clust_vol = splitapply(@sum, vol, cs);
for i = 1:size(counts,2)
    clust_ct(:,i) = splitapply(@sum, counts(:,i), cs);
end
clust_id = unique(cs); % output of split apply is in sorted group var order

% calculate a cluster-cluster distance matrix:
clust_ddmat = nan(length(clust_lat));
for i = 1:length(clust_lat)
    clust_ddmat(i,:) = deg2km(distance(clust_lat(i), clust_lon(i), clust_lat, clust_lon));
end

try2merge = find(clust_vol < volthresh); % cluster ids/indices to merge
while ~isempty(try2merge)
    disp('merging cluster countdown. done in...')
    disp(length(try2merge))
%     if length(try2merge) <= 2
%         disp('error around here');
%     end

    % extract the first one that doesn't satisfy the volume threshold.
    idx = try2merge(1);
    dd = clust_ddmat(idx,:);
    dd(idx) = Inf; % so you don't merge with itself

    if min(dd) > centdistthresh
        % can't merge, do nothing and continue looping
        try2merge(1) = [];
    else
        % find the closest centroid(s) that will allow you to satisfy the
        % volume threshold:
        dd(dd > centdistthresh) = nan; % set too-far points to nan
        tmpv = clust_vol; tmpv(isnan(dd)) = inf; % set too-far points to inf so you can get min excluding them
        merge_idx = [idx, find(tmpv == min(tmpv),1)]; 
        clustids2merge = clust_id(merge_idx); % original samples to combine into this cluster
        subber = min(clustids2merge);
        cs(ismember(cs, clustids2merge)) = subber;
    
        % reset other cluster ids to go 1:N:
        cs(cs > max(clustids2merge)) = cs(cs > max(clustids2merge)) - 1;
        
        % re-do the calculations on the new merged clusters:
        [clust_lat, clust_lon] = splitapply(@meanm, lat, lon, cs);
        clust_vol = splitapply(@sum, vol, cs);
        clust_ct = nan(length(clust_vol), size(clust_ct,2));
        for i = 1:size(counts,2)
            clust_ct(:,i) = splitapply(@sum, counts(:,i), cs);
        end
        clust_id = unique(cs); % output of split apply is in sorted group var order
        
        % you need to manipulate try2merge again to:
        % (1) remove max(merge_idx) if found in try2merge since it no longer 
        % exists as a cluster
        if ismember(max(clustids2merge), try2merge) 
            try2merge(try2merge == max(clustids2merge)) = [];
        end
        % (2) check again if try2merge(1) satisfies volthresh. If so
        % remove, if not keep it in so it remerges on the next iteration
        if ~isempty(try2merge) 

            % (3) adjust try2merge values larger than max(clustids2merge) to
            % match your new clust_id and cs array
            try2merge(try2merge > max(clustids2merge)) = try2merge(try2merge > max(clustids2merge)) - 1;
        
            if clust_vol(try2merge(1)) > volthresh 
                try2merge(1) = [];
            end
            
        end
        % calculate a cluster-cluster distance matrix:
        clust_ddmat = nan(length(clust_lat));
        for i = 1:length(clust_lat)
            clust_ddmat(i,:) = deg2km(distance(clust_lat(i), clust_lon(i), clust_lat, clust_lon));
        end
        
    end

end

vol_flag = clust_vol < volthresh;
pooled_meta = table(clust_lat, clust_lon, clust_vol, vol_flag, ...
    'VariableNames', {'latitude', 'longitude', 'volume', 'volume_flag'});
pooled_ct = clust_ct;
clust_key_mod = cs;

end