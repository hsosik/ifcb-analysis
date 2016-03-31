function [] = eval_blobs(targets)

%disp(['LOAD targets ' binzip_url]);
%targets = get_bin_file(binzip_url);

% now loop through targets
config = configure();
target.config = config;
empty_target = target;

pc3 = config.pc3; %get phase congruency parameters

nt = length(targets.pid);
for i = 1:nt,
    target = empty_target;
    % get the image
    target.image = cell2mat(targets.image(i));
    % run blob comparison algorithm
    [M, m , ~, ~, ~, ~, ~] = phasecong3(target.image, pc3.nscale, pc3.norient, pc3.minWaveLength, pc3.mult, pc3.sigmaOnf, pc3.k, pc3.cutOff, pc3.g, pc3.noiseMethod);
    ht1 = hysthresh(M+m, config.hysthresh.high, config.hysthresh.low);
    ht2 = hysthresh_kovesi(M+m, config.hysthresh.high, config.hysthresh.low);
    ht_df = xor(ht1,ht2);
    if sum(ht_df(:))
        b1 = morpho(target.image, ht1);
        b2 = morpho(target.image, ht2);
        b_df = xor(b1,b2);
        b_df_sum = sum(b_df(:));
        if b_df_sum
            subplot(3,1,1);
            imshow(target.image);
            title('ROI');
            subplot(3,1,2);
            imshow(b2);
            title('Kovesi blob');
            subplot(3,1,3);
            imshow(b1);
            title(['Futrelle blob ' num2str(b_df_sum) ' pixel difference']);
            waitforbuttonpress;
        end
    end
    disp([num2str(i)]);
end

end

function [ img_blob ] = morpho( img, img_blob )

se2 = strel('disk',2);
se3 = strel('disk',3);

% omit spurious edges along margins
img_blob(1,img_blob(2,:)==0)=0;
img_blob(end,img_blob(end-1,:)==0)=0;
img_blob(img_blob(:,2)==0,1)=0;
img_blob(img_blob(:,end-1)==0,end)=0;
% now use kmean clustering approach to make sure dark areas are included
img_dark = kmean_segment(img);
img_blob(img_dark==1)=1;
% morphological processing 
img_blob = imclose(img_blob, se3);
img_blob = imdilate(img_blob, se2);
img_blob = bwmorph(img_blob, 'thin', 3); %20 oct 2011, Heidi thinks 3 times here might be better than previous 1
img_blob = imfill(img_blob, 'holes');

target.config = configure();
target.blob_image = img_blob;
target = apply_blob_min( target ); %get rid of blobs < blob_min
img_blob = target.blob_image;

end