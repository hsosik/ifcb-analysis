function [ SA ] = distance_map2surface_area( dist, xr )
%function [ SA ] = distance_map2surface_area( dist, xr )
%For example:
%
%IFCB image processing: compute estimated 3-D surface area from distance map 
%(see Moberg and Sosik 2012, Limnol. Oceanogr. Methods, regarding distance map)
%
%Heidi M. Sosik, Woods Hole Oceanographic Institution, October 2015
%
%input variables:
%   dist: matrix of closest boundary of a closed region (computed in distance_map.m)
%   xr: representative transect length (compued in distance_map.m as xr = 4*nanmean(dist(:)) - 2;)

Z = dist; Z(isnan(Z)) = 0;
X = repmat((1:size(Z,2)),size(Z,1),1) ;
Y = repmat((1:size(Z,1))',1,size(Z,2)) ;

i2 = 1:size(Z,1)-1;
i1 = 2:size(Z,1);
ia2 = 1:size(Z,2)-1;
ia1 = 2:size(Z,2);

% (i2,ia2) gives A
% (i1,ia2) gives B
% (i2,ia1) gives C
% (i1,ia1) gives D

% Create line segment AB
AB1(:,:)  = X(i2,ia2) - X(i1,ia2) ;
AB2(:,:)  = Y(i2,ia2) - Y(i1,ia2) ;
AB3(:,:)  = Z(i2,ia2) - Z(i1,ia2) ;

% Create line segment AD
AD1(:,:)  = X(i2,ia2) - X(i1,ia1) ;
AD2(:,:)  = Y(i2,ia2) - Y(i1,ia1) ;
AD3(:,:)  = Z(i2,ia2) - Z(i1,ia1) ;

% Create line segment CD
CD1(:,:) = X(i2,ia1) - X(i1,ia1) ;
CD2(:,:) = Y(i2,ia1) - Y(i1,ia1) ;
CD3(:,:) = Z(i2,ia1) - Z(i1,ia1) ;
% 
% Create bottom 3-D triangles of each quadrilateral
leg1 = (AB2(:,:).*AD3(:,:) - AB3(:,:).*AD2(:,:)).^2 ;
leg2 = (AB3(:,:).*AD1(:,:) - AB1(:,:).*AD3(:,:)).^2 ;
leg3 = (AB1(:,:).*AD2(:,:) - AB2(:,:).*AD1(:,:)).^2 ;
AREA_BOT = 0.5*sqrt(leg1 + leg2 + leg3) ;

% Create top 3-D triangles of each quadrilateral
leg1 = (CD2(:,:).*AD3(:,:) - CD3(:,:).*AD2(:,:)).^2 ;
leg2 = (CD3(:,:).*AD1(:,:) - CD1(:,:).*AD3(:,:)).^2 ;
leg3 = (CD1(:,:).*AD2(:,:) - CD2(:,:).*AD1(:,:)).^2 ;
AREA_TOP = 0.5*sqrt(leg1 + leg2 + leg3) ;

%SA = (sum(AREA_BOT(:)) + sum(AREA_TOP(:))) ; 

% Find all the facets that lie in the Z = 0 plane
ind = abs(AB3(:,:)) + abs(AD3(:,:)) + abs(CD3(:,:)) + Z(i2,ia2) ;
gg = find(ind == 0) ;
AREA_BOT(gg) = 0;
AREA_TOP(gg) = 0;
%c = pi/2/sqrt(2);
c = pi*xr/2./(2*sqrt(2)*xr/2+(1+sqrt(2))/2);
SA = 2*c*(sum(AREA_BOT(:)) + sum(AREA_TOP(:))) ; 
end

%return 
%odd
%pi*D/2 vs 2*sqrt(2)*(D/2+1/2)) = 2*sqrt(2)*D/2+sqrt(2)
%even
%pi*D/2 vs 2*sqrt(2)*D/2+1
%mean = pi*D/2/(2*sqrt(2)*D/2 + (1+sqrt(2))/2)
%expect odd overest, even underest