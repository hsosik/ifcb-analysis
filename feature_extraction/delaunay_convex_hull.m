function [ hull ] = delaunay_convex_hull( x, y )
% x, y are the points to compute the convex hull for
% hull is a 2-column vector of points on the hull

boundaries = horzcat(x,y);
dt = delaunayTriangulation(boundaries);
hull = dt.Points(dt.convexHull,:);

end

