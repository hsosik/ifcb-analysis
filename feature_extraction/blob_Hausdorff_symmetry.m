function [ target ] = blob_Hausdorff_symmetry( target )
%function [ target ] = blob_rotate( target )
% take an input rotated (major axis horizontal) b&w blob image, center
% perimeter, then calculate Hausdorff distance, before and after rotation
% 90 degrees, 180 degrees, and flipped up/down
%Heidi M. Sosik, Woods Hole Oceanographic Institution
%November 2011, IFCB processing

if target.blob_props.numBlobs > 0,
    for i = 1:target.blob_props.numBlobs,
        img = target.rotated_blob_images{i};
        c = size(img) / 2; % assume center of image is centroid
        % find points on the boundary and center them
        perimeter_img = im2bw(conv2(img,[0 -1 0; -1 4 -1; 0 -1 0]));
        [y, x] = find(perimeter_img);
        % center and correct for 1-based indexing
        p = horzcat(y-c(1)-1,x-c(2)-1);
        p90 = [p(:,2), p(:,1)];
        p180 = -p;
        pfud = [-p(:,1) p(:,2)];
        hdfud = ModHausdorffDistMex(p,pfud);
        hd90 = ModHausdorffDistMex(p, p90);
        hd180 = ModHausdorffDistMex(p,p180);
        target.blob_props.H180(i) = hd180;
        target.blob_props.H90(i) = hd90;
        target.blob_props.Hflip(i) = hdfud;
    end;
else
    target.blob_props.Hflip = NaN;
    target.blob_props.H90 = NaN;
    target.blob_props.H180 = NaN;
end

