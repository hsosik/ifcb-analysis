figure('WindowState','maximized')
worldmap([-90 90], [-270 90])
%load coastlines
%%plotm(coastlat, coastlon, 'k')
%plotm(coastlat, coastlon, [.7 .85 .68])
%geoshow('landareas.shp', 'FaceColor', [.7 .85 .68], 'EdgeColor', [.4 .65 .4])
%geoshow('landareas.shp', 'FaceColor', [.15 .4 .6], 'EdgeColor', [.6 .6 .6])
geoshow('landareas.shp', 'FaceColor', [0 85 132]./255, 'edgecolor', [.3 .4 .4], 'linewidth',.25)

bin_count = [];
hold on
if 1
    Dlist = {'https://ifcb-data.whoi.edu/api/export_metadata/NESLTER_transect'...
        'https://ifcb-data.whoi.edu/api/export_metadata/NESLTER_broadscale'...
        'https://ifcb-data.whoi.edu/api/export_metadata/EXPORTS'...
        'https://ifcb-data.whoi.edu/api/export_metadata/SPIROPA'...
        'https://habon-ifcb.whoi.edu/api/export_metadata/azmp'...
        'https://habon-ifcb.whoi.edu/api/export_metadata/gom'...
        'https://habon-ifcb.whoi.edu/api/export_metadata/ecoa'...
        'https://habon-ifcb.whoi.edu/api/export_metadata/arctic'...
        'https://ifcb-data.whoi.edu/api/export_metadata/NBP2202'...
        'https://ifcb-data.whoi.edu/api/export_metadata/OTZ_Atlantic'...
        'https://ifcb-data.whoi.edu/api/export_metadata/NAAMES'...
        'https://ifcb.caloos.org/api/export_metadata/calcofi-cruises-underway'...
        'https://ifcb.caloos.org/api/export_metadata/calcofi-cruises-ctd'...
        'https://ifcb.caloos.org/api/export_metadata/plumes-and-blooms-cruises'...    
        'https://ifcb.caloos.org/api/export_metadata/san-francisco-bay-cruises'...
        'https://ifcb-data.whoi.edu/api/export_metadata/Oleander'...
        'https://habon-ifcb.whoi.edu/api/export_metadata/hly2401'...
        'https://ifcb-data.oceanobservatories.org/api/export_metadata/PioneerMABShipboard'

        };
    
    for ii = 1:length(Dlist)
        metaT{ii} =  webread(Dlist{ii}, weboptions('timeout', 30));
        %clean up stray cases in WHOI metadata
          s = (metaT{ii}.latitude==0 & metaT{ii}.longitude==0);
          metaT{ii}.latitude(s) = NaN; metaT{ii}.longitude(s) = NaN;
        plotm(metaT{ii}.latitude, metaT{ii}.longitude, '.r', 'markersize', 4)
        bin_count = [bin_count; sum(~isnan(metaT{ii}.latitude))];
    end
    save('c:\work\IFCB_products\Global_map\metaT_dashboards', 'metaT', 'bin_count')
else
    load('c:\work\IFCB_products\Global_map\metaT_dashboards')
    for ii = 1:length(metaT)
        plotm(metaT{ii}.latitude, metaT{ii}.longitude, '.r', 'markersize', 4)
    end
end
%gomex
klist = {'\\sosiknas1\IFCB_data\IFCB101_GEOCAPE_GOMEX2013\metadata\IFCB101_GEOCAPE_GOMEX2013.kml'...
    "C:\work\IFCB_products\Global_map\IFCB101_SermilikAug2015.kml"...
    "C:\work\IFCB_products\Global_map\Laney-Healy1001.kml"...
    "C:\work\IFCB_products\Global_map\Laney-Healy1101.kml"...
    "C:\work\IFCB_products\Global_map\PEACETIME.kml"...
    };
for ii = 1:length(klist)-1
    T = readgeotable(klist{ii});
    plotm(T.Shape.Latitude,T.Shape.Longitude, '.r');
    bin_count = [bin_count; sum(~isnan(T.Shape.Latitude))];
end
T = readgeotable(klist{end}); %add the last one with handle for legend
ch = plotm(T.Shape.Latitude,T.Shape.Longitude, '.r');
bin_count = [bin_count; sum(~isnan(T.Shape.Latitude))];

%%
Dlist = {"C:\work\IFCB_products\Global_map\TaraMicrobiome_UMaine.xlsx"...
    "C:\work\IFCB_products\Global_map\RV_Svea_Baltic_Kattegat_Skagerrak_SMHI_Sweden.xlsx"...
    "C:\work\IFCB_products\Global_map\CCS_NOAA_hake_survey_2021.xlsx"...
    "C:\work\IFCB_products\Global_map\MS_FINNMAID_Helsinki_Travemunde_FerryBox_Syke_Finland.xlsx"...
    "C:\work\IFCB_products\Global_map\DFO_LaPerouse_Survey.xlsx"...
    "C:\work\IFCB_products\Global_map\BLOOFINZ-IO.xlsx"...
    "C:\work\IFCB_products\Global_map\IFCB128_TaitaoCruise2018_Continental_Shelf_Chilean_Patagonia.xlsx"...
    "C:\work\IFCB_products\Global_map\TaraEuropa_2023-2024.xlsx"...
    "C:\work\IFCB_products\Global_map\KM2418-KM2419_2024.xlsx"...
    "C:\work\IFCB_products\Global_map\SOLOMON_KOPRI_RossSea_survey_2023.xlsx"...
    };

for ii = 1:length(Dlist)
    T = readtable(Dlist{ii}, 'headerlines', 1);
    plotm(T.latitude, T.longitude, '.r','markersize',4)
    bin_count = [bin_count; sum(~isnan(T.latitude))];
end

Cbase = 'C:\work\IFCB_products\Global_map\';
Clist = {'gradients3', 'gradients4' 'gradients5' 'hot335'}; %Angel White
for ii = 1:length(Clist)
    load([Cbase Clist{ii}])
    eval(['temp =' Clist{ii} ';'])
    plotm(temp{1:100:end,1}, temp{1:100:end,2}, 'r.', 'markersize', 4)
end
clear temp gradients* hot*
Clist = {'Ilulisat_Quebec_samples', 'Lorient_Tromso_samples' 'Murmansk_Dudinka_samples'...
    'Pevek_tuktoytuk_samples' 'Tromso_Murmansk_samples'}; %Lee Karp-Boss
for ii = 1:length(Clist)
    load([Cbase Clist{ii}])
    plotm(IFCB_samples.object_lat, IFCB_samples.object_lon, 'r.', 'markersize', 4)
    bin_count = [bin_count; sum(~isnan(IFCB_samples.object_lat))];
end
clear IFCB_samples Clist ii

%c = [255 165 0]/255; %orange
load('c:\work\IFCB_products\Global_map\TS_pos')
tsh = plotm(ts(:,1),ts(:,2), 'o', 'MarkerEdgeColor', 'k', 'MarkerSize', 6, 'markerfacecolor', 'y');
legend([tsh ch], 'Time series location', 'Shipboard sample')

setm(gca, 'meridianlabel', 'off', 'ParallelLabel','off')
lh = legend([tsh ch], 'Time series location', 'Shipboard sample', 'fontsize', 12);
set(lh, 'position', [.4 .25 .12 .06])

%print('C:\work\IFCB_products\Global_map\IFCB_samples_global_map.png','-dpng', '-r300')
exportgraphics(gcf,'c:\work\IFCB_products\Global_map\IFCB_samples_global_map_transparent_2025.emf','ContentType','vector','BackgroundColor','none')

%%
figure
usamap('conus')
states = readgeotable('usastatehi.shp');
gs = geoshow('landareas.shp', 'FaceColor', [.15 .4 .6], 'EdgeColor', [.6 .6 .6]);
geoshow(states, 'facecolor', 'none', 'edgecolor', [.4 .5 .8])
states = readgeotable('usastatehi.shp');
setm(gca, 'meridianlabel', 'off', 'ParallelLabel','off', 'grid', 'off')
gh = get(gca, 'children');
set(gh(end), 'EdgeColor', 'none') 
tsh = plotm(ts(:,1),ts(:,2), 'o', 'MarkerEdgeColor', 'k', 'MarkerSize', 6, 'markerfacecolor', 'y');

exportgraphics(gcf,'c:\work\IFCB_products\Global_map\IFCB_time_series_USA_transparent2_2025.emf','ContentType','vector','BackgroundColor','none')

%%
figure('WindowState','maximized')
worldmap('na'), setm(gca, 'origin', [0 -90 0]) %this 
setm(gca, 'maplonlimit', [-135 -53], 'MapLatLimit',[18 60])
gs1 = geoshow('landareas.shp', 'FaceColor', [0 85 132]./255, 'EdgeColor', [.3 .4 .4], 'linewidth', .25 )'% [0 85 132]./255);
gs2 = geoshow(states, 'facecolor', [0 85 132]./255, 'edgecolor', [.3 .4 .4], 'linewidth',.25);
setm(gca, 'meridianlabel', 'off', 'ParallelLabel','off', 'grid', 'off')
gh = get(gca, 'children');
set(gh(end), 'EdgeColor', 'none') 
tsh = plotm(ts(:,1),ts(:,2), 'o', 'MarkerEdgeColor', 'k', 'MarkerSize', 6, 'markerfacecolor', 'y');
%%
exportgraphics(gcf,'c:\work\IFCB_products\Global_map\IFCB_time_series_USA_transparent.emf','ContentType','vector','BackgroundColor','none')

%%
%https://data.hais.ioc-unesco.org/
habT = readtable("C:\work\IFCB_products\Global_map\HAEDAT_events.csv");
g = groupcounts(habT, ["gridcode" "gridlatitude" "gridlongitude" "syndrome" "syndromeid"]);
sStr = {'ASP' 'DSP' 'NSP' 'PSP'};
mStr = {'sm' '^g' '<c' 'db'};
%%
figure('WindowState','maximized')
worldmap('na'), setm(gca, 'origin', [0 -90 0]) %this 
setm(gca, 'maplonlimit', [-135 -53], 'MapLatLimit',[18 60])
gs1 = geoshow('landareas.shp', 'FaceColor', [0 85 132]./255, 'EdgeColor', [.3 .4 .4], 'linewidth', .25 )'% [0 85 132]./255);
gs2 = geoshow(states, 'facecolor', [0 85 132]./255, 'edgecolor', [.3 .4 .4], 'linewidth',.25);
setm(gca, 'meridianlabel', 'off', 'ParallelLabel','off', 'grid', 'off')
gh = get(gca, 'children');
set(gh(end), 'EdgeColor', 'none') 
tsh = plotm(ts(:,1),ts(:,2), 'o', 'MarkerEdgeColor', 'y', 'MarkerSize', 6, 'markerfacecolor', 'y');
for ii = 1:2% length(sStr)
    ind = find(strcmp(sStr{ii},g.syndrome));
    s{ii} = scatterm(g.gridlatitude(ind), g.gridlongitude(ind), g.GroupCount(ind)*3, mStr{ii},'filled');
end
for ii = 3:4% length(sStr)
    ind = find(strcmp(sStr{ii},g.syndrome));
    s{ii} = scatterm(g.gridlatitude(ind), g.gridlongitude(ind), g.GroupCount(ind)*3, mStr{ii});
end
lh = legend([tsh s{1}.Children(1) s{2}.Children(1) s{3}.Children(1) s{4}.Children(1)] ,...
   'IFCB time series', 'Amnesic Shellfish Poisoning', 'Diarrhetic Shellfish Poisoning', 'Neurotoxic Shellfish Poisoning', 'Paralytic Shellfish Poisoning', 'textcolor', 'w', 'fontsize', 6);
set(lh, 'box', 'off', 'position', [0.4202    0.2945    0.1247    0.0917])
%%
exportgraphics(gcf,'c:\work\IFCB_products\Global_map\IFCB_time_series_USA_transparent_syndromes.emf','ContentType','vector','BackgroundColor','none')

%%


return

%mvco, Harpswell fiddlers nauset budd oceanAlliance BayStateHatch VIMS
%LOMBOS MDI Newpass GSO Jamestown Surfside PortAransas CalPoly Bodega
%ScrippsPier ScrippsPier151 MBARIbuoy DelMar NewportBeach SFPier SCWharf
%Stearns Scalloway ColeDeep Utö
ts_bin_count = [307698 63373 38648 42786 17657 463 1161 44650 ...
    1276 7332 26095 53668 2846 94844 196315 5428 16795 ...
    4507 8610 16917 3391 15229 18798 80209 ...
    4293 25653 5621 41097 ];


%%
ts_url = {'https://ifcb-data.whoi.edu/api/export_metadata/mvco'...
'https://habon-ifcb.whoi.edu/api/export_metadata/harpswell'...
'https://habon-ifcb.whoi.edu/api/export_metadata/fiddlers'...
'https://habon-ifcb.whoi.edu/api/export_metadata/nauset'...
'https://habon-ifcb.whoi.edu/api/export_metadata/buddinlet'...
'https://habon-ifcb.whoi.edu/api/export_metadata/oceanalliance'...
'https://habon-ifcb.whoi.edu/api/export_metadata/baystatehatchery'...
'https://habon-ifcb.whoi.edu/api/export_metadata/vimspier'...
'https://habon-ifcb.whoi.edu/api/export_metadata/lombos'...
'https://habon-ifcb.whoi.edu/api/export_metadata/mdibl'...
'https://habon-ifcb.whoi.edu/api/export_metadata/newpass'...
'https://ifcb-dashboard.gso.uri.edu/api/export_metadata/GSO_Dock'...
'https://ifcb-dashboard.gso.uri.edu/api/export_metadata/Jamestown'...
'https://toast.tamu.edu/api/export_metadata/Surfside_Beach'...
'https://toast.tamu.edu/api/export_metadata/Port_Aransas'...
'https://ifcb.caloos.org/api/export_metadata/cal-poly-humboldt-hioc'...
'https://ifcb.caloos.org/api/export_metadata/bodega-marine-lab'...
'https://ifcb.caloos.org/api/export_metadata/scripps-pier-ifcb-183'...
'https://ifcb.caloos.org/api/export_metadata/scripps-pier-ifcb-151'...
'https://ifcb.caloos.org/api/export_metadata/mbari-power-buoy'...
'https://ifcb.caloos.org/api/export_metadata/del-mar-mooring'...
'https://ifcb.caloos.org/api/export_metadata/newport-beach-pier'...
'https://ifcb.caloos.org/api/export_metadata/san-francisco-pier-17'...
'https://ifcb.caloos.org/api/export_metadata/santa-cruz-municipal-wharf'...
'https://ifcb.caloos.org/api/export_metadata/stearns-wharf'...
'https://ifcb-data.sams.ac.uk/api/export_metadata/Scalloway'...
'https://ifcb-data.sams.ac.uk/api/export_metadata/ColeDeep'...
'https://ifcb.plankton.live/api/export_metadata/uto'...
'https://ifcb.hpl.umces.edu/api/export_metadata/hpl-ifcb-data'...
'https://habon-ifcb.whoi.edu/api/export_metadata/aoos_KBLdock_bottles'...
'https://ifcb-data.oceanobservatories.org/api/export_metadata/PioneerMABMoored'...
};

for ii = 1:length(ts_url)
    disp(ii)
    metaT_ts{ii} =  webread(ts_url{ii}, weboptions('timeout', 30));
    bin_count_ts(ii) = size(metaT_ts,1);%sum(~isnan(metaT_ts{ii}.latitude))];
end

for ii = 1:length(metaT_ts)
    if ~isempty(metaT_ts{ii})
        num_images_ts(ii) = sum(metaT_ts{ii}.n_images(~metaT_ts{ii}.skip));
        bin_count_ts(ii) = size(metaT_ts{ii},1);%sum(~isnan(metaT_ts{ii}.latitude))];
    end
end

for ii = 1:length(metaT)
    if ~isempty(metaT{ii})
        num_images(ii) = sum(metaT{ii}.n_images(~metaT{ii}.skip));
    end
end
