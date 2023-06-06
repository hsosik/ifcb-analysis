% draws biomass maps from NES broadscale IFCB data for specified classes
% 4 different figures:
% (1) sample aggregation results for the whole data set
% (2) composite maps using all data across all seasons
% (3) sample aggregation results for all cruises within each season
% (4) seasonal composite maps

clear; close all;

%% specify some things:

sumpath = '\\sosiknas1\IFCB_products\NESLTER_broadscale\summary\';
sumpath = 'c:\work\IFCB_products\NESLTER_broadscale\summary\';

if 0
    class2map = {'Guinardia_delicatula' 'Ditylum_brightwellii' 'Cerataulina_pelagica'}; % you can specify any number of classes. 
    cbarmax = [10 3 1]; %use 
    Z = 'classC_above_optthresh./1000';
    lblstr = 'Carbon (\mug l^{-1})';
end
if 1
    class2map = {{'Hemiaulus' 'Hemiaulus_membranaceus'} {'Pseudo-nitzschia' 'pennate_Pseudo-nitzschia'}}; % you can specify any number of classes. 
    cbarmax = [5 3]; %switch to adhoc case below
    Z = 'classC_above_adhocthresh./1000';
    lblstr = 'Carbon (\mug l^{-1})';
end

% marker size + font size
MS = 72;
FS = 12;
FS2 = 8; %for lat/lon labels
% colorbar you want to use:
cbar = flipud(parula);

% hard latitude cut off to prevent over-interpreting southern boundary
latnan = 35.8; 

%% loop over summaries to get data:

flist = dir(sumpath);
all_meta = table();
allct = []; 
for i = 1:length(flist)
    fn = flist(i).name;
    if contains(fn , "summary_biovol_allHDF_min20") && ~contains(fn, "list")
        fn = [sumpath, fn];
        load(fn);
        
        % keep metadata by appending:
        all_meta = cat(1, all_meta, meta_data);

%         allct = [ allct ; classcount_above_optthresh]; lblstr = 'ml^-^1';
%         allct = [  allct ; classbiovol_above_optthresh];
        allct = [  allct ; eval(Z)]; 
   %     allct = [  allct ; classC_above_optthresh./1000]; lblstr = 'Carbon (\mug l^{-1})';
    end
end

% remove where skip == 1:
allct(all_meta.skip == 1, :) = [];
all_meta(all_meta.skip == 1, :) = [];

% a stupid solution to data formating I can't figure out...
eh = ismember(all_meta.tag1, 'underway') | ismember(all_meta.tag2, 'underway') | ...
    ismember(all_meta.tag3, 'underway') | ismember(all_meta.tag4, 'underway') | ...
    ismember(all_meta.tag5, 'underway') | ismember(all_meta.tag6, 'underway') | ...
    ismember(all_meta.tag7, 'underway') | ismember(all_meta.tag8, 'underway'); 
allct = allct(ismember(all_meta.sample_type, 'underway') | eh, :);
all_meta = all_meta(ismember(all_meta.sample_type, 'underway') | eh, :);

% remove NaN'ed lat/lon:
rmme = isnan(all_meta.latitude) | isnan(all_meta.longitude) | all_meta.longitude == 0 | all_meta.latitude == 0;
all_meta(rmme,:) = [];
allct(rmme,:) = [];

% add a datetime entry:
all_meta.datetime = datetime(strrep(all_meta.sample_time, '+00:00', '')); 

% some longitudes are negative E and some positive E. Here fix that:
%all_meta.longitude(all_meta.longitude > 0) = all_meta.longitude(all_meta.longitude > 0) - 360;

%% some data manipulation

ml = all_meta.ml_analyzed;

lat = all_meta.latitude;
lon = all_meta.longitude;

tmplonlims = [min(lon)-0.5, max(lon)+0.5];
tmplatlims = [min(latnan)-0.5, max(lat)+0.5];

dt = all_meta.datetime;
mths = month(dt);
szns = mths; 
szns(mths == 1 | mths == 2 | mths == 3) = 1;
szns(mths == 4 | mths == 5 | mths == 6) = 2;
szns(mths == 7 | mths == 8 | mths == 9) = 3;
szns(mths == 10 | mths == 11 | mths == 12) = 4;
szn_lab = {'Winter', 'Spring', 'Summer', 'Fall'};

% count number of cruises in each season:
for i = 1:4
    disp([num2str(length(unique(all_meta.cruise(szns == i)))) ' cruises in season ' szn_lab{i}]);
end

%% plotting loop:
% aggregation parameters:
dt = 40; % initial distance threshold used to create sample clusters
cdt = 50; % distance threshold for merging clusters that don't exceed vt
for j = 1:length(class2map)
    
    vt = 200;
    cidx = ismember(class2use, class2map{j});

    % pooling:
    [pooled_ct, pooled_meta, clust_key1, clust_key_mod] = pool_underway_geocluster2(sum(allct(:, cidx),2), ml, ...
        lat, lon, dt, cdt, vt);
    
    % draw a map to watch the clustering happen:
    if j == 1
        clust_vol = pooled_meta.volume;
        clust_lat = pooled_meta.latitude;
        clust_lon = pooled_meta.longitude;
        MS = 72;
        figure(1); hold on; 
        m_proj('UTM','long',tmplonlims,'lat',tmplatlims);
        m_gshhs_i('patch', [0.9 0.9 0.9]);
        m_grid('tickdir','out','yaxislocation','left', ...
                    'xaxislocation','bottom','xlabeldir','end','ticklen',.02, ...
                    'fontsize',FS2);
        [~, idx] = unique([lon, lat], 'rows', 'stable');
        m_scatter(lon(idx), lat(idx), MS/10, clust_key_mod(idx), '.');
        m_scatter(clust_lon(clust_vol >= vt), clust_lat(clust_vol >= vt), MS/5, 'k^', 'LineWidth', 1);
        m_scatter(clust_lon(clust_vol < vt), clust_lat(clust_vol < vt), MS/5, 'k*', 'LineWidth', 1);
    end

    % make the maps:
    binned_vol = pooled_meta.volume;
    
    tmplat = pooled_meta.latitude;
    tmplon = pooled_meta.longitude;
    
    gridlat = min(tmplat):0.1:max(tmplat);
    gridlon = min(tmplon):0.1:max(tmplon);
    [x1, y1] = meshgrid(gridlon, gridlat);

    figure(j*10); hold on;
    
    y = pooled_ct ./ pooled_meta.volume;
    z1 = griddata(tmplon, tmplat, y, x1, y1, 'linear');
    
    % remove interpolated values outside of the sampled limits
    k = boundary(tmplat, tmplon);
    pgon = polyshape(tmplon(k), tmplat(k),'Simplify',false);
    idx = isinterior(pgon,x1(:),y1(:));
    idx = reshape(idx,size(x1));
    z1(~idx) = nan;

    zzmod = z1;
    zzmod(y1 < latnan) = nan;
    %zzmod(zzmod > cbarmax) = cbarmax;
   % if ~any(zzmod(:) == 0)
   %     zzmod(find(isnan(zzmod) & y1 > latnan,1)) = 0; 
   % end
    %if ~any(zzmod(:) > cbarmax)
    %    zzmod(find(isnan(zzmod) & y1 > latnan,1)) = cbarmax; 
    %end

    title(['\it{' regexprep(class2map{j}, '_', ' ') '}'],'FontWeight', 'bold'); 
    m_proj('UTM','long',tmplonlims,'lat',tmplatlims);
    m_contourf(x1, y1, zzmod, 256, 'LineStyle', 'none');
    m_gshhs_i('patch', [0.9 0.9 0.9]);
    m_grid('tickdir','out','yaxislocation','left', ...
                'xaxislocation','bottom','xlabeldir','end','ticklen',.02, ...
                'fontsize',FS2);
    %c = colorbar; 
    %colormap(cbar);
    caxis([0 cbarmax(j)])
%    c.Label.String = lblstr; %'ml^-^1';
 %   set(gca, 'FontSize', FS); c.Label.FontSize = FS;

    
    figure(j*10+1)
    %tl = tiledlayout(2,2, 'TileSpacing', 'compact', 'Padding','compact'); set(gcf, 'position', [360 120 580 500])
    tl = tiledlayout(1,4, 'TileSpacing', 'compact', 'Padding','compact');  set(gcf, 'position', [50 120 1000 230])


    for i = 1:length(szn_lab)
        vt = 50; % volume threshold to shoot for in sample clustering 

        % extract data from szn i:
        tmplat = lat(szns == i); tmplon = lon(szns == i);
        tmpct = sum(allct(szns == i,cidx),2); tmpml = ml(szns == i);
        % pooling:
        [pooled_ct, pooled_meta, clust_key1, clust_key_mod] = pool_underway_geocluster2(tmpct, tmpml, ...
            tmplat, tmplon, dt, cdt, vt);
        
        %% draw maps of the O.G. sampling locations and the new pooled locations:
        
        % draw a map to watch the clustering happen:
        if j == 1
            clust_vol = pooled_meta.volume;
            clust_lat = pooled_meta.latitude;
            clust_lon = pooled_meta.longitude;
            MS = 72;
            figure(2); hold on;  
            subplot(2,2,i); hold on; %title(szn_lab{i});
            m_text(-68, 36.5, szn_lab{i})
            m_proj('UTM','long',tmplonlims,'lat',tmplatlims);
            m_gshhs_i('patch', [0.9 0.9 0.9]);
            m_grid('tickdir','out','yaxislocation','left', ...
                        'xaxislocation','bottom','xlabeldir','end','ticklen',.02, ...
                        'fontsize',FS);
            [~, idx] = unique([tmplon, tmplat], 'rows', 'stable');
            m_scatter(tmplon(idx), tmplat(idx), MS/10, clust_key_mod(idx), '.');
            m_scatter(clust_lon(clust_vol >= vt), clust_lat(clust_vol >= vt), MS/5, 'k^', 'LineWidth', 1);
            m_scatter(clust_lon(clust_vol < vt), clust_lat(clust_vol < vt), MS/5, 'k*', 'LineWidth', 1);
        end
        %% grid and plot the pooled data:
        
        % make the maps:
        binned_vol = pooled_meta.volume;
        
        tmplat = pooled_meta.latitude;
        tmplon = pooled_meta.longitude;
        
        gridlat = min(tmplat):0.1:max(tmplat);
        gridlon = min(tmplon):0.1:max(tmplon);
        [x1, y1] = meshgrid(gridlon, gridlat);
    
        figure(j*10+1)
    
        y = sum(pooled_ct,2) ./ pooled_meta.volume;
        z1 = griddata(tmplon, tmplat, y, x1, y1, 'linear');
        
        % remove interpolated values outside of the sampled limits
        k = boundary(tmplat, tmplon);
        pgon = polyshape(tmplon(k), tmplat(k),'Simplify',false);
        idx = isinterior(pgon,x1(:),y1(:));
        idx = reshape(idx,size(x1));
        z1(~idx) = nan;
    
        zzmod = z1;
        zzmod(y1 < latnan) = nan;
        %zzmod(zzmod > cbarmax) = cbarmax;
     %   if ~any(zzmod(:) == 0)
     %       zzmod(find(isnan(zzmod) & y1 > latnan,1)) = 0; 
     %   end
        %if ~any(zzmod(:) > cbarmax)
        %    zzmod(find(isnan(zzmod) & y1 > latnan,1)) = cbarmax; 
        %end
    
        %ax(i) = subplot(2,2,i);  hold on; title(['\it{' regexprep(class2map{j},'_',' ') '} \rm', ': ', szn_lab{i}],'FontWeight', 'bold'); 
        nexttile, hold on
        %title(szn_lab{i},'FontWeight', 'bold');
        m_text(-68, 36.5, szn_lab{i}, 'fontweight', 'bold')
        m_proj('UTM','long',tmplonlims,'lat',tmplatlims);
        m_contourf(x1, y1, zzmod, 256, 'LineStyle', 'none');
        m_gshhs_i('patch', [0.9 0.9 0.9]);
        m_grid('tickdir','out','yaxislocation','left', ...
                    'xaxislocation','bottom','xlabeldir','middle','ticklen',.02, ...
                    'fontsize',FS2);
    %    c = colorbar; 
    %    colormap(cbar);
        caxis([0 cbarmax(j)])
    %    c.Label.String = lblstr; %'ml^-^1';
        set(gca, 'FontSize', FS); %c.Label.FontSize = FS;
    end
    c = colorbar; 
    colormap(cbar);
    %caxis([0 cbarmax(j)])
    c.Label.String = lblstr; %'ml^-^1';
    c.Label.FontSize = FS2;
    c.FontSize = FS2;
    c.Layout.Tile = 'east';
    title(tl, ['\it{' regexprep(class2map{j}{1},'_',' ') '}'], 'fontweight', 'bold')
end




