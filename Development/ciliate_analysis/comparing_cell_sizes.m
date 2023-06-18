%%
clear all;
close all;



datadir = '/Volumes/IFCB_products-1/IFCB14_Dock/features/2015/';
filelist = dir([datadir '*.csv']);

%adcdata=load('/Volumes/IFCB_data/IFCB14_Dock/data/2015/D20150522/D20150522T002124_IFCB014.adc'); %CHOOSE WHICH ADC FILE TO LOAD

load ('/Volumes/IFCB_products/IFCB14_Dock/Manual_fromClass/D20150522T002124_IFCB014.mat');
gyro_normal=find(classlist(:,2)==34);
ciliate_mix_normal=find(classlist(:,2)==70);
proto_normal=find(classlist(:,2)==100);

load ('/Volumes/IFCB_products/IFCB14_Dock/Manual_fromClass/D20150522T004528_IFCB014.mat');
gyro_alt=find(classlist(:,2)==34);
ciliate_mix_alt=find(classlist(:,2)==70);
proto_alt=find(classlist(:,2)==100);


% %REMOVES THOSE DOUBLE ROIS
% zero_ind=find(adcdata(:,14)==0);
% [adcdata_new,PS] = removerows(adcdata,'ind',zero_ind(2:end));


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
% column 9 = equivalent diameter

%creates structure called 'scut' with roi number and texture feature
for i=1:length(filelist);
a=importdata([datadir filelist(i).name]);
texture=a.data(:,9); %CHOOSE WHAT FEATURE YOU WANT
roi=a.data(:,1);
scut(i).roi=roi;
scut(i).textures=texture;
end
%%
[normal_ciliate_ind,i] = intersect(scut(1).roi,ciliate_mix_normal);
[alt_ciliate_ind,ii] = intersect(scut(2).roi,ciliate_mix_alt);

 normal_size=scut(1).textures;
 alt_size=scut(2).textures;
 
%%


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

%% HISTOGRAM OF ALL CELL SIZES

figure
[n1,p1]=hist(scut(1).textures,[0:1:300]);
[n2,p2]=hist(scut(2).textures,[0:1:300]);
bar(p1/3.4,n1/normal_ml,'hist')
hold on; 
h=bar(p2/3.4,n2/alt_ml,'hist'); hold off
set(h,'facecolor','c')
title('normal vs alt- all cells')
legend('normal', 'stained')

%% CILIATE MIX
figure
[n1,p1]=hist(scut(1).textures,[0:1:300]);
[n2,p2]=hist(normal_size(i),[0:1:300]);
bar(p1,n1,'hist')
hold on; 
h=bar(p2,n2,'hist'); hold off
set(h,'facecolor','c')
title('normal sample-ciliate mix')
legend('normal', 'stained')


figure
[n1,p1]=hist(scut(2).textures,[0:1:300]);
[n2,p2]=hist(alt_size(ii),[0:1:300]);
bar(p1,n1,'hist')
hold on; 
h=bar(p2,n2,'hist'); hold off
set(h,'facecolor','c')
title('alt sample-ciliate mix')
legend('normal', 'stained')


%% GYRODINIUM
[normal_gyro_ind,i] = intersect(scut(1).roi,gyro_normal);
[alt_gyro_ind,ii] = intersect(scut(2).roi,gyro_alt);

figure
[n1,p1]=hist(scut(1).textures,[0:1:300]);
[n2,p2]=hist(normal_size(i),[0:1:300]);
bar(p1,n1,'hist')
hold on; 
h=bar(p2,n2,'hist'); hold off
set(h,'facecolor','c')
title('normal sample-gyro')
legend('normal', 'stained')

figure
[n1,p1]=hist(scut(2).textures,[0:1:300]);
[n2,p2]=hist(alt_size(ii),[0:1:300]);
bar(p1,n1,'hist')
hold on; 
h=bar(p2,n2,'hist'); hold off
set(h,'facecolor','c')
title('alt sample-gyro')
legend('normal', 'stained')
%% PROTOPERIDINIUM
[normal_proto_ind,i] = intersect(scut(1).roi,proto_normal);
[alt_proto_ind,ii] = intersect(scut(2).roi,proto_alt);

figure
[n1,p1]=hist(scut(1).textures,[0:1:300]);
[n2,p2]=hist(normal_size(i),[0:1:300]);
bar(p1,n1,'hist')
hold on; 
h=bar(p2,n2,'hist'); hold off
set(h,'facecolor','c')
title('normal sample-proto')
legend('normal', 'stained')

figure
[n1,p1]=hist(scut(2).textures,[0:1:300]);
[n2,p2]=hist(alt_size(ii),[0:1:300]);
bar(p1,n1,'hist')
hold on; 
h=bar(p2,n2,'hist'); hold off
set(h,'facecolor','c')
title('alt sample-proto')
legend('normal', 'stained')