load ('\\raspberry\d_work\IFCB1\ifcb_data_mvco_jun06\Manual_fromClass\summary\count_manual_current_day')
%load ('\\raspberry\d_work\IFCB1\ifcb_data_mvco_jun06\Manual_fromClass\summary\count_manual_16Nov2013_day')
[ ind_Gdel, class_label ] = get_G_delicatula_ind( class2use, class2use );
ind14 = find(~isnan(ml_analyzed_mat_bin(:,14)) | nansum(ml_analyzed_mat_bin,2) == 0);

%X2,Y2,Z2 for total G.del concentration
X2 = matdate_bin(ind14);
Y2 = sum((classcount_bin(ind14,ind_Gdel)./ml_analyzed_mat_bin(ind14,ind_Gdel)),2);
Z2 = cumtrapz(X2,Y2); %running integral

proportion_infected = (((classcount_bin(:,59)./ml_analyzed_mat_bin(:,59)))./...
   ((classcount_bin(:,59)./ml_analyzed_mat_bin(:,59))+(classcount_bin(:,14)./ml_analyzed_mat_bin(:,14))+(classcount_bin(:,60)./ml_analyzed_mat_bin(:,60))));
%X1,Y1,Z1 for proportion infected
X1 = matdate_bin(ind14);
Y1 = proportion_infected(ind14)*100;
ii = find(isnan(Y1)); X1(ii) = []; Y1(ii) = []; clear ii
Z1 = cumtrapz(X1,Y1); %running integral

%find some blooms
isgt5 = (Y2>5); %flag any time point >5 ml-1
%find transition points to above or below 2 ml-1
ii = find(diff(Y2-2==abs(Y2-2))==1); 
ii2 = find(diff(Y2-2==abs(Y2-2))==-1);
%isgt5(ii(1:end-1):ii2(2:end));
%flag any set of times where it stays >2 ml-1 and at least one time is >5 ml-1
keep = zeros(size(Y2));
for c = 1:length(ii)-1, 
    if sum(isgt5(ii(c):ii2(c+1)))>1, 
        keep(ii(c)+1:ii2(c+1)) = 1; 
    end;
end;
    
%look at this to check the results
U = [Y2 Y2-5==abs(Y2-5) Y2-2==abs(Y2-2) keep];

%find the start and stop indices for events
start2 = find(diff(keep)==1)+1;
stop2 = find(diff(keep)==-1);
[start2 stop2];

%merge events that are <= 7 days apart
iii = find(X2(start2(2:end))-X2(stop2(1:end-1)) <=7);
while ~isempty(iii)
    stop2(iii(1)) = stop2(iii(1)+1);
    start2(iii(1)+1) = []; stop2(iii(1)+1) = [];
    iii = find(X2(start2(2:end))-X2(stop2(1:end-1)) <=7);
end;

%remove the 2008 cases with gaps
ind = find(X2(start2) > datenum('12-1-2007') & X2(start2) < datenum('12-1-2008'));
start2(ind) = [];  
stop2(ind) = [];
start2 = start2-1; %add one time point before
stop2 = stop2+1; %add one time point after
ind = find(X2 == datenum('12-20-2006'));
start2(1) = ind; %adhoc fix for problem with first bloom start including a point before a big gap
[X2(start2) X2(stop2)]


%find the indices for the same start/stop times in series 1 (%infected)
start1 = nan(size(start2));
stop1 = start1;
for ii = 1:length(start2),
    [~,a] = min(abs(X2(start2(ii)) - X1));
    start1(ii) = a;
    [~,a] = min(abs(X2(stop2(ii)) - X1));
    stop1(ii) = a;
end;

%get integrated values for each event
%bloom_int1 = (Z1(stop1)-Z1(start1));  %integrated infection rate
bloom_int1 = (Z1(stop1)-Z1(start1))./(X1(stop1)-X1(start1)); %weighted average infection rate
bloom_int2 = Z2(stop2)-Z2(start2); %integrated G. del concentration

[ra,p] = corrcoef(bloom_int1,bloom_int2); %two-tailed
ra = ra(2); p = p(2);

%non-winter indices
v = datevec(X2(start2));
ind = find(v(:,2) > 4 & v(:,2) < 10);

figure
set(gcf, 'units', 'inches')
set(gcf, 'position', [1 2 7.5 6], 'paperposition', [1 1 7.5 6]);
plot(bloom_int1, bloom_int2, 'k.', 'MarkerSize',20)
%hold on
%plot(bloom_int1(ind), bloom_int2(ind), 'r.', 'MarkerSize',20)
%lh = legend('winter', 'non-winter', 'location', 'northeast');
%set(lh, 'fontsize', 14, 'box', 'off')
set(gca, 'FontSize', 20)
ylabel('Integrated \it{G. delicatula}\rm (chains ml^{ -1} d)', 'FontSize',20)
xlabel('Average infection rate (%)', 'FontSize',20)
axis square
midpoint = mean([X2(start2) X2(stop2)],2); 
ind = find(bloom_int1 < .1);
th1 = text(bloom_int1(ind)+.1, bloom_int2(ind)+150,datestr(midpoint(ind), 'mmm-yy'), 'fontsize', 14);
ind = find(bloom_int1 >= .1 & bloom_int1 <= 8);
th2 = text(bloom_int1(ind), bloom_int2(ind)+150,datestr(midpoint(ind), 'mmm-yy'), 'fontsize', 14);
ind = find(bloom_int1 > 8);
th3 = text(bloom_int1(ind)-.6, bloom_int2(ind)+150,datestr(midpoint(ind), 'mmm-yy'), 'fontsize', 14);

figure
plot(X2,Y2, '.-')
hold on
for c = 1:length(start2),
    plot(X2(start2(c):stop2(c)),Y2(start2(c):stop2(c)), 'r', 'linewidth', 2)
end;

figure
plot(X1,Y1, '.-')
hold on
for c = 1:length(start1),
    plot(X1(start1(c):stop1(c)),Y1(start1(c):stop1(c)), 'r', 'linewidth', 2)
end;

%check r excluding jul-09
[ra2,p2] = corrcoef(bloom_int1([1:2,4:end]),bloom_int2([1:2,4:end])); %
ra2 = ra2(2); p2 = p2(2);

mdl = fitlm(bloom_int2, bloom_int1); 

r_nooutlier = sqrt(mdl.Rsquared.ordinary)
%one-tailed t-test, p
p_nooutlier = mdl.Coefficients.pValue(2)/2
%test for normal distribution of residuals
%H = 0 => Do not reject the null hypothesis at the 5% significance level. 
h = kstest(mdl.Residuals.Raw)

%case without Jul-09
mdl2 = fitlm(bloom_int2([1:2,4:end]), bloom_int1([1:2,4:end]))
mdl.Rsquared.ordinary  %r-squared
p_nooutlier = mdl2.Coefficients.pValue(2)/2

mdl.Residuals.Studentized
%outlier t-test on externally studentized residuals
df = length(bloom_int1)-2; %n-2 parameters for line
p = (1-tcdf(abs(mdl.Residuals.Studentized),df))*2
outlier = find(p<0.05)
p_outlier = p(outlier)
datestr(midpoint(outlier))

%permutation test to estimate one-tailed p
%[pval, corr_obs, crit_corr, est_alpha]=mult_comp_perm_corr(bloom_int2,bloom_int1,1e5,-1);
%pval % one-tailed for negative

%case without Jul-09
%[pval, corr_obs, crit_corr, est_alpha]=mult_comp_perm_corr(bloom_int2([1:2,4:end]),bloom_int1([1:2,4:end]),1e5,-1);
%pval % one-tailed for negative

%my permutation test
% n = length(bloom_int2);
% nperm = 10000;
% for c = 1:nperm,
%     ri1 = randperm(n);
%     ri2 = randperm(n);
%     x = bloom_int1(ri1); y = bloom_int2(ri2);
%     temp = corrcoef(x,y);
%     r3(c) = temp(2);
% end;
% 
% length(find(r3<ra))/nperm %p
