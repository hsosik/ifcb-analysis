%side ways cone
%this didn't work out too easily, the pixelated cones are not accurate and
%it is hard to diagnose the errors; tried a simple two column blob with two different symmetric heights and
%checked it exactly by hand; the surface_area_revolve_2b script works as it is supposed to for that 
roiHvec = 10:10:100; %list of heights
roiLvec = 10:10:100; %list of lengths
border = 10; %size of edge around blob
%loop over all possible length & height combos
for ii = 1:length(roiHvec);
    for iii = 1:length(roiLvec),
        roiH = roiHvec(ii); roiL = roiLvec(iii);
        %y = floor(roiH./roiL*(0:roiL));
        y = roiH./roiL*(0:roiL) + mod(roiH,2);
        y = (y-mod(y,2)) - mod(roiH,2);
        y(y<0) = 0;
        blob_img = zeros([roiH roiL]+border*2,'uint8');
        center = round(roiH/2);
        %y = floor(center./roiL*(1:roiL));
        for c = 1:roiL+1
            blob_img(border+center-floor(y(c)/2)+(1:y(c)),border+c) = 1;
        end
        blob_img = fliplr(blob_img);
        %imshow(blob_img), caxis auto
        [SAalg(ii,iii) Valg(ii,iii)] = surface_area_revolve_2b(blob_img); %your function here
        PAalg(ii,iii) = sum(blob_img(:));
        if 0
           b =  bwboundaries(blob_img,8,'noholes');
           [M N] = size(blob_img);
           perim_img = bound2im(b{1},M,N);
           [Vdm(ii,iii) xdm(ii,iii) SAdm(ii,iii) ] = distmap_volume(perim_img);
        end
    end;
end;
roiHmat = repmat(roiHvec', 1,length(roiLvec));
roiLmat = repmat(roiLvec,length(roiHvec),1);
%roiHmat = roiHmat-1; roiLmat = roiLmat-1; %use this line for case of omit half pixel on each side (!!not consistent with distance map)
r = roiHmat./2;
SA = pi*r.*(r + sqrt(r.^2+roiLmat.^2)) + pi*r.^2; % in square pixels
PA = r.*roiLmat;
V = pi*(roiHmat/2).^2.*roiLmat;

error = (SAalg./SA - 1) * 100;
%error2 = (SAdm./SA - 1) * 100;
errorV = (Valg./V - 1) * 100;
%errorV2 = (Vdm./V - 1) * 100;
