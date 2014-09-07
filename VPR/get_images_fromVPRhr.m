function [ targets, imglist ] = get_images_fromVPRhr( binfullname )
%function [ targets, imglist ] = get_images_fromVPRhr( binfullname )
%read a folder of VPR tiff images into the targets structure 
% Heidi M. Sosik, Woods Hole Oceanographic Institution, September 2014

imglist = dir(fullfile(binfullname, '*.tif'));
imglist = {imglist.name};
for ii = 1:length(imglist)
    fullimgname = char(fullfile(binfullname,imglist(ii)));
    targets(ii).image = imread(fullimgname);
end;

end
