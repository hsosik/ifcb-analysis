function [  ] = view_rois( roilist )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
urlbase = 'http://ifcb-data.whoi.edu/mvco/';
subnum = 0;
max2get = 10;
nummax = min([max2get*2, length(roilist)]);
[ images, imglist ] = get_images_fromlist( urlbase, roilist(1:nummax), max2get );
for subnum = 1:length(images),
    subplot(max2get/2,2,subnum)
    imshow(images{subnum}), title(imglist(subnum), 'interpreter', 'none')
end;
for num = (max2get+1):10:length(roilist),
    nummax = min([num+max2get*2, length(roilist)]);
    list = roilist(num:nummax); %pass in 20 expecting at least 10 will be readable
    [ images, imglist ] = get_images_fromlist( urlbase, list, max2get );
    pause
    clf
    for subnum = 1:length(images),
        subplot(max2get/2,2,subnum)
        imshow(images{subnum}), title(imglist(subnum), 'interpreter', 'none')
    end;
end;
end

% urlbase = 'http://ifcb-data.whoi.edu/mvco/';
% subnum = 0;
% for num = 1:length(roilist),
%     subnum = subnum + 1;
%     subplot(5,2,subnum)
%     imgflag = 1;
%     try 
%         img = imread([urlbase roilist{num} '.png']);
%     catch err
%        disp([urlbase roilist{num} '.png unreadable'])
%        imgflag = 0;
%        subnum = subnum - 1;
%     end;
%     if imgflag,
%         imshow(img), title(roilist(num), 'interpreter', 'none')
%         if subnum == 10,
%             pause
%             clf
%             subnum = 0;
%         end;
%     end;
% end;
% end
% 
