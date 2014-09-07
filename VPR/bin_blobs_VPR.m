function [ ] = bin_blobs_VPR(binfullname, blob_out_path)
%function [ ] = bin_blobs_VPR(binfullname, blob_out_path)
% modeled from bin_blobs.m, with a few details for VPR application
% Heidi M. Sosik, Woods Hole Oceanographic Institution, September 2014

    if ~exist(blob_out_path, 'dir'),
        mkdir(blob_out_path)
    end;
    
   % [targets, imglist] = get_images_fromVPRhr(binfullname);
    imglist = dir(fullfile(binfullname, '*.tif'));
    imglist = {imglist.name};
    disp([binfullname '    producing & writing blobs...'])
    for ii = 1:length(imglist),
        target = {};
        % configure feature extraction
        target.config = configure();
        % get the image
        %target.image = targets(ii).image;
        fullimgname = char(fullfile(binfullname,imglist(ii)));
        target.image = imread(fullimgname);
        target.image = imcomplement(target.image); %reverse grayscale for VPR case
        %target.image = imcomplement(imread([png_path imglist{i}])); %read VPR roi and reverse grayscale
        % compute the blob mask (result in target.blob_image)
        target = blob(target);
        % now output the blob image as a 1-bit png
        imwrite(target.blob_image,fullfile(blob_out_path, regexprep(imglist{ii}, 'tif', 'png')),'bitdepth',1);
    end;
    disp([binfullname '    zipping blobs...'])
    zip(blob_out_path, '*', [blob_out_path filesep])
    rmdir(blob_out_path, 's')
end

