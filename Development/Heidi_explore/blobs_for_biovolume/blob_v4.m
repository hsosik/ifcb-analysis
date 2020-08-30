function [ target ] = blob( target )
% function [ target ] = blob( target )
% Find connected components (blobs) in an image and produce the corresponding mask
% Heidi M. Sosik, Woods Hole Oceanographic Institution, Oct 2011

persistent se2 seD; %structuring elemements for morphological processing

if isempty(se2)
    se2 = strel('diamond',2);
end

if isempty(seD)
    seD = strel('diamond',1);
end

config = target.config;
img = target.image;
pc3 = config.pc3; %get phase congruency parameters
[M, m] = phasecong3_Mm(img, pc3.nscale, pc3.norient, pc3.minWaveLength, pc3.mult, pc3.sigmaOnf, pc3.k, pc3.cutOff, pc3.g, pc3.noiseMethod);
Mm = M+m;
img_blob = hysthresh(Mm, config.hysthresh.high, config.hysthresh.low);

% omit spurious edges along margins
img_blob(1,img_blob(2,:)==0)=0;
img_blob(end,img_blob(end-1,:)==0)=0;
img_blob(img_blob(:,2)==0,1)=0;
img_blob(img_blob(:,end-1)==0,end)=0;
img_blob = imclose(img_blob, se2);
img_blob = bwmorph(img_blob, 'thin', 3); %tar20 oct 2011, Heidi thinks 3 times here might be better than previous 1
img_edge = img_blob; %keep this to plot?

% now use kmean clustering approach to make sure dark areas are included
img_dark = kmean_segment(img);
img_blob(img_dark==1)=1;
% morphological processing 
img_blob = imfill(img_blob, 'holes');

img_blob1 = imerode(img_blob,seD);
temp_target.blob_image = img_blob1;
temp_target.config = target.config;
[ temp_target ] = apply_blob_min( temp_target );
if temp_target.blob_props.Area > 0
    img_blob = img_blob1;
%else
%    [numel(find(img_blob)) numel(find(img_blob1))]
%    disp('small blob, no erode steps')
end

target.blob_image = img_blob;
target = apply_blob_min( target ); %get rid of blobs < blob_min

if config.plot %go to graphing routine if requested
    img_proc_plot(target, M+m, img_edge, img_dark)
    %pause
end;

end
