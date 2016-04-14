function [ perimeter, area ] = convex_hull_properties( hull )
% compute the area of a convex hull.
% hull should be a 2-column matrix of coordinates

% first compute length of each edge
% i.e., distance between each adjacent pair of vertices
hull2 = circshift(hull,1,1);
A = sqrt(sum((hull - hull2).^2,2));

% perimeter

% perimeter is just the sum of all edge lengths
perimeter = sum(A);

% area

% compute area of hull polygon
area = polyarea(hull(:,1),hull(:,2));

% add a half-pixel area for each unit distance along perimeter
% to adjust for rasterization
area = area + (perimeter / 2);

end

