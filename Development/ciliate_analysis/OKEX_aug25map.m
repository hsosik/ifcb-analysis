%for map of Aug 25

m_proj('UTM','long',[-72 -66],'lat',[40 45]);
m_gshhs_h('save','gumby');
figure(1);
%m_usercoast('gumby','color','k');%for if you want the land to be color
m_usercoast('gumby','patch',[.7 1 .7],'edgecolor','k');
%m_grid;
m_grid('box','fancy','tickdir','out');



%%
hold on

load '/Volumes/IFCB014_OkeanosExplorerAug2013/NAV/metadata.mat'

Lat=Lat_full/100;
Lon=Lon_full/100;
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

m_line(-tintinnid_lon_alt(2:17),tintinnid_lat_alt(2:17),'linewidth',2);
m_etopo2('contour', [-100:-100:-650],'edgecolor','k');