%test revolve algorithm with circular blobs

sphereVec = 10:10:500;
SAalg = nan(size(sphereVec));
Valg = SAalg;
PAalg = SAalg;

for i = 1:length(sphereVec)
   start = cputime();
    d = sphereVec(i);
    disp(strcat('Looping sphere diameter: ', num2str(d)));
    r = d/2;
    [rr cc] = meshgrid(1:d+3); %set full image size, make sure 1-pixel border all around
    R=r; cx1=R+2; cy1=R+2; %set radius, center location
    blob_img = sqrt((rr-cx1).^2+(cc-cy1).^2)<=R;
    imshow(blob_img), caxis auto
    pause
    [SAalg(i) Valg(i)] = surface_area_revolve_2e(blob_img); 
       if 1
           b =  bwboundaries(blob_img,8,'noholes');
           [M N] = size(blob_img);
           perim_img = bound2im(b{1},M,N);
           [Vdm(i) xdm(i) SAdm(i) ] = distmap_volume(perim_img);
        end
        
    PAalg(i) = sum(blob_img(:)); %projected area just to test
end

PA = pi*(sphereVec./2).^2;
SA = 4 * pi * (sphereVec./2).^2;
V = 4 / 3 * pi * (sphereVec./2).^3;
error = (SAalg - SA) ./ SA * 100;
errorV = (Valg - V) ./ V * 100;
errorPA = (PAalg - PA) ./ PA * 100;

figure
plot(sphereVec, error, '.-', 'linewidth', 2);
ylabel('Surface area error (%)')
xlabel('Sphere diameter (pixels)')
title('Spheres by revolution')

figure
plot(sphereVec, errorV, '.-', 'linewidth', 2);
ylabel('Volume error (%)')
xlabel('Sphere diameter (pixels)')
title('Spheres by revolution')
ylim([-1 1])
line(xlim, [0 0],'linestyle', '--', 'color', 'k')

figure
plot(sphereVec, errorPA, '.-', 'linewidth', 2);
ylabel('Projected area error (%)')
xlabel('Sphere diameter (pixels)')
title('Spheres by revolution')
ylim([-1 1])
line(xlim, [0 0],'linestyle', '--', 'color', 'k')
