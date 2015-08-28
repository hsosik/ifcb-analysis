load '/Volumes/d_work/IFCB1/ifcb_data_mvco_jun06/Manual_fromClass/summary/count_biovol_manual_current_day.mat'

[ ind_ciliate, class_label ] = get_ciliate_ind( class2use, class2use );
ciliate_classcount=(classcount_bin(:,ind_ciliate)./ml_analyzed_mat_bin(:,ind_ciliate));

% MVCO_daylist=10/15/13 2456580.5
% 10/29/13 2456594.5
% 11/21/13 2456617.5
% 1/16/14 2456673.5
% 2/26/14 2456714.5
% 4/2/14 2456749.5
% 6/25/14 2456833.5
% 8/6/13 2456875.5
% 8/26/14 2456895.5
% 12/19/14 2457010.5
% 3/10/15 2457091.5
% 3/25/15 2457106.5
% 4/2/15 2457114.5
% 4/27/15 2457139.5
% 5/19/15 2457161.5

%%

MVCO_daylist=[2456580.5 2456594.5 2456617.5 2456673.5 2456714.5 2456749.5 2456833.5 2456875.5 2456895.5...
    2457010.5 2457091.5 2457106.5 2457114.5 2457139.5 2457161.5];


Manual_daylist_julian=juliandate(matdate_bin);

%%

[i, ii]=intersect(Manual_daylist_julian, MVCO_daylist);

ciliate_classcount_MVCO=sum(ciliate_classcount(ii,:),2);
ml_analyzed_MVCO=(ml_analyzed_mat_bin(ii,70));

ciliate_classcount_MVCO_perml=ciliate_classcount_MVCO./ml_analyzed_MVCO;