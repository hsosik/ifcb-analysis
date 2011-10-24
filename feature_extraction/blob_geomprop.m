function [ target ] = blob_geomprop( target )
% given an image of a blob (i.e., a mask), return the geometric properties of connected components

prop_list = target.config.blob_props;

geomprops = regionprops(logical(target.blob_image), prop_list);

%FIX - merge_structs ignores any values after the first entry in geomprops
%target.blob_props = merge_structs(target.blob_props, geomprops);

%below: Heidi's variant of merge_structs to handle vector field entries,

s3 = target.blob_props;
fields = fieldnames(geomprops);
for i = 1:length(fields),
    field = char(fields(i));
    s3.(field) = [geomprops.(field)];
%next loop = addition of relevant property sums
%    if ismember(field, target.config.props2sum),
%       sumfield = ['summed' field];
%       s3.(sumfield) = sum(s3.(field));
%    end;
end
target.blob_props = s3;

end

