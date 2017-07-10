function out_im = ifcb_blob(in_im, in_sim)
% compute a blob from an image
% in_im - input image
% in_sim - input stitched image (NaNs where data is missing), optional

    target.config = configure();
    target.image = in_im;
    
    if nargin > 1
        % create a mask of the NaN region
        mask = zeros(size(in_sim));
        mask(isnan(in_sim))=1;
        % grow it by one pixel
        st = strel('disk',1);
        mask = imdilate(mask, st);
        % set target.chop to the grown mask
        target.chop = mask;
    end
    
    % now call the existing blob algorithm
    target = blob(target);
    
    out_im = target.blob_image;
end