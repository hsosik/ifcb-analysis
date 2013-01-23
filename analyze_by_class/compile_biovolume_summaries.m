resultpath = '\\raspberry\d_work\ifcb1\ifcb_data_mvco_jun06\manual_fromClass\summary\';
micron_factor = 1/3.4; %microns per pixel

classcountTB = [];
classbiovolTB = [];
ml_analyzedTB = [];
mdateTB = [];
filelistTB = [];

for yr = 2006:2012,
    disp(yr)
    temp = load([resultpath 'summary_biovol_allTB' num2str(yr)]);
    classcountTB = [ classcountTB; temp.classcountTB];
    classbiovolTB = [classbiovolTB; temp.classbiovolTB];
    ml_analyzedTB = [ ml_analyzedTB; temp.ml_analyzedTB];
    mdateTB = [ mdateTB; temp.mdateTB];
    filelistTB = [ filelistTB; temp.filelistTB];
    class2useTB = temp.class2useTB;
    clear temp
end;


%skip some bad points
ii = [strmatch('IFCB1_2006_352', filelistTB); strmatch('IFCB1_2010_153_00', filelistTB); strmatch('IFCB1_2010_153_01', filelistTB)];
classcountTB(ii,:) = [];
classbiovolTB(ii,:) = [];
ml_analyzedTB(ii) = [];
mdateTB(ii) = [];
filelistTB(ii) = [];

%cubic microns
classbiovolTB = classbiovolTB*micron_factor^3;

ind = 13; 
%[xmat, ymat ] = timeseries2ydmat(mdateTB, classcountTB(:,ind));
[xmat, ymat ] = timeseries2ydmat(mdateTB, classbiovolTB(:,ind));
[xmat, ymat_ml ] = timeseries2ydmat(mdateTB, ml_analyzedTB);
plot(xmat(:), ymat(:)./ymat_ml(:), 'r')

figure, %set(gcf, 'position', [360 278 500 250])
cstr = ['krgcmby'];
[ ind_diatom, class_label ] = get_diatom_ind( class2useTB, class2useTB );
[xmat, ymat ] = timeseries2ydmat(mdateTB, nansum(classbiovolTB(:,ind_diatom),2));
[xmat, ymat_ml ] = timeseries2ydmat(mdateTB, ml_analyzedTB);
%plot(xmat(:), ymat(:)./ymat_ml(:), 'r')
ph = plot(1:366, ymat./ymat_ml,'.-', 'linewidth', 1);
for ii = 1:length(ph),
    set(ph(ii), 'color', cstr(ii))
end;
datetick('x', 3, 'keeplimits')
%xlim(datenum(['1-1-06'; '1-1-07']))
xlim([1 367])
ylim([0 1.5e6])
th = title('Diatoms', 'fontsize', 20, 'fontname', 'arial');
%th = title('\itSynechococcus', 'fontsize', 14);
ylabel('Biovolume ( \mum^{ -3} mL^{ -1})', 'fontsize', 20, 'fontname', 'arial')
%ylabel('Cell concentration (ml^{ -1})')
lh2 = legend(num2str((2006:2012)'), 'location', 'south');
set(lh2, 'box', 'on', 'fontsize', 16, 'fontname', 'arial')
set(gca, 'fontsize', 16, 'fontname', 'arial')
set(gcf, 'position', [360 278 750 375])
