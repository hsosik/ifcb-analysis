
load '/Users/markmiller/Documents/IFCB14_Pisces/data/Manual_fromClass/summary/count_manual_02Dec2014.mat'

runtype_alt_ind=strmatch('ALT', runtype);
runtype_normal_ind=strmatch('NORMAL',runtype);

normal_ciliate_classcount=classcount(runtype_normal_ind,70:88);
alt_ciliate_classcount=classcount(runtype_alt_ind,70:88);

ciliate_total_classcount_normal=sum(normal_ciliate_classcount,2);
ciliate_total_classcount_alt=sum(alt_ciliate_classcount,2);

ciliate_perml_normal=ciliate_total_classcount_normal./ml_analyzed(runtype_normal_ind);
ciliate_perml_alt=ciliate_total_classcount_alt./ml_analyzed(runtype_alt_ind);

normal_tintinnid_classcount=classcount(runtype_normal_ind,86);
alt_tintinnid_classcount=classcount(runtype_alt_ind,86);

tintinnid_perml_normal=normal_tintinnid_classcount./ml_analyzed(runtype_normal_ind);
tintinnid_perml_alt=alt_tintinnid_classcount./ml_analyzed(runtype_alt_ind);


plot(matdate(runtype_normal_ind),ciliate_perml_normal,'k.-','linewidth',1,'markersize',18)
hold on
plot(matdate(runtype_alt_ind),ciliate_perml_alt,'r.-','linewidth',1)
legend('Staining IFCB-PE settings','Staining IFCB-FDA Settings')
%legend('Staining IFCB-FDA Settings')
ylabel('Ciliates (mL^{-1})', 'fontsize', 18, 'fontname', 'arial');
datetick('x',6)
set(gca, 'fontsize', 18, 'fontname','arial')

%%
figure
plot(matdate(runtype_normal_ind),tintinnid_perml_normal,'k.-','linewidth',1,'markersize',18)
hold on
plot(matdate(runtype_alt_ind),tintinnid_perml_alt,'r.-','linewidth',1)
legend('Staining IFCB-PE settings','Staining IFCB-FDA Settings')
%legend('Staining IFCB-FDA Settings')
ylabel('Ciliates (mL^{-1})', 'fontsize', 18, 'fontname', 'arial');
datetick('x',6)
set(gca, 'fontsize', 18, 'fontname','arial')
