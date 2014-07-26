% S= gshhs('/Users/markmiller/Documents/m_map/private/gshhs_h.b',[40 45],[-80 -60]);
% worldmap S
% geoshow([world.Lat], [world.Lon])


figure
worldmap([39.5 44], [-72 -64]);
projection = gcm;
latlim = projection.maplatlimit;
lonlim = projection.maplonlimit;

[~,ix] = sort([S.Level],'descend');
S = S(ix);
%geoshow(S, 'FaceColor', 'green');
geoshow(S, 'FaceColor', [.7 1 .7]);
%setm(gca, 'FFaceColor', 'cyan');
%axesm sinusoid; view(3);
axesm sinusoid; view(3)
h_1 = framem; set(h,'zdata',zeros(size(lat)));
%h = linem(tintinnid_lat_alt,-tintinnid_lon_alt);




stem3m(tintinnid_lat_alt,-tintinnid_lon_alt,tintinnid_perml_alt','r-')


load '/Users/markmiller/Documents/code_svn/ciliate_analysis/S.mat'

%this works
load coast
axesm sinusoid; view(3)
h = framem; set(h,'zdata',zeros(size(lat)))
plotm(lat,long)
scatterm(tintinnid_lat_alt(iz),-tintinnid_lon_alt(iz),100,log10(tintinnid_perml_alt(iz))','filled')


%iz=index for IFCB14 tintinnid counts
%norm_iz= index for IFCB10 tintinnid counts

tintinnid_perml_iz_alt=tintinnid_perml_alt(iz); %highest is 13 lat is 42.3801, lon is 67.3890
tintinnid_perml_iz_norm=tintinnid_perml_norm(norm_iz); %corresponds with 11


tintinnid_classcount_ml= [tintinnid_perml_iz_norm(11) tintinnid_perml_iz_alt(13)];
[tintinnid_ci] = poisson_count_ci(tintinnid_classcount_ml, 0.95);
tintinnid_ci_ml= normal_ci/(sum(ml_analyzed(16:end)));


points=[0.0308 0.5019];
ci=[normal_ci_ml(2) alt_ci_ml(2)];

lower=[(gyro_normal_classcount_ml-normal_ci_ml(1)) gyro_alt_classcount_ml-alt_ci_ml(1)];
upper=[normal_ci_ml(2)-gyro_normal_classcount_ml alt_ci_ml(2)-gyro_alt_classcount_ml];

% lower=[normal_ci_ml(1) alt_ci_ml(1)];
% upper=[normal_ci_ml(2) alt_ci_ml(2)];

xaxis=[1 2];
figure;
bar1= bar(xaxis, [gyro_normal_classcount_ml gyro_alt_classcount_ml]);
set(gca,'xticklabel',{'unstained','stained'}, 'fontsize', 24, 'fontname', 'arial');
ylabel('\it{Gyrodinium} \rm sp ( mL^{-1})', 'fontsize', 24, 'fontname', 'arial');
hold on
plot(xaxis, points, '.b');
errorbar(xaxis, points, lower, upper, 'r', 'Marker', 'none', 'LineStyle', 'none', 'Linewidth', 4);
axis square

