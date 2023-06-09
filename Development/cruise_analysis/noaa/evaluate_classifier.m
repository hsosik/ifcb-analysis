%function [ ] = evaluate_classfier(classpathTB, classpath_manual, class_table);

close all; clear all;

classpathTB = '\\SOSIKNAS1\IFCB_products\IFCB102_PiscesNov2014\class\summary\summary_allTB.mat';

classpath_summary = '\\SOSIKNAS1\IFCB_products\IFCB102_PiscesNov2014\Manual_fromClass\summary\count_manual_13Jan2016.mat';
classpath_manual = '\\SOSIKNAS1\IFCB_products\IFCB102_PiscesNov2014\Manual_fromClass\';
class_table = '\\RASPBERRY\d_work\IFCB1\code_git\ifcb-analysis\Development\cruise_analysis\noaa\class_table_mvco.mat';

load(classpathTB); load(classpath_summary); load(class_table);

filelist = {filelist.name}';
temp = char(filelist);
temp = temp(:,1:24);
filelist = cellstr(temp);
filelistTB = cellstr(filelistTB);

[C, IA, IB] = intersect(filelist, filelistTB); %find indices where TB results have corresponding manual results.

manual_simple = zeros(length(filelist),length(class2useTB));
for i = 1:length(filelist);
    for j = 1:length(class2useTB);
        ind = strmatch(class2useTB(j), class_table_mvco{1:113,2}, 'exact');
        manual_simple(:,j) = sum((classcount(:,ind)),2);
    end
end




classcountTB_simple = classcountTB(IB, :);


count_diff = classcountTB_simple-manual_simple;
maxn = max(count_diff); maxn = max(maxn); minn = min(count_diff); minn = min(minn);


text_offset = 0.1;

pcolor(count_diff)
set(gca, 'ytick', 1:length(class2useTB), 'yticklabel', [])
text( -text_offset+ones(size(filelist)),(1:length(filelist))+.5, filelist, 'interpreter', 'none', 'horizontalalignment', 'right', 'rotation', 0)
set(gca, 'xtick', 1:length(class2useTB), 'xticklabel', [])
text((1:length(class2useTB))+.5, -text_offset+ones(size(class2useTB)), class2useTB, 'interpreter', 'none', 'horizontalalignment', 'right', 'rotation', 45) 
axis square, colorbar, caxis([minn maxn])

full_classlist = [];
for i = 1:length(filelist);
    load([classpath_manual char(filelist(i)) '.mat']);
    full_classlist = [full_classlist; classlist];
end

for i = 1:length(full_classlist);
if isnan(full_classlist(i,2));
    full_classlist(i,2) = full_classlist(i,3);
end
end

CM = confusionmat(full_classlist(:,2), full_classlist(:,3));
pcolor(CM);
axis square, colorbar, caxis([0 150])


    