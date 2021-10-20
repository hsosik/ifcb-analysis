p = '\\sosiknas1\IFCB_products\MVCO\summary\';

flist = dir([p 'summary_biovol_allHDF_min20_????.mat']);

classcount = [];
classcount_above_adhocthresh = [];
classbiovol = [];
classbiovol_above_adhocthresh = [];
ml_analyzed = [];
mdate = [];
filelist = [];

for ii = 1:length(flist)
    temp = load([p flist(ii).name]);
    classcount = [ classcount; temp.classcount];
    %classcount_above_adhocthresh = [ classcount_above_adhocthresh; temp.classcount_above_adhocthresh];
    classbiovol = [classbiovol; temp.classbiovol];
    %classbiovol_above_adhocthresh = [classbiovol_above_adhocthresh; temp.classbiovolclassbiovol_above_adhocthresh];
    ml_analyzed = [ ml_analyzed; temp.meta_data.ml_analyzed];
    mdate = [ mdate; temp.mdate];
    filelist = [ filelist; temp.filelist];
    class2use = temp.class2use;
    clear temp 
end

ii = find(ml_analyzed<=5 & ml_analyzed>0);
count = classcount(ii,:);
biovol = classbiovol(ii,:);
ml = ml_analyzed(ii);
filelist = filelist(ii);
floorhr = floor(mdate(ii)*24)/24;

if 1 % case for full res counts
    T = table;
    T.datetime = datetime(mdate(ii), 'ConvertFrom', 'datenum');
    T.milliliters_analyzed = ml;
    T.filelist = filelist;
    T2 = array2table(count, 'VariableNames', class2use);
    count_by_class_time_series_full = [T T2];

    writetable(count_by_class_time_series_full, '\\sosiknas1\IFCB_products\MVCO\class\summary\count_by_class_time_seriesCNN_full.csv')
end

unqhr = unique(floorhr);
numhrs = length(unqhr);
count_hr = NaN(numhrs,length(class2use));
biovol_hr = count_hr; 
ml_hr = NaN(numhrs,1);
mdate_hr = ml_hr;
for cc = 1:size(unqhr,1)
    ind = find(floorhr == unqhr(cc));
    count_hr(cc,:) = sum(count(ind,:),1);
    biovol_hr(cc,:) = sum(biovol(ind,:),1);
    ml_hr(cc) = sum(ml(ind));
    mdate_hr(cc) = nanmean(mdate(ii(ind)));
end

T = table;
T.datetime = datetime(mdate_hr, 'ConvertFrom', 'datenum');
T2 = array2table(count_hr./ml_hr, 'VariableNames', class2use);
concentration_by_class_time_series_hr = [T T2];

writetable(concentration_by_class_time_series_hr, '\\sosiknas1\IFCB_products\MVCO\class\summary\concentration_by_class_time_seriesCNN_hourly.csv')

T = table;
T.datetime = datetime(mdate_hr, 'ConvertFrom', 'datenum');
T2 = array2table(biovol_hr./ml_hr, 'VariableNames', class2use);
biovol_concentration_by_class_time_series_hr = [T T2];

writetable(biovol_concentration_by_class_time_series_hr, '\\sosiknas1\IFCB_products\MVCO\class\summary\biovol_concentration_by_class_time_seriesCNN_hourly.csv')
%%
if 1 %case for counts
    T = table;
    T.datetime = datetime(mdate_hr, 'ConvertFrom', 'datenum');
    T.milliliters_analyzed = ml_hr;
    T2 = array2table(count_hr, 'VariableNames', class2use);
    count_by_class_time_series_hr = [T T2];

    writetable(count_by_class_time_series_hr, '\\sosiknas1\IFCB_products\MVCO\class\summary\count_by_class_time_seriesCNN_hourly.csv')
end
%%


floordy = floor(mdate(ii));
unqdy = unique(floordy);
numdy = length(unqdy);
count_dy = NaN(numdy,length(class2use));
biovol_dy = count_dy;
ml_dy = NaN(numdy,1);
mdate_dy = ml_dy;
for cc = 1:size(unqdy,1)
    ind = find(floordy == unqdy(cc));
    count_dy(cc,:) = sum(count(ind,:),1);
    biovol_dy(cc,:) = sum(biovol(ind,:),1);
    ml_dy(cc) = sum(ml(ind));
    mdate_dy(cc) = nanmean(mdate(ii(ind)));
end

T = table;
T.datetime = datetime(mdate_dy, 'ConvertFrom', 'datenum');
T2 = array2table(count_dy./ml_dy, 'VariableNames', class2use);
concentration_by_class_time_series_dy = [T T2];

writetable(concentration_by_class_time_series_dy, '\\sosiknas1\IFCB_products\MVCO\class\summary\concentration_by_class_time_series_CNN_daily.csv')


T = table;
T.datetime = datetime(mdate_dy, 'ConvertFrom', 'datenum');
T2 = array2table(biovol_dy./ml_dy, 'VariableNames', class2use);
biovol_concentration_by_class_time_series_dy = [T T2];

writetable(biovol_concentration_by_class_time_series_dy, '\\sosiknas1\IFCB_products\MVCO\class\summary\biovol_concentration_by_class_time_series_CNN_daily.csv')


%writetable(concentration_by_class_time_series, '\\sosiknas1\IFCB_products\MVCO\class\summary\concentration_by_class_time_series.csv')

%T2 = array2table(classcountTB_above_optthresh./ml_analyzedTB, 'VariableNames', class2useTB);

return
T = readtable('\\sosiknas1\IFCB_products\MVCO\class\summary\concentration_by_class_time_series_CNN_daily.csv');

group_table = readtable('\\sosiknas1\training_sets\IFCB\config\IFCB_classlist_type.csv');
group_table.CNN_classlist(strmatch('Pseudo-nitzschia', group_table.CNN_classlist)) = {'Pseudo_nitzschia'};
[~,ia,ib] = intersect(group_table.CNN_classlist, class2use);
diatom_ind = ib(find(group_table.Diatom(ia)));


