function [ target ] = blob_texture( target )
% given blob mask and original gray scale image, return statistical texture 
% properties of grayscale pixels inside blobs
% from DIPUM function stattxture (http://www.imageprocessingplace.com/)
% Heidi M. Sosik, Woods Hole Oceanographic Institution, Oct 2011

%texture = statxture(target.image(find(target.blob_image)));
img_adjusted = imadjust(target.image);
texture = statxture(img_adjusted(find(target.blob_image)));

target.blob_props.texture_average_gray_level = texture(1);
target.blob_props.texture_average_contrast = texture(2);
target.blob_props.texture_smoothness = texture(3);
target.blob_props.texture_third_moment = texture(4);
target.blob_props.texture_uniformity = texture(5);
target.blob_props.texture_entropy = texture(6);

end

