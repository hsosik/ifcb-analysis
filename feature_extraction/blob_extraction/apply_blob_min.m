function [ target ] = apply_blob_min( target )
%function  [ target ] = apply_blob_min( target )
% take an input b&w blob image, remove any continguous components <
% blob_min, and return the resulting blob image along with the summed area
% of the remaining components 
%Heidi M. Sosik, Woods Hole Oceanographic Institution
%October 2011, IFCB processing

blob_min = target.config.blob_min;
img_cc = bwconncomp(target.blob_image);
t = regionprops(img_cc, 'Area');
idx = find([t.Area] > blob_min);
target.blob_image = ismember(labelmatrix(img_cc), idx); %is this most efficient method?
if ~isempty(idx),
    target.blob_props.Area = [t(idx).Area];
else
    target.blob_props.Area = 0;
end;
target.blob_props.numBlobs = length(idx);
end

