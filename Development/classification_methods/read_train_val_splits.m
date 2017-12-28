p = 'C:\work\IFCB\Manual_fromClass\train_fromcsv_Sep2017\IFCB CNN project\IFCB CNN project\11-30-17\planton_10 dataset lists\';
%p = '\\sosiknas1\IFCB_products\MVCO\Manual_fromClass\train_fromcsv_Sep2017\test_validation_split\';
%p2 = '\\sosiknas1\IFCB_products\MVCO\Manual_fromClass\train_fromcsv_Sep2017\';

pfea = '\\sosiknas1\IFCB_dev\features_v3_test\features\';
class2use = dir([p]);
class2use = {class2use.name}; % get the class names
class2use(strmatch('.', class2use)) = []; %get rid of . and ..

train = [];
validation = train;
test = train;
train_class_vector = train;
validation_class_vector = train;
test_class_vector = train;
train_targets = train;
validation_targets = train;
test_targets = train;
missing = [];
for count = 1:length(class2use)
    disp(class2use(count))
    train_targets{count} = regexprep(importdata(fullfile(p, class2use{count}, 'training.txt')), '.png', '');
    validation_targets{count} = regexprep(importdata(fullfile(p, class2use{count}, 'validation.txt')), '.png', '');
    test_targets{count} = regexprep(importdata(fullfile(p, class2use{count}, 'test.txt')), '.png', '');
    train_class_vector{count} = repmat(class2use(count), length(train_targets),1);
    validation_class_vector{count} = repmat(class2use(count), length(validation_targets),1);
    test_class_vector{count} = repmat(class2use(count), length(test_targets),1); 
end;

%%%STOP HERE...seems better to make class specific mat files for features
%%%first, but doing all at once to save I/O on feature files. Where are the
%%%exported pngs for train_fromcsv_Sep2017--sosiknas1?
  
    ttemp = char(ttargets); ii = find(ttemp(:,1) == 'D');
    troinum = cellstr(ttemp(:,23:27));
    t1 = cellstr(ttemp(:,1:21));
    if ~isempty(ii)
        troinum(ii) = cellstr(ttemp(ii,26:30));
        t1(ii) = cellstr(ttemp(ii,1:24));
    end
    vtemp = char(vtargets); ii = find(vtemp(:,1) == 'D');
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
    
    %unqfiles = unique([t1; v1; tr1]);
    %vfea = nan(length(v1),241);
    %tfea = nan(length(t1),241);
    %trfea = nan(length(tr1),241);
%     for c2 = 1:length(unqfiles)
%         filename = [pfea unqfiles{c2} '_fea_v3.csv'];
%         if ~exist(filename, 'file')
%             disp(filename)
%             missing = [missing; unqfiles(c2)];
%         end
%         fea = importdata([pfea unqfiles{c2} '_fea_v3.csv']);
%         ii = strmatch(unqfiles(c2), t1);
%         if ~isempty(ii)
%             [~,iit,iia] = intersect(fea.data(:,1), str2num(char((troinum(ii)))));
%             tfea(ii(iia),:) = fea.data(iit,:);
%         end
%         ii = strmatch(unqfiles(c2), v1);
%         if ~isempty(ii)
%             [~,iiv, iia] = intersect(fea.data(:,1), str2num(char((vroinum(ii)))));
%             vfea(ii(iia),:) = fea.data(iiv,:);
%         end
%         ii = strmatch(unqfiles(c2), tr1);
%         if ~isempty(ii)
%             [~,iiv, iia] = intersect(fea.data(:,1), str2num(char((trroinum(ii)))));
%             trfea(ii(iia),:) = fea.data(iiv,:);
%         end
%     end
%   testing = tfea;
%   validation = vfea; 
%   train = trfea;
%   featitles = fea.colheaders;
%   save([p regexprep(l{count},'.csv','') '_train'], 'validation', 'testing', 'train', 'vtargets', 'ttargets', 'trtargets', 'vclass_vector', 'tclass_vector', 'trclass_vector', 'featitles')
end
 
%dlmwrite('v3_bins_missing', char(missing), 'delimiter', '')
