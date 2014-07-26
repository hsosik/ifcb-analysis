m_proj('UTM','long',[-76 -60],'lat',[40 45]);
m_gshhs_h('save','gumby');
figure(1);
m_usercoast('gumby','color','k')%'patch','k');%for if you want the land to be color
%m_grid;
m_grid('box','fancy','tickdir','out');



%%
hold on

load '/Volumes/IFCB014_OkeanosExplorerAug2013/NAV/metadata.mat'

Lat=Lat_full/100;
Lon=Lon_full/100;
m_line(-tintinnid_lon_alt(2:17),tintinnid_lat_alt(2:17),'linewidth',2);
m_etopo2('contour', [-100:-100:-650],'edgecolor','k');


load '/Volumes/IFCB014_OkeanosExplorerAug2013/data/Manual_fromClass/summary_old/alt_summary_old/count_manual_05Feb2014.mat'

min_diff= 1/86400;
match_ind_alt=NaN(size(matdate));


for ii=1:length(matdate);
    [min_ii, i2]=min(abs(matdate(ii)-Date_full));
 
    if min_ii <= min_diff
        match_ind_alt(ii)=i2;
        %i2=match_ind(ii);
    end
end;


iii=find(isnan(match_ind_alt));

match_ind_alt(find(isnan(match_ind_alt))) = [];

tintinnid_perml_alt=classcount(:,90)./ml_analyzed;
tintinnid_lat_alt=Lat(match_ind_alt);
tintinnid_lon_alt=Lon(match_ind_alt);
%%

load '/Volumes/IFCB010_OkeanosExplorerAug2013/data/Manual_fromClass/summary/count_manual_19Jan2014.mat'

match_ind_norm=NaN(size(matdate));
min_diff= 1/1440;

for ii=1:length(matdate);
    [min_ii, i2]=min(abs(matdate(ii)-Date_full));
 
    if min_ii <= min_diff
        match_ind_norm(ii)=i2;
        %i2=match_ind(ii);
    end
end;


iii=find(isnan(match_ind_norm));

match_ind_norm(find(isnan(match_ind_norm))) = [];

tintinnid_perml_norm=classcount(:,90)./ml_analyzed;
tintinnid_lat_norm=Lat(match_ind_norm);
tintinnid_lon_norm=Lon(match_ind_norm);


%for cruise track
%lons=[-71:.1:-67];
%lats=60*cos((lons+115)*pi/180);
%dates=datenum(1997,10,23,15,1:41,zeros(1,41));

m_line(-tintinnid_lon_alt,tintinnid_lat_alt);
%%