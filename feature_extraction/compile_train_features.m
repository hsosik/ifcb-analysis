load output

classes = fieldnames(output);
classes = setdiff(classes, {'config' 'Eucampia_groenlandica' 'Tropidoneis' 'dino10' 'roundCell' 'other' 'flagellate' 'crypto'});

for classcount = 1:length(classes),
    class = char(classes(classcount));
    s_temp = output.(class).features;
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
    feamat{classcount} = cell2mat(temp);
end;

train = cell2mat(feamat);
class_vector = [];
for i = 1:length(n_class),
    class_vector = [class_vector repmat(i,1,n_class(i))];
end;
featitles = fieldnames(output_largest.(class).features);

train(isnan(train)) = 0;

clear temp s_largest classcount i largest_ind field s_temp n temp output list fields class

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
