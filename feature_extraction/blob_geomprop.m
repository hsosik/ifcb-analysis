function [ target ] = blob_geomprop( target )
% given an image of a blob (i.e., a mask), return the geometric properties of connected components

prop_list = target.config.blob_props;

geomprops = regionprops(logical(target.img_blob), prop_list);

target = add_field(target, 'blob_props');
target.blob_props = merge_structs(target.blob_props, geomprops);

end

