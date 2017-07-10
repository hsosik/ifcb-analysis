function out_im = ifcb_infill_image(in_im)
% Given a stitched image containing NaNs where image data is missing,
% synthesize missing data and return an image where NaNs are replaced
% with synthetic data.

    % create mask with ones where image data is
    mask = ones(size(in_im));
    nan_ix = isnan(in_im);
    mask(nan_ix) = 0;
    
    % remove everything except pixels adjacent to gaps
    mask = bwmorph(mask,'remove');
    mask(1,:) = mask(2,:);
    mask(end,:) = mask(end-1,:);
    mask(:,1) = mask(:,2);
    mask(:,end) = mask(:,end-1);
    
    % compute mean intensity of pixels adjacent to gaps
    m = round(mean(in_im(mask)));
    infill = in_im;
    infill(nan_ix) = m;
    
    out_im = in_im;
    
    % fill nans with computed infill
    out_im(nan_ix) = infill(nan_ix);
    
    out_im = uint8(out_im);
end