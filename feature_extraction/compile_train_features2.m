%load output %load result file produced by batch_features_train.m
outdir = 'C:\work\IFCB\code_svn\feature_extraction\out\';
temp = dir([outdir '*.mat']);
classes = {temp.name};
for i = 1:length(classes),
    classes(i) = {classes{i}(1:end-4)};
end;

%classes = fieldnames(output);
%skip some classes that are empty or not properly annotated
classes = setdiff(classes, {'config' 'Eucampia_groenlandica' 'Tropidoneis' 'dino10' 'roundCell' 'other' 'flagellate' 'crypto'});
%classes = setdiff(classes, {'config' 'Eucampia_groenlandica' 'Tropidoneis' 'dino10' 'roundCell' 'other' 'flagellate' 'crypto' 'Lauderia' 'Odontella' 'Stephanopyxis'});
maxn = 250;
class_vector = [];
targets = [];
for classcount = 1:length(classes),
    class = char(classes(classcount));
    load([outdir char(classes(classcount))])
    %s_temp = output.(class).features;
    s_temp = out.features;
    
    Rings = [s_temp.Rings];
    Wedges = [s_temp.Wedges];
    HOG = [s_temp.HOG];
    s_temp = rmfield(s_temp, {'Rings' 'Wedges' 'HOG'});
    n = [s_temp.numBlobs];
    n_class(classcount) = length(n);
    largest_ind = [1 cumsum(n(1:end-1))+1];
    
    fields = fieldnames(s_temp);
    for i = 1:length(fields),
        field = char(fields(i));
        list = [s_temp.(field)];
        if length(list) > length(n),
            s_largest.(field) = list(largest_ind);
        else
            s_largest.(field) = list;
        end;
    end;
    output_largest.(class).features = s_largest;
    temp = struct2cell(s_largest);    
    feamat{classcount} = [cell2mat(temp); Wedges; Rings; HOG];
    t_temp = out.targets;
    if maxn < n_class(classcount),
        ind = randi(n_class(classcount),maxn,1);
        feamat{classcount} = feamat{classcount}(:,ind);
        t_temp = t_temp(ind);
    end;
    class_vector = [class_vector repmat(classcount,1,min(maxn,n_class(classcount)))];
    targets = [targets; t_temp'];
end;

train = cell2mat(feamat);
%class_vector = [];
%for i = 1:length(n_class),
%    class_vector = [class_vector repmat(i,1,min(maxn,n_class(i)))];
%end;
featitles = fieldnames(output_largest.(class).features);
nring = size(Rings,1); nwedge = size(Wedges,1); nhog = size(HOG,1);
featitles = [featitles; cellstr([repmat('Wedge:',nwedge,1) num2str((1:nwedge)')]); cellstr([repmat('Ring:',nring,1) num2str((1:nring)')]); cellstr([repmat('HOG:',nhog,1) num2str((1:nhog)')])];

train(isnan(train)) = 0;

clear temp s_largest classcount i largest_ind field s_temp n temp list fields class ind nhog nring nwedge 
clear outdir ans HOG Rings Wedges maxn out n_class t_temp
clear output output_largest 

return

colorset = colormap;

figure, hold on
for i = 1:length(feamat),
    plot(feamat{i}(36,:),feamat{i}(19,:), '.', 'color', colorset(i,:))
end;
set(gca, 'xscale', 'log', 'yscale', 'log')
figure, hold on
for i = 1:length(feamat),
    plot3(feamat{i}(5,:),feamat{i}(36,:),feamat{i}(37,:), '.', 'color', colorset(i,:))
end;
set(gca, 'xscale', 'log', 'yscale', 'log', 'zscale', 'log')
