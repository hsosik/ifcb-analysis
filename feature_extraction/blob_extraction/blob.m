function [ target ] = blob( target )
% function [ target ] = blob( target )
% Find connected components (blobs) in an image and produce the corresponding mask
% Heidi M. Sosik, Woods Hole Oceanographic Institution, Oct 2011

persistent se2 se3; %structuring elemements for morphological processing

if isempty(se2)
    se2 = strel('disk',2);
end;

if isempty(se3)
    se3 = strel('disk',3);
end;

config = target.config;
img = target.image;
pc3 = config.pc3; %get phase congruency parameters
[M, m] = phasecong3_Mm(img, pc3.nscale, pc3.norient, pc3.minWaveLength, pc3.mult, pc3.sigmaOnf, pc3.k, pc3.cutOff, pc3.g, pc3.noiseMethod);
img_blob = hysthresh(M+m, config.hysthresh.high, config.hysthresh.low);
% omit spurious edges along margins
img_blob(1,img_blob(2,:)==0)=0;
img_blob(end,img_blob(end-1,:)==0)=0;
img_blob(img_blob(:,2)==0,1)=0;
img_blob(img_blob(:,end-1)==0,end)=0;
img_edge = img_blob; %keep this to plot?
% now use Otsu's method to make sure dark areas are included
otsu_thresh = round((graythresh(img)*255)*0.65); % use integer threshold
img_blob(img < otsu_thresh)=1;
% morphological processing 
img_blob = imclose(img_blob, se3);
img_blob = imdilate(img_blob, se2);
img_blob = bwmorph(img_blob, 'thin', 3); %20 oct 2011, Heidi thinks 3 times here might be better than previous 1
img_blob = imfill(img_blob, 'holes');
target.blob_image = img_blob;
target = apply_blob_min( target ); %get rid of blobs < blob_min

% FIXME debug
%Mm = M + m;
%img_blob = target.blob_image;
%save('c:\Users\Heidi\Documents\GitHub\ipython\blob_debug.mat','Mm','img_edge','img_dark','img_blob');
% end debug

if config.plot, %go to graphing routine if requested
    img_proc_plot(target, M+m, img_edge, img_dark)
    %pause
end;

end
