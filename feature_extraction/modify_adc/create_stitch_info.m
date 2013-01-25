function [ stitch_info ] = create_stitch_info( adcdata, roifilename)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

fid = fopen(roifilename);
x_all = adcdata(:,12);  y_all = adcdata(:,13); startbyte_all = adcdata(:,14); xpos_all = adcdata(:,10); ypos_all = adcdata(:,11);
ind = find(~diff(adcdata(:,1)));

stitch_info = [];
for count = 1:length(ind);
    n = ind(count);
    startbyte = startbyte_all(n:n+1); x = x_all(n:n+1); y = y_all(n:n+1); xpos = xpos_all(n:n+1); ypos = ypos_all(n:n+1);
    if x(1) == 0 | x(2) == 0, startbyte = [];, end; %skip case with a 0 size rois
    imagedat = [];
    for imgcount = 1:length(startbyte),
        fseek(fid, startbyte(imgcount), -1);
        data = fread(fid, x(imgcount).*y(imgcount), 'ubit8');
        imagedat{imgcount} = reshape(data, x(imgcount), y(imgcount));
    end;
    if ~(diff(ypos) + diff(xpos)),  %if positions are the same (mistake in pre-mid 2008 files)
        [dxpos_est, dypos_est] = find_overlap(imagedat{1}, imagedat{2});  %get the overlap by comparing the images
        xpos(2) = xpos(1)+ dxpos_est;  % recover the positions of the second image
        ypos(2) = ypos(1)+ dypos_est;
    end;
    
    if ~isnan(xpos(2)) && ~isempty(imagedat), %skip this for cases where above loop returns no overlap
        %                    [img_merge, xpos_merge, ypos_merge] = stitchrois(imagedat,xpos,ypos);
        %                     if ~isnan(img_merge(1))
        stitch_info = [stitch_info; n xpos(1) ypos(1) xpos(2) ypos(2)];
        %                    end;
    end;
    
    if 0,
        figure(1), clf
        subplot(2,1,1)
        imagesc(ypos(1), xpos(1), imagedat{1})
        hold on
        imagesc(ypos(2), xpos(2), imagedat{2})
        colormap('gray'); axis([0 1300 0 1300]), axis square
        %subplot(2,1,2)
        %imagesc(ypos_merge, xpos_merge, img_merge)
        %title(['overlap: ' num2str(size(intersect(xr(1,1):xr(1,2), xr(2,1):xr(2,2)),2)) '; ' num2str(size(intersect(yr(1,1):yr(1,2), yr(2,1):yr(2,2)),2))])
        %colormap('gray'); axis([0 1300 0 1300]), axis square
    end;
end;
fclose(fid);

end

