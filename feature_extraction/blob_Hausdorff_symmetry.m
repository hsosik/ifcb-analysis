function [ target ] = blob_Hausdorff_symmetry( target )
%function [ target ] = blob_rotate( target )
% take an input rotated (major axis horizontal) b&w blob image, center
% perimeter, then calculate Hausdorff distance, before and after rotation
% 90 degrees, 180 degrees, and flipped up/down
%Heidi M. Sosik, Woods Hole Oceanographic Institution
%November 2011, IFCB processing

if target.blob_props.numBlobs > 0,
    %perimeter = bwboundaries(target.blob_image_rotated, 'noholes');
    img = target.blob_image_rotated;
    gprops = regionprops(img, 'Centroid', 'Area');
%    if size(gprops) ~= target.blob_props.numBlobs, keyboard, end;
    [~,ind] = sort([gprops.Area], 'descend'); ind = ind(1); %find largest blob
    gprops = gprops(ind);
    p = bwboundaries(img, 'noholes'); 
    c =repmat(fliplr(gprops.Centroid),size(p{ind},1),1); p = p{ind}-c;
    p90 = [p(:,2), p(:,1)];
    p180 = -p;;
    pfud = [-p(:,1) p(:,2)];
    %figure(1), clf
    %plot(p(:,1), p(:,2), '.')
    %hold on
    %plot(pfud(:,1), pfud(:,2), 'r.')
    %plot(p90(:,1), p90(:,2), 'g.')
    %plot(p180(:,1), p180(:,2), 'm.')
    hdfud = ModHausdorffDistMex(p,pfud);
    hd90 = ModHausdorffDistMex(p, p90);
    hd180 = ModHausdorffDistMex(p,p180);
    %%[hdfud hd90 hd180]
	target.blob_props.Hflip = hdfud;
    target.blob_props.H90 = hd90;
    target.blob_props.H180 = hd180;
else
    target.blob_props.Hflip = NaN;
    target.blob_props.H90 = NaN;
    target.blob_props.H180 = NaN;
end

