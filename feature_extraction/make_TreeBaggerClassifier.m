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

h = histc(Pd, [0:.1:1]); b = 0:10:100;
bar(fliplr(b)+5,cumsum(flipud(h)/length(Pd)),'width', 1)
set(gca, 'xtick', 0:10:100, 'xlim', [-5 105], 'xdir', 'rev')
cumsum(flipud(h./length(Pd)))
fliplr(b)*100-10