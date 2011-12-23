function [ target ] = image_HOG( target )
% takes gray scale image as input, returns vector of Histogram of Oriented Gradients (HOG) 
% feature descriptors stored in target structure
% Heidi M. Sosik, Woods Hole Oceanographic Institution, Oct 2011

target.image_props.HOG = HOG(target.image);

end

