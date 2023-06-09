function [ feature_mat , fea_titles ] = get_features_roilist_webservices( roilist_fullpath , fea2use)
% function [ feature_mat , fea_titles ] = get_features_roilist_webservices( roilist_fullpath )
%IFCB classifier production: get training features from pre-computed bin feature files accessible via web services
%input a cell array of ROI ids with full URL specified
%Heidi M. Sosik, Woods Hole Oceanographic Institution, April 2017
%
disp('Accessing features...please be patient')
feature_mat = NaN(length(roilist_fullpath), length(fea2use));
totaln = length(roilist_fullpath);
for count = 1:totaln
    if ~rem(count,100), disp([num2str(count) ' of ' num2str(totaln)]), end
    [ fea, titles ] = roi_features(roilist_fullpath{count}); %assume all have same fea_titles
    [~,ia] = intersect(titles, fea2use);
    feature_mat(count,:) = fea(ia);
end

end

