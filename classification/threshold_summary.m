load \\maddie\work\svn_repository\trunk\classification\summary_allTB_bythre_Laboea
m = load('\\raspberry\d_work\IFCB1\ifcb_data_mvco_jun06\Manual_fromClass\summary\count_manual_current'); 
imclass = strmatch('Laboea', m.class2use);
goodm = find(~isnan(m.ml_analyzed_mat(:,imclass)));
[~,im,it] = intersect(m.filelist(goodm), filelistTB);
im = goodm(im);
d = 0; %0
figure(1+d), clf
x = m.classcount(im,imclass);
%[ mdate_mat, y_mat, yearlist, yd ] = timeseries2ydmat_sum( m.matdate(im), m.classcount(im,imclass) );
%x = y_mat(:);
for ii = 1:length(threlist),
    y = classcountTB_above_thre(it,ii);
    %[ mdate_mat, y_mat, yearlist, yd ] = timeseries2ydmat_sum( mdateTB(it), classcountTB_above_thre(it,ii) );
    %y = y_mat(:);
%    x = m.classcount(im,imclass)./m.ml_analyzed_mat(im,imclass); y = classcountTB_above_thre(it,ii)./ml_analyzedTB(it);
    
    figure(2+d), subplot(3,4,ii)
    %bins = 0:1:30;
    %[n,xbins,nbins]=histmulti5([m.classcount(im, imclass), classcountTB_above_thre(it,ii)], [bins; bins]');
    bins = 0:1:300;
    [n,xbins,nbins]=histmulti5([x, y], [bins; bins]');
    [ix,iy,v] = find(n);
    scatter(bins(ix),bins(iy),[],log10(v), 'filled'), line(xlim, xlim), caxis([0 2]), axis square
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
end;
figure(1+d)
subplot(3,4,5), ylabel('Automated')
subplot(3,4,10), xlabel('Manual')
figure(2+d)
subplot(3,4,5), ylabel('Automated')
subplot(3,4,10), xlabel('Manual')
figure 
subplot(2,2,1), plot(threlist, Rsq, '.-'), xlabel('threshold score'), ylabel('r^2'), line([.7 .7], ylim, 'color', 'r')
subplot(2,2,2), plot(threlist, Coeffs(:,1), '.-'), xlabel('threshold score'), ylabel('y-intercept'), line([.7 .7], ylim, 'color', 'r')
subplot(2,2,3), plot(threlist, Coeffs(:,2), '.-'), xlabel('threshold score'), ylabel('slope'), line([.7 .7], ylim, 'color', 'r')
subplot(2,2,4), plot(threlist, RMSE, '.-'), xlabel('threshold score'), ylabel('RMSE'), line([.7 .7], ylim, 'color', 'r')




