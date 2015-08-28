%adc_data column description
%7 = peak scatter
%8 = peak green/orange
%9 = peak chlorophyll

% feature column description
% column 43 = texture_average_contrast
% column 44 = texture_average_gray_level
% column 45 = texture_entropy
% column 46 = texture_smoothness
% column 47 = texture_third_moment
% column 48 = texture_uniformity


load '/Users/markmiller/Documents/Experiments/IFCB_14/Scut_growth_curve/Manual_fromClass/summary/count_manual_25Mar2015.mat'

ciliate_classcount=classcount(:,70);
ciliate_perml=ciliate_classcount./ml_analyzed;
ciliate_scatter=[ciliate_perml(1); ciliate_perml(3); ciliate_perml(5); ciliate_perml(7); ciliate_perml(9); ciliate_perml(11); ciliate_perml(13); ciliate_perml(15)];
ciliate_green=[ciliate_perml(2); ciliate_perml(4); ciliate_perml(6); ciliate_perml(8); ciliate_perml(10); ciliate_perml(12); ciliate_perml(14); ciliate_perml(16)];
matdate_scatter=[matdate(1); matdate(3); matdate(5); matdate(7); matdate(9); matdate(11); matdate(13); matdate(15)];
matdate_green=[matdate(2); matdate(4); matdate(6); matdate(8); matdate(10); matdate(12); matdate(14); matdate(16)];

figure
plot(matdate_green, ciliate_green,'-*','markersize',10)
hold on
%plot(matdate_scatter, ciliate_scatter,'r-*','markersize',10)
datetick('x',2)
ylabel('Cell abundance')
set(gca,'fontsize',16, 'fontname', 'times new roman')
title('Scut cell counts-green trigger')
%legend('green','scattering')

%%

even_files=[1 1 2 2 3 3 4 4 5 5 6 6 7 7 8 8];

datadir = '/Users/markmiller/Documents/Experiments/IFCB_14/Scut_growth_curve/';
filelist = dir([datadir '*.adc']);
resultdir = '/Users/markmiller/Documents/Experiments/IFCB_14/Scut_growth_curve/Manual_fromClass/';
result_filelist = dir([resultdir '*.mat']);
featuredir = '/Users/markmiller/Documents/Experiments/IFCB_14/Scut_growth_curve/features/';
feature_filelist = dir([featuredir '*.csv']);

adc_value=8; %choose which adc column you want to use

%creates structures called 'Scut_ind' (to index which rois are scuts) and
%'Green_ind (to pull out the green fluorescence values of those scuts)
for i=2:2:16;
    adcdata=importdata([datadir filelist(i).name]);
    result=importdata([resultdir result_filelist(i).name]);
    Scut_ind(even_files(i)).scut_ind=find(result.classlist(:,2)==70);
    Green(even_files(i)).green_day=adcdata(Scut_ind(even_files(i)).scut_ind,adc_value);
end;


%creates structure called 'scut' with roi number and texture feature
for i=1:length(feature_filelist);
a=importdata([featuredir feature_filelist(i).name]);
texture=a.data(:,44); %CHOOSE WHAT FEATURE YOU WANT
roi=a.data(:,1);
scut(i).roi=roi;
scut(i).textures=texture;
end
%end


%%
%HISTOGRAM OF TEXTURES

figure
for i=2:2:16;
    subplot(4,2,even_files(i))
    hist(scut(i).textures,[0:1:160])
    hold on
    xlabel('texture')
    title(even_files(i));
end

%%
all_files=[1 2 3 4 5 6 7 8];
%HISTOGRAM OF GREEN
figure
for i=1:8;
    subplot(4,2,i)
    hist(Green(i).green_day,[0:.01:5])
    hold on
    xlabel('green fluorescence')
    xlim([0 4])
    title(all_files(i));
end

%PLOTTING GREEN PEAK FL vs TEXTURES

figure
for i=2:2:16
    clear ia ib intersect
    x=scut(i).roi;
    xx=Scut_ind(even_files(i)).scut_ind;
 [intersect,ia,ib]=intersect(x,xx); 
 y=scut(i).textures(ia);
 subplot(4,2,even_files(i))
 plot(Green(even_files(i)).green_day,y,'.')
 xlabel('green peak fluorescence')
ylabel('texture')
%set(gca,'xscale','log')
title(even_files(i));
xlim([0 4])
end
%%
