function [ target ] = blob_rotate( target )
%function [ target ] = blob_rotate( target )
% take an input b&w blob image and rotate it to make the major axis of the
% largest blob horizontal
%Heidi M. Sosik, Woods Hole Oceanographic Institution
%November 2011, IFCB processing

persistent se2 se3; %structuring elemements for morphological processing

if isempty(se2)
    se2 = strel('disk',2);
end;

if isempty(se3)
    se3 = strel('disk',3);
end;

if target.blob_props.numBlobs > 0,
    geomprops = regionprops(logical(target.blob_image), 'Orientation');
    [~,ind] = sort([target.blob_props.Area], 'descend'); %if isempty(ind), pause, end; 
    ind = ind(1);
    theta = -1*geomprops(ind).Orientation;
    %    img3 = imrotate(img2, theta, 'bilinear', 'crop');
    img = imrotate(target.blob_image, theta, 'bilinear');
    img = imclose(img, se3);
    img = imdilate(img, se2);
    img = bwmorph(img, 'thin', 1);
%figure(1), subplot(2,2,1), imshow(target.blob_image)
%subplot(2,2,2), imshow(img), subplot(2,2,4), imshow(img2); subplot(2,2,3), imshow(target.image)
%pause
    target.blob_image_rotated = img;
else %empty blob image
    target.blob_image_rotated = target.blob_image;
end

