function [r,slope,n,p,r_sig,slope_sig] = anomaly_corr(xall, yall, yearday, month_bins, subplotwidth, years)
%[r,slope,n,p,r_sig,slope_sig] = anomaly_corr(xall, yall, yearday, month_bins, subplotwidth, years)
%   Detailed explanation goes here

mon_str = {'Jan' 'Feb' 'Mar' 'Apr' 'May' 'Jun' 'Jul' 'Aug' 'Sep' 'Oct' 'Nov' 'Dec'};
dv = datevec(yearday);
stdy = nanstd(yall(:));
maxy = ceil(max(yall(:))./stdy);
stdx = nanstd(xall(:));
maxx = ceil(max(xall(:))./stdx);
if subplotwidth > 0,
    %figure
    subplotheight = ceil(size(month_bins,1)./subplotwidth);
end;
for c = 1:size(month_bins,1), 
    mon2find = month_bins(c,:);
    ii = find(ismember(dv(:,2), mon2find)); 
    x = xall(ii,:)./stdx; y = yall(ii,:)./stdy; 
    ii = find(~isnan(x) & ~isnan(y));
    [slope(c),b,r(c),sm] = lsqfitgm(x(ii),y(ii));
    n(c) = length(ii);
    t = abs(r(c)).*sqrt((n(c)-2)./(1-r(c).^2));
    p(c) = 1-tcdf(t,n(c)-2);
    if subplotwidth > 0,
        subplot(subplotheight,subplotwidth,c)  
        plot(x(:),y(:),'*b');
%        plot(x,y,'*'); t = get(gca, 'children'); set(t(end-3:end), 'marker', 'd');
        titlestr = [];
        for count = 1:length(mon2find),titlestr = [titlestr char(mon_str(mon2find(count))) '-']; end; titlestr = titlestr(1:end-1);
        title(titlestr), axis([maxx.*[-1 1] maxy.*[-1 1]]); 
        yfit2 = polyval([slope(c) b],x(ii));
        hold on
        axis square
        if p(c) < .05, %significant cases
            plot(x(ii),yfit2, 'r-')
            text(-maxx*.9,-maxy*.8,['r^2 = ' num2str(r(c).^2,'%0.2f')], 'color', 'r')
        else
            %plot(x(ii),yfit2, 'k:')
            text(-maxx*.9,-maxy*.8,['r^2 = ' num2str(r(c).^2,'%0.2f')])
        end;
    end;
    if c == 1,
        legend(num2str(years'));
    end;
end;
sig = (p<.05);
slope_sig = slope.*sig;
slope_sig(slope_sig(:) == 0) = NaN;
r_sig = r.*sig;
r_sig(r_sig(:) == 0) = NaN;

end

