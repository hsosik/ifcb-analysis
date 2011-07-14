function phi = invmoments_affine(F)

F = double(F);

[M, N] = size(F);
[x, y] = meshgrid(1:N, 1:M);
  
% Turn x, y, and F into column vectors to make the summations a bit
% easier to compute in the following.
x = x(:);
y = y(:);
F = F(:);

% DIP equation (11.3-12)
m00 = sum(F);
% Protect against divide-by-zero warnings.
if (m00 == 0)
   m00 = eps;
end
m10 = sum(x .* F);
m01 = sum(y .* F);
%center of gravity
xbar = m10 / m00; 
ybar = m01 / m00;

x = x-xbar;
y = y-ybar;

% The other central moments:
mu20 = sum(x.^2 .* F);
mu02 = sum(y.^2 .* F);
mu11 = sum(x .* y .* F);

%phi(1) = (mu20 + mu02)./m00.^2  %this is the first regular moment inv.
phi(1) = (mu20.*mu02 - mu11.^2)./m00.^4;   %m00 and mu00 are the same

return

m.m10 = sum(x .* F);
m.m01 = sum(y .* F);
m.m11 = sum(x .* y .* F);

m.m30 = sum(x.^3 .* F);
m.m03 = sum(y.^3 .* F);
m.m12 = sum(x .* y.^2 .* F);
m.m21 = sum(x.^2 .* y .* F);
