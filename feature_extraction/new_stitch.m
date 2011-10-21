function [ img_stitch, xpos_stitch, ypos_stitch ] = new_stitch( p1, p2 )
%function [ img_stitch, xpos_stitch, ypos_stitch ] = stitchrois( imagedat,xpos,ypos)
%creates one rectangular image from two overlapping rois, includes "fake"
%background sections necessary to fill the final rectangle
%INPUTS:
%   p1 - pid of first target
%   p2 - pid of second target
%OUTPUTS:
%   img_stitch - final stitched image including background fill
%   xpos_stitch, ypos_stitch - x and y location of final image corner (in pixels from origin of original camera field) 
%
%Joe Futrelle, Woods Hole Oceanographic Institution adapted from
%Heidi Sosik, Woods Hole Oceanographic Institution, 6 January 2010
%
%called by stitch_rois_batch and manual_classify (after version 3.0)
%stitchrois, revised 6/8/2010 to correct corner error in median filtering
%of background patches (left one pixel with value = 0).  
%
i1 = get_image(p1); % first image
i2 = get_image(p2); % second image
m1 = get_target(p1); % first metadata
m2 = get_target(p2); % second metadata
xpos = [m1.left; m2.left];
ypos = [m1.bottom; m2.bottom];
xpos_stitch = min(xpos);
ypos_stitch = min(ypos);
xpos_img = xpos-min(xpos)+1;
ypos_img = ypos-min(ypos)+1;
x(1) = m1.width;
y(1) = m1.height;
x(2) = m2.width;
y(2) = m2.height;
yr = [ypos ypos+y'];
xr = [xpos xpos+x'];
img_stitch = NaN; %default for case with no overlap
    if ~isempty(intersect(yr(1,1):yr(1,2), yr(2,1):yr(2,2))) && ~isempty(intersect(xr(1,1):xr(1,2), xr(2,1):xr(2,2)))
        img_stitch = NaN(max(xr(:))-min(xr(:)),max(yr(:))-min(yr(:)));
        img_stitch(xpos_img(1):x(1)+xpos_img(1)-1,ypos_img(1):y(1)+ypos_img(1)-1) = i1;
        img_stitch(xpos_img(2):x(2)+xpos_img(2)-1,ypos_img(2):y(2)+ypos_img(2)-1) = i2;
        ind_nan = find(isnan(img_stitch));   
        if ~isempty(ind_nan),
        
        t = zeros(size(img_stitch));
        t(ind_nan) = 1;
        % t is now a mask with zeros where the images are and 1 for the gap
        s = diff(t); % this seems to find top edge of gap
        s2 = diff(t')'; % find left edge of gap
        [i,j] = find(s);
        [i2,j2] = find(s2);
        unqj2 = unique(j2); % coordinates of top and bottom edges of gap
        unqi = unique(i); % coordinates of left and right edges of gap
        t = [];
        
        % now compute the mean and variance of all the pixels bordering the
        % gap
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