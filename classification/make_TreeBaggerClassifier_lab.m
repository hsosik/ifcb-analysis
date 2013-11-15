%run compile_train_features3.m to generate train and class_vector
savedir = '\\queenrose\E_work\Brosnahan_Temp\';
load([savedir 'compiled_train_lab'])
datestring = datestr(now, 'ddmmmyyyy');

%%class_vector = classes(class_vector);
disp('Growing trees...please be patient')
%b = TreeBagger(300,train,class_vector,'Method','c','OOBVarImp','on','MinLeaf',1);

matlabpool
paroptions = statset('UseParallel','always');
%tic, b = TreeBagger(300,train,class_vector,'Method','c','OOBVarImp','on','MinLeaf',1,'Options',paroptions); toc
tic, b = TreeBagger(40,train,classes(class_vector),'Method','c','OOBVarImp','on','MinLeaf',1,'Options',paroptions); toc
matlabpool close
figure, hold on
plot(oobError(b), 'b-');
xlabel('Number of grown trees', 'fontsize', 16);
ylabel('Out-of-bag classification error', 'fontsize', 16);

%b = growTrees(b,250); %specify how many to add
%plot(oobError(b), 'g');

[Yfit,Sfit,Sstdfit] = oobPredict(b);
[mSfit, ii] = max(Sfit');
for count = 1:length(mSfit), mSstdfit(count) = Sstdfit(count,ii(count)); t(count)= Sfit(count,ii(count)); end; 
if isempty(find(mSfit-t)), clear t, else disp('check for error...'); end;
c1 = confusionmat(b.Y,Yfit); %transposed from mine

for count = 1:length(classes),
 %[fpr,accu,thr] = perfcurve(b.Y,Sfit(:,count), num2str(count),'ycrit','accu');
  [fpr,accu,thr] = perfcurve(b.Y,Sfit(:,count), classes{count},'ycrit','accu');
 [maxaccu(count),iaccu] = max(accu);
 maxthre(count) = thr(iaccu);
end;
clear count fpr tpr thr iaccu accu

save([savedir 'lab_trees_' datestring],'b', 'targets', 'featitles', 'classes', 'maxthre')

total = sum(c1')';
Pd = diag(c1)./total;
Pr = 1-(sum(c1)-diag(c1)')./total'; %precision
disp('overall error rate:')
disp(sum(sum(c1)-diag(c1)')/sum(total))
text_offset = .1;
figure, bar([total diag(c1) sum(c1)'-diag(c1)])
legend('total in set', 'true pos', 'false pos')
set(gca, 'xtick', 1:length(classes), 'xticklabel', [])
text(1:length(classes), -text_offset.*ones(size(classes)), classes, 'interpreter', 'none', 'horizontalalignment', 'right', 'rotation', 45) 
set(gca, 'position', [ 0.13 0.35 0.8 0.6])
figure, bar([Pd Pr'])
set(gca, 'xtick', 1:length(classes), 'xticklabel', [])
text(1:length(classes), -text_offset.*ones(size(classes)), classes, 'interpreter', 'none', 'horizontalalignment', 'right', 'rotation', 45) 
set(gca, 'position', [ 0.13 0.35 0.8 0.6])
legend('Pd', 'Pr')
figure, boxplot(max(Sfit'),(char(b.Y)))
ylabel('Out-of-bag winning scores')
set(gca, 'xtick', 1:length(classes), 'xticklabel', [])
text(1:length(classes), -text_offset.*ones(size(classes)), classes, 'interpreter', 'none', 'horizontalalignment', 'right', 'rotation', 45) 
set(gca, 'position', [ 0.13 0.35 0.8 0.6])
hold on, plot(1:length(classes), maxthre, '*g')

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
Yfit_max(ind) = 0; %unclassified
%c2 = confusionmat(b.Y(ind),classes(Yfit_max(ind)));
ind = find(Yfit_max);
[c2, gord] = confusionmat(b.Y(ind),classes(Yfit_max(ind)));
%[c2all, gord] = confusionmat(str2num(char(b.Y)),Yfit_max);
%c2 = c2all(2:end,2:end); %skip the unclassified row/col
total = sum(c2')';
Pd2 = diag(c2)./total; %true pos rate among accepted classifications
Pr2 = 1-(sum(c2)-diag(c2)')./total'; %precision of accepted classifications
sum(sum(c2)-diag(c2)')/sum(total)
Pm2 = (sum(c1')-sum(c2'))./sum(c1'); %miss rate (true pos in unclassified)
figure, bar([Pd2 Pr2' Pm2'])
set(gca, 'xtick', 1:length(classes), 'xticklabel', [])
text(1:length(classes), -text_offset.*ones(size(classes)), classes, 'interpreter', 'none', 'horizontalalignment', 'right', 'rotation', 45) 
set(gca, 'position', [ 0.13 0.35 0.8 0.6])
legend('true pos rate', 'Sp', 'Pmissed')
set(gca, 'position', [ 0.13 0.35 0.8 0.6])

return
%what difference if add back unclassified according to max score (even if below maxthre
ind = find(Yfit_max == 0);
Yfit_max(ind) = str2num(char(Yfit(ind))); %unclassified
c3 = confusionmat(b.Y(ind),classes(Yfit_max(ind)));
%[c3, gord] = confusionmat(str2num(char(b.Y)),Yfit_max);
%c2 = c2all(2:end,2:end); %skip the unclassified row/col
total = sum(c3')';
Pd3 = diag(c3)./total; %true pos rate among accepted classifications
Pr3 = 1-(sum(c3)-diag(c3)')./total'; %specificity of accepted classifications
sum(sum(c3)-diag(c3)')/sum(total)
Pm3 = (sum(c1')-sum(c3'))./sum(c1'); %miss rate (true pos in unclassified)
figure, bar([Pd3 Sp3' Pm3'])
set(gca, 'xtick', 1:length(classes), 'xticklabel', [])
text(1:length(classes), -text_offset.*ones(size(classes)), classes, 'interpreter', 'none', 'horizontalalignment', 'right', 'rotation', 45) 
set(gca, 'position', [ 0.13 0.35 0.8 0.6])
legend('true pos rate', 'Sp', 'Pmissed')
set(gca, 'position', [ 0.13 0.35 0.8 0.6])

