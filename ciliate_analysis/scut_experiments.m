
load '/Users/markmiller/Documents/Experiments/Scut_experiments/manual_fromclass/summary/count_manual_01Apr2014.mat'

ciliate_classcount=classcount(:,72);
ciliate_classcount_perml=ciliate_classcount./ml_analyzed;

xaxis=[1 2 3 4 5 6 7];

figure
bar(xaxis, ciliate_classcount_perml)
set(gca,'xticklabel',{'Scut','FSW','FSW','FSW','Scut-stained', 'Scut', 'Scut' }, 'fontsize', 12, 'fontname', 'arial');
ylabel('Ciliates (mL^{-1})', 'fontsize', 12, 'fontname', 'arial');

ciliate_percent=[ciliate_classcount_perml(1)/ciliate_classcount_perml(1) ciliate_classcount_perml(2)/ciliate_classcount_perml(1)  ciliate_classcount_perml(3)/ciliate_classcount_perml(1)  ciliate_classcount_perml(4)/ciliate_classcount_perml(1)]*100;

figure
bar([1 2 3 4], ciliate_percent)
set(gca,'xticklabel',{'Scut','FSW','FSW','FSW'}, 'fontsize', 12, 'fontname', 'arial');
ylabel('Percent', 'fontsize', 12, 'fontname', 'arial');

load '/Users/markmiller/Documents/Experiments/Scut_experiments/manual_fromclass/D20140401T174549_IFCB014.mat'
adcdata=load ('/Users/markmiller/Documents/Experiments/Scut_experiments/D20140401T174549_IFCB014.adc');
%4 is pmtB, 5 is pmtC, 3 is pmtA

ciliate_roi_ind=find(classlist(:,4)== 1);
ciliate_green=adcdata(ciliate_roi_ind,4);
ciliate_green_mean_unstained=mean(ciliate_green);

figure
hist(ciliate_green,binrange);
title('Scut unstained -first- Green Fl')

load '/Users/markmiller/Documents/Experiments/Scut_experiments/manual_fromclass/D20140401T191650_IFCB014.mat'
adcdata=load ('/Users/markmiller/Documents/Experiments/Scut_experiments/D20140401T191650_IFCB014.adc');

ciliate_roi_ind=find(classlist(:,4)== 1);
ciliate_green_stained=adcdata(ciliate_roi_ind,4);
ciliate_green_mean_stained=mean(ciliate_green_stained);

binrange=0:0.001:.1;

figure
hist(ciliate_green_stained,binrange);
title('Scut Stained- Green Fl')


figure
bar([1 2], [ciliate_green_mean_unstained ciliate_green_mean_stained]);
set(gca,'xticklabel',{'unstained','stained'}, 'fontsize', 12, 'fontname', 'arial');
title('Mean Green Fl')

load '/Users/markmiller/Documents/Experiments/Scut_experiments/manual_fromclass/D20140401T194318_IFCB014.mat'
adcdata=load ('/Users/markmiller/Documents/Experiments/Scut_experiments/D20140401T194318_IFCB014.adc');

ciliate_roi_ind=find(classlist(:,4)== 1);
ciliate_green_unstained_2=adcdata(ciliate_roi_ind,4);
ciliate_green_mean_unstained_2=mean(ciliate_green_unstained_2);

figure
hist(ciliate_green_unstained_2, binrange);
title('Scut unstained- after stain')


load '/Users/markmiller/Documents/Experiments/Scut_experiments/manual_fromclass/D20140401T200424_IFCB014.mat'
adcdata=load ('/Users/markmiller/Documents/Experiments/Scut_experiments/D20140401T200424_IFCB014.adc');

ciliate_roi_ind=find(classlist(:,4)== 1);
ciliate_green_unstained_3=adcdata(ciliate_roi_ind,4);
ciliate_green_mean_unstained_3=mean(ciliate_green_unstained_3);

figure
bar([1 2 3 4], [ciliate_green_mean_unstained ciliate_green_mean_stained ciliate_green_mean_unstained_2 ciliate_green_mean_unstained_3]);
set(gca,'xticklabel',{'unstained','stained', 'unstained', 'unstained'}, 'fontsize', 12, 'fontname', 'arial');
title('Mean Green Fl')




