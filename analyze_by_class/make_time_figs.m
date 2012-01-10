function [ ] = make_time_figs(class2use,xvec,ymat,maxsubplots)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

numfig = ceil(length(class2use)/maxsubplots);
indcount = 1;
y1 = datevec(xvec(1)); y1 = y1(1);
y2 = datevec(xvec(end)); y2 = y2(1)+1;
xt = datenum(cellstr([repmat('1-1-',y2-y1+1,1) num2str((y1:y2)')]));
xl = xt([1,end]);
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
        nnan = find(~isnan(ymat(:,indcount)));
        plot(xvec(nnan), ymat(nnan,indcount), '.-')
        set(gca,'xlim', xl)
        set(gca, 'xtick', xt)
        datetick
        if subcount < subplots,
            set(gca,'xticklabel', []);
        end;
        set(gca, 'xgrid', 'on')
        yl = ylim;
        text(xvec(1)+2,.9*yl(2), class2use(indcount), 'interpreter', 'none', 'verticalalignment', 'top')
        indcount = indcount + 1;
    end;
end
end

