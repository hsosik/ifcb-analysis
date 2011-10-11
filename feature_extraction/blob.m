function [ img_blob ] = blob( img )
% find a "blob" in the image and produce its mask. this can be further
% split if other downstream filters need e.g., the phasecong result
% JF
persistent se2 se3;

if isempty(se2)
    se2 = strel('disk',2);
end;

if isempty(se3)
    se3 = strel('disk',3);
end;

% FIXME magic numbers
[M m , ~, ~, ~, ~, ~] = phasecong3(img, 4, 6, 2, 2.5, 0.55, 2.0, 0.3, 5,-1);
% FIXME magic numbers
img_blob = hysthresh(M+m, 0.2, 0.1);
% omit spurious edges along margins
img_blob(1,img_blob(2,:)==0)=0;
img_blob(end,img_blob(end-1,:)==0)=0;
img_blob(img_blob(:,2)==0,1)=0;
img_blob(img_blob(:,end-1)==0,end)=0;
% now use kmean clustering approach to make sure dark areas are included
img_dark = kmean_segment(img);
img_blob(img_dark==1)=1;
% now apply some structuring morphs to fill in various gaps
img_blob = imclose(img_blob, se3);
img_blob = imdilate(img_blob, se2);
img_blob = bwmorph(img_blob, 'thin', 1);
img_blob = imfill(img_blob, 'holes');
    
end