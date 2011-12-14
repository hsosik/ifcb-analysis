function [ img_stitch, xpos_stitch, ypos_stitch ] = stitchrois( imagedat,xpos,ypos)
%function [ img_stitch, xpos_stitch, ypos_stitch ] = stitchrois( imagedat,xpos,ypos)
%creates one rectangular image from two overlapping rois, includes "fake"
%background sections necessary to fill the final rectangle
%INPUTS:
%   imagedat - 1x2 cell array of original overlapping rois
%   xpos, ypos - 2x1 vectors of x and y locations of roi corners (in pixels from origin in original camera field)   
%OUTPUTS:
%   img_stitch - final stitched image including background fill
%   xpos_stitch, ypos_stitch - x and y location of final image corner (in pixels from origin of original camera field) 
%
%Heidi Sosik, Woods Hole Oceanographic Institution, 6 January 2010
%
%called by stitch_rois_batch and manual_classify (after version 3.0)
%stitchrois, revised 6/8/2010 to correct corner error in median filtering
%of background patches (left one pixel with value = 0).  
%
xpos_stitch = min(xpos);
ypos_stitch = min(ypos);
xpos_img = xpos-min(xpos)+1;
ypos_img = ypos-min(ypos)+1;
[x(1),y(1)] = size(imagedat{1}); %roi1 size
[x(2),y(2)] = size(imagedat{2}); %roi2 size
yr = [ypos ypos+y'];
xr = [xpos xpos+x'];
img_stitch = NaN; %default for case with no overlap
    if ~isempty(intersect(yr(1,1):yr(1,2), yr(2,1):yr(2,2))) && ~isempty(intersect(xr(1,1):xr(1,2), xr(2,1):xr(2,2)))
        img_stitch = NaN(max(xr(:))-min(xr(:)),max(yr(:))-min(yr(:)));
        img_stitch(xpos_img(1):x(1)+xpos_img(1)-1,ypos_img(1):y(1)+ypos_img(1)-1) = imagedat{1};
        img_stitch(xpos_img(2):x(2)+xpos_img(2)-1,ypos_img(2):y(2)+ypos_img(2)-1) = imagedat{2};   
        ind_nan = find(isnan(img_stitch));   
        if ~isempty(ind_nan),
        
        t = zeros(size(img_stitch));
        t(ind_nan) = 1;
        s = diff(t);
        s2 = diff(t')';
        [i,j] = find(s);
        [i2,j2] = find(s2);
        unqj2 = unique(j2);
        unqi = unique(i);
        t = [];
        
        for count = 1:length(unqi),
            ind = find(i == unqi(count));
            t = [t; nanmean([img_stitch(unqi(count)+1,j(ind)); img_stitch(unqi(count),j(ind))])'];
        end;
        for count = 1:length(unqj2),
            ind = find(j2 == unqj2(count));
            t = [t; nanmean([img_stitch(i2(ind),unqj2(count)+1) img_stitch(i2(ind),unqj2(count))], 2)];
        end;
        ind = find(t>150);
        if length(ind) > length(t)/2,
            m = mean([t(t>150)]); %get the mean of pixels on the edge of gaps, exclude anything really dark
            v = var(t(t>150));
        else
            m = mean([t]); %get the mean of pixels on the edge of gaps
            v = var(t);
        end;
        n = imnoise(ones(size(img_stitch)), 'gaussian',0,v/255^2/5);
        temp = ones(size(img_stitch))*m;
        temp = round(medfilt2(temp.*n, 'symmetric'));  %ADD round to force back to integer pixel values, Heidi 1/6/10
        img_stitch(ind_nan) = temp(ind_nan);
        end; 
    end;
end

