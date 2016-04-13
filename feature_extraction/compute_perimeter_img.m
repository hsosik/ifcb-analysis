function [ perimeter_img ] = compute_perimeter_img( img )
%return 4-connected perimeter image for a B&W blob image
% done by convolving the image with this matrix
% |  0 -1  0 |
% | -1  4 -1 |
% |  0 -1  0 |
% and only keeping points for which the result is > 0

perimeter_img = im2bw(conv2(single(img),[0 -1 0; -1 4 -1; 0 -1 0], 'same'));

end

