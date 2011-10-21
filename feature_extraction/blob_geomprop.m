function [ geomprops ] = blob_geomprop( blob_image, prop_list)
% given an image of a blob (i.e., a mask), return the geometric properties of connected components

geomprops = regionprops(logical(blob_image), prop_list);

end

