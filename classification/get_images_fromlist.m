function [ images , imglist] = get_images_fromlist( path, roilist, max2get )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
numgot = 0;
num = 0;
while numgot < max2get && num < length(roilist),
%for num = 1:length(roilist)
    num = num + 1;
    numgot = numgot + 1;
    try 
        images{numgot} = imread([path roilist{num} '.png']);
        imglist(numgot) = roilist(num);
    catch err
       disp([path roilist{num} '.png unreadable'])
       numgot = numgot - 1;
    end;
end;
end

