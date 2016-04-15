function [ target ] = blob_geomprop( target )
% given an image of a blob (i.e., a mask), return the geometric properties of connected components

prop_list = target.config.blob_props;

geomprops = regionprops(logical(target.blob_image), [prop_list {'Image'}]);

%[~,ind] = sort([geomprops.FilledArea], 2,'descend');
[~,ind] = sort([geomprops.Area], 2,'descend');
if length(ind) > 1,
    geomprops = geomprops(ind); %sort largest to smallest
end;
target.blob_props.numBlobs = length(ind);
geomprops(1).Perimeter = 0; % initialize at zero
geomprops(1).ConvexPerimeter = 0; %initialize at zero
geomprops(1).ConvexArea = 0;
geomprops(1).Solidity = 0;
geomprops(1).maxFeretDiameter = 0; %initialize at zero
geomprops(1).minFeretDiameter = 0; %initialize at zero
target.blob_images = {}; %initialize at empty

if target.blob_props.numBlobs > 0,
    target.blob_images = {geomprops.Image};
    for count = 1:target.blob_props.numBlobs
        perimeter_img = compute_perimeter_img( target.blob_images{count} );
        geomprops(count).Perimeter = benkrid_perimeter(perimeter_img);
        target.blob_perimeter_images{count} = perimeter_img; 
        %d = (geomprops(count).ConvexHull(:,1:2))';
        %dd = dist(d);
        %geomprops(count).ConvexPerimeter = sum(diag(dd,1));
        % compute convex hull using delaunay triangulation
        [x, y] = find(perimeter_img);
        ch = delaunay_convex_hull(x, y);
        % compute perim and area of hull
        [conv_perim, conv_area] = convex_hull_properties(ch);
        geomprops(count).ConvexPerimeter = conv_perim;
        geomprops(count).ConvexArea = conv_area;
        % now we can compute solidity
        geomprops(count).Solidity = geomprops(count).Area / conv_area;
        % now compute min/max feret diameter from hull
        fd = hull_feret_diameter(ch,0:359);
        %[fd] = imFeretDiameter(target.blob_images{count},0:359);
        geomprops(count).maxFeretDiameter = max(fd);
        geomprops(count).minFeretDiameter = min(fd);
        % now compute the major and minor axis length, and eccentricity
        [X, Y] = find(target.blob_images{count});
        [~, m] = eig(cov(X,Y),'vector');
        L = 4 * sqrt(m);
        geomprops(count).MajorAxisLength = max(L);
        geomprops(count).MinorAxisLength = min(L);
        geomprops(count).Eccentricity = sqrt(1-(min(L)/max(L))^2);
    end;
end;
geomprops = rmfield(geomprops, 'Image');
%geomprops = rmfield(geomprops, 'ConvexHull');
s3 = target.blob_props;
fields = fieldnames(geomprops);
if target.blob_props.numBlobs == 0,
    for i = 1:length(fields),
        field = char(fields(i));
        s3.(field) = 0;
    end;
else
    for i = 1:length(fields),
        field = char(fields(i));
        s3.(field) = [geomprops.(field)];
    end;
end
if s3.numBlobs > 0, %change later to merge with above case for numBlobs > 0?
    temp = cat(1,geomprops.BoundingBox);
    s3.BoundingBox_xwidth = temp(:,3)';
    s3.BoundingBox_ywidth = temp(:,4)';
else
    s3.BoundingBox_xwidth = 0;
    s3.BoundingBox_ywidth = 0;
end;

if target.config.plot, %go to graphing routine if requested
    bb = geomprops.BoundingBox;
    subplot(5,1,1)
    plot([bb(1) bb(1) bb(1)+bb(3) bb(1)+bb(3) bb(1)], [bb(2) bb(2)+bb(4) bb(2)+bb(4) bb(2) bb(2)])
    pause
end;
s3 = rmfield(s3, 'BoundingBox');
target.blob_props = s3;

end
