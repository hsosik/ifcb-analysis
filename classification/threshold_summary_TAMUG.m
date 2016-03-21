load \\Dq-cytobot-pc\IFCB\class_TAMUG_Trees_15Jul2015\summary\summary_allTB_bythre_Flagellate_MIX
%m = load('\\Dq-cytobot-pc\IFCB\manual\summary\count_manual_28Jul2015');
load('\\Dq-cytobot-pc\IFCB\manual\summary\count_manual_28Jul2015')
imclass = strmatch('Flagellate_MIX', m.class2use);
goodm = find(~isnan(m.ml_analyzed_mat(:,imclass)));
[~,im,it] = intersect(m.filelist(goodm), filelistTB);
im = goodm(im);
d = 0; %0
figure(1+d), clf
x = m.classcount(im,imclass); %all manually sorted time points
%[ mdate_mat, y_mat, yearlist, yd ] = timeseries2ydmat_sum( m.matdate(im), m.classcount(im,imclass) );
%x = y_mat(:); %manually sorted time points-daily
%[matdate_bin, classcount_bin, ml_analyzed_mat_bin] = make_hour_bins(m.matdate(im),m.classcount(im,imclass), m.ml_analyzed_mat(im,imclass));
%x=classcount_bin; % manually sorted time points-hourly
for ii = 1:length(threlist),
    
%    all classifier time points
    y = classcountTB_above_thre(it,ii); 
    
    % classifier time points- daily
    %[ mdate_mat, y_mat, yearlist, yd ] = timeseries2ydmat_sum( mdateTB(it), classcountTB_above_thre(it,ii) );
    %y = y_mat(:);
    
    %using abundance rather than counts
    % x = m.classcount(im,imclass)./m.ml_analyzed_mat(im,imclass); y = classcountTB_above_thre(it,ii)./ml_analyzedTB(it);


    % classifier time points- hourly
    % [matdate_bin, classcount_bin, ml_analyzed_mat_bin] = make_hour_bins(mdateTB(it), classcountTB_above_thre(it,ii), ml_analyzedTB(it));
    % y=classcount_bin;
    
    figure(2+d), subplot(3,4,ii)
    %bins = 0:1:30;
    %[n,xbins,nbins]=histmulti5([m.classcount(im, imclass), classcountTB_above_thre(it,ii)], [bins; bins]');
    bins = 0:1:300;
    [n,xbins,nbins]=histmulti5([x, y], [bins; bins]');
    [ix,iy,v] = find(n);
    if ii == 1, colormax = floor(max(log10(v))); end;
    scatter(bins(ix),bins(iy),[],log10(v), 'filled'), line(xlim, xlim), caxis([0 colormax]); axis square
    figure(1+d), subplot(3,4,ii), hold on
    plot(x,y, '.')
    axis square
    line(xlim, xlim)
    lin_fit{ii} = fitlm(x,y);
    Rsq(ii) = lin_fit{ii}.Rsquared.ordinary;
    Coeffs(ii,:) = lin_fit{ii}.Coefficients.Estimate;
    coefPs(ii,:) = lin_fit{ii}.Coefficients.pValue;
    RMSE(ii) = lin_fit{ii}.RMSE;
    eval(['fplot(''x*' num2str(Coeffs(ii,2)) '+' num2str(Coeffs(ii,1)) ''' , xlim, ''color'', ''r'')'])
    axis([0 inf 0 inf])
end;
figure(1+d)
subplot(3,4,5), ylabel('Automated')
subplot(3,4,10), xlabel('Manual')
figure(2+d)
subplot(3,4,5), ylabel('Automated')
subplot(3,4,10), xlabel('Manual')
figure 
subplot(2,2,1), plot(threlist, Rsq, '.-'), xlabel('threshold score'), ylabel('r^2')%, line([.7 .7], ylim, 'color', 'r')
subplot(2,2,2), plot(threlist, Coeffs(:,1), '.-'), xlabel('threshold score'), ylabel('y-intercept')%, line([.7 .7], ylim, 'color', 'r')
subplot(2,2,3), plot(threlist, Coeffs(:,2), '.-'), xlabel('threshold score'), ylabel('slope')%, line([.7 .7], ylim, 'color', 'r')
subplot(2,2,4), plot(threlist, RMSE, '.-'), xlabel('threshold score'), ylabel('RMSE')%, line([.7 .7], ylim, 'color', 'r')



%to calculate what percentage of the classifier counts are within a poisson
%confidence interval of the manual counts
ii = 8; %for threshold = .7
 [ mdate_mat, y_mat, yearlist, yd ] = timeseries2ydmat_sum( m.matdate(im), m.classcount(im,imclass) );
 x = y_mat(:);
%[matdate_bin, classcount_bin, ml_analyzed_mat_bin] = make_hour_bins(m.matdate(im),m.classcount(im,imclass), m.ml_analyzed_mat(im,imclass));
%x=classcount_bin;
 [ mdate_mat, y_mat, yearlist, yd ] = timeseries2ydmat_sum( mdateTB(it), classcountTB_above_thre(it,ii) );
 y = y_mat(:);
%[matdate_bin, classcount_bin, ml_analyzed_mat_bin] = make_hour_bins(mdateTB(it), classcountTB_above_thre(it,ii), ml_analyzedTB(it));
%y=classcount_bin;
cix=poisson_count_ci(x,0.95);
good = length(find(y>=cix(:,1) & y <= cix(:,2)));
bad = length(find(y<cix(:,1) | y > cix(:,2)));
myall = length(find(~isnan(x)));
%check good+bad = all
faction_inside_ci=good/myall; %fraction inside conf interval
%%
