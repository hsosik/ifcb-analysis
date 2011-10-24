function [ target ] = blob_geomprop( target )
% given an image of a blob (i.e., a mask), return the geometric properties of connected components

prop_list = target.config.blob_props;

geomprops = regionprops(logical(target.blob_image), prop_list);

%FIX - merge_structs ignores any values after the first entry in geomprops
target.blob_props = merge_structs(target.blob_props, geomprops);

end

