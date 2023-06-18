%%

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

matdate_alt=matdate;
ml_analyzed_alt=ml_analyzed;

iii=find(isnan(match_ind_alt));

match_ind_alt(find(isnan(match_ind_alt))) = [];

tintinnid_alt=classcount(:,90);
tintinnid_perml_alt=classcount(:,90)./ml_analyzed;
tintinnid_lat_alt=Lat(match_ind_alt);
tintinnid_lon_alt=Lon(match_ind_alt);
%%

load '/Volumes/IFCB010_OkeanosExplorerAug2013/data/Manual_fromClass/summary/count_manual_08May2014.mat'

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
tintinnid_norm=classcount(:,90);
tintinnid_perml_norm=classcount(:,90)./ml_analyzed;
tintinnid_lat_norm=Lat(match_ind_norm);
tintinnid_lon_norm=Lon(match_ind_norm);

%%

%for practice
% figure
% worldmap([40 45],[-80 -60])
% load coast
% plotm(lat,long,'LineWidth',1,'Color','blue')
% plotm(tintinnid_lat_alt,-tintinnid_lon_alt,'r*')
% plot3m(tintinnid_lat_alt,-tintinnid_lon_alt,tintinnid_perml_alt')
% %surfacem(tintinnid_lat,-tintinnid_lon,tintinnid_perml')
% 
% figure
% worldmap([40 45],[-80 -60])
% load coast
% plotm(lat,long,'LineWidth',1,'Color','blue')
% plotm(tintinnid_lat_norm,-tintinnid_lon_norm,'r*')
% plot3m(tintinnid_lat_norm,-tintinnid_lon_norm,tintinnid_perml_norm')
% surfacem(tintinnid_lat,-tintinnid_lon,tintinnid_perml')

% 
iz=find(tintinnid_perml_alt); %finds the nonzeros
noniz=find(tintinnid_perml_alt==0);
% 
% worldmap([40 45],[-80 -60])
% load coast
% plotm(lat,long)
% view(3)
% plotm(tintinnid_lat_alt,-tintinnid_lon_alt,'-k')
% stem3m(tintinnid_lat_alt,-tintinnid_lon_alt,tintinnid_perml_alt')
% scatterm(tintinnid_lat_alt(iz),-tintinnid_lon_alt(iz),100,log10(tintinnid_perml_alt(iz))','filled')
% scatterm(tintinnid_lat_alt(noniz),-tintinnid_lon_alt(noniz),50,log10(tintinnid_perml_alt(noniz))')


% m_proj('UTM','long',[-76 -60],'lat',[39 45]);
% set(gca,'color',[.9 .99 1]); 
 %m_gshhs_h('save','gumby'); %run this to make coastline if not already saved in directory
% figure(1);
% m_usercoast('gumby','color','k')%'patch','k');%for if you want the land to be color
% %m_grid;
% m_grid('box','fancy','tickdir','out');
% hold on
% m_line(-tintinnid_lon_alt,tintinnid_lat_alt);



% m_proj('miller','long',[-76 -60],'lat',[40 45]);
% set(gca,'color',[.9 .99 1]);  % Trick is to set this *before* the patch call.
% 
% m_usercoast('gumby','patch',[.7 1 .7],'edgecolor','k');%for if you want the land to be color
% m_etopo2('contour', [-100:-100:-650],'edgecolor','k')
% m_grid('box','fancy','tickdir','out');
% hold on
% m_line(-tintinnid_lon_alt(iz),tintinnid_lat_alt(iz),'marker','o','color','r','MarkerFaceColor','r');

% for i=1:length(iz)
% m_line(-tintinnid_lon_alt(i),tintinnid_lat_alt(i),'marker','o','color','r');
% end;
% 
% cmp=jet(8);
% m_line(-tintinnid_lon_alt(iz),tintinnid_lat_alt(iz),'marker','o','color','r');

%

%alt_metadata_map




    







