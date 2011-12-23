function [ target ] = blob_rotated_geomprop( target )
% given a rotated blob image of a blob, return a few geometric properties of connected components

%prop_list = target.config.blob_props;
prop_list = {'BoundingBox', 'Area'};

geomprops = regionprops(logical(target.blob_image_rotated), prop_list);
[~,ind] = sort([geomprops.Area], 2,'descend');
if length(ind) > 1,
    geomprops = geomprops(ind); %sort largest to smallest
end;
target.blob_props.RotatedArea = [geomprops.Area];
if isempty(target.blob_props.RotatedArea), 
    target.blob_props.RotatedArea = 0; %init in case no blobs
end;
if target.blob_props.numBlobs > 0,
    temp = cat(1,geomprops.BoundingBox);
    target.blob_props.RotatedBoundingBox_xwidth = temp(:,3)';
    target.blob_props.RotatedBoundingBox_ywidth = temp(:,4)';
else
    target.blob_props.RotatedBoundingBox_xwidth = 0;
    target.blob_props.RotatedBoundingBox_ywidth = 0;
end;

end

