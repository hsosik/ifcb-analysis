% HYSTHRESH - Hysteresis thresholding
%
% Usage: bw = hysthresh(im, T1, T2)
%
% Arguments:
%             im  - image to be thresholded (assumed to be non-negative)
%             T1  - upper threshold value
%             T2  - lower threshold value
%
% Returns:
%             bw  - the thresholded image (containing values 0 or 1)
%
% Function performs hysteresis thresholding of an image.
% All pixels with values above threshold T1 are marked as edges
% All pixels that are adjacent to points that have been marked as edges
% and with values above threshold T2 are also marked as edges. Eight
% connectivity is used.
%
% It is assumed that the input image is non-negative
%

% Joe Futrelle 2016 - impl using morphological and other
% elementwise operations


function bw = hysthresh(im, T1, T2)

persistent se; %structuring elemement for morphological processing

if isempty(se)
    se = strel('rectangle',[3 3]);
end;

if (T2 > T1 || T2 < 0 || T1 < 0)  % Check thesholds are sensible
  error('T1 must be >= T2 and both must be >= 0 ');
end

bw = im > T1;
s = 1;
while s > 0
    bd = (imdilate(bw,se) & (im > T2)) - bw;
    bw = bw | bd;
    s = sum(bd(:));
end
