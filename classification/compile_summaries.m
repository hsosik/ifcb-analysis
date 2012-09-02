classcountTBall = [];
classcountTB_above_adhocthreshall = [];
classcountTB_above_optthreshall = [];
ml_analyzedTBall = [];
mdateTBall = [];
filelistTBall = [];

for yr = 2006:2012,
    temp = load(['summary_allTB' num2str(yr)]);
    classcountTBall = [ classcountTBall; temp.classcountTB];
    classcountTB_above_adhocthreshall = [ classcountTB_above_adhocthreshall; temp.classcountTB_above_adhocthresh];
    classcountTB_above_optthreshall = [ classcountTB_above_optthreshall; temp.classcountTB_above_optthresh];
    ml_analyzedTBall = [ ml_analyzedTBall; temp.ml_analyzedTB];
    mdateTBall = [ mdateTBall; temp.mdateTB];
    filelistTBall = [ filelistTBall; temp.filelistTB];
    class2useTB = temp.class2useTB;
    clear temp
end;

return

ind = 19; figure
[xmat, ymat ] = timeseries2ydmat(mdateTBall, classcountTB_above_adhocthreshall(:,ind)./ml_analyzedTBall);
plot(xmat(:), ymat(:))
title(class2useTB(ind))
datetick, set(gca, 'xgrid', 'on')