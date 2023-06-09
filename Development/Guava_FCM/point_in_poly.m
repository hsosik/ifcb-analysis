function [ind_poly, vertices]=point_in_poly(data,subplot_num,varargin)
% identifies points that are in a polygon using ray-intersection rule - a point is inside the
% polygon if the number of times it crosses an edge is odd, and outside if
% the number of times it crosses is even. Retruns indices of points inside
% the polygon.

%Gating script! Ah-ha!
%subplot(211)
axes(subplot_num);
%gcf=subplot_num;

if isempty(varargin)
    h=impoly;
    vertices=getPosition(h);
    hold on
    plot(vertices(:,1),vertices(:,2),'r*')
    %first find everything that's in a square designated by the vertices-this
    %cuts down on the number of points to evaluate.
else
    h=impoly(gca,varargin{:});
    disp('Adjust gate as necessary; then hit any key to return')
    
    pause
    
    vertices=getPosition(h);
    hold on
    plot(vertices(:,1),vertices(:,2),'g*')
end


%construct the box:
xcorners=[min(vertices(:,1)) max(vertices(:,1))];
ycorners=[min(vertices(:,2)) max(vertices(:,2))];
% corners=[xcorners(1) ycorners(1); xcorners(1) ycorners(2); xcorners(2) ycorners(1); xcorners(2) ycorners(2)];
%lower left, upper left, lower right, upper right

%Go through each pair of vertices, and find points that are
%above/below the line to include in the final polygon
% synblock=fcsdat(:,[2 4]); %2,4 for FACS 1, 3 %for EPICS
% synblock=double(data); %in case still in unit notation

%if want to constrain data in a smaller box:
% ii= synblock(:,1) < xcorners(1);
% synblock(ii,:)=0;
% ii= synblock(:,1) > xcorners(2);
% synblock(ii,:)=0;
% ii= synblock(:,2) < ycorners(1);
% synblock(ii,:)=0;
% ii=find(synblock(:,2) > ycorners(2));
% synblock(ii,:)=0;
%
% ii=find(synblock(:,1)~=0);
% synblock=synblock(ii,:);

%Now fit a line between each of the two adjacent vertices:
%
pt=double(data);
M=(vertices(2:end,2)-vertices(1:end-1,2))./(vertices(2:end,1)-vertices(1:end-1,1));
M=[M; (vertices(end,2)-vertices(1,2))./(vertices(end,1)-vertices(1,1))];

B=vertices(:,2)-M.*vertices(:,1);
M=M'; B=B';
vert_slp=[];
if any(isinf(M)) %means there may be a vertical line...
    vert_slp=find(isinf(M));
    %  keyboard
end

%Don't really need this - tend to ignore points on horizontal edge...
% horiz_slp=[];
% if any((M==0)) %means there may be a vertical line...
%     horiz_slp=find(M==0);
%     %  keyboard
% end
%eval all points within the box and see where they would intersect each
%edge. Do this by seeing where a horizontal ray would cross, and if that
%crossing would be in the edge:

[n ~]=size(pt); m=length(vertices);
%see if point crosses edge: x coordinate must be inside box and y
%coordinate must be within the two edge y coordinates:
testx=(repmat(pt(:,2),1,m)-repmat(B,n,1))./repmat(M,n,1); %xcoordinates of edge-line intersection with ray

isin_x=(repmat(pt(:,1),1,m)-testx).*(repmat(xcorners(2),n,m)-testx);  %negative value means within x range, positive outside, 0 is on the edge

% Special handling for vertical edges to see if points cross:
if ~isempty(vert_slp)
    for j=1:length(vert_slp)
        isin_x(:,vert_slp(j))=1; %default positive and outside the x
        jj= pt(:,1) < vertices(vert_slp(j),1); %ray will cross if x-value is less than this vertical edge
        isin_x(jj,vert_slp(j))=-1;      
        %repmat(vertices(vert_slp(j)),n,1);
    end
end

testv1=vertices(:,2)'; testv2=[vertices(2:end,2); vertices(1,2)]';
isin_y=(repmat(pt(:,2),1,m)-repmat(testv1,n,1)).*(repmat(pt(:,2),1,m)-repmat(testv2,n,1)); %negative value means within edge y's, positive is outside

num_xings=sum((isin_y<0).*(isin_x<0),2); %if even outside the polygon, if odd inside

test_odd=floor(num_xings/2)-(num_xings/2); %if not 0, then 1!
ind_poly= test_odd~=0;
% syngroup=synblock(ind_poly,:);

end
