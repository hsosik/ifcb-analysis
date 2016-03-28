function [ perimeter_img ] = compute_perimeter_img( img )
%return 4-connected perimeter image for a B&W blob image
%   Detailed explanation goes here

perimeter_img = im2bw(conv2(single(img),[0 -1 0; -1 4 -1; 0 -1 0]));

end

