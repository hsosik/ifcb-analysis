function [classcount, classbiovol, classC, classcount_above_optthresh, classbiovol_above_optthresh, classC_above_optthresh, classcount_above_adhocthresh, classbiovol_above_adhocthresh, classC_above_adhocthresh, class2useTB] = summarize_TBclassMVCO(classfile, feafile, adhocthresh)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

micron_factor = 1/3.4; %microns per pixel

load(classfile)
classcount = NaN(length(class2useTB),1);
classcount_above_optthresh = classcount;
classcount_above_adhocthresh = classcount;
classbiovol = classcount;
classbiovol_above_optthresh = classcount;
classbiovol_above_adhocthresh = classcount;
classC = classcount;
classC_above_optthresh = classcount;
classC_above_adhocthresh = classcount;
feastruct = importdata(feafile);
ind = strmatch('Biovolume', feastruct.colheaders);
targets.Biovolume = feastruct.data(:,ind)*micron_factor.^3;

%% get the TBclass labels with application of adhocthresh
t = repmat(adhocthresh,length(TBclass),1);
win = (TBscores > t);
[i,j] = find(win);
TBclass_above_adhocthresh = cell(size(TBclass));
TBclass_above_adhocthresh(:) = deal(repmat({'unclassified'},1,length(TBclass)));
TBclass_above_adhocthresh(i) = class2useTB(j); %most are correct his way (zero or one case above threshold)
ind = find(sum(win')>1); %now go back and fix the conflicts with more than one above threshold
for count = 1:length(ind),
    [~,ii] = max(TBscores(ind(count),:));
    TBclass_above_adhocthresh(ind(count)) = class2useTB(ii);
end;
%%

[ind_diatom] = get_diatom_ind(class2useTB,class2useTB);
diatom_flag = zeros(size(class2useTB));
diatom_flag(ind_diatom) = 1;
cellC_diatom = biovol2carbon(targets.Biovolume,1);
cellC_notdiatom = biovol2carbon(targets.Biovolume,0);
for ii = 1:length(class2useTB),
    if diatom_flag(ii)
        cellC = cellC_diatom;
    else
        cellC = cellC_notdiatom;
    end
    ind = strmatch(class2useTB(ii), TBclass,'exact');
    classcount(ii) = size(ind,1);
    classbiovol(ii) = sum(targets.Biovolume(ind));
    classC(ii) = sum(cellC(ind));
    ind = strmatch(class2useTB(ii), TBclass_above_threshold, 'exact');
    classcount_above_optthresh(ii) = size(ind,1);
    classbiovol_above_optthresh(ii) = sum(targets.Biovolume(ind));
    classC_above_optthresh(ii) = sum(cellC(ind));
    ind = strmatch(class2useTB(ii), TBclass_above_adhocthresh, 'exact');
    classcount_above_adhocthresh(ii) = size(ind,1);
    classbiovol_above_adhocthresh(ii) = sum(targets.Biovolume(ind));
    classC_above_adhocthresh(ii) = sum(cellC(ind));
end;
end

