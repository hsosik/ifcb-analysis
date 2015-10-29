close all;
clear all;
%load \\sosiknas1\Lab_data\VPR\NBP1201\classifiers\classifier_obb_output_RossSea_Trees_30Sep2015.mat
load \\sosiknas1\Lab_data\VPR\NBP1201\classifiers\classifier_obb_output_RossSea_Trees_22Sep2015_200trees_allCat.mat;
%train_dir_base = '\\sosiknas1\Lab_data\VPR\NBP1201\VPR8_train_20Sept2015_extra_qc\';
train_dir_base = '\\sosiknas1\Lab_data\VPR\NBP1201\VPR8_train_20Sept2015_qc\';
mistake_ind = find(~strcmp(Yfit, b.Y)); 

top_scores_sum = zeros(length(Sfit),1);
top_score = zeros(length(Sfit),1);
second_score = zeros(length(Sfit),1);
third_score = zeros(length(Sfit),1);


for i = 1:length(Sfit)
 score_sort = sort(Sfit(i,:));
 score_sum = sum(score_sort(end-1:end));
 top_scores_sum(i)=score_sum;
 top_score(i) = score_sort(end);
 second_score(i)= score_sort(end-1);
 third_score(i)= score_sort(end-2);
 
end

top_score_ind = find(top_scores_sum > 0);

figure
hold on
subplot(4,1,1)
 xlim([0 1])
ylim([0 500])
hist(top_score)
legend('top score')
subplot(4,1,2)
hist(second_score)
 xlim([0 1])
ylim([0 500])
legend('second score')
subplot(4,1,3)
hist(third_score)
 xlim([0 1])
ylim([0 500])
legend('third score')
subplot(4,1,4)
hist(top_scores_sum)
legend('Sum of top 2 scores')
 xlim([0 1])
ylim([0 500])
%for i = 1:length(Sfit)


mistakes = strcmp(Yfit, classes2(Yfit_max));
mistake_ind = find(~strcmp(Yfit, b.Y));
mistake_ind = strmatch('unclassified', classes2(Yfit_max));

%for i = 1:length(top_score_ind);
figure(2)
 for ii = 1:25:length(mistake_ind)
    i = mistake_ind(ii); 
    clf
    subplot(3,1,1);
    bar(Sfit(top_score_ind(i),:))
    ylim([0 1])
    xlim([0 12])
    title(strcat(targets(top_score_ind(i)), '  ', b.Y(top_score_ind(i))));
    set(gca, 'XTickLabel', classes);
    
    temp =strcat(train_dir_base, b.Y(top_score_ind(i)), '\', targets(top_score_ind(i)), '.tif');
   blob_base = '\\sosiknas1\Lab_data\VPR\NBP1201\vpr8\blobs\';
   ziploc = char(targets(top_score_ind(i)));
   blob_target = strcat(cellstr(ziploc(20:34)), '.png');
   ziploc = strcat(cellstr(ziploc(12:18)), '.zip');
   ziploc = strcat(blob_base, ziploc);
   

   
    blob = read_blob_zip(ziploc{1}, blob_target{1});
    subplot(3,1,2);
    imshow(imread(char(temp)))
    
    subplot(3,1,3);
    imshow(blob);
    
    pause
  
end

