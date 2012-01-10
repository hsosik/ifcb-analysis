function [ ] = make_indexseries_figs(class2use,ymat,maxsubplots)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

numfig = ceil(length(class2use)/maxsubplots);
indcount = 1;
for figcount = 1:numfig,
    figure
    orient tall
    fpos = get(gcf, 'position');
    set(gcf, 'position', [fpos(1) fpos(2)/10 fpos(3) fpos(4)*2])
    if figcount < numfig,
        subplots = maxsubplots;
    else
        subplots = length(class2use)-indcount+1;
    end;
    for subcount = 1:subplots,
        subplot(maxsubplots,1,subcount)
        plot(ymat(:,indcount), '.-')
        yl = ylim;
        text(200,.9*yl(2), class2use(indcount), 'interpreter', 'none', 'verticalalignment', 'top')
        indcount = indcount + 1;
    end;
end
end

