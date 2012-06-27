load MVCO_trees_25Jun2012
[Yfit,Sfit] = oobPredict(b);
t = repmat(maxthre,length(Yfit),1);
win = (Sfit >= t);
[i,j] = find(win);
Yfit_max = NaN(size(Yfit));
Yfit_max(i) = j;
ind = find(sum(win')>1);
for count = 1:length(ind),
    ii = find(win(ind(count),:));
    [~,Yfit_max(ind(count))] = max(Sfit(ind(count),:));
end;

t = find(isnan(Yfit_max));
for ii = 1780:length(t),
    img = imread(['http://ifcb-data.whoi.edu/mvco/' targets{t(ii)}]); imshow(img)
    title([b.Y{t(ii)} '; max: ' Yfit{t(ii)}])
    cnum = strmatch(Yfit(t(ii)), b.ClassNames, 'exact');
    disp(['class score: ' num2str(Sfit(t(ii),cnum)) '; fit class threshold: ' num2str(maxthre(cnum)) '; max score ' num2str(max(Sfit(t(ii),:)))])
    pause
end;
