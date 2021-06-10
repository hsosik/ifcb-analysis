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



ii = find(ml_analyzedTB<=5 & ml_analyzedTB>0);
count = classcountTB_above_optthresh(ii,:);
ml = ml_analyzedTB(ii);
floorhr = floor(mdateTB(ii)*24)/24;
unqhr = unique(floorhr);
numhrs = length(unqhr);
count_hr = NaN(numhrs,length(class2useTB));
ml_hr = NaN(numhrs,1);
mdate_hr = ml_hr;
for cc = 1:size(t,1)
    ind = find(floorhr == unqhr(cc));
    count_hr(cc,:) = sum(count(ind,:),1);
    ml_hr(cc) = sum(ml(ind));
    mdate_hr(cc) = nanmean(mdateTB(ii(ind)));
end

T = table;
T.datetime = datetime(mdate_hr, 'ConvertFrom', 'datenum');
T2 = array2table(count_hr./ml_hr, 'VariableNames', class2useTB);
concentration_by_class_time_series = [T T2];

%writetable(concentration_by_class_time_series, '\\sosiknas1\IFCB_products\MVCO\class\summary\concentration_by_class_time_series.csv')

%T2 = array2table(classcountTB_above_optthresh./ml_analyzedTB, 'VariableNames', class2useTB);
