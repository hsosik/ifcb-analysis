function [next_ind, imagemap] = fillscreen(imagedat,imgind,camx, camy, border, title_str, classlist, mark_col, classnum);
%function [next_ind, imagemap] = fillscreen(imagedat,imgind,camx, camy,border, title_str, classlist, mark_col, classnum);
%For Imaging FlowCytobot roi viewing; Use with manual_classify scripts;
%Fills current graph window with a roi collage taken in consecutive from an input set,
%returning the index number of the next image in the set that doesn't fit on
%this screen;
%Heidi M. Sosik, Woods Hole Oceanographic Institution, 30 May 2009
%modified 12 January 2010 to skip over zero-size rois
%modifeid 15 January 2010 so that selected ID displayed on previous pages within a category have proper text color (red for main list, blue for subdivide list)

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

%outputs:
%   next_ind = index number of the next image in the set that doesn't fit
%   imagemap = pixel map of roi index numbers as plotted, for use with ginput in manual_classify scripts

delete(gca)
imagemap = NaN(camx, camy);
pagefull = 0;
start_pos = [1 1]; %start at origin
ycum = 1;
next_ind = 1;
while ~pagefull && next_ind <= length(imgind)
    [x,y] = size(imagedat{next_ind});  %get image dimensions
    if x > 0,  %skip if zero size roi
        %check if the next one fits
        check_pos = [start_pos(1) + x, start_pos(2) + y];
        if check_pos(2) > camy, %goes off the bottom
            pagefull = 1;
            %next_ind stays on this one
        elseif check_pos(1) > camx, %doesn't fit on this row
            start_pos = [1, ycum + border]; % go to new row
            check_pos = [start_pos(1) + x, start_pos(2) + y];
            if check_pos(2) > camy, %goes off the bottom
                pagefull = 1;
            else %fits here
                plotnow = 1;
            end;
        else %fits here
            plotnow = 1;
        end;
        if plotnow
            colormap(gray); shading flat; hold on; axis([1 camx 1 camy]); set(gca, 'ydir', 'reverse')
            h = imagesc(imagedat{next_ind}', 'xdata', start_pos(1):check_pos(1), 'ydata', start_pos(2):check_pos(2)); hold on
            text(start_pos(1),start_pos(2), num2str(imgind(next_ind)), 'verticalalignment','top');
            if classlist(imgind(next_ind), mark_col) ~= classnum & ~isnan(classlist(imgind(next_ind), mark_col)),  %if class changed on this round, mark with new class number
                cstr = 'r'; if mark_col ~= 2, cstr  = 'b'; end;
                text(start_pos(1),start_pos(2)+20, num2str(classlist(imgind(next_ind),mark_col)), 'color', cstr, 'fontweight', 'bold');
            end;
            imagemap(start_pos(1):check_pos(1),start_pos(2):check_pos(2)) = imgind(next_ind);
            next_ind = next_ind + 1;
            start_pos(1) = check_pos(1) + border; %adjust start along x-axis (keep same row)
            ycum = max(ycum, check_pos(2)); %increase maximum y if this image is tallest in the current row
            plotnow = 0;
        end;
    else %go on to next one if zero-size roi
        next_ind = next_ind + 1;
    end;
end;
title(title_str, 'fontsize', 16, 'color', 'r', 'fontweight', 'bold','interpreter','none')
th = text(1, -5, 'SELECT ALL', 'fontsize', 20, 'verticalalignment', 'bottom', 'backgroundcolor', [.9 .9 .9]);
