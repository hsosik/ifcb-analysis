%I made a change

resultpath = '\\queenrose\IFCB014_OkeanosExplorerAug2013\data\Manual_fromClass\Alt\';
filelist = dir([resultpath 'D*.mat']);
basepath = '\\queenrose\IFCB014_OkeanosExplorerAug2013\data\';
load([resultpath filelist(1).name]) %read first file to get classes


figure
for filecount = 4,
    filename = filelist(filecount).name;
    disp(filename)
    hdrname = [basepath regexprep(filename, 'mat', 'hdr')]; 
    adcname = [basepath regexprep(filename, 'mat', 'adc')];
    load([resultpath filename])
    adcdata = load(adcname);
    loglog(adcdata(:,4),adcdata(:,5),'.');
 
    hold on
    
end

2:16 %IFCB14 Alt
9:73 %IFCB10

load '\\queenrose\IFCB010_OkeanosExplorerAug2013\data\Manual_fromClass\summary\count_manual_19Jan2014.mat'
ciliate_classcount=classcount(:,72:92);
ciliate_sum=sum(ciliate_classcount,2);
ciliate_bin=sum(ciliate_sum(9:73));
ml_analyzed_bin=sum(ml_analyzed(9:73));
ciliate_bin_perml=ciliate_bin/ml_analyzed_bin;
%0.4480 ciliate/ml
std=nanstd((ciliate_sum(9:73))/(sum(ml_analyzed(9:73))));

load '\\queenrose\IFCB014_OkeanosExplorerAug2013\data\Manual_fromClass\Alt\summary\count_manual_05Feb2014.mat'
ciliate_classcount=classcount(:,72:92);
ciliate_sum=sum(ciliate_classcount,2);
ciliate_bin=sum(ciliate_sum(2:16));
ml_analyzed_bin=sum(ml_analyzed(2:16));
ciliate_bin_perml=ciliate_bin/ml_analyzed_bin;
%1.7702 ciliate/ml

load '\\queenrose\IFCB014_OkeanosExplorerAug2013\data\Manual_fromClass\Alt\summary\count_manual_low_green05Feb2014.mat'
ciliate_classcount=classcount_lowgreen(:,72:92);
ciliate_sum=sum(ciliate_classcount,2);
ciliate_bin=sum(ciliate_sum(2:16));
ml_analyzed_bin=sum(ml_analyzed_lowgreen(2:16));
ciliate_bin_perml=ciliate_bin/ml_analyzed_bin;
%0.3848


load '\\queenrose\IFCB014_OkeanosExplorerAug2013\data\Manual_fromClass\Alt\summary\count_manual_high_green05Feb2014.mat'
ciliate_classcount=classcount_lowgreen(:,72:92);
ciliate_sum=sum(ciliate_classcount,2);
ciliate_bin=sum(ciliate_sum(2:16));
ml_analyzed_bin=sum(ml_analyzed_lowgreen(2:16));
ciliate_bin_perml=ciliate_bin/ml_analyzed_bin;
%1.3854

load '\\queenrose\IFCB014_OkeanosExplorerAug2013\data\Manual_fromClass\Alt\summary\count_manual_lowlow_green05Feb2014.mat'
ciliate_classcount=classcount_lowgreen(:,72:92);
ciliate_sum=sum(ciliate_classcount,2);
ciliate_bin=sum(ciliate_sum(2:16));
ml_analyzed_bin=sum(ml_analyzed_lowgreen(2:16));
ciliate_bin_perml=ciliate_bin/ml_analyzed_bin;
%0.5195


load '\\queenrose\IFCB014_OkeanosExplorerAug2013\data\Manual_fromClass\Alt\summary\count_manual_highhigh_green05Feb2014.mat'
ciliate_classcount=classcount_lowgreen(:,72:92);
ciliate_sum=nansum(ciliate_classcount,2);
ciliate_bin=sum(ciliate_sum(2:16));
ml_analyzed_bin=sum(ml_analyzed_lowgreen(2:16));
ciliate_bin_perml=ciliate_bin/ml_analyzed_bin;
%1.2507

load '\\queenrose\IFCB014_OkeanosExplorerAug2013\data\Manual_fromClass\Alt\summary\count_manual_lowlow2_green05Feb2014.mat'
ciliate_classcount=classcount_lowgreen(:,72:92);
ciliate_sum=sum(ciliate_classcount,2);
ciliate_bin=sum(ciliate_sum(2:16));
ml_analyzed_bin=sum(ml_analyzed_lowgreen(2:16));
ciliate_bin_perml=ciliate_bin/ml_analyzed_bin;
%0.5195


load '\\queenrose\IFCB014_OkeanosExplorerAug2013\data\Manual_fromClass\Alt\summary\count_manual_highhigh2_green05Feb2014.mat'
ciliate_classcount=classcount_lowgreen(:,72:92);
ciliate_sum=nansum(ciliate_classcount,2);
ciliate_bin=sum(ciliate_sum(2:16));
ml_analyzed_bin=sum(ml_analyzed_lowgreen(2:16));
ciliate_bin_perml=ciliate_bin/ml_analyzed_bin;
%1.2507





load '\\queenrose\IFCB014_OkeanosExplorerAug2013\data\Manual_fromClass\Alt\summary\count_manual_lowlow_green05Feb2014.mat'
figure %example
ciliate_classcount=classcount_lowgreen(:,72:92);
ciliate_sum=sum(ciliate_classcount,2);
plot(matdate_lowgreen, ciliate_sum./ml_analyzed_lowgreen, 'r.-')
datetick('x')
%ylabel([class2use{classnum} ' (mL^{-1})'])
hold on

load '/Volumes/IFCB010_OkeanosExplorerAug2013/data/Manual_fromClass/summary/count_manual_19Jan2014.mat'

ciliate_classcount=classcount(:,72:92);
ciliate_sum=sum(ciliate_classcount,2);
plot(matdate, ciliate_sum./ml_analyzed, 'b.-')
legend('IFCB14 low green','IFCB10  ');

figure
bar(0.448, 'r');
hold on 

red = [0.448 0.3848]';
green = [0 1.3854]';

red = [0.448 0.5195]';
green = [0 1.2507]';

xaxis=[1 2];
% Create a stacked bar chart using the bar function
figure;
bar1= bar(xaxis, [red green], 0.5, 'stack');
hold on
errorbar(xaxis,[red green],0.0062,0.0062)
set(bar1(1),'FaceColor',[0.847058832645416 0.160784319043159 0],...
    'EdgeColor',[0.847058832645416 0.160784319043159 0]);
set(bar1(2),'FaceColor',[0.400000005960464 1 0.400000005960464],...
    'EdgeColor',[0 1 0]);

ylabel('Abundance (cell mL^{-1})', 'fontsize', 12, 'fontname', 'arial');
set(gca,'xticklabel',{'IFCB 10','IFCB 14'}, 'fontsize', 12, 'fontname', 'arial');

