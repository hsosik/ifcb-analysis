function [ xmean, xstd ] = smoothed_climatology( x , win)
%function [ xmean, xstd ] = smoothed_climatology( x , win)
%assume input vector or matrix with dimensions yearday (or week or month) x number of years
%outputs running mean and std with span +/- value specified in win, pooling observations from all years
xin = x; 
xinlength = size(xin,1);
x = [x; x; x]; %make sure consistency across Dec-Jan transition
xlength = size(x,1);
for ii = 1:xlength, 
    iii = ii-win:ii+win; 
    iii = intersect(iii,1:xlength); 
    t = x(iii,:); 
    xmean(ii) = nanmean(t(:)); 
    xstd(ii) = nanstd(t(:)); 
end;
xmean = xmean(xinlength+1:xinlength*2);
xstd = xstd(xinlength+1:xinlength*2);

end

