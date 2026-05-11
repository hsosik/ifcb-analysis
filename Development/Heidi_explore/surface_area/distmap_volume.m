 function [ volume x surface_area ] = distmap_volume_test( boundary_image )
% [ volume ] = distmap_volume( boundary_image )
% distmap_volume( boundary_image ) returns the volume in pixel cubes 
% of a target with complex closed boundary shape indicated in the 
% black and white 2D boundary_image (boundary pixels set to 1)
%
% Volume is derived according to the distance map approach 
% of Moberg and Sosik (2012), Limnology and Oceanography: Methods    
% 
% Emily A. Moberg and Heidi M. Sosik
% Woods Hole Oceanographic Institution, 2012
%
% updated to also return a surface area estimate, October 2015, Heidi

% calculate distance map (SciPy-matching EDT)
dist = bwdist_scipy(~boundary_image); 
dist = dist + 1;

% mask distance map image (all distances outside boundary set to NaN)
image_fill = imfill(boundary_image,'holes'); 
dist(image_fill==0) = NaN; 
% deterministic single-precision sum/mean (column-major)
flat = dist(:);
sum_val = single(0.0); count = 0;
for i = 1:numel(flat)
    v = flat(i);
    if ~isnan(v)
        sum_val = single(sum_val + single(v));
        count = count + 1;
    end
end
mean_val = single(sum_val / single(count));
% find representative transect length
x = single(4.0) * mean_val - single(2.0);

% define cross-section correction factors 
% pyramidal cross-section to interpolated diamond
c1 = (x^2)/(x^2 + 2*x + single(1/2));  
% diamond to circumscribing circle
c2 = single(pi/2);

% calculate final volume applying correction factors to distance map
volume = single(c1 * c2 * single(2.0) * sum_val); 

surface_area = distance_map2surface_area4(dist, x);

end
