function [features1, featitles] = getfeat_test2(img, plot_flag)

warning('off')
%se5 = strel('disk', 5);  %used 20 with sedge, etc.
se2 = strel('disk', 2);
se3 = strel('disk', 3);
%se4 = strel('disk', 4);
blob_min = 200;

fearow = 1;  %count position for feature row start

% [sx sy] = size(img);
[M m or ft pc EO,T] = phasecong3(img, 4, 6, 2, 2.5, 0.55, 2.0, 0.3, 5,-1);
%[M m or ft pc EO,T] = phasecong3(img, 3, 8, 2.3, 3, 0.55, 4.0, 0.1, 10,-1);
%figure(3), imshow(pc{1}+pc{2}+pc{3}+pc{4}+pc{5}+pc{6})
%nm= nonmaxsup(M, or, 1.5); %1.5
%M = M+m;
edgim = hysthresh(M+m, .2, .1);
%omit apparently spurious edges along margins of ROI
edgim(1,edgim(2,:) == 0) = 0;
edgim(end,edgim(end-1,:) == 0) = 0;
edgim(edgim(:,2) == 0,1) = 0;
edgim(edgim(:,end-1) == 0,end) = 0;
imgbw = edgim;
%now use kmean clustering approach to make sure dark areas are included
img_darkareas = kmean_segment(img);
imgbw(img_darkareas == 1) = 1;
if plot_flag, 
    figure(98), clf
    subplot(1,4,1), imshow(img), caxis auto, subplot(1,4,2), imshow(edgim), subplot(1,4,3), imshow(img_darkareas), subplot(1,4,4), imshow(imgbw), caxis auto
end;
img2 = imclose(imgbw, se3); 
img2 = imdilate(img2, se2);
img2 = bwmorph(img2, 'thin', 1);
img2 = imfill(img2, 'holes'); % modified to fill in the holes for accurate area readings

%img2 is the black image after edge detection
l = bwlabel(img2, 8);
t = regionprops(l, 'Area');
if ~isempty(t),  %this is case with a detectable blob
    s = cat(1,t.Area);
    temp = find(s > blob_min);
    features1(fearow) = sum(s(temp));
else    
    features1 = NaN;  %case where no blobs
end;

featitles = {'Area'};
%plotting option for testing various boundary methods, etc. "if 1" turns on
%plot and pause option
if plot_flag,
    figure(1), hold on
    temp = find(s > blob_min);
    l(find(ismember(l(:), find(s < 200)))) = length(s)+1; %plot all small blobs as one extreme color below
    lb = label2rgb(l, 'jet');
    clf
    subplot(221)
    imshow(img), caxis auto
    title('Original image')
    %    title(char(imgfiles(imgcount).name))
    subplot(222)
    imshow(imgbw)
    title('Thresholded Image')
    subplot(223)
    %imshow(img3)
    imshow(img2)
    title('First Morph')
    hold on   
    subplot(224)
    imshow(lb)
    title('Visualize labeled area')
    figure(2)
    clf
    subplot(221)
    imshow(img), caxis auto
    title('Original Image')
    %   title(char(imgfiles(imgcount).name))
    subplot(222)
    imshow(M)
    title('Phase Congruency Result')
    subplot(223)
    imshow(edgim)
    title('Thresholded Image')
    subplot(224)
    imshow(img2)
    title('First Morph')
    pause
end;
