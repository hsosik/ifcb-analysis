%environmental=load ('/Users/markmiller/Documents/code_svn/MVCO_environmental/Other_day.mat');
biological=load('/Volumes/d_work/IFCB1/ifcb_data_mvco_jun06/Manual_fromClass/summary/count_manual_current_day.mat');

environmental=load ('/Users/markmiller/Documents/code_svn/MVCO_environmental/Other_day.mat');

[common_dates,ia,ib]=intersect(biological.matdate_bin,environmental.mdate);

biological_counts_common=biological.classcount_bin(ia,:);
biological_ml_common=biological.ml_analyzed_mat_bin(ia,:);
biological_perml=biological_counts_common./biological_ml_common;

temp_common=environmental.Temp(ib);
saln_common=environmental.Saln(ib);
wspd_common=environmental.Wspd(ib);
wdir_common=environmental.Wdir(ib);
waveh_swell_common=environmental.waveh_swell(ib);
wavep_swell_common=environmental.wavep_swell(ib);
waveh_windwave_common=environmental.waveh_windwave(ib);
wavep_windwave_common=environmental.wavep_windwave(ib);
vE_common=environmental.vE(ib);
vN_common=environmental.vN(ib);
DailySolar_common=environmental.DailySolar(ib);

%%
load conc_summary_fcb.mat
synperml_timeseries=synperml(:,1);
mdate_timeseries=mdate(:,1);
picoeukperml_timeseries=picoeukperml(:,1);
euk2_10perml_timeseries=euk2_10perml(:,1);

 for i=2:13;
     synperml_timeseries=[synperml_timeseries; synperml(:,i)];
     mdate_timeseries=[mdate_timeseries; mdate(:,i)];
     picoeukperml_timeseries=[picoeukperml_timeseries; picoeukperml(:,i)];
     euk2_10perml_timeseries=[euk2_10perml_timeseries; euk2_10perml(:,i)];
 end
 

[common_dates_syn,ia,ib]=intersect(common_dates,mdate_timeseries);
 
syn_perml_common=synperml_timeseries(ib);
mdate_common=mdate_timeseries(ib);
picoeuk_common=picoeukperml_timeseries(ib);
euk2_10common=euk2_10perml_timeseries(ib);

