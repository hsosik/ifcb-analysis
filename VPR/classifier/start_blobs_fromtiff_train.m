%start_blobs_fromtiff_train.m
%configure and initiate batch processing for blob extractiom
%VPR case
%Heidi M. Sosik, Woods Hole Oceanographic Institution, September 2014

in_dir= '\\maddie\work\VPR\vpr3\classifier\trrois_VPR4Edit\'; %USER 
out_dir = '\\maddie\work\VPR\vpr3\classifier\blobs\'; %USER main blob output location

bins = dir([in_dir]);
bins = {bins.name}; 
bins = bins(3:end);
%bins = regexprep({bins.name}', '.adc', '');

for bincount = 1:length(bins),
    disp(bins{bincount})
    img_path = [in_dir bins{bincount}  filesep];
    blob_path = [out_dir bins{bincount}  filesep];
    if ~exist(blob_path, 'dir'),
        mkdir(blob_path)
    end;
    imglist = dir([img_path '*.tif']);
    imglist = {imglist.name};
    %[targets, imglist] = get_images_fromROI([in_dir bins{bincount} '.roi']);
    disp('    writing blobs...')
    for i = 1:length(imglist),
        target = {};
        % configure feature extraction
        target.config = configure();
        % get the image
        %target.image = cell2mat(targets.image(i));
        target.image = imcomplement(imread([img_path imglist{i}])); %read VPR roi and reverse grayscale
        % compute the blob mask (result in target.blob_image)
        target = blob(target);
        % now output the blob image as a 1-bit png
        imwrite(target.blob_image,[blob_path regexprep(imglist{i}, 'tif', 'png')],'bitdepth',1);
    end;
  %  zip(blob_png_path(1:end-1), blob_png_path)
  %  rmdir(blob_png_path, 's')
end

