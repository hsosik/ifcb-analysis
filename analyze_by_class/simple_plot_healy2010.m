resultpath = '\\floatcoat\laneylab\projects\HLY1001\work\manual_fromClass\underway\summary\';
load([resultpath 'count_manual_16Apr2012'])
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


load([resultpath 'count_biovol_manual_12Jun2012']);
[ lat, lon ] = get_healy2010_latlon( matdate );

diatom_class = {'Asterionellopsis' 'Cerataulina' 'Chaetoceros' 'Corethron' 'Coscinodiscus' 'Cylindrotheca' 'DactFragCerataul' 'Dactyliosolen' ...
    'Ditylum' 'Ephemera' 'Eucampia' 'Guinardia' 'Guinardia_flaccida' 'Guinardia_striata' 'Lauderia' 'Leptocylindrus' 'Licmophora' 'Odontella' ...
    'Paralia' 'pennate' 'Pleurosigma' 'Pseudonitzschia' 'Rhizosolenia' 'Skeletonema' 'Stephanopyxis' 'Thalassionema' 'Thalassiosira' 'Fragilariopsis' };

[~,diatom_ind] = intersect(class2use, diatom_class);

dino_class = {'Ceratium' 'dino10' 'dino30' 'Dinophysis' 'Gonyaulax' 'Gyrodinium' 'Prorocentrum'};
[~,dino_ind] = intersect(class2use, dino_class);

mix_class = {'roundCell' 'clusterflagellate' 'flagellate' 'kiteflagellates' 'mix_elongated'};

nonphyto_class = {'bad' 'ciliate' 'detritus' 'ciliate_mix' 'tintinnid' 'Myrionecta' 'Laboea'};
[~,phyto_ind] = setdiff(class2use, nonphyto_class);
diatom_biovol = sum(classbiovol(:,diatom_ind),2);
dino_biovol = sum(classbiovol(:,dino_ind),2);
phyto_biovol = sum(classbiovol(:,phyto_ind),2);
