function [ scale_bar_image ] = make_scale_bar( pixel_per_micron, bar_length_micron, bar_height_micron )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

scale_bar_image = zeros(round(pixel_per_micron*bar_height_micron),round(pixel_per_micron*bar_length_micron)); %black bar
%imwrite(img_bar, 'my_scale_bar.png','png');

end

