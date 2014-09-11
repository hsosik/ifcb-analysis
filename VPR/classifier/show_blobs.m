in_dir= 'C:\work\IFCB\test_forEliseOlson\test_Aug2014_RossSea\trrois_VPR4Edit\'; %USER 
out_dir = 'C:\work\IFCB\test_forEliseOlson\test_Aug2014_RossSea\blobs\'; %USER main blob output location

bins = dir([in_dir]);
bins = {bins.name}; 
bins = bins(3:end);
%bins = regexprep({bins.name}', '.adc', '');

for bincount = 3:length(bins),
    png_path = [in_dir bins{bincount}  filesep];
    blob_png_path = [out_dir bins{bincount}  filesep];
    imglist = dir([png_path '*.tif']);
    imglist = {imglist.name};
    for i = 1:10:length(imglist),
       % target.image = imcomplement(imread([png_path imglist{i}])); %read VPR roi and reverse grayscale
        target.image = imread([png_path imglist{i}]); %read VPR roi
        target.blob_image = imread([blob_png_path regexprep(imglist{i}, 'tif', 'png')]);
        figure(1), clf
        subplot(1,2,1), imshow(target.image)
        title([bins{bincount} ':  ' imglist{i}])
        subplot(1,2,2), imshow (target.blob_image)
        pause
    end;
end;
 