function [slope, b, r, p] = fit_line(x,y,plotflag);
%function [slope, b, r, p] = fit_line(x,y, plotflag);
if ~exist('plotflag', 'var') %default no plot
    plotflag = 0;
end;
temp = size(x);
if temp(2)>temp(1), x = x'; y = y'; end;
ii = find(~isnan(x) & ~isnan(y));
%[slope,b,r,sm] = lsqfitgm(x(ii),y(ii)); %model-2
fit = polyfit(x(ii), y(ii), 1);
slope = fit(1); b = fit(2);
r = corrcoef(x(ii),y(ii));
[tau,p_rho] = corr(x(ii),y(ii), 'type', 'kendall'); %Kendall's rank
r = r(2);
r(2) = tau; % same value as returned by corrcoef
n = length(ii);
t = abs(r).*sqrt((n-2)./(1-r.^2));
p = 1-tcdf(t,n-2);
p(2) = p_rho;
if plotflag,
    figure
    plot(x,y, '.')
    hold on
    fplot(['x*' num2str(slope) '+' num2str(b)], xlim)
    title(['r = ' num2str(r, '%.2f ') '; ' 'y = ' num2str(slope) '*x+' num2str(b) '; p = ' num2str(p,'%.3f')])
end;
end
