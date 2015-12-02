function [next_ind, imagemap] = fillscreen(imagedat,imgind,camx, camy, border, title_str, classlist, mark_col, classnum, dataformat);
%function [next_ind, imagemap] = fillscreen(imagedat,imgind,camx, camy,border, title_str, classlist, mark_col, classnum);
%For Imaging FlowCytobot roi viewing; Use with manual_classify scripts;
%Fills current graph window with a roi collage taken in consecutive from an input set,
%returning the index number of the next image in the set that doesn't fit on
%this screen;
%Heidi M. Sosik, Woods Hole Oceanographic Institution, 30 May 2009
%modified 12 January 2010 to skip over zero-size rois
%modified 15 January 2010 so that selected ID displayed on previous pages within a category have proper text color (red for main list, blue for subdivide list)
%modified 9 September 2014 to adjust axes position
%April 2015, revised to remove subdivide functionality and recast for manual_classify_4_1
%Sep 2015, revised to include data format input (optional) so that VPR images can have white font for text labels

%inputs:
%   imagedat = cell array of roi images in order to plot
%   imgind = vector of roi indices in original adc file
%   camx = maximum x size of images (usually full camera field)
%   camy = maximum y size of images (usually full camera field)
%   border = number of pixels to place between images
%   title_str = string for graph title
%   classlist - matrix of class identity results
%   mark_col - column of classlist to edit with manual identifications
%   classnum - category number being viewed
%   dataformat - optional input to indicate if input dataformat requires change in font color (b/w)

%outputs:
%   next_ind = index number of the next image in the set that doesn't fit
%   imagemap = pixel map of roi index numbers as plotted, for use with ginput in manual_classify scripts

delete(gca)
imagemap = NaN(camx, camy);
pagefull = 0;
start_pos = [1 1]; %start at origin
ycum = 1;
next_ind = 1;
f = 1; %initialize to keep image size as input
imagedat_in = imagedat;  %keep an unchanged copy in case need multiple resize
text_color = 'k';
if exist('dataformat', 'var')
    if dataformat == 2 %VPR case
        text_color = 'w';
    end
end
while ~pagefull && next_ind <= length(imgind)
    if f ~= 1,
        imagedat{next_ind} = imresize(imagedat_in{next_ind},f);
    end
    [x,y] = size(imagedat{next_ind});  %get image dimensions
    if x > 0,  %skip if zero size roi
        %check if the next one fits
        check_pos = [start_pos(1) + x, start_pos(2) + y];
        if check_pos(2) > camy, %goes off the bottom
            pagefull = 1;
            if ~exist('plotnow', 'var') %first image too big for page
                f = f*camy/y;
                imagedat{next_ind} = imresize(imagedat_in{next_ind}, f);
            end
            plotnow = 0;
            %next_ind stays on this one
        elseif check_pos(1) > camx, %doesn't fit on this row
            if start_pos(1) ~= 1,
                start_pos = [1, ycum + border]; % go to new row
            end
            check_pos = [start_pos(1) + x, start_pos(2) + y];
            if check_pos(2) > camy, %goes off the bottom
                pagefull = 1;
            elseif check_pos(1) > camx %too big for a row of its own
                f = f*(camx-1)/x; %new resize factor
                %in this case need to remake the whole page with this f now
                plotnow = 0;
                delete(gca)
                imagemap = NaN(camx, camy);
                pagefull = 0;
                start_pos = [1 1]; %start at origin
                ycum = 1;
                next_ind = 1;
            else
                %fits here
                plotnow = 1;
            end
            %end
        else %fits here
            plotnow = 1;
        end;
        if plotnow
            colormap(gray); shading flat; hold on; axis([1 camx 1 camy]); set(gca, 'ydir', 'reverse', 'yticklabel', [], 'units', 'inches')
            set(gca,'ytick', 0:200:camy, 'xtick', 0:200:camx, 'plotboxAspectRatioMode', 'auto', 'dataAspectRatioMode', 'manual', 'dataAspectRatio', [1 1 1]);
            h = imagesc(imagedat{next_ind}', 'xdata', start_pos(1):check_pos(1), 'ydata', start_pos(2):check_pos(2)); hold on
            text(start_pos(1),start_pos(2), num2str(imgind(next_ind)), 'verticalalignment','top', 'color', text_color);
            if classlist(imgind(next_ind), mark_col) ~= classnum & ~isnan(classlist(imgind(next_ind), mark_col)),  %if class changed on this round, mark with new class number
                cstr = 'r'; if mark_col ~= 2, cstr  = 'b'; end;
                text(start_pos(1),start_pos(2)+20, num2str(classlist(imgind(next_ind),mark_col)), 'color', cstr, 'fontweight', 'bold');
            end;
            imagemap(start_pos(1):check_pos(1),start_pos(2):check_pos(2)) = imgind(next_ind);
            next_ind = next_ind + 1;
            start_pos(1) = check_pos(1) + border; %adjust start along x-axis (keep same row)
            ycum = max(ycum, check_pos(2)); %increase maximum y if this image is tallest in the current row
            plotnow = 0;
        end
    else %go on to next one if zero-size roi
        next_ind = next_ind + 1;
    end
end
if f ~= 1,
    uiwait(msgbox(['Images on this page rescaled to fit ' num2str(f*100,'%0.1f') '%']))
end
title(title_str, 'fontsize', 12, 'color', 'r', 'fontweight', 'bold','interpreter','tex')
th = text(1, -5, {'SELECT all page'}, 'fontsize', 16, 'verticalalignment', 'bottom', 'backgroundcolor', [.9 .9 .9]);
