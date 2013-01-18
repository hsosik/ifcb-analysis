%classcountTBall = [];
classcountTB_above_adhocthreshall = [];
%classcountTB_above_optthreshall = [];
ml_analyzedTBall = [];
mdateTBall = [];
filelistTBall = [];

for yr = 2006:2012,
    temp = load(['summary_LaboeaTBpt7' num2str(yr)]);
%    classcountTBall = [ classcountTBall; temp.classcountTB];
    classcountTB_above_adhocthreshall = [ classcountTB_above_adhocthreshall; temp.classcountTB_above_adhocthresh];
%    classcountTB_above_optthreshall = [ classcountTB_above_optthreshall; temp.classcountTB_above_optthresh];
    ml_analyzedTBall = [ ml_analyzedTBall; temp.ml_analyzedTB];
    mdateTBall = [ mdateTBall; temp.mdateTB];
    filelistTBall = [ filelistTBall; temp.filelistTB];
    class2useTB = temp.class2useTB;
    clear temp
end;

clear yr
