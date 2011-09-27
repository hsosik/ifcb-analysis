function [ img ] = get_image( pid )
% given a PID such as
% http://ifcb-data.whoi.edu/IFCB1_2011_270_120600_00995,
% fetch the image.

img = imread([char(pid) '.png'], 'PNG');

end