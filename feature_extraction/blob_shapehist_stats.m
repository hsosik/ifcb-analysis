function [ target ] = blob_shapehist_stats( target )
% function [ target ] = blob_shapehist_stats( target )
% given blob mask, return statistics of all possible Euclidean distances between points on perimeter(s); 
% distances first normalized by equivalent spherical diameter of blob;  
% stats computed and returned in shapehist fields of target: mean, mode, median, skewness, and kurtosis
% Heidi M. Sosik, Woods Hole Oceanographic Institution, Oct 2011


%perimeter = bwboundaries(target.blob_image, 'noholes');
%target.perimeter_xy = perimeter;
if isempty(target.blob_images),
    target.blob_props.shapehist_mean_normEqD = 0;
    target.blob_props.shapehist_median_normEqD = 0;
    target.blob_props.shapehist_skewness_normEqD = 0;
    target.blob_props.shapehist_kurtosis_normEqD = 0;
else
    for idx = 1:length(target.blob_images),
        [x, y] = find(target.blob_perimeter_images{idx});
        d = subsample_dist(horzcat(x,y)');
        dnorm = d./target.blob_props.EquivDiameter(idx);
        target.blob_props.shapehist_mean_normEqD(idx) = mean(dnorm);
        target.blob_props.shapehist_median_normEqD(idx) = median(dnorm);
        target.blob_props.shapehist_skewness_normEqD(idx) = skewness(dnorm);
        target.blob_props.shapehist_kurtosis_normEqD(idx) = kurtosis(dnorm);
    end;
end;
end