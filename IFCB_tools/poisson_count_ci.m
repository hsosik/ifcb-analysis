function [ ci] = poisson_count_ci( N, ciint)
%function [ ci ] = poisson_count_ci( N, alpha )
%   Compute upper and lower confidence intervals on a count from Poisson distribution
%   Input:  N - vector of count values
%           ciint - value less than 1 specifying width of confidence
%           interval (e.g., 0.95 for 95% ci)
%   Output: [upper, lower] - upper and lower confidence intervals, respectively
%
% Heidi M. Sosik, Woods Hole Oceanographic Institution, Sep 2013

alpha = 1-ciint;
for ii = 1:length(N),
    [~,ci(ii,:)] = poissfit(N(ii),alpha);
end;

end

