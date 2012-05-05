function [ feature_mat, featitles ] = add_derived_features( feature_mat, featitles)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

a = strmatch('Area', featitles, 'exact'); b = strmatch('Perimeter', featitles, 'exact'); 
feature_mat = [feature_mat; feature_mat(a,:)./feature_mat(b,:).^2; feature_mat(a,:)./feature_mat(b,:)]; %A/P^2 compactness or circularity index; A/P roundness index
featitles = [featitles; 'Area/Perimeter^2'; 'Area/Perimeter'];

a = strmatch('Hflip', featitles, 'exact'); b = strmatch('H90', featitles, 'exact'); c = strmatch('H180', featitles, 'exact'); 
feature_mat = [feature_mat; feature_mat(b,:)./feature_mat(a,:); feature_mat(b,:)./feature_mat(c,:); feature_mat(a,:)./feature_mat(c,:)]; %A/P^2 compactness or circularity index; A/P roundness index
featitles = [featitles; 'H90/Hflip'; 'H90/H180'; 'Hflip/H180'];

a = strmatch('summedConvexPerimeter', featitles, 'exact'); b = strmatch('summedPerimeter', featitles, 'exact'); 
feature_mat = [feature_mat; feature_mat(a,:)./feature_mat(b,:)]; 
featitles = [featitles; 'summedConvexPerimeter/Perimeter'];

a = strmatch('RotatedBoundingBox_xwidth', featitles, 'exact'); b = strmatch('RotatedBoundingBox_ywidth', featitles, 'exact'); c = strmatch('RotatedArea', featitles, 'exact'); 
feature_mat = [feature_mat; feature_mat(c,:)./(feature_mat(a,:).*feature_mat(b,:))]; %solidity of rotated bounding box
featitles = [featitles; 'rotated BoundingBox solidity'];

end

