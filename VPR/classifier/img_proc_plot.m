function [  ] = img_proc_plot( target, img_pc, img_edge, img_dark)
% function [  ] = img_proc_plot( img, img_pc, img_edge, img_dark, img_blob )
% produce figure for manual inspection, given input image set (original, phase congruency, edge, 
% dark areas, and b&w blob mask)
% Heidi M. Sosik, Woods Hole Oceanographic Institution, Oct 2011

img = target.image;
img_blob = target.blob_image;

figure(1), clf
subplot(2,3,1), imshow(img); title('original')
    perimeter = bwboundaries(img_blob, 'noholes');
    subplot(2,3,1), hold on
    for count = 1:length(perimeter),
        plot(perimeter{count}(:,2), perimeter{count}(:,1), 'r')
    end;
    %plot(target.blob_prop
subplot(2,3,2), imshow(img_pc); title('phase cong')
subplot(2,3,3), imshow(img_edge); title('edges')
subplot(2,3,4), imshow(img_dark); title('dark areas')
subplot(2,3,5), imshow(img_blob); title('blob')
end

