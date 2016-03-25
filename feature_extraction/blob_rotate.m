function [ target ] = blob_rotate( target )
% for each blob image in the target,
% take the image and transform it so that
% the blob's major axis is horizontal and the image is
% centered on the blob's centroid
%Heidi M. Sosik, Woods Hole Oceanographic Institution
%November 2011, IFCB processing

if target.blob_props.numBlobs > 0,
    for i = 1:target.blob_props.numBlobs,
        theta = -1*target.blob_props.Orientation(i);
        centered = center_blob(target.blob_images{i});
        rot = imrotate(centered,theta,'nearest','crop');
        target.rotated_blob_images{i}=rot;
    end;
else %empty blob image
    target.rotated_blob_images = {};
end

