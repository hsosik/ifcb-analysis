function [ target ] = blob_rotate( target )
% Rotate each blob using deterministic orientation and crop-rotation code.

if target.blob_props.numBlobs > 0
    for i = 1:target.blob_props.numBlobs
        orientation = explicit_orientation(target.blob_images{i});
        target.blob_props.Orientation(i) = orientation;
        centered = center_blob(target.blob_images{i});
        rot = imrotate_nearest_crop_explicit(centered, orientation);
        target.rotated_blob_images{i}=rot;
    end
else
    target.rotated_blob_images = {};
end

end
