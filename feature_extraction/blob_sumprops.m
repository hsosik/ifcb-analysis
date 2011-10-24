function [ target ] = blob_summprops( target )
% given geometric properties of connected components in a blob image,
% produce sums of selected properties (set in configure) to deal with cases
% with > 1 connected component in blob image
%Heidi M. Sosik, Woods Hole Oceanographic Institution
%October 2011, IFCB processing

fields = fieldnames(target.blob_props);
[~, ~, ind] = intersect(target.config.props2sum, fields);
for i = 1:length(ind),
    field = char(fields(ind(i)));
    sumfield = ['summed' field];
    target.blob_props.(sumfield) = sum(target.blob_props.(field));
end

end

