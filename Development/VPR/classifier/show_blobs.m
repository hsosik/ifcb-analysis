in_dir= '\\SosikNAS1\Lab_data\VPR\NBP1201NewTrain201412\rois\'; %USER 
out_dir = '\\SosikNAS1\Lab_data\VPR\NBP1201NewTrain201412\blobs2\'; %USER main blob output location
out_dir2 = '\\SosikNAS1\Lab_data\VPR\NBP1201NewTrain201412\blobs\'; %USER main blob output location

bins = dir([in_dir]);
bins = {bins.name}; 
bins = bins(3:end);
%bins = regexprep({bins.name}', '.adc', '');

for bincount = 1:length(bins),
    png_path = [in_dir bins{bincount}  filesep];
    blob_png_path = [out_dir bins{bincount}  filesep];
    blob_png_path2 = [out_dir2 bins{bincount}  filesep];
    imglist = dir([png_path '*.tif']);
    imglist = {imglist.name};
    for i = 2:10:length(imglist),
       % target.image = imcomplement(imread([png_path imglist{i}])); %read VPR roi and reverse grayscale
        target.image = imread([png_path imglist{i}]); %read VPR roi
        target.blob_image = imread([blob_png_path regexprep(imglist{i}, 'tif', 'png')]);
        target.blob_image2 = imread([blob_png_path2 regexprep(imglist{i}, 'tif', 'png')]);
        figure(1), clf
        subplot(1,3,1), imshow(target.image)
        title([bins{bincount} ':  ' imglist{i}])
        subplot(1,3,2), imshow (target.blob_image)
        subplot(1,3,3), imshow (target.blob_image2)
        pause
    end;
end;
 