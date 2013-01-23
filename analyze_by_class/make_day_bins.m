function [matdate_bin, classcount_bin, ml_analyzed_mat_bin] = make_day_bins(matdate,classcount, ml_analyzed_mat)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

matdate_day = floor(matdate);
matdate_bin = unique(floor(matdate_day));
classcount_bin = NaN(length(matdate_bin),size(classcount,2));
ml_analyzed_mat_bin = classcount_bin;
for count = 1:length(matdate_bin),
    idx = find(matdate_day == matdate_bin(count));
    if ~isempty(idx),
        temp = classcount(idx,:);
        temp(isnan(ml_analyzed_mat(idx,:))) = NaN;
        %classcount_bin(count,:) = nansum(classcount(idx,:),1);
        classcount_bin(count,:) = nansum(temp,1);
        ml_analyzed_mat_bin(count,:) = nansum(ml_analyzed_mat(idx,:),1);
    end;
end;
%no zeros mls should exist, zeros arise from nansum of all NaNs, set them
%back to NaN; do the same for cellcounts
%classcount_bin((ml_analyzed_mat_bin==0)) = NaN;
ml_analyzed_mat_bin((ml_analyzed_mat_bin==0)) = NaN;

end

