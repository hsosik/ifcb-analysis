classcountTB = [];
classcountTB_above_adhocthresh = [];
classcountTB_above_optthresh = [];
ml_analyzedTB = [];
mdateTB = [];
filelistTB = [];

for yr = 2006:2018
    temp = load(['\\sosiknas1\IFCB_products\MVCO\class\summary\' 'summary_allTB' num2str(yr)]);
    %temp = load(['C:\work\IFCB\class\summary\' 'summary_allTB' num2str(yr)]);
    classcountTB = [ classcountTB; temp.classcountTB];
    classcountTB_above_adhocthresh = [ classcountTB_above_adhocthresh; temp.classcountTB_above_adhocthresh];
    classcountTB_above_optthresh = [ classcountTB_above_optthresh; temp.classcountTB_above_optthresh];
    ml_analyzedTB = [ ml_analyzedTB; temp.ml_analyzedTB];
    mdateTB = [ mdateTB; temp.mdateTB];
    filelistTB = [ filelistTB; temp.filelistTB];
    class2useTB = temp.class2useTB;
    clear temp
end


%% Compute and save full resolution concentrations, include ml_analyzed in the output

ii = find(ml_analyzedTB<=5 & ml_analyzedTB>0);
count = classcountTB_above_optthresh(ii,:);
ml = ml_analyzedTB(ii);
mdate = mdateTB(ii);
filelist = filelistTB(ii);

T = table;
T.datetime = datetime(mdate, 'ConvertFrom', 'datenum');
T.matdate = mdate;
T.ml_analyzed = ml;
T.pid = filelist;
T2 = array2table(count./ml, 'VariableNames', class2useTB);
concentration_by_class_time_series_full = [T T2];

writetable(concentration_by_class_time_series_full, '\\sosiknas1\IFCB_products\MVCO\class\summary\concentration_by_class_time_series_full.csv')

%% Compute and save hourly concentrations
floorhr = floor(mdateTB(ii)*24)/24;
unqhr = unique(floorhr);
numhrs = length(unqhr);
count_hr = NaN(numhrs,length(class2useTB));
ml_hr = NaN(numhrs,1);
mdate_hr = ml_hr;
for cc = 1:size(unqhr,1)
    ind = find(floorhr == unqhr(cc));
    count_hr(cc,:) = sum(count(ind,:),1);
    ml_hr(cc) = sum(ml(ind));
    mdate_hr(cc) = nanmean(mdateTB(ii(ind)));
end

T = table;
T.datetime = datetime(mdate_hr, 'ConvertFrom', 'datenum');
T.matdate = mdate_hr;
T2 = array2table(count_hr./ml_hr, 'VariableNames', class2useTB);
concentration_by_class_time_series_hr = [T T2];

writetable(concentration_by_class_time_series_hr, '\\sosiknas1\IFCB_products\MVCO\class\summary\concentration_by_class_time_series_hr.csv')


%% Compute and save daily concentrations
floordy = floor(mdateTB(ii));
unqdy = unique(floordy);
numdy = length(unqdy);
count_dy = NaN(numdy,length(class2useTB));
ml_dy = NaN(numdy,1);
mdate_dy = ml_dy;
for cc = 1:size(unqdy,1)
    ind = find(floordy == unqdy(cc));
    count_dy(cc,:) = sum(count(ind,:),1);
    ml_dy(cc) = sum(ml(ind));
    mdate_dy(cc) = nanmean(mdateTB(ii(ind)));
end

T = table;
T.datetime = datetime(mdate_dy, 'ConvertFrom', 'datenum');
T.matdate = mdate_dy;
T2 = array2table(count_dy./ml_dy, 'VariableNames', class2useTB);
concentration_by_class_time_series_dy = [T T2];

writetable(concentration_by_class_time_series_dy, '\\sosiknas1\IFCB_products\MVCO\class\summary\concentration_by_class_time_series_dy.csv')

%writetable(concentration_by_class_time_series, '\\sosiknas1\IFCB_products\MVCO\class\summary\concentration_by_class_time_series.csv')

%T2 = array2table(classcountTB_above_optthresh./ml_analyzedTB, 'VariableNames', class2useTB);
