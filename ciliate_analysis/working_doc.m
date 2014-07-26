%I made a change

my_filelist_temp= {'D20130828T001640_IFCB010';
'D20130828T003719_IFCB010';
'D20130828T005757_IFCB010'};


export_png_from_ROIlist( 'C:\Users\Emily Fay\Documents\Ciliate_Code\IFCB_14\OKEX\D20130828T003219_IFCB014.roi', [325 100 702] )
export_png_from_ROIlist( 'C:\Users\Emily Fay\Documents\Ciliate_Code\IFCB_14\OKEX\D20130828T014733_IFCB014.mat', [1781 504 210] )
export_png_from_ROIlist( 'C:\Users\Emily Fay\Documents\Ciliate_Code\IFCB_14\OKEX\D20130828T030243_IFCB014.roi', [728 6] )
export_png_from_ROIlist( 'C:\Users\Emily Fay\Documents\Ciliate_Code\IFCB_14\OKEX\IFCB10\D20130828T001640_IFCB010.roi', [1596 173 79] )
export_png_from_ROIlist( 'C:\Users\Emily Fay\Documents\Ciliate_Code\IFCB_14\OKEX\IFCB10\D20130828T003719_IFCB010.roi', [125 1450] )
export_png_from_ROIlist( 'C:\Users\Emily Fay\Documents\Ciliate_Code\IFCB_14\OKEX\IFCB10\D20130828T005757_IFCB010.roi', [292] )

Alt files:
'D20130828T003219_IFCB014.mat' 325 100 702
'D20130828T014733_IFCB014.mat' 1781 504 210
'D20130828T030243_IFCB014.mat' 728 6 

IFCB10 Files:
'D20130828T001640_IFCB010.mat' 1596 173 79
'D20130828T003719_IFCB010.mat' 125 1450
'D20130828T005757_IFCB010.mat' 292


load 'C:\Users\Emily Fay\Documents\Ciliate_Code\IFCB_14\Scut_testing\Normal\results\summary\count_manual_29Jan2014.mat'
figure %example
classnum = 72; %90 for tintinnid
plot(matdate, classcount(:,classnum)./ml_analyzed, '.-')
datetick('x')
ylabel([class2use{classnum} ' (mL^{-1})'])
hold on

load 'C:\Users\Emily Fay\Documents\Ciliate_Code\IFCB_14\Scut_testing\Alt\results\summary\count_manual_29Jan2014.mat'
classnum = 72; %90 for tintinnid
plot(matdate, classcount(:,classnum)./ml_analyzed, 'r.-')
datetick('x')
legend('Normal','Alt');

%%

load '/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/Dinos_stained_unstained/2-1-14/Alt/summary/count_manual_05Feb2014.mat'
gyro_alt_classcount=classcount(16:end, 36);
gyro_alt_classcount_ml= (sum(gyro_alt_classcount))/(sum(ml_analyzed(16:end)));
[alt_ci] = poisson_count_ci(sum(gyro_alt_classcount), 0.95);
alt_ci_ml= alt_ci/(sum(ml_analyzed(16:end)));


load '/Users/markmiller/Documents/Experiments/IFCB_14/Dock_Experiments/Dinos_stained_unstained/2-1-14/Normal/summary/count_manual_05Feb2014.mat'
gyro_normal_classcount=classcount(16:end, 36);
gyro_normal_classcount_ml= (sum(gyro_normal_classcount))/(sum(ml_analyzed(16:end)));
[normal_ci] = poisson_count_ci(sum(gyro_normal_classcount), 0.95);
normal_ci_ml= normal_ci/(sum(ml_analyzed(16:end)));


points=[0.0308 0.5019];
ci=[normal_ci_ml(2) alt_ci_ml(2)];

lower=[(gyro_normal_classcount_ml-normal_ci_ml(1)) gyro_alt_classcount_ml-alt_ci_ml(1)];
upper=[normal_ci_ml(2)-gyro_normal_classcount_ml alt_ci_ml(2)-gyro_alt_classcount_ml];

% lower=[normal_ci_ml(1) alt_ci_ml(1)];
% upper=[normal_ci_ml(2) alt_ci_ml(2)];

xaxis=[1 2];
figure;
bar1= bar(xaxis, [gyro_normal_classcount_ml gyro_alt_classcount_ml]);
set(gca,'xticklabel',{'unstained','stained'}, 'fontsize', 24, 'fontname', 'arial');
ylabel('\it{Gyrodinium} \rm sp ( mL^{-1})', 'fontsize', 24, 'fontname', 'arial');
hold on
plot(xaxis, points, '.b');
errorbar(xaxis, points, lower, upper, 'r', 'Marker', 'none', 'LineStyle', 'none', 'Linewidth', 4);
axis square
%%














load 'C:\Users\Emily Fay\Documents\Ciliate_Code\IFCB_14\Van\results\alt\summary\count_manual_05Feb2014.mat'
figure %example
classnum = 36; %90 for tintinnid %32 for dino30
plot(matdate(16:end), classcount(16:end,classnum)./ml_analyzed(16:end), '.-', 'LineWidth',2)
datetick('x')
set(gca,'xgrid','on', 'FontSize',12);
ylabel('Gyrodinium sp (cell mL^{-1})', 'fontsize', 12, 'fontname', 'arial');
hold on

load 'C:\Users\Emily Fay\Documents\Ciliate_Code\IFCB_14\Van\results\normal\summary\count_manual_05Feb2014.mat'
classnum = 36; %90 for tintinnid
plot(matdate(16:end), classcount(16:end,classnum)./ml_analyzed(16:end), 'r.-', 'LineWidth',2)
datetick('x')

legend('stained','unstained');

load '\\queenrose\IFCB010_OkeanosExplorerAug2013\data\Manual_fromClass\summary\count_manual_19Jan2014.mat'
ciliate_classcount=classcount(:,72:92);
ciliate_sum=sum(ciliate_classcount,2);
figure 
plot(matdate, ciliate_sum./ml_analyzed, '.-', 'LineWidth',2)
datetick('x')
set(gca,'xgrid','on', 'FontSize',12);
ylabel('Ciliate Mix (cell mL^{-1})', 'fontsize', 12);
hold on

load '\\queenrose\IFCB014_OkeanosExplorerAug2013\data\Manual_fromClass\Alt\summary\count_manual_05Feb2014.mat'
ciliate_classcount=classcount(:,72:92);
ciliate_sum=sum(ciliate_classcount,2);
plot(matdate, ciliate_sum./ml_analyzed, 'r.-', 'LineWidth',2)

legend('IFCB10','IFCB14 stained');

export_png_from_ROIlist('C:\Users\Emily Fay\Documents\Ciliate_Code\IFCB_14\Van\D20140201T045850_IFCB014.roi', [152])
export_png_from_ROIlist('C:\Users\Emily Fay\Documents\Ciliate_Code\IFCB_14\Van\D20140201T052229_IFCB014.roi', [580 720 632 697 936])
export_png_from_ROIlist('C:\Users\Emily Fay\Documents\Ciliate_Code\IFCB_14\Van\D20140201T061221_IFCB014.roi', [50 427 1279] )
export_png_from_ROIlist('C:\Users\Emily Fay\Documents\Ciliate_Code\IFCB_14\Van\D20140201T063834_IFCB014.roi', [573 208] )
export_png_from_ROIlist('C:\Users\Emily Fay\Documents\Ciliate_Code\IFCB_14\Van\D20140201T070213_IFCB014.roi', [656 115 257 340] )
export_png_from_ROIlist('C:\Users\Emily Fay\Documents\Ciliate_Code\IFCB_14\Van\D20140201T072825_IFCB014.roi', [432 784] )
export_png_from_ROIlist('C:\Users\Emily Fay\Documents\Ciliate_Code\IFCB_14\Van\D20140201T075205_IFCB014.roi', [700 144 200] )
export_png_from_ROIlist('C:\Users\Emily Fay\Documents\Ciliate_Code\IFCB_14\Van\D20140201T081818_IFCB014.roi', [724] )
export_png_from_ROIlist('C:\Users\Emily Fay\Documents\Ciliate_Code\IFCB_14\Van\D20140201T084157_IFCB014.roi', [191 148 245] )
export_png_from_ROIlist('C:\Users\Emily Fay\Documents\Ciliate_Code\IFCB_14\Van\D20140201T113745_IFCB014.roi', [835] )
export_png_from_ROIlist('C:\Users\Emily Fay\Documents\Ciliate_Code\IFCB_14\Van\D20140201T125116_IFCB014.roi', [457] )
export_png_from_ROIlist('C:\Users\Emily Fay\Documents\Ciliate_Code\IFCB_14\Van\D20140201T143100_IFCB014.roi', [523] )
export_png_from_ROIlist('C:\Users\Emily Fay\Documents\Ciliate_Code\IFCB_14\Van\D20140201T193011_IFCB014.roi', [278] )
export_png_from_ROIlist('C:\Users\Emily Fay\Documents\Ciliate_Code\IFCB_14\Van\D20140202T020906_IFCB014.roi', [826] )


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

