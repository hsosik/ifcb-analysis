function [ target ] = blob_shapehist_stats( target )
% function [ target ] = blob_shapehist_stats( target )
% given blob mask, return statistics of all possible Euclidean distances between points on perimeter(s); 
% distances first normalized by equivalent spherical diameter of blob;  
% stats computed and returned in shapehist fields of target: mean, mode, median, skewness, and kurtosis
% Heidi M. Sosik, Woods Hole Oceanographic Institution, Oct 2011

%if ~exist(target.perimeter_xy), 
    perimeter = bwboundaries(target.blob_image, 'noholes');
%end;
target.perimeter_xy = perimeter;
if isempty(perimeter),
    target.blob_props.shapehist_mean_normEqD = 0;
    target.blob_props.shapehist_mode_normEqD = 0;
    target.blob_props.shapehist_median_normEqD = 0;
    target.blob_props.shapehist_skewness_normEqD = 0;
    target.blob_props.shapehist_kurtosis_normEqD = 0;
end;
for idx = 1:length(perimeter),
    d = dist(perimeter{idx}'); d = d(:);
    dnorm = d./target.blob_props.EquivDiameter(idx);
    target.blob_props.shapehist_mean_normEqD(idx) = mean(dnorm);
    target.blob_props.shapehist_mode_normEqD(idx) = mode(dnorm);
    target.blob_props.shapehist_median_normEqD(idx) = median(dnorm);
    target.blob_props.shapehist_skewness_normEqD(idx) = skewness(dnorm);
    target.blob_props.shapehist_kurtosis_normEqD(idx) = kurtosis(dnorm);
end;
end