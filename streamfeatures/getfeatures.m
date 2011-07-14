function [features1, perimeter1, pixidx1, FrDescp1, Centroid1, featitles] = getfeatures(img)
%function [features1, perimeter1, pixidx1, FrDescp1, Centroid1, featitles] = getfeatures(img, imgname)
%Heidi, Oct. 17, 2006 updated to correct index errors in calculations of HD90/HD180, HDupd/HD180, T, and E
%Heidi, Oct. 27, 2009 updated to correct minor bug ('sy <=' should be 'sy <' on line "if sx >= toolong & sy <= toolong")
warning('off')
se5 = strel('square', 5);  %used 20 with sedge, etc.
se2 = strel('square', 2);
se3 = strel('square', 3);
se4 = strel('square', 4);
%D = [1 2 4 16 32 64 128 256]';
D = [1 2 4 16 32 64]';
z = zeros(size(D));
offsets = [z D; -D D; -D z; -D -D];  %0, 45, 90, 135 degrees
numcom = length(offsets);
numD = length(D);
clear z

fearow = 1;  %count position for feature row start

[sx sy] = size(img);
%because phase congruency is time consuming on large images lower
%resolution on long sides before phasecong
toolong = 150;

if max([sx, sy]) >= toolong, %reduce resolution on long side(s)o
    if sx >= toolong & sy >= toolong
        sx = floor(sx/2)*2;
        sy = floor(sy/2)*2;
        img = imadd(imdivide(img(1:2:sx, 1:2:sy),2), imdivide(img(2:2:sx,2:2:sy),2));
    elseif sx >= toolong
        sx = floor(sx/2)*2;
        sy = floor(sy/2)*2;
        img = imadd(imdivide(img(1:2:sx, :),2), imdivide(img(2:2:sx,:),2));
    else
        sx = floor(sx/2)*2;
        sy = floor(sy/2)*2;
        img = imadd(imdivide(img(:,1:2:sy),2), imdivide(img(:,2:2:sy),2));
    end;
    [pc or ft] = phasecong(img);
    nm = nonmaxsup(pc, or, 2); %1.5
    edgim = hysthresh(nm, 0.4, 0.2);
    imgbw = edgim;
    %    imgbw = bwmorph(edgim,'skel',Inf);
    imgbw(find(img < 150)) = 1;  %fill in dark areas, 150 = arbitrary threshold for now
    img2 = imclose(imgbw, se5); %leave light areas as holes
%    if sx >= toolong & sy <= toolong,  %reduce resolution on remaining small side
    if sx >= toolong & sy < toolong,  %reduce resolution on remaining small side - change <= to <, Heidi 10/27/09
        img2 = (img2(:,1:2:sy) | img2(:,2:2:sy)); %lower res for bw = logical case
    elseif sy >= toolong & sx < toolong,
        img2 = (img2(1:2:sx,:) | img2(2:2:sx,:)); %lower res for bw = logical case
    end;
else
    sx = floor(sx/2)*2;
    sy = floor(sy/2)*2;
    [pc or ft] = phasecong(img);
    nm = nonmaxsup(pc, or, 1.5); %1.5
    edgim = hysthresh(pc, .6, .4);
    imgbw = edgim;
    %    imgbw = bwmorph(edgim,'skel',Inf);  %does this really help?
    imgbw(find(img < 150)) = 1;  %fill in dark areas, 150 = arbitrary threshold for now
    img2 = imclose(imgbw, se4); %leave light areas as holes
    img2 = (img2(1:2:sx, 1:2:sy)| img2(2:2:sx,2:2:sy)); %lower res for bw = logical case
end;
img2 = imdilate(img2, se2);
img2 = imclose(img2, se3);
img2 = bwmorph(img2, 'thin', 1);
%img2 is the black and white quarter-resolution image after edge detection
l = bwlabel(img2, 8);
t = regionprops(l, 'Area', 'Orientation', 'PixelList', 'PixelIdxList');
if ~isempty(t),  %this is case with a detectable blob
    s = cat(1,t.Area);
    [junk, ind] = max(s);
    pixidx1 = t(ind).PixelIdxList;
    l2 = l; l2(find(l2(:) ~= ind)) = 0; l2(find(l2)) = 1;  %mark labels for largest blob only
    %now rotate the image to line up the major axes
    theta = -1*t(ind).Orientation;
    %    img3 = imrotate(img2, theta, 'bilinear', 'crop');
    img3 = imrotate(img2, theta, 'bilinear');
    img3 = imdilate(img3, se2);
    img3 = imclose(img3, se3);
    img3 = bwmorph(img3, 'thin', 1);
    %img3 is like img2 but rotated (cropped to same size)
    %get all the regular blob properties
    l = bwlabel(img3, 8);
    t = regionprops(l, 'Area');
    if ~isempty(t),
        s = cat(1,t.Area);
        [junk, ind] = max(s);
        l2 = l; l2(find(l2(:) ~= ind)) = 0; l2(find(l2)) = 1;  %mark labels for largest blob only
        %    t = regionprops(l2,'Area', 'Centroid', 'MajorAxisLength', 'MinorAxisLength', 'Eccentricity', 'Orientation', 'ConvexArea', 'EquivDiameter', 'Solidity', 'Extent', 'Perimeter', 'PixelList', 'PixelIdxList', 'BoundingBox');
        t = regionprops(l2,'Area', 'Centroid', 'MajorAxisLength', 'MinorAxisLength', 'Eccentricity', 'Orientation', 'ConvexArea', 'EquivDiameter', 'Solidity', 'Extent', 'Perimeter', 'BoundingBox', 'PixelList', 'FilledArea');
        pix = t.PixelList;
        features1(fearow:fearow+4) = [t.Area; t.MajorAxisLength; t.MinorAxisLength; t.Eccentricity; t.Orientation;];
        fearow = fearow + 5;  %1:5
        features1(fearow:fearow+7) = [t.ConvexArea; t.EquivDiameter; t.Solidity; t.Extent; t.Perimeter; t.BoundingBox(3:4)'; t.FilledArea];
        fearow = fearow + 8; %7:13

        %    perimeter1 = bwboundaries(img3, 'noholes'); %perimeter and pixlist have opposite x-y order
        perimeter1 = bwboundaries(l2, 'noholes'); %perimeter and pixlist have opposite x-y order
        [temp, ind] = max(cellfun('length', perimeter1));
        perimeter1 = perimeter1{ind}; %biggest perimeter only, this has a problem for flagellates with "detached" flagella - finds flagella
        FrDescp1 = frdescp(perimeter1);
        Centroid1 = t.Centroid;
        %    pix = t.PixelList;
        %    pixidx1 = t.PixelIdxList;

        %NOW get some other features...
        %moments invariant, which image should be used here, maybe edge image without "fill"?
        invarmom = invmoments(imgbw);  %get invariant moments on img
        features1(fearow:fearow+6) = invarmom;
        fearow = fearow + 7; %14:20

        %DIPUM texture stats
        texture = statxture(img(pixidx1));
        features1(fearow:fearow+5) = texture;
        fearow = fearow + 6; %21:26

        %Number of line segment endpoints, on reconstructed boundary
        %reconstructed with first Fourier descriptors only
        z2 = ifrdescp(FrDescp1,length(FrDescp1)/10);  %reconstruct boundary with first 10% of Fourier descriptors
        %    disp(length(FrDescp1/10))
        %    z2 = ifrdescp(FrDescp1,30);  %reconstruct boundary with first 10% of Fourier descriptors
        [M N] = size(img3);
        z2im = bound2im(z2,M+1,N+1);  %boundary image  %why does this crash with M and N
        z2im = imdilate(z2im, se2);
        z2im = imclose(z2im, se3);
        z2im = bwmorph(z2im, 'thin', 1);
        z2im = bwmorph(z2im, 'skel', Inf);
        z2im = bwmorph(z2im, 'spur', 10);
%figure(2), clf, subplot(231), imshow(img), caxis auto, subplot(232), imshow(pc), subplot(233), imshow(edgim), subplot(234), imshow(img2), subplot(235), imshow(img3), subplot(236), imshow(z2im)
%pause
%if sx > 200,
%figure, clf, subplot(231), imshow(img), subplot(232), imshow(pc), subplot(233), imshow(edgim), subplot(234), imshow(img2), subplot(235), imshow(img3), subplot(236), imshow(z2im)
%end;

%keyboard
        rwfea = getRW(z2im);  %56 elements: wedge total, 32 wedges, 23 rings
        %    rwtitles = ['wedge sum'; cellstr([repmat('Wedge:',32,1) num2str((1:32)')]); cellstr([repmat('Ring:',23,1) num2str((1:23)')])];
        rwtitles = ['wedge sum'; 'center/total'; cellstr([repmat('Wedge:',48,1) num2str((1:48)')]); cellstr([repmat('Ring:',50,1) num2str((1:50)')])];

        %    imgname(findstr(imgname, '_')) = 'v';
        %    imgname = ['v' imgname];
        %    eval([imgname ' = z2im;'])
        %    save('dinobry', imgname, '-append')
        features1(fearow) = size(find(endpoints(z2im)),1);%number of line segment endpoints
        fearow = fearow + 1; %27
        %    clf, subplot(221), imshow(img), subplot(222), imshow(img2), subplot(223), imshow(img3), subplot(224), imshow(z2im)
        t2 = regionprops(bwlabel(z2im), 'Centroid');
        [M N] = size(z2im);
        if ~isempty(t2),
            dx = round(N-t2.Centroid(1)*2);
            dy = round(M-t2.Centroid(2)*2);
            %pad image with zeros so that ROI Centroid is at the center of the image
            if dy < 0,
                direction = 'post';
            else
                direction = 'pre';
            end;
            z2imtr = padarray(z2im, [abs(dy) 0], 0, direction);
            if dx < 0,
                direction = 'post';
            else
                direction = 'pre';
            end;
            z2imtr = padarray(z2imtr, [0 abs(dx)], 0, direction);
            z2imtrr = imrotate(z2imtr, 180);
            z2imtrr2 = imrotate(z2imtr, 90);
            z2imtrrf = flipud(z2imtr);
            [pxA, pyA] = find(z2imtr);
            [mA,nA] = size(z2imtr);
            pxA = pxA-mA/2; pyA = pyA-nA/2;  %offset so centroid is at origin
            %   figure(1), clf, plot(pyA, pxA, '.'), hold on
            [pxB, pyB] = find(z2imtrr);
            [mB,nB] = size(z2imtr);
            pxB = pxB-mB/2; pyB = pyB-nB/2;
            %   plot(pyB, pxB, '.r')
            pxA = single(pxA); pxB = single(pxB);
            [pxAm, pxBm] = meshgrid(pxA, pxB);
            pxAm = (pxAm-pxBm).^2;  %add overwrites to avoid running out of memory on lg imgs
            clear pxBm
            pyA = single(pyA); pyB = single(pyB);
            [pyAm, pyBm] = meshgrid(pyA, pyB);
            pyAm = (pyAm-pyBm).^2;
            clear pyBm
            %    distm = sqrt((pxAm-pxBm).^2 + (pyAm-pyBm).^2);
            %    hab = max(min(distm));
            %    hba = max(min(distm'));
            pxAm = sqrt(pxAm + pyAm);
            hab = max(min(pxAm));
            hba = max(min(pxAm'));
            clear pxAm pyAm
            H1 = max(hab,hba);
            [pxB, pyB] = find(z2imtrr2);
            [mB,nB] = size(z2imtrr2);
            pxB = pxB-mB/2; pyB = pyB-nB/2;
            %   plot(pyB, pxB, '.g')
            pxA = single(pxA); pxB = single(pxB);
            [pxAm, pxBm] = meshgrid(pxA, pxB);
            pxAm = (pxAm-pxBm).^2;  %add overwrites to avoid running out of memory on lg imgs
            clear pxBm
            pyA = single(pyA); pyB = single(pyB);
            [pyAm, pyBm] = meshgrid(pyA, pyB);
            pyAm = (pyAm-pyBm).^2;
            clear pyBm
            %    distm = sqrt((pxAm-pxBm).^2 + (pyAm-pyBm).^2);
            %    hab = max(min(distm));
            %    hba = max(min(distm'));
            pxAm = sqrt(pxAm + pyAm);
            hab = max(min(pxAm));
            hba = max(min(pxAm'));
            clear pxAm pyAm
            H2 = max(hab,hba);
            [pxB, pyB] = find(z2imtrrf);
            [mB,nB] = size(z2imtrrf);
            pxB = pxB-mB/2; pyB = pyB-nB/2;
            %   plot(pyB, pxB, '.m')
            pxA = single(pxA); pxB = single(pxB);
            [pxAm, pxBm] = meshgrid(pxA, pxB);
            pxAm = (pxAm-pxBm).^2;  %add overwrites to avoid running out of memory on lg imgs
            clear pxBm
            pyA = single(pyA); pyB = single(pyB);
            [pyAm, pyBm] = meshgrid(pyA, pyB);
            pyAm = (pyAm-pyBm).^2;
            clear pyBm
            %    distm = sqrt((pxAm-pxBm).^2 + (pyAm-pyBm).^2);
            %    hab = max(min(distm));
            %    hba = max(min(distm'));
            pxAm = sqrt(pxAm + pyAm);
            hab = max(min(pxAm));
            hba = max(min(pxAm'));
            clear pxAm pyAm
            H3 = max(hab,hba);
            %simple top and bottom width relative to centroid width, for rhizo,
            %flagellate, etc.
            s = t.BoundingBox;
            ind = find(pix(:,1) == round(s(1))+10); %ten pixels ind from left of bounding box
            if length(ind) > 1,
                left10 = max(pix(ind,2)) - min(pix(ind,2));
            else
                left10 = 1;
            end;
            ind = find(pix(:,1) == round(s(1)+s(3))-10); %ten pixels in from right of bounding box
            if length(ind) > 1,
                right10 = max(pix(ind,2)) - min(pix(ind,2));
            else
                right10 = 1;
            end;
            features1(fearow:fearow+1) = [left10/t.MinorAxisLength; right10/t.MinorAxisLength];% relative height 10 pixels from left and right ends
            fearow = fearow + 2; %28:29

            %trial to get number of convex and concave segments comprising the
            %boundary, use same reconstructed boundary as above for line ends
            l3 = bwlabel(z2im);
            t3 = regionprops(l3, 'Area');
            s = cat(1,t3.Area);
            [junk, ind] = max(s);
            l4 = l3; l4(find(l4(:) ~= ind)) = 0; l4(find(l4)) = 1; clear l3
            perimeter3 = bwboundaries(l4); perimeter3 = perimeter3{1};
            centr3 = regionprops(l4, 'Centroid');
            centr3 = centr3.Centroid;
            %distance of each boundary point from centroid
            cdist = sqrt((perimeter3(:,2)-centr3(1)).^2 + (perimeter3(:,1)-centr3(2)).^2);
            if rem(length(cdist),2), cdist = cdist(1:end-1); end; %even length only
            cdist = mean(reshape(cdist,2,length(cdist)/2)); %now this is a row vector, with 2-pixel resolution
            dcdist = medfilt1(round(diff(cdist)),3);  %smoothed "derivative"
            %find places where derivative changes sign
            nneg = size(find(dcdist(1:end-1) >= 0 & dcdist(2:end) < 0),2);  %size = 2 for row vector
            npos = size(find(dcdist(1:end-1) <= 0 & dcdist(2:end) > 0),2);
            features1(fearow:fearow+1) = [nneg; npos];%number concave/convex, check order?
            fearow = fearow + 2; %30:31

            features1(fearow:fearow+3) = [mean(cdist); std(cdist); mean(cdist)/(t.EquivDiameter/2); sum(abs(cdist-t.EquivDiameter))];
            fearow = fearow + 4; %32:35

            %try moments invariant on filtered boundary
            img4 = imfill(l4,'holes');
            invarmom3 = invmoments(img4);  %get invariant moments on img
            features1(fearow:fearow+6) = invarmom3;
            fearow = fearow + 7; %36:42
            invarmom4 = invmoments_affine(img4);
            features1(fearow) = invarmom4;
            fearow = fearow + 1; %43

            features1(fearow:fearow+2) = [H1; H2; H3]; %Haussdorf 180, 90, up/down reflection
            fearow = fearow + 3;  %44:46

            %moments invariant
            invarmom = invmoments(img);  %get invariant moments on grayscale img
            features1(fearow:fearow+6) = invarmom;
            fearow = fearow + 7; %47:53

            gcom = graycomatrix(img, 'NumLevels', 16, 'Offset', offsets);
            %    for count = 1:size(gcom,3),
            %        gcom(:,:,count) = gcom(:,:,count)./sum(sum(gcom(:,:,count)))
            %    end;
            for count = 1:numD,  %4 angles
                gcom2(:,:,count*2-1) = round(mean(gcom(:,:,count:numD:end),3));
                gcom2(:,:,count*2) = max(gcom(:,:,count:numD:end),[],3)-min(gcom(:,:,count:numD:end),[],3);
            end;
            %figure(1), clf, imshow(img)
            %figure(2), clf, imshow(si), caxis auto

            %    gomtitles = cellstr([repmat('Contr:',length(offsets),1) num2str(offsets)]);
            %    gomtitles = [gomtitles; cellstr([repmat('Corr:',length(offsets),1) num2str(offsets)])];
            %    gomtitles = [gomtitles; cellstr([repmat('Energy:',length(offsets),1) num2str(offsets)])];
            %    gomtitles = [gomtitles; cellstr([repmat('Homog:',length(offsets),1) num2str(offsets)])];

            gomtitles = cellstr([repmat('Contr mean:',numD,1) num2str(D)]);
            gomtitles = [gomtitles; cellstr([repmat('Contr range:',numD,1) num2str(D)])];
            gomtitles = [gomtitles; cellstr([repmat('Corr mean:',numD,1) num2str(D)])];
            gomtitles = [gomtitles; cellstr([repmat('Corr range:',numD,1) num2str(D)])];
            gomtitles = [gomtitles; cellstr([repmat('Energy mean:',numD,1) num2str(D)])];
            gomtitles = [gomtitles; cellstr([repmat('Energy range:',numD,1) num2str(D)])];
            gomtitles = [gomtitles; cellstr([repmat('Homog mean:',numD,1) num2str(D)])];
            gomtitles = [gomtitles; cellstr([repmat('Homog range:',numD,1) num2str(D)])];

            statsV = graycoprops(gcom2,'all'); numcom = 12;
            features1(fearow:fearow+numcom-1) = statsV.Contrast;
            fearow = fearow+numcom; %54:77
            features1(fearow:fearow+numcom-1) = statsV.Correlation;
            fearow = fearow+numcom; %78:101
            features1(fearow:fearow+numcom-1) = statsV.Energy;
            fearow = fearow+numcom; %102:125
            features1(fearow:fearow+numcom-1) = statsV.Homogeneity;
            fearow = fearow+numcom; %126:149
%corrected index error - Oct. 17, 2006, Heidi
%            features1(fearow) = features1(41)./features1(40); fearow = fearow + 1;%H90/H180  %150
%            features1(fearow) = features1(42)./features1(40); fearow = fearow + 1;%Hupd/H180
            features1(fearow) = features1(45)./features1(44); fearow = fearow + 1;%H90/H180  %150
            features1(fearow) = features1(46)./features1(44); fearow = fearow + 1;%Hupd/H180
            features1(fearow) = features1(10)./features1(1); fearow = fearow + 1;%perimeter/area
            features1(fearow) = features1(1)./features1(10).^2; fearow = fearow + 1;%area/perimeter^2
            features1(fearow) = features1(2)./features1(11); fearow = fearow + 1;%maj ax/bound box 1
            features1(fearow) = features1(3)./features1(12); fearow = fearow + 1;%min ax/bound box 2
            features1(fearow) = features1(1)./features1(13); fearow = fearow + 1;%area/filled area
%corrected index error from 39 to 43, Oct. 17, 2006, Heidi    
            if features1(43) <= 1/108, %T
                features1(fearow) = features1(43)*108;
            else
                features1(fearow) = 1./features1(43)/108;
            end;
            fearow = fearow + 1;
            if features1(43) <= 1/16/pi^2,  %E
                features1(fearow) = features1(43)*16*pi^2;
            else
                features1(fearow) = 1./features1(43)/16/pi^2;
            end;
            fearow = fearow + 1; %158

            features1(fearow:fearow+99)= rwfea;  %rings and wedges
            fearow = fearow + 100;  %159:218
            %    if ~isempty(find(isnan(features1))) | ~isempty(find(isinf(features1)))
            %        disp('There are NaNs in this feature vector.  Should not be true for training set.')
            %        keyboard
            %   end;
        else  %t2 empty
            features1 = NaN;  %case where no blobs
            perimeter1 = NaN;
            pixidx1 = NaN;
            FrDescp1 = NaN;
            Centroid1 = NaN;
            gomtitles = NaN;
            rwtitles = NaN;
        end;
    else  %t empty
        features1 = NaN;  %case where no blobs
        perimeter1 = NaN;
        pixidx1 = NaN;
        FrDescp1 = NaN;
        Centroid1 = NaN;
        gomtitles = NaN;
        rwtitles = NaN;
    end;
else
    features1 = NaN;  %case where no blobs
    perimeter1 = NaN;
    pixidx1 = NaN;
    FrDescp1 = NaN;
    Centroid1 = NaN;
    gomtitles = NaN;
    rwtitles = NaN;
end;

featitles = {'Area' 'MajorAxisLength' 'MinorAxisLength' 'Eccentricity' 'Orientation' 'ConvexArea' 'EquivDiam' 'Solidity' 'Extent' 'Perimeter' 'BoundingBox Dim1' 'BoundingBox Dim2' 'FilledArea' 'InvMom1' 'InvMom2' 'InvMom3' 'InvMom4' 'InvMom5' 'InvMom6' 'InvMom7' 'Avg gray level' 'Avg contrast' 'Smoothness' 'Third moment' 'Uniformity' 'Entropy' 'Number of line ends' 'Rel. left height' 'Rel. right height' 'Num concave segments' 'Num convex segments'};
featitles = [featitles {'Mean cdist' 'Std cdist' 'meanCdist/EqRadius' 'sum deviat EqRad' 'InvMom1b' 'InvMom2b' 'InvMom3b' 'InvMom4b' 'InvMom5b' 'InvMom6b' 'InvMom7b' 'InvMom_affine1' 'HD180' 'HD90' 'HD upd refl' 'InvMom1g' 'InvMom2g' 'InvMom3g' 'InvMom4g' 'InvMom5g' 'InvMom6g' 'InvMom7g'}];
featitles = [featitles gomtitles' {'H90/H180' 'Hupd/H180' 'perimeter/area' 'area/perimeter^2' 'maj ax/bb1' 'min ax/bb2' 'area/filled area' 'T' 'E'}];
featitles = [featitles rwtitles'];
%plotting option for testing various boundary methods, etc. "if 1" turns on
%plot and pause option
if 0,
    %    centr = t.Centroid;
    mja =   t.MajorAxisLength;
    mna = t.MinorAxisLength;
    ang = t.Orientation;
    s = t.BoundingBox;
    figure(1), hold on
    lb = label2rgb(l, 'jet');
    clf
    subplot(221)
    imshow(imadjust(img))
    %    title(char(imgfiles(imgcount).name))
    subplot(222)
    imshow(imgbw)
    subplot(223)
    imshow(img3)
    hold on
    plot(perimeter1(:,2), perimeter1(:,1), '.r')
    x1 = Centroid1(1) - 0.5*mja*cosd(ang);
    x2 = Centroid1(1) + 0.5*mja*cosd(ang);
    y1 = Centroid1(2) + 0.5*mja*sind(ang);
    y2 = Centroid1(2) - 0.5*mja*sind(ang);
    line([x1 x2], [y1 y2], 'color', 'g', 'linewidth', 2)
    mang = ang+90;
    x1 = Centroid1(1) - 0.5*mna*cosd(mang);
    x2 = Centroid1(1) + 0.5*mna*cosd(mang);
    y1 = Centroid1(2) + 0.5*mna*sind(mang);
    y2 = Centroid1(2) - 0.5*mna*sind(mang);
    line([x1 x2], [y1 y2], 'color', 'g', 'linewidth', 2)
    s = t.BoundingBox;
    patch([s(1) s(1) s(1)+s(3) s(1)+s(3)], [s(2) s(2)+s(4) s(2)+s(4) s(2)], 'm', 'facecolor', 'none', 'edgecolor', 'm')

    subplot(224)
    imshow(lb)
    figure(2)
    clf
    subplot(221)
    imshow(img)
    %   title(char(imgfiles(imgcount).name))
    subplot(222)
    imshow(pc)
    subplot(223)
    imshow(edgim)
    subplot(224)
    imshow(img2)
    pause
end;
