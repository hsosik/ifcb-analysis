%p = 'C:\work\IFCB\Manual_fromClass\train_fromcsv_Sep2017\train_validation_split\';
p = '\\sosiknas1\IFCB_products\MVCO\Manual_fromClass\train_fromcsv_Sep2017\test_validation_split\';
p2 = '\\sosiknas1\IFCB_products\MVCO\Manual_fromClass\train_fromcsv_Sep2017\';

pfea = '\\sosiknas1\IFCB_dev\features_v3_test\features\';
l = dir([p '*.csv']);
l = {l.name};
class2use = regexprep(l, '.csv', '')';
train = [];
validation = train;
train_class_vector = train;
validation_class_vector = train;
train_targets = train;
validation_targets = train;
missing = [];
for count = 2:length(l)
    disp(l(count))
    [~, t] = xlsread([p l{count}], 1, 'A2');
    [~, v] = xlsread([p l{count}], 1, 'B2');
    
    eval(['t = {' t{1}(2:end-1) '};']);
    eval(['v = {' v{1}(2:end-1) '};']);
    ttargets = regexprep(t', '.jpg', '');
    vtargets = regexprep(v', '.jpg', '');
    tclass_vector = repmat(class2use(count), length(ttargets),1);
    vclass_vector = repmat(class2use(count), length(vtargets),1);
    
    %get the list of all example rois
    tr = dir([p2 class2use{count} '\*.png']);
    tr = regexprep({tr.name}', '.png', '');
    %just the ones not in test or validation
    [trtargets,ia] = setdiff(tr, [ttargets; vtargets]);
    trclass_vector = repmat(class2use(count), length(trtargets),1);
    
    ttemp = char(t); ii = find(ttemp(:,1) == 'D');
    troinum = cellstr(ttemp(:,23:27));
    t1 = cellstr(ttemp(:,1:21));
    if ~isempty(ii)
        troinum(ii) = cellstr(ttemp(ii,26:30));
        t1(ii) = cellstr(ttemp(ii,1:24));
    end
    vtemp = char(v); ii = find(vtemp(:,1) == 'D');
    vroinum = cellstr(vtemp(:,23:27));
    v1 = cellstr(vtemp(:,1:21));
    if ~isempty(ii)
        vroinum(ii) = cellstr(vtemp(ii,26:30));
        v1(ii) = cellstr(vtemp(ii,1:24));
    end
    ttemp = char(trtargets); ii = find(ttemp(:,1) == 'D');
    trroinum = cellstr(ttemp(:,23:27));
    tr1 = cellstr(ttemp(:,1:21));
    if ~isempty(ii)
        trroinum(ii) = cellstr(ttemp(ii,26:30));
        tr1(ii) = cellstr(ttemp(ii,1:24));
    end
    
    unqfiles = unique([t1; v1; tr1]);
    vfea = nan(length(v1),241);
    tfea = nan(length(t1),241);
    trfea = nan(length(tr1),241);
    for c2 = 1:length(unqfiles)
        filename = [pfea unqfiles{c2} '_fea_v3.csv'];
        if ~exist(filename, 'file')
            disp(filename)
            missing = [missing; unqfiles(c2)];
        end
        fea = importdata([pfea unqfiles{c2} '_fea_v3.csv']);
        ii = strmatch(unqfiles(c2), t1);
        if ~isempty(ii)
            [~,iit,iia] = intersect(fea.data(:,1), str2num(char((troinum(ii)))));
            tfea(ii(iia),:) = fea.data(iit,:);
        end
        ii = strmatch(unqfiles(c2), v1);
        if ~isempty(ii)
            [~,iiv, iia] = intersect(fea.data(:,1), str2num(char((vroinum(ii)))));
            vfea(ii(iia),:) = fea.data(iiv,:);
        end
        ii = strmatch(unqfiles(c2), tr1);
        if ~isempty(ii)
            [~,iiv, iia] = intersect(fea.data(:,1), str2num(char((trroinum(ii)))));
            trfea(ii(iia),:) = fea.data(iiv,:);
        end
    end
   testing = tfea;
   validation = vfea; 
   train = trfea;
   featitles = fea.colheaders;
   save([p regexprep(l{count},'.csv','') '_train'], 'validation', 'testing', 'train', 'vtargets', 'ttargets', 'trtargets', 'vclass_vector', 'tclass_vector', 'trclass_vector', 'featitles')
end
 
%dlmwrite('v3_bins_missing', char(missing), 'delimiter', '')
