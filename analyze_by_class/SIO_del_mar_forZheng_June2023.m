T = load('\\sosiknas1\IFCB_products\SIO_Delmar_mooring\summary\summary_biovol_allHDF_min20_2020.mat');
L = load('\\sosiknas1\IFCB_products\SIO_Delmar_mooring\summary\summary_biovol_allHDF_min20_2020lists.mat');

T.classcount = array2table(T.classcount,'VariableNames', class2use);
T.classC = array2table(T.classC,'VariableNames', class2use);
L.classFeaList = array2table(L.classFeaList, 'VariableNames', L.class2use);
T.datetime = datetime(T.mdate, 'ConvertFrom', 'datenum');
nonProtist_classes = {'bad' 'bead' 'bubble' 'detritus' 'detritus theca fragment' 'fecal pellet' 'fiber' 'zooplankton'};
cells2sum_classes = setdiff(T.class2use, T.nonProtist_classes);

cellC_ind = find(strcmp('cellC', L.classFeaList_variables));
ESD_ind = find(strcmp('ESD', L.classFeaList_variables));

summedCellC = NaN(size(T.filelist)); %initialize
for ii = 1:length(summedCellC)
    Feamat = cat(1,L.classFeaList{ii,cells2sum_classes}{:}); %matrix of features for classes to sum
    summedCellC(ii) = sum(Feamat(Feamat(:,ESD_ind)>=10,cellC_ind),"all"); %sum the cellC for cells > 10 micrometer ESD
end

figure %cell concentration
plot(T.datetime, T.classcount.Lingulodinium./T.meta_data.ml_analyzed, '.-')
ylabel('\itLingulodinium\rm (cells ml^{-1})')

figure %Carbon biomass
plot(T.datetime, T.classC.Lingulodinium./T.meta_data.ml_analyzed/1000, '.-')
ylabel('\itLingulodinium\rm (\mug C l^{-1})')

figure %Carbon biomass, total for cells>10 microns and Lpoly
plot(T.datetime, summedCellC./T.meta_data.ml_analyzed/1000, '.-')
hold on
plot(T.datetime, T.classC.Lingulodinium./T.meta_data.ml_analyzed/1000a, '.-')
ylabel('Plankton biomass (\mug C l^{-1})')
legend('All plankton > 10\mum', '\itLingulodinium')

figure %biomass fraction (Lpoly/total>10micron)
plot(T.datetime, T.classC.Lingulodinium./summedCellC, '.-')
ylabel('\itLingulodinium\rm biomass fraction')