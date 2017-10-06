clear all

load '\\sosiknas1\IFCB_data\IFCB102_PiscesNov2014\metadata\metadata_raw.mat' %non-staining
%load '\\sosiknas1\IFCB_data\IFCB014_PiscesNov2014\metadata\metadata_raw.mat' %staining
Lon=longitude;
Lat=latitude;


load '\\sosiknas1\IFCB_data\IFCB102_PiscesNov2014\metadata\IFCB102_PiscesNov2014_ifcb_locations.mat' %non-staining
%load '\\sosiknas1\IFCB_data\IFCB014_PiscesNov2014\metadata\IFCB014_PiscesNov2014_ifcb_locations.mat' %staining

clear name*
for i=1:length(pid)
temp1=char(pid{i});
temp2=temp1(49:72);
%name_all(i,:)=cellstr([temp2 '.mat']);
name_all(i,:)=cellstr([temp2]); %name of all files runs on cruise
end
clear temp*

load '\\sosiknas1\IFCB_products\IFCB102_PiscesNov2014\Manual_fromClass\summary\count_manual_25Jul2017.mat' %non-staining
%load '\\sosiknas1\IFCB_products\IFCB014_PiscesNov2014\Manual_fromClass\summary\count_manual_24Jul2017.mat' %staining

% for i=1:length(filelist)
% name(i,:)=cellstr(filelist(i).name);
% end

load '\\sosiknas1\IFCB_products\IFCB014_PiscesNov2014\Manual_fromClass\surface_ctd_list.mat' %don't comment out this

clear total_filelist
for i=1:length(filelist) %making a filelist list that is a vector of cells to compare to the surface_ctd_list
    temp=filelist(i).name;
    total_filelist(i,:)=cellstr(temp(1:24)); %name of all files in result file
end

[d,dd]=setdiff(total_filelist,surface_ctd_list); %finds files unique to only underway files

c=colormap(jet);
mycmap=c(1:5:64,:);
mycmap(1,:)=[0 0 0];

% choose what types of files to plot
[a,aa,aaa]=intersect(d,name_all); %for plotting only underway samples, this finds the names in common from underway samples and from the whole filelist of the cruise
%[a,aa,aaa]=intersect(total_filelist,name_all); %for plotting underway and ctd samples, this finds the names in common from the filelist from results and the whole filelist from the cruise
%[a,aa,aaa]=intersect(surface_ctd_list,name_all); %for plotting ctd samples, this finds the names in common from the ctd filelist and the whole filelist of the cruise

% 'aa' is the index for the result data, 'aaa' is the index for the whole cruise data

% choose which class to plot
ciliate_count=classcount(aa,86)+classcount(aa,120)+classcount(aa,121)...
    +classcount(aa,115)+classcount(aa,116)+classcount(aa,118)+classcount(aa,119); %Change the column number to choose which class to plot
%ciliate_count=classcount(aa,70); %Change the column number to choose which class to plot
%[matdate_bin, classcount_bin, ml_analyzed_bin] = make_hour_bins(matdate,ciliate_count, ml_analyzed);

%ciliate_perml=classcount_bin./ml_analyzed_bin;

ciliate_perml=ciliate_count./ml_analyzed(aa);

ciliate_lat=latitude(aaa);
ciliate_lon=longitude(aaa);

iz=find(ciliate_perml); %finds the nonzeros
noniz=find(ciliate_perml==0);
ciliate_lat_iz=ciliate_lat(iz);
ciliate_lon_iz=ciliate_lon(iz);

ciliate_lat_noniz=ciliate_lat(noniz);
ciliate_lon_noniz=ciliate_lon(noniz);

%cd /Users/markmiller/Documents/Code/m_map/

m_proj('UTM','long',[-78 -65],'lat',[35 44.27]);
figure(1);
%m_gshhs_h('save','gumby2');
m_usercoast('gumby2','patch',[.7 1 .7],'edgecolor','k');
m_tbase('contour',[-500 -100 000:2000:5000],'edgecolor','k');
%m_grid('box','fancy','tickdir','out','fontsize', 16, 'fontname','Times New Roman');
hold on
m_line(Lon, Lat,'color','b','linewi',1.5);

[X,Y] = m_ll2xy(ciliate_lon_noniz, ciliate_lat_noniz); %changes lat and lon to matlab numbers
hd = scatter(X,Y, 20, [0 0 0], 'filled');%plot IFCB positions, marker size, and abundance.
[X,Y] = m_ll2xy(ciliate_lon_iz, ciliate_lat_iz);
hd = scatter(X,Y, 50, ciliate_perml(iz), 'filled');
text(X,Y, datestr(matdate(iz)));

caxis([0 0.8]); %change this for scaling color bar 
h=colorbar;
set(get(h,'ylabel'),'string','Cell concentration (mL^{-1})','fontsize',20,'fontname','Times New Roman');
title('Ciliate mix','fontsize',18)
xlabel('Longitude')
ylabel('Latitude')
%print Alt_OKEX_map -dpdf

