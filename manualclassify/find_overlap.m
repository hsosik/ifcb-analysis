function [ offsetx_est, offsety_est ] = find_overlap( imgA, imgB )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

%imgA1 = imgA - mode(imgA(:)) ;
%imgB1 = imgB - mode(imgA(:)) ;
imgA1 = imgA - mode([imgA(:); imgB(:)]) ;
imgB1 = imgB - mode([imgA(:); imgB(:)]) ;

R = xcorr2(imgB1,imgA1) ;
Rnorm = xcorr2(abs(imgB1),abs(imgA1)) ;
Rcheck = R - Rnorm ; 

z = find(Rcheck(:) == 0) ; % Find offsets with perfect correlation
offsetx_est = NaN;
offsety_est = NaN;
if ~isempty(z),
[zind(:,1) zind(:,2)] = ind2sub([size(imgA,1)+size(imgB,1)-1 size(imgA,2)+size(imgB,2)-1], z) ;

% Determine the associated size of the overlap regions
m = ones(1,size(imgA,1)) ;
n = ones(1,size(imgB,1)) ;
overlap_cols = xcorr(n,m) ;

m = ones(1,size(imgA,2)) ;
n = ones(1,size(imgB,2)) ;
overlap_rows = xcorr(n,m) ;
zind(:,3) = overlap_cols(zind(:,1)) .* overlap_rows(zind(:,2)) ;

% Figure out what delays they correspond to
offx = (-size(imgA,1)+1:(size(imgB,1))) ;
offy = (-size(imgA,2)+1:(size(imgB,2))) ;

zind(:,1) = offx(zind(:,1)) ;
zind(:,2) = offy(zind(:,2)) ;

% Select the perfect correlation offset that corresponds to the biggest overlap
[a b] = max(zind(:,3));
%figure(6), plot(zind(:,3), '.-')

offsetx_est = -zind(b,1);
offsety_est = -zind(b,2);

% xpos_temp = [1; offsetx_est];
% ypos_temp = [1; offsety_est];
% 
%xr = [xpos_temp xpos_temp + [size(imgA,1); size(imgB,1)]-1];
%yr = [ypos_temp ypos_temp + [size(imgA,2); size(imgB,2)]-1];

s = intersect(0:size(imgA,1)-1, offsetx_est:size(imgB,1) + offsetx_est - 1);
t = intersect(0:size(imgA,2)-1, offsety_est:size(imgB,2) + offsety_est - 1);

%check to make sure the peak is a real overlap with no pixel differences
if isempty(t) || isempty(s), keyboard, end;
if ~isempty(find(imgA(s+1,t+1)-imgB(s-offsetx_est+1,t-offsety_est+1), 1)),
    offsetx_est = NaN;
    offsety_est = NaN;
end;
end;

end
