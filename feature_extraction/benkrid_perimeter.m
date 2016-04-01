function [ perimeter ] = benkrid_perimeter( border_image )
% perimeter estimation based on
% K. Benkrid, D. Crookes. Design and FPGA Implementation of
% a Perimeter Estimator. The Queen's University of Belfast.
% http://www.cs.qub.ac.uk/~d.crookes/webpubs/papers/perimeter.doc
%
% border_image should be a logical image where the pixels
% along the border are 1 and all other pixels are 0

weights = zeros([50 1]);

weights([5 7 15 17 25 27]+1) = 1;
weights([21 33]+1) = sqrt(2);
weights([13 23]+1) = (1 + sqrt(2)) / 2;

coded_image = conv2(single(border_image),[10 2 10; 2 1 2; 10 2 10]);

weighted_coded_image = weights(coded_image+1);

perimeter = sum(weighted_coded_image(:));

end

