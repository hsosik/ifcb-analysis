function [ SA V xr ] = surface_area_revolve_2e( blob )

[~,y1] = max(blob);
r = (sum(blob));
ri = find(r); 
xr = mean(r(ri)); %"representative" transect length for output
r = r/2;
%ri = [ri ri(end)]; %use this to assume last pixel column has flat top/bottom edges (i.e., just a disk, not a conical frustum)
r = r(ri); %subtract 0.5 for case of half pixel off edges
y1 = y1(ri);
%y1 = [ 0 y1 0 ] ; %this for cone ends down to zero
%r = [0 r 0];

da = .25;
angvec = 0:da:180;
angR = angvec*pi/180; % radians
angR = repmat(angR,length(r),1);
i2 = 1:length(r)-1;
i1 = 2:length(r);
ia2 = 1:length(angvec)-1;
ia1 = 2:length(angvec);
r = repmat(r',1,length(angvec));
y1 = repmat(y1',1,length(angvec));
center = y1+r;
center([1,end],:) = center([2,end-1],:);

% center(1,:) = center(2,:) ;
% center(end,:) = center(end-1,:) ;
Y = center + cos(angR).*r ;
Z = sin(angR).*r ;
x = (1:size(Y,1)) ;
x(1) = x(1)-0.5; x(end) = x(end)+.5;
X = repmat(x',1,length(angvec)) ;  

% Assume spacing along z axis (left to right) = 1
% If you want it to be something different, you need to put it in X above
% and uncomment a bunch of stuff

% Now consider the quadraliterals with vertices A, B, C, D where A = leftmost, bottom point, B =
% rightmost, bottom point, C = leftmost top point, and D = rightmost top point
%
% (i2,ia2) gives A
% (i1,ia2) gives B
% (i2,ia1) gives C
% (i1,ia1) gives D

%AB  = zeros(size(X,1)-1,size(X,2)-1,3) ;
%AD  = zeros(size(X,1)-1,size(X,2)-1,3) ;
%CD  = zeros(size(X,1)-1,size(X,2)-1,3) ;

% Create line segment AB
AB1(:,:)  = [X(i2,ia2) - X(i1,ia2)] ;
AB2(:,:)  = [Y(i2,ia2) - Y(i1,ia2)] ;
AB3(:,:)  = [Z(i2,ia2) - Z(i1,ia2)] ;

% Create line segment AD
AD1(:,:)  = [X(i2,ia2) - X(i1,ia1)] ;
AD2(:,:)  = [Y(i2,ia2) - Y(i1,ia1)] ;
AD3(:,:)  = [Z(i2,ia2) - Z(i1,ia1)] ;

% Create line segment CD
CD1(:,:) = [X(i2,ia1) - X(i1,ia1)] ;
CD2(:,:) = [Y(i2,ia1) - Y(i1,ia1)] ;
CD3(:,:) = [Z(i2,ia1) - Z(i1,ia1)] ;
% 
% Create bottom 3-D triangles of each quadrilateral
leg1 = squeeze((AB2(:,:).*AD3(:,:) - AB3(:,:).*AD2(:,:)).^2) ;
leg2 = squeeze((AB3(:,:).*AD1(:,:) - AB1(:,:).*AD3(:,:)).^2) ;
leg3 = squeeze((AB1(:,:).*AD2(:,:) - AB2(:,:).*AD1(:,:)).^2) ;
AREA_BOT = 0.5*sqrt(leg1 + leg2 + leg3) ;

% Create top 3-D triangles of each quadrilateral
leg1 = squeeze((CD2(:,:).*AD3(:,:) - CD3(:,:).*AD2(:,:)).^2) ;
leg2 = squeeze((CD3(:,:).*AD1(:,:) - CD1(:,:).*AD3(:,:)).^2) ;
leg3 = squeeze((CD1(:,:).*AD2(:,:) - CD2(:,:).*AD1(:,:)).^2) ;
AREA_TOP = 0.5*sqrt(leg1 + leg2 + leg3) ;

SA = 2*(sum(AREA_BOT(:)) + sum(AREA_TOP(:))) ; % Factor of 2 is because only did top half of revolution
SA = SA + sum(pi*r([1,end],1).^2); %add flat end caps

b1 = pi * r(i1,1).^2;
b2 = pi * r(i2,1).^2;
%h = 1; % assume 1-pixel high cone slices
h = diff(x)'; %height of cone slices
V = sum(h/3 .* (b1 + b2 + sqrt(b1.*b2)));
% % Area of first conical end
% foo1 = 2*(sum(AREA_BOT(1,:)') + sum(AREA_TOP(1,:)')) ;
% 
% % Area of first cylinder
% foo2a = AREA_BOT(2:50,:) ; foo2a = sum(foo2a(:)) ;
% foo2b = AREA_TOP(2:50,:) ; foo2b = sum(foo2b(:)) ;
% foo2 = 2*(foo2a+foo2b) ;
% 
% % Area of transition
% foo3 = 2*(sum(AREA_BOT(51,:)') + sum(AREA_TOP(51,:)')) ;
% 
% % Area of second cylinder
% foo4a = AREA_BOT(52:100,:) ; foo4a = sum(foo4a(:)) ;
% foo4b = AREA_TOP(52:100,:) ; foo4b = sum(foo4b(:)) ;
% foo4 = 2*(foo4a + foo4b) ;
% 
% % Area of second conical end
% foo5 = 2*sum(AREA_BOT(101,:)') + sum(AREA_TOP(101,:)')) ;
% [foo1 ; foo2 ; foo3 ; foo4 ; foo5]
end