%run compile_train_features3.m to generate train and class_vector
load compiled_train_mvco
datestring = datestr(now, 'ddmmmyyyy');

%%class_vector = classes(class_vector);
disp('Growing trees...please be patient')
%b = TreeBagger(300,train,class_vector,'Method','c','OOBVarImp','on','MinLeaf',1);

matlabpool
paroptions = statset('UseParallel','always');
%tic, b = TreeBagger(300,train,class_vector,'Method','c','OOBVarImp','on','MinLeaf',1,'Options',paroptions); toc
tic, b = TreeBagger(300,train,classes(class_vector),'Method','c','OOBVarImp','on','MinLeaf',1,'Options',paroptions); toc
matlabpool close
figure, hold on
plot(oobError(b), 'b-');
xlabel('Number of Grown Trees');
ylabel('Out-of-Bag Classification Error');

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

save(['MVCO_trees_' datestring],'b', 'targets', 'featitles', 'classes', 'maxthre')

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
figure, boxplot(max(Sfit'),str2num(char(b.Y)))
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
[c2all, gord] = confusionmat(str2num(char(b.Y)),Yfit_max);
c2 = c2all(2:end,2:end); %skip the unclassified row/col
total = sum(c2')';
Pd2 = diag(c2)./total; %true pos rate among accepted classifications
Pr2 = 1-(sum(c2)-diag(c2)')./total'; %precision of accepted classifications
sum(sum(c2)-diag(c2)')/sum(total)
Pm2 = (sum(c1')-sum(c2'))./sum(c1'); %miss rate (true pos in unclassified)
figure, bar([Pd2 Sp2' Pm2'])
set(gca, 'xtick', 1:length(classes), 'xticklabel', [])
text(1:length(classes), -text_offset.*ones(size(classes)), classes, 'interpreter', 'none', 'horizontalalignment', 'right', 'rotation', 45) 
set(gca, 'position', [ 0.13 0.35 0.8 0.6])
legend('true pos rate', 'Sp', 'Pmissed')
set(gca, 'position', [ 0.13 0.35 0.8 0.6])

%what difference if add back unclassified according to max score (even if below maxthre
ind = find(Yfit_max == 0);
Yfit_max(ind) = str2num(char(Yfit(ind))); %unclassified
%c2 = confusionmat(b.Y(ind),classes(Yfit_max(ind)));
[c3, gord] = confusionmat(str2num(char(b.Y)),Yfit_max);
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


return

figure, hold on
for count = 1:length(classes),
 %[fpr,tpr,thr] = perfcurve(b.Y,Sfit(:,count), num2str(count));
  [fpr,tpr,thr, acu, optrocpt] = perfcurve(b.Y,Sfit(:,count), classes{count});
  subplot(2,1,1), ph = plot(fpr,tpr, 'r');
  title(classes(count)), xlabel('False pos rate'), ylabel('True pos rate')
  %[fpr,accu,thr] = perfcurve(b.Y,Sfit(:,count), num2str(count),'ycrit','accu');
  [fpr,accu,thr] = perfcurve(b.Y,Sfit(:,count), classes{count},'ycrit','accu');
  subplot(2,1,2), hold off, ph2 = plot(thr,accu, 'g'); 
  hold on, ph3 = plot(thr, 1-fpr, 'r'); legend('accuracy', '1-false pos rate')
  set(ph, 'color', 'k'), set(gca, 'ylim', [max(accu)*.99 1])
%  [maxaccu(count),iaccu] = max(accu);
%  maxthre(count) = thr(iaccu);
  maxthre(count) = thr(find(fpr == optrocpt(1) & tpr == optrocpt(2)));
  line(maxthre(count)*[1 1], ylim, 'linestyle', ':')
  xlabel('Threshold for ''good'' Returns');
  subplot(2,1,1), hold on, plot(fpr(iaccu), tpr(iaccu), 'g*')
  disp([fpr(iaccu), tpr(iaccu), maxthre(count)])
  pause
end;


%num_correct = length(find(b.Y==Yfit_max))
%num_nanincorrect = length(find(b.Y~=Yfit_max))
num_nan = length(find(isnan(Yfit_max)))
num_wrong = num_nanincorrect-num_nan
acc = num_correct./(num_correct+num_wrong)
unk_rate = num_nan./(num_correct+num_nanincorrect)
sum(c')-sum(c2') %num unknown per 

figure
h = histc(Pd, [0:.1:1]); b = 0:10:100;
bar(fliplr(b)+5,cumsum(flipud(h)/length(Pd)),'width', 1)
set(gca, 'xtick', 0:10:100, 'xlim', [-5 105], 'xdir', 'rev')
cumsum(flipud(h./length(Pd)))'
fliplr(b)
