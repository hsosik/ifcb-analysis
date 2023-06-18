clear
split_cylinders = false;
roiLvec = [100:200:1000 ]; %2000 5000 10000]; %list of lengths
border = 10; %size of edge around blob
%loop over all possible length & height combos
roiLvec = [200:200:1000 2000 5000 10000]; %list of lengths
if split_cylinders
    roiHvec = 20:20:80; %list of heights
else
    roiHvec = [20:21 30:31 40 41]; %list of heights
end
for ii = 1:length(roiHvec);
    for iii = 1:length(roiLvec),
        roiH = roiHvec(ii); roiL = roiLvec(iii);
        blob_img = zeros([roiH roiL]+border*2,'uint8');
        blob_img(border+1:border+roiH, border+1:border+roiL) = 1;
        if split_cylinders
            blob_img(border+1:border+(roiH/2), border+1:border+(roiL/2)) = 0; % half skinnier cylinder
        end
      %  imshow(blob_img), caxis auto
        %[SAalg(ii,iii) Valg(ii,iii)] = surface_area_revolve_2b(blob_img); %your function here
        [SAalg(ii,iii) Valg(ii,iii)] = surface_area_revolve_2e(blob_img); %your function here
        if 1
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

if ~split_cylinders
    %one cylinder with flat ends
    SA = 2*pi*((roiHmat/2).^2) + pi*roiHmat.*roiLmat; % in square pixels
    V = pi*(roiHmat/2).^2.*roiLmat;
else
    %%case for half skinnier cylinder, flat ends
    %roiLmat = roiLmat-1;
    SA = pi*(roiHmat)/2.*(roiLmat)/2 + pi*(roiHmat).*(roiLmat)/2 + pi*((roiHmat)/2).^2 + pi*((roiHmat)/2/2).^2  + pi*((roiHmat)/2).^2 - pi*((roiHmat)/2/2).^2;
    %estimate with two perfect cylinders
    %V = pi*(roiHmat/2).^2.*roiLmat/2 + pi*(roiHmat/2/2).^2.*roiLmat/2;
    %true case with cone at joint
    V = pi*(roiHmat/2).^2.*(roiLmat/2-.5) + pi*(roiHmat/2/2).^2.*(roiLmat/2-.5) + pi/3*((roiHmat/2).^2+(roiHmat/4).^2 +sqrt((roiHmat/2).^2.*(roiHmat/4).^2));
end

%next 4 lines case for half skinnier cylinder with cone ends, but flat edge between
%r1 = (roiHmat-1)/2;
%r2 = (roiHmat/2-1)/2;
% roiLmat = roiLmat-1;
% SA = pi*r1.*(sqrt(1+r1.^2)) + pi*r2.*(sqrt(1+r2.^2)) + ...
%     pi*2*r1.*(roiLmat/2-1) + pi*2*r2.*(roiLmat/2-1) + pi*r1.^2 - pi*r2.^2;

%lateral area without endcaps
%SA = pi.*(roiHmat-0).*(roiLmat-0); % in square pixels

%r = roiHmat/2;
%SA = 2*pi*r.*(sqrt(1+r.^2)) + pi*roiHmat.*roiLmat; % in square pixels; case for cone end
%V = pi*(roiHmat/2).^2.*roiLmat + 2*pi/3*r.^2; %cylinder with cone ends

%From error comparisons for distance map approach for SA, seems clear that
%approach is correct wihout removal of any half pixel from edges.
%To be consistent, the revolve approach should also not have half pixels
%removed from edges. 
%So either, consider first and last pixel slice to be 1.5 pixels wide with
%slant from difference between adjacent heights OR include a flat pixel (no
%slant) on one end or the other. 

error = (SAalg./SA - 1) * 100;
error2 = (SAdm./SA - 1) * 100;
errorV = (Valg./V - 1) * 100;
errorV2 = (Vdm./V - 1) * 100;

if ~split_cylinders
    figure
    th = plot(roiLvec, error2, '.-', 'linewidth', 2);
    set(th([2 4 6]), 'linestyle', ':') %make odd widths dotted
    ylabel('Surface area error (%)')
    xlabel('Cylinder length (pixels)')
    title('Cylinders by distance map')
    hlegend = legend(num2str(roiHvec'), 'location', 'southeast');
    hlt = text('Parent', hlegend.DecorationContainer, 'String', 'Width', 'HorizontalAlignment', 'center',...
        'VerticalAlignment', 'bottom', 'Position', [0.5, 1.05, 0], 'Units', 'normalized');
    line(xlim, [0 0],'linestyle', '--', 'color', 'k')
    
    figure
    th = plot(roiLvec, errorV2, '.-', 'linewidth', 2);
    set(th([2 4 6]), 'linestyle', ':') %make odd widths dotted
    ylabel('Volume error (%)')
    xlabel('Cylinder length (pixels)')
    title('Cylinders by distance map')
    hlegend = legend(num2str(roiHvec'), 'location', 'southeast');
    hlt = text('Parent', hlegend.DecorationContainer, 'String', 'Width', 'HorizontalAlignment', 'center',...
        'VerticalAlignment', 'bottom', 'Position', [0.5, 1.05, 0], 'Units', 'normalized');
    line(xlim, [0 0],'linestyle', '--', 'color', 'k')
    
    figure
    th = plot(roiLvec, error, '.-', 'linewidth', 2);
    set(th([2 4 6]), 'linestyle', ':') %make odd widths dotted
    ylabel('Surface area error (%)')
    xlabel('Cylinder length (pixels)')
    title('Cylinders by revolution')
    hlegend = legend(num2str(roiHvec'), 'location', 'southeast');
    hlt = text('Parent', hlegend.DecorationContainer, 'String', 'Width', 'HorizontalAlignment', 'center',...
        'VerticalAlignment', 'bottom', 'Position', [0.5, 1.05, 0], 'Units', 'normalized');
    ylim([-.01 .01])
    
    figure
    th = plot(roiLvec, errorV, '.-', 'linewidth', 2);
    set(th([2 4 6]), 'linestyle', ':') %make odd widths dotted
    ylabel('Volume error (%)')
    xlabel('Cylinder length (pixels)')
    title('Cylinders by revolution')
    hlegend = legend(num2str(roiHvec'), 'location', 'southeast');
    hlt = text('Parent', hlegend.DecorationContainer, 'String', 'Width', 'HorizontalAlignment', 'center',...
        'VerticalAlignment', 'bottom', 'Position', [0.5, 1.05, 0], 'Units', 'normalized');
    ylim([-.01 .01])
end

if split_cylinders
    figure
    plot(roiLvec, error2, '.-', 'linewidth', 2)
    ylabel('Surface area error (%)')
    xlabel('Cylinder length (pixels)')
    title('Two cylinders by distance map')
    hlegend = legend(num2str(roiHvec'), 'location', 'southeast');
    hlt = text('Parent', hlegend.DecorationContainer, 'String', 'Width', 'HorizontalAlignment', 'center',...
        'VerticalAlignment', 'bottom', 'Position', [0.5, 1.05, 0], 'Units', 'normalized');
    line(xlim, [0 0],'linestyle', '--', 'color', 'k')
    
    figure
    plot(roiLvec, errorV2, '.-', 'linewidth', 2)
    ylabel('Volume error (%)')
    xlabel('Cylinder length (pixels)')
    title('Two cylinders by distance map')
    hlegend = legend(num2str(roiHvec'), 'location', 'southeast');
    hlt = text('Parent', hlegend.DecorationContainer, 'String', 'Width', 'HorizontalAlignment', 'center',...
        'VerticalAlignment', 'bottom', 'Position', [0.5, 1.05, 0], 'Units', 'normalized');
    line(xlim, [0 0],'linestyle', '--', 'color', 'k')
    
    figure
    plot(roiLvec, error, '.-', 'linewidth', 2)
    ylabel('Surface area error (%)')
    xlabel('Cylinder length (pixels)')
    title('Two cylinders by revolution')
    hlegend = legend(num2str(roiHvec'), 'location', 'southeast');
    hlt = text('Parent', hlegend.DecorationContainer, 'String', 'Width', 'HorizontalAlignment', 'center',...
        'VerticalAlignment', 'bottom', 'Position', [0.5, 1.05, 0], 'Units', 'normalized');
    %ylim([-.01 .01])
    
    figure
    plot(roiLvec, errorV, '.-', 'linewidth', 2)
    ylabel('Volume error (%)')
    xlabel('Cylinder length (pixels)')
    title('Two cylinders by revolution')
    hlegend = legend(num2str(roiHvec'), 'location', 'southeast');
    hlt = text('Parent', hlegend.DecorationContainer, 'String', 'Width', 'HorizontalAlignment', 'center',...
        'VerticalAlignment', 'bottom', 'Position', [0.5, 1.05, 0], 'Units', 'normalized');
    ylim([-1 1])
end

%note for split cylinders:
%cone between two segments has smaller volume than sum of two half pixels,
%one from each cylinder - and the difference between those volumes gets
%smaller as diameter increases. 