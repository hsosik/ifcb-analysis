function [classcount, classbiovol, classC, classcount_above_optthresh, classbiovol_above_optthresh, classC_above_optthresh, class2useTB] = summarize_TBclassMVCO(classfile, feafile)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

micron_factor = 1/3.4; %microns per pixel

load(classfile)
classcount = NaN(length(class2useTB),1);
classcount_above_optthresh = classcount;
%classcount_above_adhocthresh = classcount;
classbiovol = classcount;
classbiovol_above_optthresh = classcount;
%classbiovol_above_adhocthresh = classcount;
classC = classcount;
classC_above_optthresh = classcount;
%classC_above_adhocthresh = classcount;
feastruct = importdata(feafile);
ind = strmatch('Biovolume', feastruct.colheaders);
targets.Biovolume = feastruct.data(:,ind)*micron_factor.^3;

[ind_diatom] = get_diatom_ind(class2useTB,class2useTB);
diatom_flag = zeros(size(class2useTB));
diatom_flag(ind_diatom) = 1;
cellC_diatom = biovol2carbon(targets.Biovolume,1);
cellC_notdiatom = biovol2carbon(targets.Biovolume,0);
for ii = 1: length(class2useTB),
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
    %ind = strmatch(class2useTB(ii), TBclass_above_adhocthresh, 'exact');
    %classcount_above_adhocthresh(ii) = size(ind,1);
    %classbiovol_above_adhocthresh(ii) = sum(targets.Biovolume(ind));
    %classC_above_adhocthresh(ii) = sum(cellC(ind));
end;
end

