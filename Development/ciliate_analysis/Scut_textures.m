%%
clear all;
close all;



datadir = '/Users/markmiller/Documents/Experiments/IFCB_14/blue_laser_data/features/';
filelist = dir([datadir '*.csv']);

adcdata=load('/Users/markmiller/Documents/Experiments/IFCB_14/blue_laser_data/D20150107T152446_IFCB014.adc'); %CHOOSE WHICH ADC FILE TO LOAD


%REMOVES THOSE DOUBLE ROIS
zero_ind=find(adcdata(:,14)==0);
[adcdata_new,PS] = removerows(adcdata,'ind',zero_ind(2:end));


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

%creates structure called 'scut' with roi number and texture feature
for i=1:length(filelist);
a=importdata([datadir filelist(i).name]);
texture=a.data(:,44); %CHOOSE WHAT FEATURE YOU WANT
roi=a.data(:,1);
scut(i).roi=roi;
scut(i).textures=texture;
end

%Description of sample= filelist number (filename)
%NORMAL STAIN LEVEL=5 (T152446)
%10 fold less stain= 4(T151142)
%50 fold less stain= 3 (T150151)
%100 fold less stain= 2 (T145141)
% no stain= 6 (T162819)
%2x regular stain= 11(T210914)


% new cells= 15 (D20150121T162923)
% old cells= 16 (D20150121T164625)
% heated cells= 17(D20150121T171243)

%HISTOGRAM OF TEXTURES
figure
hist(scut(5).textures,[0:1:160]) %CHOOSE WHICH FILELIST NUMBER YOU ARE USING FOR TEXTURES
hold on
xlabel('texture')
%%
%PLOTTING GREEN PEAK FL vs TEXTURES
figure
plot(adcdata_new(:,8),scut(5).textures,'.')
xlabel('green peak fluorescence')
ylabel('texture')
%set(gca,'xscale','log')
%%

% %adcdata=load('/Users/markmiller/Documents/Experiments/IFCB_14/blue_laser_data/D20150121T171243_IFCB014.adc');
% 
% 
% for i=1:length(filelist);
% a=importdata([datadir filelist(i).name]);
% texture=a.data(:,44);
% roi=a.data(:,1);
% scut(i).roi=roi;
% scut(i).textures=texture;
% end
% 
% %NORMAL STAIN LEVEL=5 (T152446)
% %10 fold less stain= 4(T151142)
% %50 fold less stain= 3 (T150151)
% %100 fold less stain= 2 (T145141)
% % no stain= 6 (T162819)
% %2x regular stain= 11(T210914)
% % new cells (D20150121T162923)
% % old cells (D20150121T164625)
% % heated cells (D20150121T171243)
% 
% %figure
% hist(scut(17).textures,[0:1:160])
% 
% 
% % figure
% % plot(adcdata(2:end,8),scut(17).textures,'.')
% % xlabel('green peak fluorescence')
% % ylabel('texture')