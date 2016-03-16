function [ ] = classifier_oob_analysis( classifiername )
%[ ] = classifier_oob_analysis( classifername )
%For example:
% classifier_oob_analysis('C:\work\IFCB\user_training_test_data\manual\summary\UserExample_Trees_06Aug2015')
% input classifier file name with full path
% expects output from make_TreeBaggerClassifier*.m
% Heidi M. Sosik, Woods HOle Oceanographic Institution, September 2014
% Jan 2016, update graph labels and correct error in precision calculation

load(classifiername)

close all
figure(1)
title(classifiername, 'interpreter', 'none')
plot(oobError(b), 'b-');
xlabel('Number of Grown Trees');
ylabel('Out-of-Bag Classification Error');
ylim([0 1])

%clear t
%confustion matrix for winner takes all interpretation of scores
[Yfit,Sfit,Sstdfit] = oobPredict(b);
[mSfit, ii] = max(Sfit');
for count = 1:length(mSfit), mSstdfit(count) = Sstdfit(count,ii(count)); t(count)= Sfit(count,ii(count)); end; 
if isempty(find(mSfit-t)), clear t, else disp('check for error...'); end;
[c1, gord1] = confusionmat(b.Y,Yfit); %transposed from mine
clear t

%sorting features according to the best ones
figure(2)
[delerr,ind]=sort(b.OOBPermutedVarDeltaError,2,'descend');
bar(sort(b.OOBPermutedVarDeltaError,2,'descend'))
ylabel('Feature importance')
xlabel('Feature ranked index')
%ylim([0 1])
disp(['Most important features: ' ])
disp(featitles(ind(1:20))')
%fea2use = ind(1:200); save fea2use fea2use

total = sum(c1')';
maxn = max(total);
[TP TN FP FN] = conf_mat_props(c1);

Pd = TP./(TP+FN); %probability of detection
%Pr = 1-(sum(c1)-diag(c1)')./total'; %precision 1-FP/(TP+FP)
Pr = TP./(TP+FP); %precision = TP/(TP+FP) = diag(c1)./sum(c1)'
disp('overall error rate:')
disp(1-sum(TP)./sum(total))
%disp(sum(sum(c1)-diag(c1)')/sum(total))
text_offset = 0.1;

figure(3)
bar([total TP FP])
legend('total in set', 'true pos', 'false pos')
set(gca, 'xtick', 1:length(classes), 'xticklabel', [])
text(1:length(classes), -text_offset.*ones(size(classes)), classes, 'interpreter', 'none', 'horizontalalignment', 'right', 'rotation', 45) 
set(gca, 'position', [ 0.13 0.35 0.8 0.6])
title('score threshold = 0')

figure(4)
bar([Pd Pr])
set(gca, 'xtick', 1:length(classes), 'xticklabel', [])
text(1:length(classes), -text_offset.*ones(size(classes)), classes, 'interpreter', 'none', 'horizontalalignment', 'right', 'rotation', 45) 
set(gca, 'position', [ 0.13 0.35 0.8 0.6])
legend('Pd', 'Pr')
title('score threshold = 0')

figure(5) 
boxplot(max(Sfit'),b.Y)
ylabel('Out-of-bag winning scores')
set(gca, 'xtick', 1:length(classes), 'xticklabel', [], 'ylim', [0 1])
text(1:length(classes), -.1*ones(size(classes)), classes, 'interpreter', 'none', 'horizontalalignment', 'right', 'rotation', 45) 
set(gca, 'position', [ 0.13 0.35 0.8 0.6])
hold on, plot(1:length(classes), maxthre, '*g')
title('score threshold = 0')
lh = legend('optimal threshold score'); set(lh, 'fontsize', 10)

figure(6)
cplot = zeros(size(c1)+1);
cplot(1:length(classes),1:length(classes)) = c1;
%pcolor(log10(cplot))
pcolor(cplot)
set(gca, 'ytick', 1:length(classes), 'yticklabel', [])
text( -text_offset+ones(size(classes)),(1:length(classes))+.5, classes, 'interpreter', 'none', 'horizontalalignment', 'right', 'rotation', 0)
set(gca, 'xtick', 1:length(classes), 'xticklabel', [])
text((1:length(classes))+.5, -text_offset+ones(size(classes)), classes, 'interpreter', 'none', 'horizontalalignment', 'right', 'rotation', 45) 
axis square, colorbar, caxis([0 maxn])
title('manual vs. classifier; score threshold = 0')

%after applying the optimal threshold
t = repmat(maxthre,length(Yfit),1);
win = (Sfit > t);
[i,j] = find(win);
Yfit_max = NaN(size(Yfit));
Yfit_max(i) = j;
ind = find(sum(win')>1);
for count = 1:length(ind),
    %    ii = find(win(ind(count),:));
    [~,Yfit_max(ind(count))] = max(Sfit(ind(count),:));
end;
ind = find(isnan(Yfit_max));
Yfit_max(ind) = length(classes)+1; %unclassified set to last class
ind = find(Yfit_max);
classes2 = [classes; 'unclassified'];
[c3, gord] = confusionmat(b.Y,classes2(Yfit_max));
total = sum(c3')';
[TP TN FP FN] = conf_mat_props(c3);

Pd3 = TP./(TP+FN); %probability of detection
Pr3 = TP./(TP+FP); %precision = TP/(TP+FP) = diag(c1)./sum(c1)'
disp('error rate for all classifications (optimal score threshold):')
disp(1-sum(TP)./sum(total))
Pm3 = c3(:,end)./total;

disp('fraction unclassified:')
disp(length(find(Yfit_max==length(classes2)))./length(Yfit_max))
c3b = c3(1:end-1,1:end-1); %ignore the instances in 'unknown'
total = sum(c3b')';
[TP TN FP FN] = conf_mat_props(c3b);
disp('error rate for accepted classifications (optimal score threshold):')
disp(1-sum(TP)./sum(total))

figure(8) 
bar([Pd3 Pr3 Pm3])
title('optimal score threshold')
set(gca, 'xtick', 1:length(classes2), 'xticklabel', [])
text(1:length(classes2), -text_offset.*ones(size(classes2)), classes2, 'interpreter', 'none', 'horizontalalignment', 'right', 'rotation', 45)
set(gca, 'position', [ 0.13 0.35 0.8 0.6])
legend('Pd', 'Pr', 'Pmissed')
set(gca, 'position', [ 0.13 0.35 0.8 0.6])

figure(9)
cplot = zeros(size(c3)+1);
cplot(1:length(classes2),1:length(classes2)) = c3;
%pcolor(log10(cplot))
pcolor(cplot)
set(gca, 'ytick', 1:length(classes2), 'yticklabel', [])
text( -text_offset+ones(size(classes2)),(1:length(classes2))+.5, classes2, 'interpreter', 'none', 'horizontalalignment', 'right', 'rotation', 0)
set(gca, 'xtick', 1:length(classes), 'xticklabel', [])
text((1:length(classes2))+.5, -text_offset+ones(size(classes2)), classes2, 'interpreter', 'none', 'horizontalalignment', 'right', 'rotation', 45) 
axis square, colorbar, caxis([0 maxn])
title('manual vs. classifier; optimal score threshold')

end