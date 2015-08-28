
load '/Volumes/d_work/IFCB1/ifcb_data_mvco_jun06/Manual_fromClass/summary/count_manual_current.mat'

crypto_filelist={'IFCB1_2013_011_174553'
'IFCB1_2013_011_180852'
'IFCB1_2013_011_183214'
'IFCB5_2013_094_130629'
'IFCB5_2013_094_132943'
'IFCB5_2013_094_135255'
'IFCB5_2013_194_135924'
'IFCB5_2013_194_142018'
'IFCB5_2013_194_143924'
'IFCB5_2013_194_144330'
'IFCB1_2013_288_171044'
'IFCB1_2013_288_173355'
'IFCB1_2013_288_175708'};

[crypto_days,ia,ib]=intersect(filelist,crypto_filelist);

crypto_ifcb_count=classcount(ia,28);
crypto_ifcb_matdate=matdate(ia);
crypto_ifcb_ml=ml_analyzed_mat(ia,28);
crypto_ifcb_perml=crypto_ifcb_count./crypto_ifcb_ml;
%%
figure
plot(crypto_ifcb_matdate,crypto_ifcb_perml,'*');
datetick
