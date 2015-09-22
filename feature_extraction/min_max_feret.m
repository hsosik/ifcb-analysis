function [maxD minD minP thetamax thetabox] = get_feret ( D )
%http://www.cb.uu.se/~cris/blog/index.php/archives/408
%D = D = t.ConvexHull

minD = Inf; minV = [];
maxD = 0;   maxV = [];
N = size(D,1);

p0 = N;
p = 1;
q = 2;
while area(D(p,:),D(next(p,N),:),D(next(q,N),:)) > ...
      area(D(p,:),D(next(p,N),:),D(q,:))
   q = next(q,N);
end
q0 = q;
while p~=p0
   p = next(p,N);
   listq = q;                       % p,q is an antipodal pair
   while area(D(p,:),D(next(p,N),:),D(next(q,N),:)) > ...
         area(D(p,:),D(next(p,N),:),D(q,:))
      q = next(q,N);
      listq = [listq,q];            % p,q is an antipodal pair
   end
   if area(D(p,:),D(next(p,N),:),D(next(q,N),:)) == ...
      area(D(p,:),D(next(p,N),:),D(q,:))
      listq = [listq,next(q,N)];    % p,q+1 is an antipodal pair
   end
   for ii=1:length(listq)
      q = mod(listq(ii)-1,N)+1;
      v = D(p,:)-D(q,:);
      d = norm(v);
      if d>maxD
         maxD = d;
         maxV = v;
      end
   end
   pt3 = D(p,:);
   for ii=1:length(listq)-1
      pt1 = D(listq(ii),:);
      pt2 = D(listq(ii+1),:);
      h = height(pt1,pt2,pt3);
      if h<minD
         minD = h;
         minV = pt2-pt1;
         pt4 = pt3 + minV*100;
         pt5 = pt3 - minV*100;
      end
   end
end

maxA = atan2(maxV(2),maxV(1));
minA = atan2(minV(2),minV(1))+pi/2;
minV = minV/norm(minV);
w = D*minV';
minP = max(w)-min(w);

fprintf('Object length: %.2f, at %.2f degrees\n',maxD,maxA*180/pi);
fprintf('Minimum bounding box: %.2f by %.2f, at %.2f degrees\n',...
        minD,minP,minA*180/pi);

    thetamax = maxA*180/p;
    thetabox = minA*180/p;

% Signed area of triangle
area = @(pt1,pt2,pt3) ( (pt2(1)-pt1(1))*(pt3(2)-pt1(2)) - ...
                        (pt2(2)-pt1(2))*(pt3(1)-pt1(1)) ) / 2;

% Height of triangle, pt3 is the top vertex
height = @(pt1,pt2,pt3) ( (pt2(1)-pt1(1))*(pt3(2)-pt1(2)) - ...
                          (pt2(2)-pt1(2))*(pt3(1)-pt1(1)) ) / ...
                                               norm(pt2-pt1);

% Next point along the polygon
next = @(p,N) mod(p,N)+1;


