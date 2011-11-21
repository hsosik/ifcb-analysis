function [ target ] = blob_geomprop( target )
% given an image of a blob (i.e., a mask), return the geometric properties of connected components

prop_list = target.config.blob_props;

geomprops = regionprops(logical(target.blob_image), prop_list);
[~,ind] = sort([geomprops.FilledArea], 2,'descend');
if length(ind) > 1,
    geomprops = geomprops(ind); %sort largest to smallest
    target.blob_props.Area = target.blob_props.Area(ind);
end;
%below: Heidi's variant of merge_structs to handle vector field entries,
s3 = target.blob_props;
fields = fieldnames(geomprops);
for i = 1:length(fields),
    field = char(fields(i));
    s3.(field) = [geomprops.(field)];
end
if s3.numBlobs > 0,
    temp = cat(1,geomprops.BoundingBox);
    s3.BoundingBox_xwidth = temp(:,3)';
    s3.BoundingBox_ywidth = temp(:,4)';
else
    s3.BoundingBox_xwidth = 0;
    s3.BoundingBox_ywidth = 0;
end;
s3 = rmfield(s3, 'BoundingBox');
target.blob_props = s3;

if target.config.plot, %go to graphing routine if requested
    bb = target.blob_props.BoundingBox;
    subplot(5,1,1)
    plot([bb(1) bb(1) bb(1)+bb(3) bb(1)+bb(3) bb(1)], [bb(2) bb(2)+bb(4) bb(2)+bb(4) bb(2) bb(2)])
    pause
end;
%target.blob_props = rmfield(target.blob_props, 'BoundingBox');

end

