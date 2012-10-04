summarypath = '\\floatcoat\LaneyLab\projects\HLY1101\work_IFCB8\Manual\summary\'; %USER where is the summary output from biovolume_summary_ICESCAPE_manual.m
load([summarypath 'count_biovol_manual_04oct2012'])  %USER change the date if you update the output from biovolume_summary_ICESCAPE_manual.m
filelist = {filelist.name}'; filelist = regexprep(filelist, '.mat', '');

%get some metadata vectors
lat = [metadata.lat_deg];
lon = [metadata.lon_deg];
depth = [metadata.depth];
stn = [metadata.station];

listpath = '\\floatcoat\LaneyLab\projects\HLY1101\work_IFCB8\code_Aug2012\'; %USER where are the section filelists

%priority b: underway transit between stations 34 and 45 -> across the 'old' tongue of the bloom
filelist1 = load([listpath 'filelist_stn34_45'], 'filelist'); filelist1 = filelist1.filelist;
[~,ind1,~] = intersect(filelist, filelist1);

%priority c: underway transit between stations 75 and 76
filelist2 = load([listpath 'filelist_stn75_76'], 'filelist'); filelist2 = filelist2.filelist;
[~,ind2,~] = intersect(filelist, filelist2);

%*priority a: stations 77-81 inclusive, casts coming out of the ice, parallel and eastward of the bloom
filelist3 = load([listpath 'filelist_stn77_81'], 'filelist'); filelist3 = filelist3.filelist;
[~,ind3,~] = intersect(filelist, filelist3);

%under ice transect, ***double check this stn range***
ind4 = find(ismember(stn, [53:76]));

%end of cruise underway section
filelist5 = load([listpath 'filelist_underway_end_section'], 'filelist'); filelist5 = filelist5.filelist;
[~,ind5,~] = intersect(filelist, filelist5);

%revise the IFCB summary info to exclude empty classes
ii = find(sum(classcount)==0); %empty categories (i.e., zero counts across all samples annotated to date)
class2use(ii) = [];
classbiovol(:,ii) = [];
classcarbon(:,ii) = [];
classcount(:,ii) = [];

% which classes are diatoms
diatom_str = {'Asterionellopsis' 'Cerataulina' 'Chaetoceros' 'Corethron' 'Coscinodiscus' 'Cylindrotheca' 'DactFragCerataul' 'Dactyliosolen' 'Ditylum'...
    'Ephemera' 'Eucampia' 'Guinardia' 'Guinardia_flaccida' 'Guinardia_striata' 'Lauderia' 'Licmophora' 'Odontella' 'Paralia' 'pennate' 'Pleurosigma'...
    'Pseudonitzschia' 'Rhizosolenia' 'Skeletonema' 'Stephanopyxis' 'Thalassionema' 'Thalassiosira' 'Fragilariopsis' 'Navicula' 'Fragilariopsis_Grazed'...
    'Bacterosira' 'Detonula' 'Melosira' 'Nitzschia frigida'};
[~,diatom_ind,~] = intersect(class2use, diatom_str);

% which classes are dinos
dino_str = { 'dino10' 'dino30' 'Dinophysis'  'Gonyaulax' 'Gyrodinium'  'Prorocentrum'};
[~,dino_ind,~] = intersect(class2use, dino_str);

% which classes are phyto
[temp, phyto_ind] = setdiff(class2use, {'bad', 'detritus', 'ciliate', 'other', 'Fragilariopsis_Grazed'}); %case to skip non-phytoplankton

%adjust some labels
class2use(strmatch('roundCell',class2use)) = {'Misc nano'};
class2use(strmatch('dino30',class2use)) = {'Misc dino'};

%%%%%%%%%%%%%%%%%%%%%%%%
if 0, %case to plot depth dependent sections
    ind = ind3; %USER assign ind according to desired section number with depth resolution (ind3 or ind4)
    x = lon(ind); xfactor = 100; xgrid = (floor(min(lon(ind))):.05:ceil(max(lon(ind)))); xl = 'Longitude'; %use this to plot v. longitude
    %x = stn(ind); xfactor = 100; xgrid = (min(stn(ind)):.1:max(stn(ind))); xl = 'Station number'; %use this to plot v. stn number
    y = depth(ind); ygrid = (0:5:ceil(max(depth(ind)/10))*10)'; yl = 'Depth (m)'; %depth
    %carbon in pg mL^-1 (divide by 1e6 for microg mL-1, mult by 1e3 for microgL-1 = mg m-3, i.e., divide by 1000)
    z = classcarbon(ind,:)./repmat(ml_analyzed(ind),1,length(class2use))/1000; cl = log10(10.^[-3:2]); zl = 'Carbon (mg m^{-3})'; %summed Carbon
    
    %if doing a depth resolved contour plot, make a patch to mask results deeper than water column
    maxy = NaN(size(stn(ind)));
    patchx = maxy;
    [unqstn, unqstn_ind] = unique(stn(ind)); unqstn_ind = ind(unqstn_ind);
    for count = 1:length(unqstn),
        temp = find(stn(ind) == unqstn(count));
        if ~isempty(temp),
            maxy(count) = max(y(temp));
            patchx(count) = x(temp(1));
        end;
    end;
    maxz = max(z(:))*2; %value above all real z to show up on top of 3-d plot in 2-d view
    patch_vert = [min(x) max(y) maxz; [patchx; maxy; repmat(maxz,1,length(maxy))]';  max(x) max(y) maxz];
    patch_vert = patch_vert(find(~isnan(patch_vert(:,1))),:);
    
    %find the rank order by class (cind)
    [temp, cind] = sort(sum(z),2, 'descend');
    cind = cind(find(temp)); %just keep the non-zero cases
    cind = cind(ismember(cind,phyto_ind) == 1); %just keep the phyto cases
    
    plotind = 0;
    for fignum = 1:ceil(length(cind)./4)
        figure(fignum), clf, set(gcf, 'position', [680   25   560   980])
        subplot(6,1,1)
        plot(lon(unqstn_ind), lat(unqstn_ind), '.-')
        text(lon(unqstn_ind), lat(unqstn_ind), num2str(stn(unqstn_ind)'))
        textx = max(xgrid)-.3*(max(xgrid)-min(xgrid));
        for subnum = 2:5,
            if (plotind < length(cind)), %skip last cases in sets of 6 beyond classes available
                plotind = plotind + 1; n = cind(plotind);
                subplot(6,1,subnum)
                [xi yi zi] = griddata(x*xfactor, y, z(:,n), xgrid*xfactor, ygrid);
                zi(zi(:)<0) = 0;
                surf(xi/xfactor,yi, log10(zi)), set(gca, 'ydir', 'reverse'), shading interp, caxis([min(cl) max(cl)])
                hold on
                [c,h] = contour(xi/xfactor,yi, log10(zi), cl, 'linewidth', 2, 'color', 'w'); %clab = clabel(c,h);
                ph = patch(patch_vert(:,1), patch_vert(:,2)+2, patch_vert(:,3), 'w', 'edgecolor', 'w');
                plot3(x, y, ones(size(ind))*maxz, '.k')
                text(textx, max(ygrid)*.8, maxz*1.1,['\it' char(class2use(n))])
                view(2)
                ylim([0 max(ygrid)])
                if subnum == 4, ylabel(yl); end; %middle panel only
            end;
        end;
        %bottom panel only
        xlabel(xl)
        p = get(gca, 'position'); cbh = colorbar('location', 'South'); set(gca, 'position', p);
        p = get(cbh, 'position'); p(2) = .17; set(cbh, 'position', p); set(cbh, 'XAxisLocation', 'bottom')
        set(cbh, 'xtick', cl); set(cbh, 'xticklabel', num2str(10.^cl'));
        set(get(cbh, 'xlabel'), 'String', zl)
        orient tall
    end;
    
    
    figure(fignum+1), clf, set(gcf, 'position', [680   25   560   980])
    subplot(6,1,1)
    plot(lon(unqstn_ind), lat(unqstn_ind), '.-')
    text(lon(unqstn_ind), lat(unqstn_ind), num2str(stn(unqstn_ind)'))
    textx = max(xgrid)-.3*(max(xgrid)-min(xgrid));
    for subnum = 2:3,
        if subnum == 2,
            cind2 = phyto_ind;
            textstr = 'Total nano&microphytplankton';
        else
            cind2 = diatom_ind;
            textstr = 'Total diatoms';
        end;
        zsum = sum(z(:,cind2),2);
        subplot(6,1,subnum)
        [xi yi zi] = griddata(x*xfactor, y, zsum, xgrid*xfactor, ygrid);
        zi(zi(:)<0) = 0;
        surf(xi/xfactor,yi, log10(zi)), set(gca, 'ydir', 'reverse'), shading interp, caxis([min(cl) max(cl)])
        hold on
        [c,h] = contour(xi/xfactor,yi, log10(zi), cl, 'linewidth', 2, 'color', 'w'); %clab = clabel(c,h);
        ph = patch(patch_vert(:,1), patch_vert(:,2)+2, patch_vert(:,3), 'w', 'edgecolor', 'w');
        plot3(x, y, ones(size(ind))*maxz, '.k')
        text(textx, max(ygrid)*.8, maxz*1.1,textstr)
        view(2)
        ylim([0 max(ygrid)])
        if subnum == 2, ylabel(yl); end; %middle panel only
    end;
    %bottom panel only
    xlabel(xl)
    p = get(gca, 'position'); cbh = colorbar('location', 'South'); set(gca, 'position', p);
    p = get(cbh, 'position'); p(2) = .45; set(cbh, 'position', p); set(cbh, 'XAxisLocation', 'bottom')
    set(cbh, 'xtick', cl); set(cbh, 'xticklabel', num2str(10.^cl'));
    set(get(cbh, 'xlabel'), 'String', zl)
    orient tall
    
    subplot(6,1,subnum+2)
    zsum = sum(z(:,diatom_ind),2)./sum(z(:,phyto_ind),2);
    [xi yi zi] = griddata(x*xfactor, y, zsum, xgrid*xfactor, ygrid);
    zi(zi(:)<0) = 0;
    surf(xi/xfactor,yi, zi), set(gca, 'ydir', 'reverse'), shading interp, caxis([0 1])
    hold on
    [c,h] = contour(xi/xfactor,yi, zi, 0:.2:1, 'linewidth', 2, 'color', 'w'); clab = clabel(c,h);
    ph = patch(patch_vert(:,1), patch_vert(:,2)+2, patch_vert(:,3), 'w', 'edgecolor', 'w');
    plot3(x, y, ones(size(ind))*maxz, '.k')
    text(textx, max(ygrid)*.8, maxz*1.1,'Fraction diatoms')
    view(2)
    ylim([0 150])
    ylabel(yl), xlabel(xl)
    p = get(gca, 'position'); cbh = colorbar('location', 'South'); set(gca, 'position', p);
    p = get(cbh, 'position'); p(2) = .17; set(cbh, 'position', p); set(cbh, 'XAxisLocation', 'bottom')
    %set(cbh, 'xtick', cl); set(cbh, 'xticklabel', num2str(10.^cl'));
    %set(get(cbh, 'xlabel'), 'String', 'Fraction diatoms')
    orient tall
    
    
    %try some pie charts
    ind = ind1;
    %some depths only
    ind = ind(depth(ind)<5 | isnan(depth(ind))); %nan for underway
    z = classcarbon(ind,:)./repmat(ml_analyzed(ind),1,length(class2use))/1000; %carbon mg m-3
    
    %rank order
    [temp, cind] = sort(sum(z),2, 'descend');
    cind = cind(find(temp)); %just keep the non-zero cases
    cind = cind(ismember(cind,phyto_ind) == 1); %just keep the phyto cases
    
    figure
    pie(sum(z(:,cind(1:10))), class2use(cind(1:10)))
    
    
    %now make one that looks at all 4 sections, use one list that includes anything ever in 10 top
    for i = 1:4,
        eval(['ind = ind' num2str(i) ';'])
        z = classcarbon(ind,:)./repmat(ml_analyzed(ind),1,length(class2use))/1000; %carbon mg m-3
        ind = ind(depth(ind)<5 | isnan(depth(ind))); %nan for underway
        %rank order
        [temp, cind] = sort(sum(z),2, 'descend');
        cind = cind(find(temp)); %just keep the non-zero cases
        cind = cind(ismember(cind,phyto_ind) == 1); %just keep the phyto cases
        eval(['cind' num2str(i) '=cind;'])
    end;
    %keep any class that makes top 10 in any section
    cind = unique([cind1(1:10) cind2(1:10) cind3(1:10) cind4(1:10)]);
    
    %WOW - matlab is super annoying, skipping zeros in any one pie and reassigning colors
    for i = 1:4,
        eval(['ind = ind' num2str(i) ';'])
        ind = ind(depth(ind)<5 | isnan(depth(ind))); %nan for underway
        z = classcarbon(ind,:)./repmat(ml_analyzed(ind),1,length(class2use))/1000; %carbon mg m-3
        
        subplot(2,2,i)
        pie(sum(z(:,cind)), class2use(cind))
    end;
end; %if plot depth sections


if 1, %plot surface underway
    ind = ind5; %USER assign ind according to desired section number with depth resolution (ind3 or ind4)
    x = lon(ind); xl = 'Longitude'; %use this to plot v. longitude
    %x = stn(ind); xl = 'Station number'; %use this to plot v. stn number
    y = lat(ind); yl = 'Latitude'; %depth
    %carbon in pg mL^-1 (divide by 1e6 for microg mL-1, mult by 1e3 for microgL-1 = mg m-3, i.e., divide by 1000)
    z = classcarbon(ind,:)./repmat(ml_analyzed(ind),1,length(class2use))/1000; cl = log10(10.^[-3:2]); zl = 'Carbon (mg m^{-3})'; %summed Carbon
    %find the rank order by class (cind)
    [temp, cind] = sort(sum(z),2, 'descend');
    cind = cind(find(temp)); %just keep the non-zero cases
    cind = cind(ismember(cind,phyto_ind) == 1); %just keep the phyto cases
    for n = 1:length(cind),
    figure
    stem3(x, y, z(:,cind(n)), 'b')
    %stem3(pos_bin(ind,2), pos_bin(ind,1), numcells_bin2(1,ind)./ml_analyzed_bin(ind), 'b')
    %zlim([0 3000])
    title(class2use(cind(n)))
    %pause
    end;
end; %plot surface underway
