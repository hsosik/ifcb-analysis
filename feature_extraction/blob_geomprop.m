function [ target ] = blob_geomprop( target )
% Given an image of a blob mask, return geometric properties of components.
% This override keeps Heidi's geometry path but replaces regionprops
% Orientation with explicit_orientation() so MATLAB/Python use the same
% deterministic angle for blob rotation and feature output.

prop_list = target.config.blob_props;

geomprops = regionprops(logical(target.blob_image), [prop_list {'Image'}]);

[~,ind] = sort([geomprops.Area], 2,'descend');
if length(ind) > 1
    geomprops = geomprops(ind);
end
target.blob_props.numBlobs = length(ind);
geomprops(1).Perimeter = 0;
geomprops(1).ConvexPerimeter = 0;
geomprops(1).ConvexArea = 0;
geomprops(1).Solidity = 0;
geomprops(1).maxFeretDiameter = 0;
geomprops(1).minFeretDiameter = 0;
target.blob_images = {};

if target.blob_props.numBlobs > 0
    target.blob_images = {geomprops.Image};
    for count = 1:target.blob_props.numBlobs
        % Replace MATLAB regionprops Orientation with deterministic explicit
        % moment orientation before downstream blob_rotate uses it.
        geomprops(count).Orientation = explicit_orientation(target.blob_images{count});

        perimeter_img = compute_perimeter_img( target.blob_images{count} );
        geomprops(count).Perimeter = benkrid_perimeter(perimeter_img);
        target.blob_perimeter_images{count} = perimeter_img;
        [x, y] = find(perimeter_img);
        try
            ch = delaunay_convex_hull(x, y);
            [conv_perim, conv_area] = convex_hull_properties(ch);
            geomprops(count).ConvexPerimeter = conv_perim;
            geomprops(count).ConvexArea = conv_area;
        catch
            r = corrcoef(x,y);
            if r(2,2) == 1
                geomprops(count).ConvexPerimeter = geomprops(count).Perimeter;
                geomprops(count).ConvexArea = geomprops(count).Area;
                ch = [x(:) y(:)];
            else
                disp('unexpected problem with convex hull computation')
                keyboard
            end
        end
        geomprops(count).Solidity = geomprops(count).Area / geomprops(count).ConvexArea;
        fd = hull_feret_diameter(ch,0:359);
        geomprops(count).maxFeretDiameter = max(fd);
        geomprops(count).minFeretDiameter = min(fd);
        [X, Y] = find(target.blob_images{count});
        [~, m] = eig(cov(X,Y),'vector');
        L = 4 * sqrt(m);
        geomprops(count).MajorAxisLength = max(L);
        geomprops(count).MinorAxisLength = min(L);
        geomprops(count).Eccentricity = sqrt(1-(min(L)/max(L))^2);
    end
end
geomprops = rmfield(geomprops, 'Image');
s3 = target.blob_props;
fields = fieldnames(geomprops);
if target.blob_props.numBlobs == 0
    for i = 1:length(fields)
        field = char(fields(i));
        s3.(field) = 0;
    end
else
    for i = 1:length(fields)
        field = char(fields(i));
        s3.(field) = [geomprops.(field)];
    end
end
if s3.numBlobs > 0
    temp = cat(1,geomprops.BoundingBox);
    s3.BoundingBox_xwidth = temp(:,3)';
    s3.BoundingBox_ywidth = temp(:,4)';
else
    s3.BoundingBox_xwidth = 0;
    s3.BoundingBox_ywidth = 0;
end

if target.config.plot
    bb = geomprops.BoundingBox;
    subplot(5,1,1)
    plot([bb(1) bb(1) bb(1)+bb(3) bb(1)+bb(3) bb(1)], [bb(2) bb(2)+bb(4) bb(2)+bb(4) bb(2) bb(2)])
    pause
end
s3 = rmfield(s3, 'BoundingBox');
target.blob_props = s3;

end
