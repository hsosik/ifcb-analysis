

load '/Volumes/IFCB014_OkeanosExplorerAug2013/data/CTD/Manual_fromClass/summary/count_manual_07Oct2014.mat'
CTD_classcount_ciliate=sum(classcount(:,70:88),2);

CTD_ml_analyzed=ml_analyzed;
CTD_matdate=matdate;
CTD_runtype=runtype;
CTD_filelist=filelist;
CTD_classcount=classcount;

%%
load '/Volumes/IFCB014_OkeanosExplorerAug2013/data/continuous/Manual_fromClass/summary/count_manual_08May2014.mat'

runtype_alt_ind=strmatch('ALT', runtype);
runtype_normal_ind=strmatch('NORMAL',runtype);

normal_ciliate_classcount=classcount(runtype_normal_ind,72:89);
alt_ciliate_classcount=classcount(runtype_alt_ind,72:89);

ciliate_total_classcount_normal=sum(normal_ciliate_classcount,2);
ciliate_total_classcount_alt=sum(alt_ciliate_classcount,2);

ciliate_perml_normal=ciliate_total_classcount_normal./ml_analyzed(runtype_normal_ind);
ciliate_perml_alt=ciliate_total_classcount_alt./ml_analyzed(runtype_alt_ind);

normal_tintinnid_classcount=classcount(runtype_normal_ind,90);
alt_tintinnid_classcount=classcount(runtype_alt_ind,90);


tintinnid_perml_normal=normal_tintinnid_classcount./ml_analyzed(runtype_normal_ind);
tintinnid_perml_alt=alt_tintinnid_classcount./ml_analyzed(runtype_alt_ind);

figure
plot(matdate(runtype_normal_ind),ciliate_perml_normal,'k.-','linewidth',1,'markersize',18)
hold on
plot(matdate(runtype_alt_ind),ciliate_perml_alt,'r.-','linewidth',1)
%legend('Traditional IFCB','Staining IFCB-PE settings','Staining IFCB-FDA Settings')
legend('Staining IFCB-PE settings','Staining IFCB-FDA Settings')
plot(CTD_matdate,CTD_classcount_ciliate./CTD_ml_analyzed,'.b')
ylabel('Ciliates (mL^{-1})', 'fontsize', 24, 'fontname', 'arial');
datetick('x',6)
%legend('Ciliate Mix','tintinnid')
set(gca, 'fontsize', 24, 'fontname','arial','XTickLabel',{'08/25','08/27','08/29','08/31','09/02'},...
    'XTick',[735471 735473 735475 735477 735479])