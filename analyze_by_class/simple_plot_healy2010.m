resultpath = '\\floatcoat\laneylab\projects\HLY1001\work\manual_fromClass\underway\summary\';
load([resultpath 'count_manual_12Apr2012'])
[ lat, lon ] = get_healy2010_latlon( matdate );

ii = 7; %pick a number from class2use
figure
plot(lat, classcount(:,ii)./ml_analyzed, '.')
ylabel([class2use{ii} ', mL^{-1}'])
xlabel('Latitude')

figure
stem3(lon, lat, classcount(:,ii)./ml_analyzed)
zlabel([class2use{ii} ', mL^{-1}'])
ylabel('Latitude')
xlabel('Longitude')

for ii = 1:length(class2use),
    figure(99), clf
    stem3(lon, lat, classcount(:,ii)./ml_analyzed)
    zlabel([class2use{ii} ', mL^{-1}'])
    ylabel('Latitude')
    xlabel('Longitude')
    pause
end;
