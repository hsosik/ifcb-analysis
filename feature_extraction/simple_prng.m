function [ out ] = simple_prng( n, shape, seed )
% This is a simple pseudo random number generator that is adequate
% for some purposes but is inferior to the algorithms provided
% by MATLAB; it is used here so that the MATLAB and Python algorithms
% can generate the same random streams for operations requiring randomness
%   n = maximum value (non-inclusive)
%   shape = size of matrix to generate
%   seed = random seed (default 1)
if nargin < 3
    seed = 1;
end

size=prod(shape);
prev=seed;

out = zeros(1,size);
for j=1:size
    prev = mod(prev * 30203, 29663);
    out(j)=prev;
end
if length(shape)>1
    out = reshape(mod(out,n),shape);
end

end

