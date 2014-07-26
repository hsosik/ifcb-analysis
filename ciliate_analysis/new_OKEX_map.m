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


iii=find(isnan(match_ind_alt));

match_ind_alt(find(isnan(match_ind_alt))) = [];

tintinnid_alt=classcount(:,90);
tintinnid_perml_alt=classcount(:,90)./ml_analyzed;
tintinnid_lat_alt=Lat(match_ind_alt);
tintinnid_lon_alt=Lon(match_ind_alt);
ml_analyzed_alt=ml_analyzed;
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

iz=find(tintinnid_perml_alt); %finds the nonzeros
noniz=find(tintinnid_perml_alt==0);


tintinnid_lat_iz_alt=tintinnid_lat_alt(iz);
tintinnid_lon_iz_alt=tintinnid_lon_alt(iz);

norm_iz=find(tintinnid_perml_norm); %finds the nonzeros
norm_noniz=find(tintinnid_perml_norm==0);

tintinnid_lat_iz_norm=tintinnid_lat_norm(norm_iz);
tintinnid_lon_iz_norm=tintinnid_lon_norm(norm_iz);



%iz=index for IFCB14 tintinnid counts
%norm_iz= index for IFCB10 tintinnid counts

tintinnid_perml_iz_alt=tintinnid_perml_alt(iz);%highest is 13 lat is 42.3801, lon is 67.3890  %low is 4
tintinnid_iz_alt=tintinnid_alt(iz);
ml_analyzed_iz_alt=ml_analyzed_alt(iz);
tintinnid_perml_iz_norm=tintinnid_perml_norm(norm_iz); %corresponds with 11 , corresponds with 3
tintinnid_iz_norm=tintinnid_norm(norm_iz);
ml_analyzed_iz_norm=ml_analyzed(norm_iz);
%%

tintinnid_classcount_norm= tintinnid_iz_norm(11);
tintinnid_classcount_norm_perml=tintinnid_classcount_norm/ml_analyzed_iz_norm(11);
[tintinnid_ci_norm] = poisson_count_ci(tintinnid_classcount_norm, 0.95);
tintinnid_ci_ml_norm= tintinnid_ci_norm/ml_analyzed_iz_norm(11);

tintinnid_classcount_alt= tintinnid_iz_alt(13);
tintinnid_classcount_alt_perml=tintinnid_classcount_alt/ml_analyzed_iz_alt(13);
[tintinnid_ci_alt] = poisson_count_ci(tintinnid_classcount_alt, 0.95);
tintinnid_ci_ml_alt= tintinnid_ci_alt/ml_analyzed_iz_alt(13);


points=[tintinnid_classcount_norm_perml tintinnid_classcount_alt_perml];
%ci=[normal_ci_ml(2) alt_ci_ml(2)];

lower=[(tintinnid_classcount_norm_perml-tintinnid_ci_ml_norm(1)) tintinnid_classcount_alt_perml-tintinnid_ci_ml_alt(1)];
upper=[tintinnid_ci_ml_norm(2)-tintinnid_classcount_norm_perml tintinnid_ci_ml_alt(2)-tintinnid_classcount_alt_perml];

% lower=[normal_ci_ml(1) alt_ci_ml(1)];
% upper=[normal_ci_ml(2) alt_ci_ml(2)];

xaxis=[1 2];
figure;
bar1= bar(xaxis, [tintinnid_classcount_norm_perml tintinnid_classcount_alt_perml]);
set(gca,'xticklabel',{'Traditional IFCB','Staining IFCB'}, 'fontsize', 14, 'fontname', 'Times new roman');
ylabel('Tintinnid ( mL^{-1})', 'fontsize', 18, 'fontname', 'Times new roman');
hold on
%plot(xaxis, points, '.b');
%errorbar(xaxis, points, lower, upper, 'r', 'Marker', 'none', 'LineStyle', 'none', 'Linewidth', 4);
axis square

%%

tintinnid_classcount_norm= tintinnid_iz_norm(4);
tintinnid_classcount_norm_perml=tintinnid_classcount_norm/ml_analyzed_iz_norm(4);
[tintinnid_ci_norm] = poisson_count_ci(tintinnid_classcount_norm, 0.95);
tintinnid_ci_ml_norm= tintinnid_ci_norm/ml_analyzed_iz_norm(4);

tintinnid_classcount_alt= tintinnid_iz_alt(4);
tintinnid_classcount_alt_perml=tintinnid_classcount_alt/ml_analyzed_iz_alt(4);
[tintinnid_ci_alt] = poisson_count_ci(tintinnid_classcount_alt, 0.95);
tintinnid_ci_ml_alt= tintinnid_ci_alt/ml_analyzed_iz_alt(4);

points=[tintinnid_classcount_norm_perml tintinnid_classcount_alt_perml];
%ci=[normal_ci_ml(2) alt_ci_ml(2)];

lower=[(tintinnid_classcount_norm_perml-tintinnid_ci_ml_norm(1)) tintinnid_classcount_alt_perml-tintinnid_ci_ml_alt(1)];
upper=[tintinnid_ci_ml_norm(2)-tintinnid_classcount_norm_perml tintinnid_ci_ml_alt(2)-tintinnid_classcount_alt_perml];

% lower=[normal_ci_ml(1) alt_ci_ml(1)];
% upper=[normal_ci_ml(2) alt_ci_ml(2)];

xaxis=[1 2];
figure;
bar1= bar(xaxis, [tintinnid_classcount_norm_perml tintinnid_classcount_alt_perml]);
set(gca,'xticklabel',{'Traditional IFCB','Staining IFCB'}, 'fontsize', 14, 'fontname', 'Times new roman');
ylabel('Tintinnid ( mL^{-1})', 'fontsize', 18, 'fontname', 'Times new roman');
hold on
%plot(xaxis, points, '.b');
%errorbar(xaxis, points, lower, upper, 'r', 'Marker', 'none', 'LineStyle', 'none', 'Linewidth', 4);
axis square
