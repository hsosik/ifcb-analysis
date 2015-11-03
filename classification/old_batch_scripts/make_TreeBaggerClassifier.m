%run compile_train_features3.m to generate train and class_vector
load compiled_train
datestring = datestr(now, 'ddmmmyyyy');

%class_vector = classes(class_vector);
disp('Growing trees...please be patient')
b = TreeBagger(300,train,class_vector,'Method','c','OOBVarImp','on','MinLeaf',1);
figure, hold on
plot(oobError(b), 'b-');
xlabel('Number of Grown Trees');
ylabel('Out-of-Bag Classification Error');

%b = growTrees(b,250); %specify how many to add
%plot(oobError(b3), 'g');
save(['MVCO_trees_' datestring],'b', 'targets', 'featitles', 'classes')

[Yfit,Sfit] = oobPredict(b);  
c1 = confusionmat(b.Y,Yfit); %transposed from mine

total = sum(c1')';
Pd = diag(c1)./total;
Sp = 1-(sum(c1)-diag(c1)')./total';
sum(sum(c1)-diag(c1)')/sum(total)
text_offset = .1;
figure, bar([total diag(c1) sum(c1)'-diag(c1)])
legend('total in set', 'detected', 'wrong')
set(gca, 'xtick', 1:length(classes), 'xticklabel', [])
text(1:length(classes), -text_offset.*ones(size(classes)), classes, 'interpreter', 'none', 'horizontalalignment', 'right', 'rotation', 45) 
set(gca, 'position', [ 0.13 0.35 0.8 0.6])
figure, bar([Pd Sp'])
set(gca, 'xtick', 1:length(classes), 'xticklabel', [])
text(1:length(classes), -text_offset.*ones(size(classes)), classes, 'interpreter', 'none', 'horizontalalignment', 'right', 'rotation', 45) 
set(gca, 'position', [ 0.13 0.35 0.8 0.6])
legend('Pd', 'Sp')

figure
h = histc(Pd, [0:.1:1]); b = 0:10:100;
bar(fliplr(b)+5,cumsum(flipud(h)/length(Pd)))
set(gca, 'xtick', 0:10:100, 'xlim', [-5 105], 'xdir', 'rev')
cumsum(flipud(h./length(Pd)))'
fliplr(b)

figure, hold on
for count = 1:length(classes),
 [fpr,tpr,thr] = perfcurve(b.Y,Sfit(:,count), classes{count});
  subplot(2,1,1), ph = plot(fpr,tpr, 'r');
  title(classes(count)), xlabel('False pos rate'), ylabel('True pos rate')
  [fpr,accu,thr] = perfcurve(b.Y,Sfit(:,count), classes{count},'ycrit','accu');
  subplot(2,1,2), hold off, ph2 = plot(thr,accu, 'g'); 
  hold on, ph3 = plot(thr, 1-fpr, 'r'); legend('accuracy', '1-false pos rate')
  set(ph, 'color', 'k'), set(gca, 'ylim', [max(accu)*.99 1])
  [maxaccu(count),iaccu] = max(accu);
  maxthre(count) = thr(iaccu);
  line(maxthre(count)*[1 1], ylim, 'linestyle', ':')
  xlabel('Threshold for ''good'' Returns');
  subplot(2,1,1), hold on, plot(fpr(iaccu), tpr(iaccu), 'g*')
  pause
end;


t = repmat(maxthre,length(Yfit),1);
win = (Sfit > t);
[i,j] =find(win);
Yfit_max = NaN(size(Yfit));
Yfit_max(i) = j;
ind = find(sum(win')>1);
for count = 1:length(ind),
    ii = find(win(ind(count),:));
    [~,Yfit_max(ind(count))] = max(Sfit(ind(count),:));
end;

ind = find(~isnan(Yfit_max));
c2 = confusionmat(b.Y(ind),classes(Yfit_max(ind)));
total = sum(c2')';
Pd2 = diag(c2)./total;
Sp2 = 1-(sum(c2)-diag(c2)')./total';
sum(sum(c2)-diag(c2)')/sum(total)
Pm2 = (sum(c1')-sum(c2'))./sum(c1');
figure, bar([Pd2 Sp2' Pm2'])

%num_correct = length(find(b.Y==Yfit_max))
%num_nanincorrect = length(find(b.Y~=Yfit_max))
num_nan = length(find(isnan(Yfit_max)))
num_wrong = num_nanincorrect-num_nan
acc = num_correct./(num_correct+num_wrong)
unk_rate = num_nan./(num_correct+num_nanincorrect)
sum(c')-sum(c2') %num unknown per 

