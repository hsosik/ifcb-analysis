function [ target ] = blob( target )
% function [ target ] = blob( target )
% Find connected components (blobs) in an image and produce the corresponding mask
% Heidi M. Sosik, Woods Hole Oceanographic Institution, Oct 2011

persistent se1 se2 se3 se0 se90 seD; %structuring elemements for morphological processing

if isempty(se0)
    se0 = strel('line', 1, 0);
end;

if isempty(se90)
    se90 = strel('line', 1, 90);
end;

if isempty(seD)
    seD = strel('diamond', 2);
end;

if isempty(se2)
    se2 = strel('disk',2);
end;

if isempty(se3)
    se3 = strel('disk',3);
end;

if isempty(se1)
    se1 = strel('disk',1);
end;


f = [1 1];
config = target.config;
%img = imadjust(target.image);
%[~,thr] = edge(img, 'canny');
%blob_s = edge(img, 'canny', thr.*f);
%%blob_dil = imdilate(blob_s, [se90 se0]);
%%blob_dfill = imfill(blob_dil, 'holes');
%%img_blob = imclearborder(blob_dfill, 4);
%%img_blob = imerode(img_blob, seD);
%%%img_blob = imerode(img_blob, seD);

img = target.image;
% pc3 = config.pc3; %get phase congruency parameters
% [M m , ~, ~, ~, ~, ~] = phasecong3(img, pc3.nscale, pc3.norient, pc3.minWaveLength, pc3.mult, pc3.sigmaOnf, pc3.k, pc3.cutOff, pc3.g, pc3.noiseMethod);
% config.hysthresh.high = .3;
% config.hysthresh.low = .18;
% img_blob = hysthresh(M+m, config.hysthresh.high, config.hysthresh.low);
% % omit spurious edges along margins
% img_blob(1,img_blob(2,:)==0)=0;
% img_blob(end,img_blob(end-1,:)==0)=0;
% img_blob(img_blob(:,2)==0,1)=0;
% img_blob(img_blob(:,end-1)==0,end)=0;
% img_edge = img_blob; %keep this to plot?

% now use kmean clustering approach to make sure dark areas are included
img_dark = kmean_segment2(img);
%img_blob(img_dark==1)=1;
img_blob = img_dark;
%keyboard

%img_blob = imclose(img_blob, seD); img_blob_close = img_blob;
%img_blob = imdilate(img_blob, seD); img_blob_dilate = img_blob;
img_blob = imclose(img_blob, se3); img_blob_close = img_blob;
img_blob = imdilate(img_blob, se2); img_blob_dilate = img_blob;

img_blob = bwmorph(img_blob, 'thin', 3); %20 oct 2011, Heidi thinks 3 times here might be better than previous 1
%img_blob = imfill(img_blob, 'holes');

%%img_blob = imdilate(img_blob, [se90 se0]);
%%img_blob = imfill(img_blob, 'holes');
%%img_blob = imclearborder(img_blob, 4);
%%img_blob = imerode(img_blob, seD);
img_blob = imerode(img_blob, seD);


%% morphological processing 
%img_blob = imclose(blob_s, se3);
%img_blob = blob_s;
%%img_blob = imdilate(img_blob, se2);
%%img_blob = bwmorph(img_blob, 'thin', 3); %20 oct 2011, Heidi thinks 3 times here might be better than previous 1
%%img_blob = imfill(img_blob, 'holes');
%img_blob = imclearborder(img_blob, 4);
%%img_blob = imerode(img_blob, seD);

target.blob_image = img_blob;

target.config.blob_min = 700;
target = apply_blob_min( target ); %get rid of blobs < blob_min

if config.plot, %go to graphing routine if requested
    %img_proc_plot(target, M+m, img_edge, img_dark)
    img_proc_plot(target, img_blob_close, img_blob_dilate , img_dark)
    pause
end;

end
