function [ xmean, xstd ] = smoothed_climatology( x , win)
%function [ xmean, xstd ] = smoothed_climatology( x , win)
%assume input vector or matrix with dimensions yearday (or week or month) x number of years
%outputs running mean and std with span +/- value specified in win, pooling observations from all years
 
xlength = size(x,1);
for ii = 1:xlength, 
    iii = ii-win:ii+win; 
    iii = intersect(iii,1:xlength); 
    t = x(iii,:); 
    xmean(ii) = nanmean(t(:)); 
    xstd(ii) = nanstd(t(:)); 
end;

end

