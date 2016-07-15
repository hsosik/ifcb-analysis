function [ V xr SA ] = surface_area_revolve_2e( blob )
%[ V xr SA ] = surface_area_revolve_2e( blob )
% given an image of a blob (i.e., a mask), return the volume and surface
% area computed for a solid of revolution
% assumes input blob is already rotated to align the major axis horizontally
%
% Imaging FlowCytobot analysis 
% Heidi M. Sosik, Woods Hole Oceanographic Institution, March 2016
%
% Based on algorithm contributions from Louis Kilfoyle, February 2016

[~,y1] = max(blob); % find the "bottom" point of the circle for each slice
r = (sum(blob)); % find the diameter of the circle for each slice
ri = find(r); % find all diameter > 0 (the slice actually exists)
r = r/2; % turn diameters into radii
r = r(ri); % only store radii that actually exist ( r > 0 )
y1 = y1(ri); % only store first point of circle for circles that exist ( r > 0 )

da = .25; % the arc amount in degrees of each triangular facet base
angvec = 0:da:180; % how many degrees to step along
% we only go to 180 since 0 to 180 and 180 to 360 are equivalent
% we can save time by just doubling after 180
angR = angvec*pi/180; % radian version of angles
angR = repmat(angR,length(r),1); % format vector into matrix for operations
% select indices of neighbors for comparison
i2 = 1:length(r)-1; % select "left" radii neighbors
i1 = 2:length(r); % select "right" radii neighbors
ia2 = 1:length(angvec)-1; % select "left" angle neighbors
ia1 = 2:length(angvec); % select "right" angle neighbors
r = repmat(r',1,length(angvec)); % format vector into matrix for operations
y1 = repmat(y1',1,length(angvec)); % format vector into matrix for operations
center = y1+r; % find the center of the circle for each slice
center([1,end],:) = center([2,end-1],:); % avoid effects at ends

Y = center + cos(angR).*r ; % Y coordinates of all angles on all circles
Z = sin(angR).*r ; % Z coords of all angles on all circles
x = (1:size(Y,1)) ; % x coord is index of the slice in Y matrix
% by nature this method cuts off 1 pixel worth of the shape right in the
% middle. to account for this, we add a half pixel to each end
x(1) = x(1)-0.5; x(end) = x(end)+.5; % add the half pixel
X = repmat(x',1,length(angvec)) ; % format the vector into matrix for operations

% Now consider the quadraliterals with vertices A, B, C, D where A = leftmost, bottom point, B =
% rightmost, bottom point, C = leftmost top point, and D = rightmost top point
%
% (i2,ia2) gives A
% (i1,ia2) gives B
% (i2,ia1) gives C
% (i1,ia1) gives D

% area of the triangular facet is given by:
% A = .5 * sqrt((x2*y3 - x3*y2)^2 + (x3*y1-x1*y3)^2 + (x1*y2 - x2*y1)^2)

% each quadrilateral forms two triangles split by segment AD
% so we use the above formula twice, once where x1,x2,x3 are given by AB
% and once where x1,x2,x3 are given by CD

% Create line segments AB for all quadrilaterals
AB1(:,:)  = [X(i2,ia2) - X(i1,ia2)] ; % this is x1 in our formula
AB2(:,:)  = [Y(i2,ia2) - Y(i1,ia2)] ; % this is x2 in our formula
AB3(:,:)  = [Z(i2,ia2) - Z(i1,ia2)] ; % this is x3 in our formula

% Create line segments AD for all quadrilaterals
AD1(:,:)  = [X(i2,ia2) - X(i1,ia1)] ; % this is y1 in our formula
AD2(:,:)  = [Y(i2,ia2) - Y(i1,ia1)] ; % this is y2 in our formula
AD3(:,:)  = [Z(i2,ia2) - Z(i1,ia1)] ; % this is y3 in our formula

% Create line segments CD for all quadrilaterals
CD1(:,:) = [X(i2,ia1) - X(i1,ia1)] ; % this is x1 in our formula
CD2(:,:) = [Y(i2,ia1) - Y(i1,ia1)] ; % this is x2 in our formula
CD3(:,:) = [Z(i2,ia1) - Z(i1,ia1)] ; % this is x3 in our formula

% Create triangle formed by AB and AD for all quadrilaterals
leg1 = squeeze((AB2(:,:).*AD3(:,:) - AB3(:,:).*AD2(:,:)).^2) ;
leg2 = squeeze((AB3(:,:).*AD1(:,:) - AB1(:,:).*AD3(:,:)).^2) ;
leg3 = squeeze((AB1(:,:).*AD2(:,:) - AB2(:,:).*AD1(:,:)).^2) ;
AREA_BOT = 0.5*sqrt(leg1 + leg2 + leg3) ; % calc area using formula

% Create triangle formed by CD and AD for all quadrilaterals
leg1 = squeeze((CD2(:,:).*AD3(:,:) - CD3(:,:).*AD2(:,:)).^2) ;
leg2 = squeeze((CD3(:,:).*AD1(:,:) - CD1(:,:).*AD3(:,:)).^2) ;
leg3 = squeeze((CD1(:,:).*AD2(:,:) - CD2(:,:).*AD1(:,:)).^2) ;
AREA_TOP = 0.5*sqrt(leg1 + leg2 + leg3) ; % calc area using formula

SA = 2*(sum(AREA_BOT(:)) + sum(AREA_TOP(:))) ; % times 2 to account for angles 180 - 360
SA = SA + sum(pi*r([1,end],1).^2); %add flat end caps

b1 = pi * r(i1,1).^2;
b2 = pi * r(i2,1).^2;
h = diff(x)'; %height of cone slices
V = sum(h/3 .* (b1 + b2 + sqrt(b1.*b2)));

xr = mean(r(:,1)*2);

end