
load '/Volumes/IFCB014_OkeanosExplorerAug2013/data/Manual_fromClass/Alt/summary/count_manual_low_green27Jan2014.mat'

load '/Volumes/IFCB010_OkeanosExplorerAug2013/data/Manual_fromClass/summary/count_manual_19Jan2014.mat'

min_diff= 1/24;
match_ind=NaN(size(matdate_lowgreen));


for ii=1:length(matdate_lowgreen);
    [min_ii, i2]=min(abs(matdate_lowgreen(ii)-matdate));
 
    if min_ii <= min_diff
        match_ind(ii)=i2;
        %i2=match_ind(ii);
    end
end;


iii=find(isnan(match_ind));

match_ind(find(isnan(match_ind))) = [];


[matdate_lowgreen(iii)-matdate(match_ind(iii))]*24 %as a check, should appear as less than 1
[matdate_lowgreen-matdate(match_ind)]*24 

ciliate_classcount=classcount(:, 72:92);
total_ciliate_classcount=mean(ciliate_classcount,2);

low_green_ciliate_classcount=classcount_lowgreen(:, 72:92);
total_low_green_ciliate_classcount=mean(low_green_ciliate_classcount,2);



nind = find(~isnan(match_ind)); %finds when there are no NaNs

figure
plot(matdate_lowgreen(nind), classcount_lowgreen(nind,72)./ml_analyzed_lowgreen(nind), '.-')
hold on
plot(matdate(match_ind(nind)), classcount(match_ind(nind),72)./ml_analyzed(match_ind(nind)), 'r.-')
legend('low green', 'IFCB 10')

figure
plot(classcount_lowgreen(nind,72)./ml_analyzed_lowgreen(nind), classcount(match_ind(nind),72)./ml_analyzed(match_ind(nind)), '.')


[low_green_mdate_mat, low_green_mat, yearlist, yd ] = timeseries2ydmat(matdate_lowgreen(nind), classcount_lowgreen(nind,72)./ml_analyzed_lowgreen(nind));
[mdate_mat, y_mat, yearlist, yd ] = timeseries2ydmat(matdate(match_ind(nind)), classcount(match_ind(nind),72)./ml_analyzed(match_ind(nind)));

%y_mat 236:240

figure
plot(yd(236:240), low_green_mat(236:240), '.-')
hold on
plot(yd(236:240), y_mat(236:240), 'r.-')
legend('low green', 'IFCB 10')

figure
plot(low_green_mat(236:240), y_mat(236:240), '.');


% nind = find(isnan(match_ind)); %finds when there are NaNs
% match_ind(nind) = [];
% c2 = classcount(match_ind,72)./ml_analyzed(match_ind);
% c1 = classcount_lowgreen(:,72)./ml_analyzed_lowgreen;
% c1(nind) = [];

% count1=total_low_green_ciliate_classcount(1:31)./ml_analyzed(1:31);
% count2=total_low_green_ciliate_classcount(36:46)./ml_analyzed(36:46);
% low_green_count_total= [count1; count2];
% low_green_count_total_day=total_low_green_ciliate_classcount(2:17)./ml_analyzed(2:17);
% 
% count_total=ciliate_classcount(match_ind)./ml_analyzed(match_ind);
% count_total_day=ciliate_classcount(match_ind(2:17))./ml_analyzed(match_ind(2:17));
% 
% figure
% plot(mean(count_total_day),mean(low_green_count_total_day), '*');