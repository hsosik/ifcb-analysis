summary_path = 'C:\work\IFCB\user_training_test_data\class2\summary\'; %USER
class2do_string = 'Karenia,pennate_diatom,misc_nano'; %'Guinardia_striata'; %USER
m = load('C:\work\IFCB\user_training_test_data\manual_temp\summary\count_manual_28Dec2016'); %USER

load([summary_path 'summary_allTB_bythre_' class2do_string]);
ind = strfind(class2do_string, ',');
if ~isempty(ind)
    ind = [0 ind length(class2do_string)];
    for c = 1:length(ind)-1
        imclass(c) = strmatch(class2do_string(ind(c)+1:ind(c+1)-1), m.class2use);
    end
else
    imclass = strmatch(class2do_string, m.class2use);
end

if isfield(m, 'ml_analyzed_mat')
    goodm = find(~isnan(m.ml_analyzed_mat(:,imclass(1))));
    m.filelist = regexprep(m.filelist,'.mat', '')';
else
    goodm = find(~isnan(m.ml_analyzed(imclass)));
    m.filelist = regexprep({m.filelist.name},'.mat', '')';
end
[~,im,it] = intersect(m.filelist(goodm), filelistTB);
im = goodm(im);
figure(1), clf
x = sum(m.classcount(im,imclass),2); %all manually sorted time points
%[ mdate_mat, y_mat, yearlist, yd ] = timeseries2ydmat_sum( m.matdate(im), m.classcount(im,imclass) );
%x = y_mat(:); %manually sorted time points-daily
%[matdate_bin, classcount_bin, ml_analyzed_mat_bin] = make_hour_bins(m.matdate(im),m.classcount(im,imclass), m.ml_analyzed_mat(im,imclass));
%x=classcount_bin; % manually sorted time points-hourly
for ii = 1:length(threlist)
    
    %all classifier time points
    y = classcountTB_above_thre(it,ii); 
    
    % classifier time points- daily
    %[ mdate_mat, y_mat, yearlist, yd ] = timeseries2ydmat_sum( mdateTB(it), classcountTB_above_thre(it,ii) );
    %y = y_mat(:);
    
    %using concentration rather than counts
    % x = m.classcount(im,imclass)./m.ml_analyzed_mat(im,imclass); y = classcountTB_above_thre(it,ii)./ml_analyzedTB(it);

    % classifier time points- hourly
    % [matdate, classcount_bin, ml_analyzed_mat] = make_hour_bins(mdateTB(it), classcountTB_above_thre(it,ii), ml_analyzedTB(it));
    % y=classcount_bin;
    
    figure(1), subplot(3,4,ii), hold on
    plot(x,y, '.')
    axis square
    line(xlim, xlim)
    lin_fit{ii} = fitlm(x,y);
    Rsq(ii) = lin_fit{ii}.Rsquared.ordinary;
    Coeffs(ii,:) = lin_fit{ii}.Coefficients.Estimate;
    coefPs(ii,:) = lin_fit{ii}.Coefficients.pValue;
    RMSE(ii) = lin_fit{ii}.RMSE;
    eval(['fplot(@(x)x*' num2str(Coeffs(ii,2)) '+' num2str(Coeffs(ii,1)) ''' , xlim, ''color'', ''r'')'])
end;
figure(1)
subplot(3,4,5), ylabel('Automated')
subplot(3,4,10), xlabel('Manual')
figure 
subplot(2,2,1), plot(threlist, Rsq, '.-'), xlabel('threshold score'), ylabel('r^2'), line([.7 .7], ylim, 'color', 'r')
subplot(2,2,2), plot(threlist, Coeffs(:,1), '.-'), xlabel('threshold score'), ylabel('y-intercept'), line([.7 .7], ylim, 'color', 'r')
subplot(2,2,3), plot(threlist, Coeffs(:,2), '.-'), xlabel('threshold score'), ylabel('slope'), line([.7 .7], ylim, 'color', 'r')
subplot(2,2,4), plot(threlist, RMSE, '.-'), xlabel('threshold score'), ylabel('RMSE'), line([.7 .7], ylim, 'color', 'r')


%to calculate what percentage of the classifier counts are within a poisson
%confidence interval of the manual counts

chosen_threshold = 0.7; %USER

ii = find(threlist == chosen_threshold);
% [ mdate_mat, y_mat, yearlist, yd ] = timeseries2ydmat_sum( m.matdate(im), m.classcount(im,imclass) );
% x = y_mat(:);
%[matdate_bin, classcount_bin, ml_analyzed_mat_bin] = make_hour_bins(m.matdate(im),m.classcount(im,imclass), m.ml_analyzed_mat(im,imclass));
%x=classcount_bin;
% [ mdate_mat, y_mat, yearlist, yd ] = timeseries2ydmat_sum( mdateTB(it), classcountTB_above_thre(it,ii) );
% y = y_mat(:);
%[matdate_bin, classcount_bin, ml_analyzed_mat_bin] = make_hour_bins(mdateTB(it), classcountTB_above_thre(it,ii), ml_analyzedTB(it));
%y=classcount_bin;
y = classcountTB_above_thre(it,ii);
%x = m.classcount(im,imclass);
cix=poisson_count_ci(x,0.95);
good = length(find(y>=cix(:,1) & y <= cix(:,2)));
bad = length(find(y<cix(:,1) | y > cix(:,2)));
all = length(find(~isnan(x)));
%check good+bad = all
fraction_inside_ci=good/all; %fraction inside conf interval
%%
figure

for count = ii;
    handle_1=subplot(2,2,1);
    set(handle_1,'fontsize',20,'fontname','Times New Roman')
%     [matdate_bin, classcount_bin, ml_analyzed_mat_bin] = make_hour_bins(mdateTB(it), classcountTB_above_thre(it,ii), ml_analyzedTB(it));
%     y=classcount_bin;
    plot(x,y, '.')
    hold on
    axis square
    line(xlim, xlim)
    eval(['fplot(@(x)x*' num2str(Coeffs(ii,2)) '+' num2str(Coeffs(ii,1)) ''' , xlim, ''color'', ''r'')'])
    %legend(' ','1:1 line','line of best fit')
    text(5,30,' A','fontsize',20, 'fontname', 'Times New Roman')
    subplot(2,2,1), ylabel('Automated counts','fontsize',20,'fontname','Times New Roman')
    subplot(2,2,1), xlabel('Manual counts','fontsize',20,'fontname','Times New Roman')
    box(handle_1,'on');
end;
handle_2=subplot(2,2,2); plot(threlist, Rsq, '.-'), xlabel('threshold score','fontsize',20,'fontname','Times New Roman'), ylabel('r^2','fontsize',20,'fontname','Times New Roman'), line([.7 .7], ylim, 'color', 'r')
set(handle_2,'fontsize',20,'fontname','Times New Roman')
text(0.2,0.75,' B','fontsize',20, 'fontname', 'Times New Roman')
handle_3=subplot(2,2,3); plot(threlist, Coeffs(:,1), '.-'), xlabel('threshold score','fontsize',20,'fontname','Times New Roman'), ylabel('y-intercept','fontsize',20,'fontname','Times New Roman'), line([.7 .7], ylim, 'color', 'r')
set(handle_3,'fontsize',20,'fontname','Times New Roman')
text(0.1,0.5,' C','fontsize',20, 'fontname', 'Times New Roman')
%ylim([0 4])
handle_4=subplot(2,2,4); plot(threlist, Coeffs(:,2), '.-'), xlabel('threshold score','fontsize',20,'fontname','Times New Roman'), ylabel('slope','fontsize',20,'fontname','Times New Roman'), line([.7 .7], ylim, 'color', 'r')
set(handle_4,'fontsize',20,'fontname','timesnewroman')
text(0.1,0.2,' D','fontsize',20, 'fontname', 'Times New Roman')








