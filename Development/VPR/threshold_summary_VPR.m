clear all
load('\\sosiknas1\Lab_data\VPR\NBP1201\vpr8\class_RossSea_Trees_30Oct2015_six_classes\classpath_div\summary\summary_allTB');
decimal = filelistTB(:,17:18);
decimal = str2num(decimal);
ind = find(decimal ==1);
class2plot = 'phaeMany';%'squashed' 'phaeMany23' 'whiteout' 'phaeMany'  'phaeIndivAll' 'phaeIndiv'  'phae2all'  'phaeManyMix'

load(['\\sosiknas1\Lab_data\VPR\NBP1201\vpr8\class_RossSea_Trees_30Oct2015_six_classes\classpath_div\summary_by_thre\summary_allTB_bythre_' class2plot]);
m = load('\\SOSIKNAS1\Lab_data\VPR\NBP1201\manual\summary\count_manual_30Oct2015'); 

goodm = 1:length(m.filelist);%find(~isnan(m.ml_analyzed_mat(:,imclass)));
%[~,im,it] = intersect(m.filelist.(goodm), filelistTB(ind));
%im = goodm(im);
im= goodm;
it = ind;
d = 0; %0
figure(1+d), clf


if strmatch(class2plot, 'squashed', 'exact')
   imclass = strmatch(class2plot, m.class2use, 'exact'); %'squashed' 'phaeMany23' 'whiteout' 'phaeMany'  'phaeIndivAll'
   x = m.classcount(im,imclass);
end

if strmatch(class2plot, 'blurry_marSnow', 'exact')
       imclass1 = strmatch('blurry', m.class2use, 'exact');
   imclass2 = strmatch('marSnow', m.class2use, 'exact'); %'squashed' 'phaeMany23' 'whiteout' 'phaeMany'  'phaeIndivAll'
   x = m.classcount(im,imclass1) + m.classcount(im,imclass1);
end

if strmatch(class2plot, 'phaeIndiv', 'exact')
   imclass = strmatch(class2plot, m.class2use, 'exact'); %'squashed' 'phaeMany23' 'whiteout' 'phaeMany'  'phaeIndivAll'
   x = m.classcount(im,imclass);
end

 if strmatch(class2plot, 'whiteout', 'exact');
    imclass = strmatch(class2plot, m.class2use, 'exact'); %'squashed' 'phaeMany23' 'whiteout' 'phaeMany'  'phaeIndivAll'
    x = m.classcount(im,imclass); %all manually sorted time points
 end

  if strmatch(class2plot, 'phaeManyMix', 'exact');
    imclass = strmatch(class2plot, m.class2use, 'exact'); %'squashed' 'phaeMany23' 'whiteout' 'phaeMany'  'phaeIndivAll'
    x = m.classcount(im,imclass); %all manually sorted time points
end
        
%  if strmatch(class2plot, 'phaeMany23', 'exact')
%     imclass = strmatch(class2plot, m.class2use, 'exact'); %'squashed' 'phaeMany23' 'whiteout' 'phaeMany'  'phaeIndivAll'
%     x = m.classcount(im,imclass);
%  end
%  
  if strmatch(class2plot, 'phae2all', 'exact')
    imclass1 = strmatch('phaeIndiv2', m.class2use, 'exact');
   imclass2 = strmatch('phaeMany23', m.class2use, 'exact'); %'squashed' 'phaeMany23' 'whiteout' 'phaeMany'  'phaeIndivAll'
    x = m.classcount(im,imclass1) + m.classcount(im,imclass2);
  end


if strmatch(class2plot, 'phaeMany', 'exact')
   imclass1 = strmatch('phaeMany', m.class2use, 'exact');
   imclass2 = strmatch('phaeManyMix', m.class2use, 'exact');
   x = m.classcount(im,imclass1)% + m.classcount(im,imclass2); %all manually sorted time points
end

 if strmatch(class2plot, 'phaeIndivAll', 'exact') 
    imclass1 = strmatch('phaeIndiv', m.class2use, 'exact');
    imclass2 = strmatch('phaeIndiv2', m.class2use, 'exact');
    x = m.classcount(im,imclass1) + m.classcount(im,imclass2);
 end
        

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
    
%     figure(2+d), subplot(3,4,ii)
%     %bins = 0:1:30;
%     %[n,xbins,nbins]=histmulti5([m.classcount(im, imclass), classcountTB_above_thre(it,ii)], [bins; bins]');
%     %bins = 0:1:300;
%     bins = 0:1:7;
%     [n,xbins,nbins]=histmulti5([x, y], [bins; bins]');
%     [ix,iy,v] = find(n);
%     if ii == 1, colormax = floor(max(log10(v))); end;
%     %scatter(bins(ix),bins(iy),[],log10(v), 'filled'), line(xlim, xlim), caxis([0 colormax]); axis square
%     scatter(bins(ix),bins(iy),[],log10(v), 'filled'), line(xlim, xlim); axis square
    
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
    title(class2plot);
end;
figure(1+d)
subplot(3,4,5), ylabel('Automated')
subplot(3,4,10), xlabel('Manual')
% figure(2+d)
% subplot(3,4,5), ylabel('Automated')
% subplot(3,4,10), xlabel('Manual')
figure 
subplot(2,2,1), plot(threlist, Rsq, '.-'), xlabel('threshold score'), ylabel('r^2')%, line([.7 .7], ylim, 'color', 'r')
subplot(2,2,2), plot(threlist, Coeffs(:,1), '.-'), xlabel('threshold score'), ylabel('y-intercept')%, line([.7 .7], ylim, 'color', 'r')
subplot(2,2,3), plot(threlist, Coeffs(:,2), '.-'), xlabel('threshold score'), ylabel('slope')%, line([.7 .7], ylim, 'color', 'r')
subplot(2,2,4), plot(threlist, RMSE, '.-'), xlabel('threshold score'), ylabel('RMSE')%, line([.7 .7], ylim, 'color', 'r')



%to calculate what percentage of the classifier counts are within a poisson
% %confidence interval of the manual counts
% ii = 8; %for threshold = .7
%  [ mdate_mat, y_mat, yearlist, yd ] = timeseries2ydmat_sum( m.matdate(im), m.classcount(im,imclass) );
%  x = y_mat(:);
% %[matdate_bin, classcount_bin, ml_analyzed_mat_bin] = make_hour_bins(m.matdate(im),m.classcount(im,imclass), m.ml_analyzed_mat(im,imclass));
% %x=classcount_bin;
%  [ mdate_mat, y_mat, yearlist, yd ] = timeseries2ydmat_sum( mdateTB(it), classcountTB_above_thre(it,ii) );
%  y = y_mat(:);
% %[matdate_bin, classcount_bin, ml_analyzed_mat_bin] = make_hour_bins(mdateTB(it), classcountTB_above_thre(it,ii), ml_analyzedTB(it));
% %y=classcount_bin;
% cix=poisson_count_ci(x,0.95);
% good = length(find(y>=cix(:,1) & y <= cix(:,2)));
% bad = length(find(y<cix(:,1) | y > cix(:,2)));
% myall = length(find(~isnan(x)));
% %check good+bad = all
% faction_inside_ci=good/myall; %fraction inside conf interval
% %%
