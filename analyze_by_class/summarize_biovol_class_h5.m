function [classcount, classbiovol, classC, classcount_above_optthresh, classbiovol_above_optthresh, classC_above_optthresh, classcount_above_adhocthresh, classbiovol_above_adhocthresh, classC_above_adhocthresh, class_labels, classFeaList, classPidList] = summarize_biovol_class_h5(classfile, feafile, adhocthresh, optthresh, pidlist_flag)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
persistent ind_diatom class2use
%micron_factor = 1/3.4; %microns per pixel
micron_factor = 1/2.77; %microns per pixel

%load(classfile)
%[bin_id, scores, roi_numbers, class_labels] = load_class_scores(classfile);
classTable = load_class_scores(classfile);
class_labels = classTable.class_labels;
if isempty(class2use)
    class2use = class_labels;
end
if ~isequal(class_labels,class2use)
    disp('class2use different between calls to this function')
    keyboard
end
classcount = NaN(length(class_labels),1);
classcount_above_optthresh = classcount;
classcount_above_adhocthresh = classcount;
classbiovol = classcount;
classbiovol_above_optthresh = classcount;
classbiovol_above_adhocthresh = classcount;
classC = classcount;
classC_above_optthresh = classcount;
classC_above_adhocthresh = classcount;
feastruct = importdata(feafile);
%ind = strmatch('Biovolume', feastruct.colheaders);
ind = strmatch('summedBiovolume', feastruct.textdata);
targets.Biovolume = feastruct.data(:,ind)*micron_factor.^3;
%targets.esd = (targets.Biovolume*3/4/pi).^(1/3)*2; 
targets.esd = biovol2esd(targets.Biovolume);
ind = strmatch('summedSurfaceArea', feastruct.textdata);
targets.SurfaceArea = feastruct.data(:,ind)*micron_factor.^2;
ind = strmatch('maxFeretDiameter', feastruct.textdata);
targets.maxFeretDiameter = feastruct.data(:,ind)*micron_factor;
ind = strmatch('summedMajorAxisLength', feastruct.textdata);
targets.summedMajorAxisLength = feastruct.data(:,ind)*micron_factor;
ind = strmatch('RepresentativeWidth', feastruct.textdata);
targets.RepresentativeWidth = feastruct.data(:,ind)*micron_factor;
ind = strmatch('summedArea', feastruct.textdata);
targets.summedArea = feastruct.data(:,ind)*micron_factor.^2;
ind = strmatch('numBlobs', feastruct.textdata);
targets.numBlobs = feastruct.data(:,ind);
targets.roi_numbers = feastruct.data(:,1);
targets.pid = cellstr(strcat(classTable.metadata.bin_id, '_', num2str(feastruct.data(:,1), '%05.0f')));
%%
adcfile = regexprep(feafile, '_fea_v4.csv', '.adc');
adcfile = regexprep(adcfile, 'IFCB_products', 'IFCB_data');
adcfile = regexprep(adcfile, 'IFCB_products', 'IFCB_data');
adcfile = regexprep(adcfile, 'features\\D', 'data\');
adcfile = regexprep(adcfile, 'features_v4\\D', 'data\'); %MVCO case

%temp fudge for old MVCO products
% mvco_flag = 0;
% if strfind(feafile, 'MVCO')
%     mvco_flag = 1;
%     [p,f] = fileparts(feafile);
%     f = regexprep(f, '_fea_v2', '');
%     if strmatch(f(1),'I')
%         adcfile = strcat('\\sosiknas1\IFCB_data\MVCO\data\',f(7:10), filesep, f(1:14),filesep, f, '.adc');
%     else
%         adcfile = strcat('\\sosiknas1\IFCB_data\MVCO\data\',f(2:5), filesep, f(1:9),filesep, f, '.adc')
%     end
% end

%add opts to address adc files with only 1 row of data
opts = delimitedTextImportOptions("NumVariables", 24);
opts.VariableTypes = repmat("double", 1,24); %["double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double"];
adc = readtable(adcfile, opts);
%adc = readtable(adcfile, 'FileType', 'text');
targets.adc = adc{feastruct.data(:,1), 3:11};

%make sure the roi_numbers match
[~,ia,ib] = intersect(feastruct.data(:,1), classTable.roi_numbers);
classTable.scores_feamatch(ia,:) = classTable.scores(ib,:);

%% get the Predicted_class labels with application of adhocthresh
if length(adhocthresh) == 1
    t = ones(size(classTable.scores_feamatch))*adhocthresh;
else
    t = repmat(adhocthresh,length(Predicted_class),1);
end
win = (classTable.scores_feamatch > t);
[i,j] = find(win);
[targets.maxscore, Predicted_class] = max(classTable.scores_feamatch');
Predicted_class((targets.maxscore==0)) = NaN;
%Predicted_class_above_adhocthresh = cell(size(Predicted_class));
%Predicted_class_above_adhocthresh(:) = deal(repmat({'unclassified'},1,length(Predicted_class)));
%Predicted_class_above_adhocthresh(i) = class_labels(j); %most are correct his way (zero or one case above threshold)
Predicted_class_above_adhocthresh = zeros(size(Predicted_class));
Predicted_class_above_adhocthresh(i) = j; %most are correct his way (zero or one case above threshold)

ind = find(sum(win')>1); %now go back and fix the conflicts with more than one above threshold
for count = 1:length(ind)
    [~,ii] = max(classTable.scores_feamatch(ind(count),:));
    Predicted_class_above_adhocthresh(ind(count)) = ii;
end

Predicted_class_above_adhocthresh(isnan(Predicted_class)) = NaN; %these are the no ROI triggers

%% get the Predicted_class labels with application of "optthresh" input as 2-component vector,
%first value is primary min score, second value is max allowed for second ranked score
%if length(adhocthresh) == 1
%     t = ones(size(classTable.scores_feamatch))*optthresh(1);
% %else
% %    t = repmat(adhocthresh,length(Predicted_class),1);
% %end
% win = (classTable.scores_feamatch > t);
% [i,j] = find(win);
% 
% Predicted_class_above_optthresh = zeros(size(Predicted_class));
% Predicted_class_above_optthresh(i) = j; %most are correct his way (zero or one case above threshold)
% 
% ind = find(sum(win')>1); %now go back and fix the conflicts with more than one above threshold
% for count = 1:length(ind)
%     [~,ii] = max(classTable.scores_feamatch(ind(count),:));
%     Predicted_class_above_opthresh(ind(count)) = ii;
% end
% 
% %now check to make sure the second ranked score is low enough
% temp = classTable.scores_feamatch';
% ind = sub2ind(size(temp),Predicted_class,1:size(temp,2));
% 
% temp(ind(~isnan(ind))) = -inf; %set the max values to -inf
% second_score = max(temp);
% Predicted_class_above_optthresh((second_score>optthresh(2))) = 0;

% % dylan's tweak:
% scomat = classTable.scores_feamatch;
% [~, topclassidx] = max(scomat, [], 2); % col index of top class in scomat
% topclassidx_lin = sub2ind(size(scomat), (1:size(scomat,1)).', topclassidx);
% topclasssco = scomat(topclassidx_lin);
% 
% % here's the top-scoring class with score > optthresh(1):
% Predicted_class_above_optthresh = topclassidx(topclasssco > optthresh(1)); 
% 
% % this zero's out the top-scoring class where any other score is >
% % optthresh(2):
% scomat(topclassidx_lin) = -1;
% Predicted_class_above_optthresh(any(scomat > optthresh(2), 2)) = 0;
% 
% % transpose to get it the same format as heidi's:
% Predicted_class_above_optthresh = Predicted_class_above_optthresh';
% 
% % Predicted_class_above_optthresh is a 1 x roi vector of the column index of 
% % the "winning class". 0 indicates no winning class.
% 
% Predicted_class_above_optthresh(isnan(Predicted_class)) = NaN; %these are the no ROI triggers
 
%% dylan's tweak for opt thresh X statistic X class:

scomat = classTable.scores_feamatch;
[~, topclassidx] = max(scomat, [], 2); % col index of top class in scomat
topclassidx_lin = sub2ind(size(scomat), (1:size(scomat,1)).', topclassidx);
topclasssco = scomat(topclassidx_lin);

% here's the top-scoring class with score > optthresh(1):
tmp = optthresh(topclassidx)'; % this creates a vector of opt thresh X roi 
% where opt thresh is for the top-scoring class of each roi.
keepers = topclasssco > tmp; % =1 where the top-scoring class exceeded it's opt thresh
Predicted_class_above_optthresh = zeros(1, length(keepers));
Predicted_class_above_optthresh(keepers) = topclassidx(keepers); 

% Predicted_class_above_optthresh is a 1 x roi vector of the column index of 
% the "winning class". 0 indicates no winning class.
Predicted_class_above_optthresh(isnan(Predicted_class)) = NaN; %these are the no ROI triggers

%%

%[ind_diatom] = get_diatom_ind(class_labels,class_labels);
if isempty(ind_diatom) %first call to function
    gfile = '\\sosiknas1\training_sets\IFCB\config\IFCB_classlist_type.csv';
    disp('Loading list of diatom classes from:')
    disp(gfile)
    group_table = readtable(gfile);
    [~,ia,ib] = intersect(group_table.CNN_classlist, class2use);
    ind_diatom = ib(find(group_table.Diatom(ia)));
end
diatom_flag = zeros(size(class_labels));
diatom_flag(ind_diatom) = 1;
cellC_diatom = biovol2carbon(targets.Biovolume,1);
cellC_notdiatom = biovol2carbon(targets.Biovolume,0);
for ii = 1:length(class_labels)
    if diatom_flag(ii)
        cellC = cellC_diatom;
    else
        cellC = cellC_notdiatom;
    end
    %ind = strmatch(class_labels(ii), Predicted_class,'exact');
    ind = find(Predicted_class == ii);
    classcount(ii) = length(ind);
    classbiovol(ii) = sum(targets.Biovolume(ind));
    classC(ii) = sum(cellC(ind));
    if ~isempty(ind)
        classFeaList{ii} = [targets.esd(ind) targets.maxFeretDiameter(ind) targets.summedMajorAxisLength(ind) targets.RepresentativeWidth(ind) targets.summedArea(ind) targets.SurfaceArea(ind) targets.Biovolume(ind) cellC(ind) targets.numBlobs(ind) targets.adc(ind,:) targets.roi_numbers(ind) targets.maxscore(ind)'];
    else
        classFeaList{ii} = single.empty(0,size(targets.adc,2)+11);
    end
    if pidlist_flag
        classPidList{ii} = targets.pid(ind);
    end
    if exist('Predicted_class_above_optthresh', 'var')
        %ind = strmatch(class_labels(ii), Predicted_class_above_threshold, 'exact');
        ind = find(Predicted_class_above_optthresh==ii);
        classcount_above_optthresh(ii) = length(ind);
        classbiovol_above_optthresh(ii) = sum(targets.Biovolume(ind));
        classC_above_optthresh(ii) = sum(cellC(ind));
    else 
        Predicted_class_above_optthresh = NaN;
    end
    %ind = strmatch(class_labels(ii), Predicted_class_above_adhocthresh, 'exact');
    ind = find(Predicted_class_above_adhocthresh==ii);
    classcount_above_adhocthresh(ii) = length(ind);
    classbiovol_above_adhocthresh(ii) = sum(targets.Biovolume(ind));
    classC_above_adhocthresh(ii) = sum(cellC(ind));
end
if ~pidlist_flag
    classPidList = NaN;
end
end
