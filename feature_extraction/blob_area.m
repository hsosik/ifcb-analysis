function [ area ] = blob_area( blob_image )
% given an image of a blob (i.e., a mask), return the area of the mask in
% pixels

blob_min = 200; % FIXME magic number

%cc = bwconncomp(blob_image);
%t = regionprops(cc, 'Area');
t = regionprops(logical(blob_image), 'Area');
idx = find([t.Area] > blob_min);
%BW2 = ismember(labelmatrix(cc), idx); %need this? use for next call to region props or better to do all at once?
area = sum([t(idx).Area]);

% t = regionprops(logical(blob_image), 'Area');
% if ~isempty(t),  %this is case with a detectable blob
%     s = cat(1, t.Area);
%     temp = s > blob_min;
%    area = sum(s(temp)); 
% else    
%     area = NaN;  %case where no blobs
% end;

end

