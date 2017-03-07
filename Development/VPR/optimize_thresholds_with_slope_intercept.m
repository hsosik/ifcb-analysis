clear all
load('\\sosiknas1\Lab_data\VPR\NBP1201\vpr8\class_RossSea_Trees_30Oct2015_six_classes\classpath_div\summary\summary_allTB');
decimal = filelistTB(:,17:18);
decimal = str2num(decimal);
ind3 = find(decimal ==1);
m = load('\\SOSIKNAS1\Lab_data\VPR\NBP1201\manual\summary\count_manual_12Nov2015'); 


manual_results = zeros(size(m.classcount,1),(size(classcountTB,2)));
% 
%    'blurry_marSnow'
%     'phae2all'
%     'phaeIndiv'
%     'phaeMany'
%     'squashed'
%     'whiteout'
%     'unclassified'
    
load('\\sosiknas1\Lab_data\VPR\NBP1201\classifiers\RossSea_Trees_30Oct2015_six_classes');

[Yfit,Sfit,Sstdfit] = oobPredict(b);
[mSfit, ii] = max(Sfit');
for count = 1:length(mSfit), mSstdfit(count) = Sstdfit(count,ii(count)); t(count)= Sfit(count,ii(count)); end; 
if isempty(find(mSfit-t)), clear t, else disp('check for error...'); end;
[c1, gord1] = confusionmat(b.Y,Yfit); %transposed from mine
clear t

t = repmat(adhocthresh',length(Yfit),1);
t= t(:,1:end-1);
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

%False discovery rate - fdr
FDR = (sum(c3)' - diag(c3))./sum(c3)'; %intercept for categories that don't have enough (False discovery rate)
Pd = diag(c3)./sum(c3')';%slope for those categories (maybe try for white out, too)



load \\RASPBERRY\d_work\IFCB1\code_git\ifcb-analysis\Development\VPR\class_table_vpr
for i = 1:length(class2useTB);
ind2 = strmatch(class2useTB(i), class_table_vpr.class2useTB, 'exact');
manual_results(:,i) = sum(m.classcount(:,ind2),2);
end

classcountTB_optimized = zeros(size(classcountTB_above_adhocthresh));
figure
for ii = [1 2 5 6];
%for ii = 1:(length(class2useTB)-1);
    x = manual_results(:,ii);
    y = classcountTB_above_adhocthresh(ind3,ii);
   stats = fitlm(x,y);
   intercept = stats.Coefficients.Estimate(1);
   intercept_temp = repmat(intercept, size(classcountTB_above_adhocthresh, 1), 1);
   slope = stats.Coefficients.Estimate(2);
   temp = (classcountTB_above_adhocthresh(:,ii) - intercept_temp).*(1/slope);
   classcountTB_optimized(:,ii) = temp;
   subplot(3,2,ii)
   plot(x,y, '.')
   title(class2useTB(ii))
end

for ii = [3 4];
   intercept = FDR(ii);
   intercept_temp = repmat(intercept, size(classcountTB_above_adhocthresh, 1), 1);
   slope = Pd(ii);
   %temp = (classcountTB_above_adhocthresh(:,ii) - intercept_temp).*(1/slope);
   temp = (classcountTB_above_adhocthresh(:,ii) - intercept_temp.*classcountTB_above_adhocthresh(:,ii))./slope;
   classcountTB_optimized(:,ii) = temp;
   subplot(3,2,ii)
   plot(x,y, '.')
   title(class2useTB(ii))
end

figure

for k = 1:(length(class2useTB)-1)
subplot(3,2,k);
hold on;
plot(classcountTB_above_adhocthresh(:,k), 'g.');
plot(ind3, manual_results(:,k), 'r*', 'markerSize', 7);
plot(classcountTB_optimized(:,k), 'k.');
plot(ind3, classcountTB_optimized(ind3,k), 'mo', 'markerSize', 7);
   title(class2useTB(k))
   legend('adhoc', 'manual', 'optimized');
end




    
    
    
    
 