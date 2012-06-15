function  isin = isinpoly(x,y,xp,yp)
% ISIN = ISINPOLY(X,Y,XP,YP)   Finds whether points with
%           coordinates X and Y are inside or outside of
%           a polygon with vertices XP, YP.
%           Returns matrix ISIN of the same size as X and Y
%           with 0 for points outside a polygon, 1 for
%           inside points and  0.5 for points belonging
%           to a polygon XP, YP itself.

%  Copyright (c) 1995  by Kirill K. Pankratov
%       kirill@plume.mit.edu
%       4/10/94, 8/26/94.

 % Handle input ::::::::::::::::::::::::::::::::
if nargin<4
  fprintf('\n  Error: not enough input arguments.\n\n')
  return
end

 % Make the contour closed and get the sizes
xp = [xp(:); xp(1)];
yp = [yp(:); yp(1)];
sz = size(x);
x = x(:); y = y(:);

lp = length(xp); l = length(x);
ep = ones(1,lp); e = ones(1,l);

 % Calculate cumulative change in azimuth from points x,y
 % to all vertices
A = diff(atan2(yp(:,e)-y(:,ep)',xp(:,e)-x(:,ep)'))/pi;
A = A+2*((A<-1)-(A>1));
isin = any(A==1)-any(A==-1);
isin = (abs(sum(A))-isin)/2;

 % Check for boundary points
A = (yp(:,e)==y(:,ep)')&(xp(:,e)==x(:,ep)');
fnd = find(any(A));
isin(fnd) = .5*ones(size(fnd));
isin = round(isin*2)/2;

 % Reshape output to the input size
isin = reshape(isin,sz(1),sz(2));
