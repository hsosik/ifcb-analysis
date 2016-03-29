function img_out = kmean_segment(img)
warning('off');
%segment image to conservatively identify dark pixels
img = im2single(img);
% use kmeans to separate the background and foreground using the intensity values of the image
[J, C, ~, ~] = kmeans(img(:),2, 'emptyaction', 'drop', 'Start', [0 1]');
while sum(isnan(C)), %handle error in kmeans due to random start
    [J, C, ~, ~] = kmeans(img(:),2, 'emptyaction', 'drop');
end;
[~,bkgd_ind] = max(C);
temp = min(img(J ==bkgd_ind));
J(img(:) > temp*.65) = bkgd_ind; %extend "background" to be conservative about what is labeled foreground
img = reshape(J,size(img));
% change the image to binary
img = im2bw(img, 1);
% if the foreground and background are reversed, invert them
if C(1) < C(2), %if foreground centroid isn't darker
    img = (~img); %swap zeros and ones so foreground is darker set
end
img_out = img; %output image segmented so darkest grayscale pixels = 1
end
