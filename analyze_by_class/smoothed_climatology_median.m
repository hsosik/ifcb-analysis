function [ xmedian, xstd ] = smoothed_climatology( x , win)
%function [ xmedian, xstd ] = smoothed_climatology( x , win)
%assume input vector or matrix with dimensions yearday x number of years
%outputs running mean and std with span +/- value specified in win, pooling observations from all years
 
for ii = 1:366, 
    iii = ii-win:ii+win; 
    iii = intersect(iii,1:366); 
    t = x(iii,:); 
    t = t(~isnan(t(:)));
    xmedian(ii) = median(t); 
    xstd(ii) = nanstd(t); 
end;

end

