function [CV] = func_findCV(toplot, isin, file, lab);

% toplot(find(toplot<=0))=NaN; % why are there -9.997 values?
toplot(find(toplot<0))=NaN; % why are there -9.997 values?
CV = [];
% maxval = max(toplot(isin)); %to not use the absolute max value (which often seems to be an artifact)
% isinlessthanmax = isin((toplot(isin))<maxval);
% endch = max(toplot(isinlessthanmax));
endch = max(toplot);
startch = unique(min(toplot(isin)'));
endchind = max(toplot);
startchind = unique(min(toplot(isin)'));
bins = linspace(startch, endch, 2*sqrt(length(isin)));
histCh = hist([startch; endch; toplot(isin)], bins);
%now look for peak of histogram and re-do the histogram with this in the
%middle of the range (to avoid a few large values making it low-resolution)
maxhistind = mean(find(histCh==max(histCh))); % channel of peak

if maxhistind < length(bins)/2
    endch = bins(maxhistind * 2); % get the new end value
end
bins = linspace(startch, endch, 2*sqrt(length(isin))); % recalc bins and histogram
histCh = hist([startch; endch; toplot(isin)], bins);
plot(bins, histCh,'.-');
if ~isempty(find(histCh(2:end-1)>=0.5*max(histCh)))
    histCh = hist([startch; endch; toplot(isin)], bins);
    if histCh(end) >= 0.5*max(histCh)
        histCh = histCh(1:end-1); bins = bins(1:end-1);
    end
    plot(bins, histCh,'.-');
    hold on
    plot(bins(end), histCh(end),'r.')
    binLa = min(bins(find(histCh>=0.5*max(histCh)))); %channel value at left side of peak
    binRa = max(bins(find(histCh>=0.5*max(histCh)))); %channel value at right side of peak
    if length(find(bins>binLa & bins<binRa))>1 & binLa > bins(1) & binRa < bins(end)
%         keyboard
%         if binLa > bins(1) & binRa < bins(end)
        binLb = bins(find(bins==binLa)-1); % 1 less
        binRb = bins(find(bins==binRa)+1); % 1 more
    else
        binLb = binLa;
        binRb = binRa;
    end
    bininda = find(bins == binLa):find(bins == (binRa));
    binindb = find(bins == binLb):find(bins == (binRb));
    hold on
    plot(bins(bininda), histCh(bininda),'g.');
    
    plot(bins(binindb), histCh(binindb),'ro');

    % interpolate between points around 0.5max (for width (i.e. SD), but not for mean (used in CV=SD/mean))
    m1 = (histCh(find(bins==binLa)) - histCh(find(bins==binLb))) / (binLa-binLb);
    bin1hm =  binLb + (0.5*max(histCh) - histCh(find(bins==binLb))) / m1 ;%binLb + (m1 /   (0.5*max(histCh) - histCh(find(bins==binLb))));
    m2 = (histCh(find(bins==binRa)) - histCh(find(bins==binRb))) / (binRa-binRb);
    bin2hm = binRb + (0.5*max(histCh) - histCh(find(bins==binRb))) / m2 ;%binRb - (m2 / (0.5*max(histCh) - histCh(find(bins==binRb))));
    fwhmint = bin2hm - bin1hm;
    SDint = fwhmint / 2.36;
    % mean of points before/after 0.5max
    fwhma = bins(bininda(end)) - bins(bininda(1));
    fwhmb = bins(binindb(end)) - bins(binindb(1));
    fwhm = mean([fwhma fwhmb]);
    SDa = fwhma / 2.36;
    SDb = fwhmb / 2.36;
    SD = mean([SDa SDb]);
    meanbina =  sum(bins(bininda) .* histCh(bininda)) / sum(histCh(bininda));
    meanbinb =  sum(bins(binindb) .* histCh(binindb)) / sum(histCh(binindb));
    CVa = SDa / meanbina;
    CVb = SDb / meanbinb;
    CV = mean([CVa CVb]);
    CVint = SDint / mean([meanbina meanbinb]);
    line([meanbina meanbina], [0  max(histCh(bininda))],'color','c','linewidth',1,'linestyle',':')
    line([meanbinb meanbinb], [0  max(histCh(binindb))],'color','g','linewidth',1,'linestyle','-.')
    line([],[])
    edgeL = mean([bins(bininda(1)) bins(binindb(1))]);
    edgeR = mean([bins(bininda(end)) bins(binindb(end))]);
    line([edgeL edgeR],[max(histCh(binindb))/2 max(histCh(binindb))/2],'color','c','linewidth',3,'linestyle',':')
    plot(bin1hm, 0.5*max(histCh),'r*');
    plot(bin2hm, 0.5*max(histCh),'r*');
    axis([0 3*meanbina 0 inf])
    title([file '    ' lab '    = ' num2str(mean([meanbina meanbina])) '  CVmean = ' num2str(CV) '  CVinterp = ' num2str(CVint)],'interpreter','none');
    disp(['CVinterp = ' num2str(CVint)])
end