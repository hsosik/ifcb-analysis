%resultpath = '\\raspberry\d_work\ifcb1\ifcb_data_mvco_jun06\manual_fromClass\summary\';
resultpath = 'C:\work\IFCB\code_svn\classification\';

classcountTB = [];
classcountTB_above_adhocthresh = [];
ml_analyzedTB = [];
mdateTB = [];
filelistTB = [];

for yr = 2006:2012,
    disp(yr)
    temp = load([resultpath 'summary_allTB' num2str(yr)]);
    classcountTB_above_adhocthresh = [ classcountTB; temp.classcountTB_above_adhocthresh];
    classcountTB = [ classcountTB; temp.classcountTB];
    ml_analyzedTB = [ ml_analyzedTB; temp.ml_analyzedTB];
    mdateTB = [ mdateTB; temp.mdateTB];
    filelistTB = [ filelistTB; temp.filelistTB];
    class2useTB = temp.class2useTB;
    clear temp
end;


%skip some bad points
ii = [strmatch('IFCB1_2006_352', filelistTB); strmatch('IFCB1_2010_153_00', filelistTB); strmatch('IFCB1_2010_153_01', filelistTB)];
classcountTB(ii,:) = [];
classcountTB_above_adhocthresh(ii,:) = [];
ml_analyzedTB(ii) = [];
mdateTB(ii) = [];
filelistTB(ii) = [];

ind = 13; 
%[xmat, ymat ] = timeseries2ydmat(mdateTB, classcountTB(:,ind));
[xmat, ymat ] = timeseries2ydmat(mdateTB, classcountTB_above_adhocthresh(:,ind));
[xmat, ymat_ml ] = timeseries2ydmat(mdateTB, ml_analyzedTB);
plot(xmat(:), ymat(:)./ymat_ml(:), 'r')
