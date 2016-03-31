function [ target ] = blob_rotated_geomprop( target )
% given a rotated blob image, return a few geometric properties of the largest connected component

prop_list = {'BoundingBox' 'Area'};
target.blob_props.RotatedBoundingBox_xwidth = zeros(1,max(1,target.blob_props.numBlobs));
target.blob_props.RotatedBoundingBox_ywidth = target.blob_props.RotatedBoundingBox_xwidth;
target.blob_props.rotated_BoundingBox_solidity = target.blob_props.RotatedBoundingBox_xwidth;

for idx = 1:target.blob_props.numBlobs,
    %input to region props as label image (single blob labeled as 1s), not input as logical (since possible to get split blobs after rotation)
    geomprops = regionprops(target.rotated_blob_images{idx}, prop_list);  
    target.blob_props.RotatedBoundingBox_xwidth(idx) = geomprops.BoundingBox(3);
    target.blob_props.RotatedBoundingBox_ywidth(idx) = geomprops.BoundingBox(4);
    target.blob_props.rotated_BoundingBox_solidity(idx) = geomprops.Area./(geomprops.BoundingBox(3)*geomprops.BoundingBox(4));
end;

end

