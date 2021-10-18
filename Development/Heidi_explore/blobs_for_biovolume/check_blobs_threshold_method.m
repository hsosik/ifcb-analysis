f = dir('\\sosiknas1\IFCB_products\Attune_size_calibration_July2018\blobs_v4_kmeans\D20181207\*.png');
f = {f.name}';
%%
for ii = 1:length(f)
    disp(f(ii))
    imk = imread(['\\sosiknas1\IFCB_products\Attune_size_calibration_July2018\blobs_v4_kmeans\D20181207\' f{ii}]);
    imo = imread(['\\sosiknas1\IFCB_products\Attune_size_calibration_July2018\blobs_v4_otsu\D20181207\' f{ii}]);
    imk2 = imread(['\\sosiknas1\IFCB_products\Attune_size_calibration_July2018\blobs_v4\D20181207\' f{ii}]);
    img = imread(['https://ifcb-data.whoi.edu/Attune_size_calibration_July2018/' f{ii}]);
    if ~isequal(imk2,imo)
        figure(1)
        subplot(2,3,1), imshow(img)
        subplot(2,3,2), imshow(imk)
        subplot(2,3,3), imshow(imo)
        subplot(2,3,4), imshow(imk2)
        subplot(2,3,5), imshow(imo-imk)
        subplot(2,3,6), imshow(imo-imk2)
        pause
    end
end