c=colormap;
%mycmap=c(1:6:64,:);
mycmap=c(1:5:64,:);
%mycmap=c;
mycmap(1,:)=[0 0 0];

% black=[0 0 0];
% mycmap=[black;mycmap];

%tintinnid_bins=0.2:0.1:1.2;
tintinnid_bins=0:0.1:1.2;

%classes={'one';'two';'thr';'fou';'fiv';'six';'sev';'eig';'nin';'ten';'ele'};

% for ii=1:length(tintinnid_bins),    
%     tintinnid_color_bins.(classes{ii})=NaN(1,10);
% end
% 
% for i=1:10;
% tintinnid_color_bins.(classes{i})=find(tintinnid_perml_alt(norm_iz) >=tintinnid_bins(i) & tintinnid_perml_alt(iz) < tintinnid_bins(i+1));
% end
% 
% for i=11;
%     tintinnid_color_bins.(classes{i})=find(tintinnid_perml_alt(iz) >=tintinnid_bins(i));
% end

tintinnid_lat_iz_alt=tintinnid_lat_alt(iz);
tintinnid_lon_iz_alt=tintinnid_lon_alt(iz);


% tintinnid_color_bins_1=find(tintinnid_perml_alt(iz) >=tintinnid_bins(1) & tintinnid_perml_alt(iz) < tintinnid_bins(2));
% tintinnid_color_bins_2=find(tintinnid_perml_alt(iz) >=tintinnid_bins(2) & tintinnid_perml_alt(iz) < tintinnid_bins(3));
% tintinnid_color_bins_3=find(tintinnid_perml_alt(iz) >=tintinnid_bins(3) & tintinnid_perml_alt(iz) < tintinnid_bins(4));
% tintinnid_color_bins_4=find(tintinnid_perml_alt(iz) >=tintinnid_bins(4) & tintinnid_perml_alt(iz) < tintinnid_bins(5));
% tintinnid_color_bins_7=find(tintinnid_perml_alt(iz) >=tintinnid_bins(7) & tintinnid_perml_alt(iz) < tintinnid_bins(8));
% tintinnid_color_bins_11=find(tintinnid_perml_alt(iz) >=tintinnid_bins(11));

tintinnid_color_bins_0=find(tintinnid_perml_alt ==tintinnid_bins(1));
tintinnid_color_bins_1=find(tintinnid_perml_alt(iz) >=tintinnid_bins(2) & tintinnid_perml_alt(iz) < tintinnid_bins(3));
tintinnid_color_bins_2=find(tintinnid_perml_alt(iz) >=tintinnid_bins(3) & tintinnid_perml_alt(iz) < tintinnid_bins(4));
tintinnid_color_bins_3=find(tintinnid_perml_alt(iz) >=tintinnid_bins(4) & tintinnid_perml_alt(iz) < tintinnid_bins(5));
tintinnid_color_bins_4=find(tintinnid_perml_alt(iz) >=tintinnid_bins(5) & tintinnid_perml_alt(iz) < tintinnid_bins(6));
tintinnid_color_bins_7=find(tintinnid_perml_alt(iz) >=tintinnid_bins(8) & tintinnid_perml_alt(iz) < tintinnid_bins(9));
tintinnid_color_bins_11=find(tintinnid_perml_alt(iz) >=tintinnid_bins(12));
%%

%% OLD MAP
%m_proj('UTM','long',[-76 -60],'lat',[39 45]);
% m_proj('UTM','long',[-72 -64],'lat',[39.5 44]);
% figure(2);
% %m_gshhs_h('save','gumby');
% m_usercoast('gumby','patch',[.7 1 .7],'edgecolor','k');%for if you want the land to be color
% %m_etopo2('contour', [-50:-50:-500],'edgecolor','k') %for higher
% %resolution
% %m_etopo2('contour', [-60:-500:-600],'edgecolor','k')%for low resolution
% m_etopo2('contour', [-100:-500:-750],'edgecolor','k')%for medium
% %resolution
% m_grid('box','fancy','tickdir','out');
% hold on
% 
% m_line(-tintinnid_lon_alt, tintinnid_lat_alt,'color','b');

%stem3m(-tintinnid_lon_alt,tintinnid_lat_alt,tintinnid_perml_alt')

%%

m_proj('UTM','long',[-72 -65],'lat',[40 44]);
figure(1);
m_usercoast('gumby','patch',[.7 1 .7],'edgecolor','k');
%m_tbase('contour',[-5000:700:-100 000:2000:5000],'edgecolor','k');
m_tbase('contour',[-500 -100 000:2000:5000],'edgecolor','k');
%m_tbase('contour',[-5000:700:-50 000:2000:5000],'edgecolor','k');
%m_tbase('contour',[-7000:2000:-1000 000:2000:5000],'edgecolor','k');
%m_etopo2('contour','edgecolor','k')
m_grid('box','fancy','tickdir','out','fontsize', 16, 'fontname','Times New Roman');
hold on
%m_line(-Lon, Lat,'color','b','linewi',1.5);

m_line(-Lon(1:960000), Lat(1:960000),'color','b','linewi',1.5);

%imshow('http://demi.whoi.edu/IFCB010_OkeanosExplorerAug2013/D20130828T095434_IFCB010_00099.html')
%imshow('/Users/markmiller/Documents/Experiments/OKEX_Cruise/tintinnid images/D20130828T100908_IFCB014_png/D20130828T100908_IFCB014_00154.png')


%m_line(-tintinnid_lon_iz_alt,tintinnid_lat_iz_alt)
%%
%m_line(-tintinnid_lon_alt(noniz),tintinnid_lat_alt(noniz),'marker','o','color','k','MarkerFaceColor','k','Markersize',5);
%m_line(-tintinnid_lon_norm(norm_noniz(1:445)),tintinnid_lat_norm(norm_noniz(1:445)),'marker','o','color','k','MarkerFaceColor','none','Markersize',5);

% m_proj('UTM','long',[-72 -64],'lat',[39.5 44]);
% figure(1);
% m_usercoast('gumby','patch',[.7 1 .7],'edgecolor','k');
% m_etopo2('contour', [-100:-500:-750],'edgecolor','k')
% m_grid('box','fancy','tickdir','out');
% hold on
% m_line(-Lon, Lat,'color','b');

for i=1:length(tintinnid_color_bins_0);
m_line(-tintinnid_lon_alt(tintinnid_color_bins_0(i)),tintinnid_lat_alt(tintinnid_color_bins_0(i)),'marker','o','color',[mycmap(1,:)],'MarkerFaceColor',[mycmap(1,:)],'Markersize',5);
end


for i=1:length(tintinnid_color_bins_1);
m_line(-tintinnid_lon_iz_alt(tintinnid_color_bins_1(i)),tintinnid_lat_iz_alt(tintinnid_color_bins_1(i)),'marker','o','color',[mycmap(2,:)],'MarkerFaceColor',[mycmap(2,:)],'Markersize',10);
end


for i=1:length(tintinnid_color_bins_2);
m_line(-tintinnid_lon_iz_alt(tintinnid_color_bins_2(i)),tintinnid_lat_iz_alt(tintinnid_color_bins_2(i)),'marker','o','color',[mycmap(3,:)],'MarkerFaceColor',[mycmap(3,:)],'Markersize',10);
end

for i=1:length(tintinnid_color_bins_3);
m_line(-tintinnid_lon_iz_alt(tintinnid_color_bins_3(i)),tintinnid_lat_iz_alt(tintinnid_color_bins_3(i)),'marker','o','color',[mycmap(4,:)],'MarkerFaceColor',[mycmap(4,:)],'Markersize',10);
end

for i=1:length(tintinnid_color_bins_4);
m_line(-tintinnid_lon_iz_alt(tintinnid_color_bins_4(i)),tintinnid_lat_iz_alt(tintinnid_color_bins_4(i)),'marker','o','color',[mycmap(5,:)],'MarkerFaceColor',[mycmap(5,:)],'Markersize',10);
end

for i=1:length(tintinnid_color_bins_7);
m_line(-tintinnid_lon_iz_alt(tintinnid_color_bins_7(i)),tintinnid_lat_iz_alt(tintinnid_color_bins_7(i)),'marker','o','color',[mycmap(8,:)],'MarkerFaceColor',[mycmap(8,:)],'Markersize',10);
end

for i=1:length(tintinnid_color_bins_11);
m_line(-tintinnid_lon_iz_alt(tintinnid_color_bins_11(i)),tintinnid_lat_iz_alt(tintinnid_color_bins_11(i)),'marker','o','color',[mycmap(12,:)],'MarkerFaceColor',[mycmap(12,:)],'Markersize',10);
end

%colorbar('YTickLabel',{'0','0.1','0.2','0.3','0.4','0.5','0.6','0.7','0.8','0.9','1.0','1.1','1.2'})
% colormap(mycmap);
% h_1=colorbar('YTickLabel',{'0','0.1','0.2','0.3','0.4','0.5','0.6','0.7','0.8','0.9','1.0','1.1','1.2'})
% set(get(h_1,'ylabel'),'string','Cell concentration (mL^{-1})','fontsize',20,'fontname','arial');

numcolors=12;
colormap(mycmap);
caxis([0.01 numcolors]);
%colorbar('YTickLabel',{'0.2','0.3','0.4','0.5','0.6','0.7','0.8','0.9','1.0','1.1','1.2'})
h=colorbar('Ytick',[0.01+0.5*(numcolors-1)/numcolors:(numcolors-1)/numcolors:numcolors],...
    'YTickLabel',{'0','0.1','0.2','0.3','0.4','0.5','0.6','0.7','0.8','0.9','1.0','1.1','1.2'},'Ylim',[0.01 numcolors])
%set(h,'Ytick',[12])

%set(get(h,'ylabel'),'string','Cell concentration (mL^{-1})');
set(get(h,'ylabel'),'string','Cell concentration (mL^{-1})','fontsize',20,'fontname','Times New Roman');
%%

%tintinnid_bins_norm=0.2:0.1:0.8;
%mycmap_norm=c(1:10:64,:);

norm_iz=find(tintinnid_perml_norm); %finds the nonzeros
norm_noniz=find(tintinnid_perml_norm==0);

tintinnid_lat_iz_norm=tintinnid_lat_norm(norm_iz);
tintinnid_lon_iz_norm=tintinnid_lon_norm(norm_iz);

tintinnid_color_bins_norm_0=find(tintinnid_perml_norm ==tintinnid_bins(1));
tintinnid_color_bins_norm_1=find(tintinnid_perml_norm(norm_iz) >=tintinnid_bins(1) & tintinnid_perml_norm(norm_iz) < tintinnid_bins(2));
tintinnid_color_bins_norm_2=find(tintinnid_perml_norm(norm_iz) >=tintinnid_bins(2) & tintinnid_perml_norm(norm_iz) < tintinnid_bins(3));
tintinnid_color_bins_norm_3=find(tintinnid_perml_norm(norm_iz) >=tintinnid_bins(3) & tintinnid_perml_norm(norm_iz) < tintinnid_bins(4));
tintinnid_color_bins_norm_4=find(tintinnid_perml_norm(norm_iz) >=tintinnid_bins(4) & tintinnid_perml_norm(norm_iz) < tintinnid_bins(5));
tintinnid_color_bins_norm_5=find(tintinnid_perml_norm(norm_iz) >=tintinnid_bins(5) & tintinnid_perml_norm(norm_iz) < tintinnid_bins(6));
tintinnid_color_bins_norm_6=find(tintinnid_perml_norm(norm_iz) >=tintinnid_bins(6) & tintinnid_perml_norm(norm_iz) < tintinnid_bins(7));
tintinnid_color_bins_norm_7=find(tintinnid_perml_norm(norm_iz) >=tintinnid_bins(7));

%m_proj('UTM','long',[-76 -60],'lat',[39 45]);
% m_proj('UTM','long',[-72 -64],'lat',[39.5 44]);
% figure(2);
% m_usercoast('gumby','patch',[.7 1 .7],'edgecolor','k');%for if you want the land to be color
% %m_etopo2('contour', [-100:-100:-650],'edgecolor','k')%for higher
% %resolution bathymetry
% m_etopo2('contour', [-100:-500:-750],'edgecolor','k')
% %m_etopo2('contour', [-60:-500:-600],'edgecolor','k')%for low resolution
% m_grid('box','fancy','tickdir','out');
% hold on

%%
%m_line(-tintinnid_lon_iz_norm,tintinnid_lat_iz_norm)

%m_line(-tintinnid_lon_norm,tintinnid_lat_norm)
%%
%m_line(-tintinnid_lon_norm(norm_noniz(1:445)),tintinnid_lat_norm(norm_noniz(1:445)),'marker','o','color','k','MarkerFaceColor','k','Markersize',3);
%m_line(-tintinnid_lon_norm(norm_noniz(1:148)),tintinnid_lat_norm(norm_noniz(1:148)),'marker','o','color','k','MarkerFaceColor','none','Markersize',5);

m_proj('UTM','long',[-72 -65],'lat',[40 44]);
figure(2);
m_usercoast('gumby','patch',[.7 1 .7],'edgecolor','k');
%m_tbase('contour','edgecolor','k');
m_tbase('contour',[-5000:700:-100 000:2000:5000],'edgecolor','k');
%m_etopo2('contour','edgecolor','k')
m_grid('box','fancy','tickdir','out','fontsize', 16, 'fontname','Times New Roman');
hold on
%m_line(-Lon, Lat,'color','b','linewi',1.5);

m_line(-Lon(1:960000), Lat(1:960000),'color','b','linewi',1.5);

% m_proj('UTM','long',[-72 -64],'lat',[39.5 44]);
% figure(2);
% m_usercoast('gumby','patch',[.7 1 .7],'edgecolor','k');
% m_etopo2('contour', [-100:-500:-750],'edgecolor','k')
% m_grid('box','fancy','tickdir','out');
% hold on
% m_line(-Lon, Lat,'color','b');


for i=1:length(tintinnid_color_bins_norm_0);
m_line(-tintinnid_lon_norm(tintinnid_color_bins_norm_0(i)),tintinnid_lat_norm(tintinnid_color_bins_norm_0(i)),'marker','o','color',[mycmap(1,:)],'MarkerFaceColor',[mycmap(1,:)],'Markersize',5);
end

for i=1:length(tintinnid_color_bins_norm_1);
m_line(-tintinnid_lon_iz_norm(tintinnid_color_bins_norm_1(i)),tintinnid_lat_iz_norm(tintinnid_color_bins_norm_1(i)),'marker','o','color',[mycmap(2,:)],'MarkerFaceColor',[mycmap(2,:)],'Markersize',10);
end

for i=1:length(tintinnid_color_bins_norm_2);
m_line(-tintinnid_lon_iz_norm(tintinnid_color_bins_norm_2(i)),tintinnid_lat_iz_norm(tintinnid_color_bins_norm_2(i)),'marker','o','color',[mycmap(3,:)],'MarkerFaceColor',[mycmap(3,:)],'Markersize',10);
end

for i=1:length(tintinnid_color_bins_norm_3);
m_line(-tintinnid_lon_iz_norm(tintinnid_color_bins_norm_3(i)),tintinnid_lat_iz_norm(tintinnid_color_bins_norm_3(i)),'marker','o','color',[mycmap(4,:)],'MarkerFaceColor',[mycmap(4,:)],'Markersize',10);
end

% %colorbar('YTickLabel',{'0.2','0.3','0.4','0.5','0.6','0.7','0.8','0.9','1.0','1.1','1.2'})
% h=colorbar('Ytick',[0:12:1.2],'YTickLabel',{'0','0.1','0.2','0.3','0.4','0.5','0.6','0.7','0.8','0.9','1.0','1.1','1.2'})
% %set(h,'Ytick',[12])
% colormap(mycmap);
% %set(get(h,'ylabel'),'string','Cell concentration (mL^{-1})');
% set(get(h,'ylabel'),'string','Cell concentration (mL^{-1})','fontsize',20,'fontname','arial');
%%
numcolors=12;
colormap(mycmap);
caxis([0.01 numcolors]);
%colorbar('YTickLabel',{'0.2','0.3','0.4','0.5','0.6','0.7','0.8','0.9','1.0','1.1','1.2'})
h=colorbar('Ytick',[0.01+0.5*(numcolors-1)/numcolors:(numcolors-1)/numcolors:numcolors],...
    'YTickLabel',{'0','0.1','0.2','0.3','0.4','0.5','0.6','0.7','0.8','0.9','1.0','1.1','1.2'},'Ylim',[0.01 numcolors])

%set(get(h,'ylabel'),'string','Cell concentration (mL^{-1})');
set(get(h,'ylabel'),'string','Cell concentration (mL^{-1})','fontsize',20,'fontname','Times New Roman');
%%



