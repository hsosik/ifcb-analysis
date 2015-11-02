%print fig_4 -r600 -dtiffnocompression

%adc_data
%7 = peak scatter
%8 = peak green/orange
%9 = peak chlorophyll

%3 = int scatter
%4 = int green/orange
%5 = int chlorophyll

%% green trigger no stain
%ml_analyzed = 2.5114
%  %scut=0%
%  %detritus= 100%
adcdata=load ('/Users/markmiller/Documents/Experiments/IFCB_14/Stain_Protocol_Testing/8-8-13/D20130808T150500_IFCB013.adc');
load '/Users/markmiller/Documents/Experiments/IFCB_14/Stain_Protocol_Testing/8-8-13/Manual_fromClass/D20130808T150500_IFCB013.mat'
load '/Users/markmiller/Documents/Experiments/IFCB_14/Stain_Protocol_Testing/8-8-13/Manual_fromClass/summary/count_manual_22Jul2014.mat'


ciliate_roi_ind=find(classlist(:,4)== 1);
other_roi_ind=find(classlist(:,2)== 46);

%ciliate_green=adcdata(2:end,4);
ciliate_green=adcdata(ciliate_roi_ind,8);
%ciliate_ssc=adcdata(2:end,3);
ciliate_ssc=adcdata(ciliate_roi_ind,7);
other_green=adcdata(other_roi_ind,8);
other_ssc=adcdata(other_roi_ind,7);

figure

subplot(1,3,2)
loglog(other_roi_ind(2:end),other_green(2:end),'k.','markersize',14);
hold on
loglog(ciliate_roi_ind(2:end),ciliate_green(2:end),'r.','markersize',14);
 ylim([0.01 1])
 xlim([1 1000])
%  ylim([0.001 0.1]) USE THIS SET
%  xlim([0.005 1])
xlabel('Side Scattering','fontsize',16, 'fontname', 'Times New Roman')
%ylabel('FDA fluorescence\bf','fontsize',24, 'fontname', 'Times New Roman')
set(gca,'fontsize',16, 'fontname', 'Times New Roman')
text(3,0.2,' B','fontsize',18, 'fontname', 'Times New Roman')
axis square



%scatter trigger no stain FILE 2
%ml_analyzed= 2.2626
%  %scut= 41%
%  %detritus= 59%
adcdata=load ('/Users/markmiller/Documents/Experiments/IFCB_14/Stain_Protocol_Testing/8-8-13/D20130808T151648_IFCB013.adc');
load '/Users/markmiller/Documents/Experiments/IFCB_14/Stain_Protocol_Testing/8-8-13/Manual_fromClass/D20130808T151648_IFCB013.mat'

ciliate_roi_ind=find(classlist(:,4)== 1);
other_roi_ind=find(classlist(:,2)== 46);

ciliate_green=adcdata(ciliate_roi_ind,8);
ciliate_ssc=adcdata(ciliate_roi_ind,7);
other_green=adcdata(other_roi_ind,8);
other_ssc=adcdata(other_roi_ind,7);
% 
% ciliate_green=adcdata(2:end,4);
% ciliate_ssc=adcdata(2:end,3);


subplot(1,3,1)
loglog(other_roi_ind(2:end),other_green(2:end),'k.','markersize',14);
hold on
loglog(ciliate_roi_ind(2:end),ciliate_green(2:end),'r.','markersize',14);
 ylim([0.01 1])
 xlim([1 1000])
%  ylim([0.001 0.1]) USE THIS SET
%  xlim([0.005 1])
%xlabel('Side Scattering','fontsize',24, 'fontname', 'Times New Roman')
ylabel('FDA fluorescence','fontsize',16, 'fontname', 'Times New Roman')
set(gca,'fontsize',16, 'fontname', 'Times New Roman')
text(3,0.2,' A','fontsize',18, 'fontname', 'Times New Roman')
axis square

%green trigger with stain
%ml_analyzed= 2.2729
%  %scut= 75%
%  %detritus= 25%
adcdata=load ('/Users/markmiller/Documents/Experiments/IFCB_14/Stain_Protocol_Testing/8-8-13/D20130808T154634_IFCB013.adc');
load '/Users/markmiller/Documents/Experiments/IFCB_14/Stain_Protocol_Testing/8-8-13/Manual_fromClass/D20130808T154634_IFCB013.mat'

ciliate_roi_ind=find(classlist(:,4)== 1);
other_roi_ind=find(classlist(:,2)== 46);

ciliate_green=adcdata(ciliate_roi_ind,8);
ciliate_ssc=adcdata(ciliate_roi_ind,7);
other_green=adcdata(other_roi_ind,8);
other_ssc=adcdata(other_roi_ind,7);

% ciliate_green=adcdata(2:end,4);
% ciliate_ssc=adcdata(2:end,3);

subplot(1,3,3)
loglog(other_roi_ind(2:end),other_green(2:end),'k.','markersize',14);
hold on
loglog(ciliate_roi_ind(2:end),ciliate_green(2:end),'r.','markersize',14);
 ylim([0.01 1])
 xlim([1 1000])
%  ylim([0.001 0.1]) USE THIS SET
%  xlim([0.005 1])
%xlabel('Side Scattering','fontsize',18, 'fontname', 'Times New Roman')
%ylabel('FDA fluorescence','fontsize',18, 'fontname', 'Times New Roman')
set(gca,'fontsize',16, 'fontname', 'Times New Roman')
text(3,0.2,' C','fontsize',18, 'fontname', 'Times New Roman')

axis square


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% green trigger no stain
%ml_analyzed = 2.5114
%  %scut=0%
%  %detritus= 100%
adcdata=load ('/Users/markmiller/Documents/Experiments/IFCB_14/Stain_Protocol_Testing/8-8-13/D20130808T150500_IFCB013.adc');
load '/Users/markmiller/Documents/Experiments/IFCB_14/Stain_Protocol_Testing/8-8-13/Manual_fromClass/D20130808T150500_IFCB013.mat'

ciliate_roi_ind=find(classlist(:,4)== 1);
other_roi_ind=find(classlist(:,2)== 46);

%ciliate_green=adcdata(2:end,4);
ciliate_green=adcdata(ciliate_roi_ind,8);
%ciliate_ssc=adcdata(2:end,3);
ciliate_ssc=adcdata(ciliate_roi_ind,7);
other_green=adcdata(other_roi_ind,8);
other_ssc=adcdata(other_roi_ind,7);

figure

subplot(1,3,2)
hist((ciliate_green(2:end)),[0.01:0.001:0.5])
hold on
hist((other_green(2:end)),[0.01:0.001:.5])
set(gca,'xscale','log')
%  ylim([0.001 0.1]) USE THIS SET
 xlim([0.01 0.5])
%  xlim([0.005 1])
xlabel('Side Scattering','fontsize',14, 'fontname', 'Times New Roman')
%ylabel('FDA fluorescence\bf','fontsize',24, 'fontname', 'Times New Roman')
set(gca,'fontsize',14, 'fontname', 'Times New Roman')
%text(3,0.2,' B','fontsize',18, 'fontname', 'Times New Roman')
axis square


%scatter trigger no stain
%ml_analyzed= 2.2626
%  %scut= 41%
%  %detritus= 59%
adcdata=load ('/Users/markmiller/Documents/Experiments/IFCB_14/Stain_Protocol_Testing/8-8-13/D20130808T151648_IFCB013.adc');
load '/Users/markmiller/Documents/Experiments/IFCB_14/Stain_Protocol_Testing/8-8-13/Manual_fromClass/D20130808T151648_IFCB013.mat'

ciliate_roi_ind=find(classlist(:,4)== 1);
other_roi_ind=find(classlist(:,2)== 46);

ciliate_green=adcdata(ciliate_roi_ind,8);
ciliate_ssc=adcdata(ciliate_roi_ind,7);
other_green=adcdata(other_roi_ind,8);
other_ssc=adcdata(other_roi_ind,7);
% 
% ciliate_green=adcdata(2:end,4);
% ciliate_ssc=adcdata(2:end,3);




subplot(1,3,1)
hist((ciliate_green(2:end)),[0.01:0.001:0.5])
hold on
hist((other_green(2:end)),[0.01:0.001:.5])
set(gca,'xscale','log')
%  ylim([0.001 0.1]) USE THIS SET
 xlim([0.01 0.5])
%xlabel('Side Scattering','fontsize',24, 'fontname', 'Times New Roman')
ylabel('FDA fluorescence','fontsize',18, 'fontname', 'Times New Roman')
set(gca,'fontsize',18, 'fontname', 'Times New Roman')
%text(3,0.2,' A','fontsize',18, 'fontname', 'Times New Roman')
axis square



%green trigger with stain
%ml_analyzed= 2.2729
%  %scut= 75%
%  %detritus= 25%
adcdata=load ('/Users/markmiller/Documents/Experiments/IFCB_14/Stain_Protocol_Testing/8-8-13/D20130808T154634_IFCB013.adc');
load '/Users/markmiller/Documents/Experiments/IFCB_14/Stain_Protocol_Testing/8-8-13/Manual_fromClass/D20130808T154634_IFCB013.mat'

ciliate_roi_ind=find(classlist(:,4)== 1);
other_roi_ind=find(classlist(:,2)== 46);

ciliate_green=adcdata(ciliate_roi_ind,8);
ciliate_ssc=adcdata(ciliate_roi_ind,7);
other_green=adcdata(other_roi_ind,8);
other_ssc=adcdata(other_roi_ind,7);

% ciliate_green=adcdata(2:end,4);
% ciliate_ssc=adcdata(2:end,3);


subplot(1,3,3)
hist((ciliate_green(2:end)),[0.01:0.001:0.5])
hold on
hist((other_green(2:end)),[0.01:0.001:.5])
set(gca,'xscale','log')
%  ylim([0.001 0.1]) USE THIS SET
 xlim([0.01 0.5])
%xlabel('Side Scattering','fontsize',18, 'fontname', 'Times New Roman')
%ylabel('FDA fluorescence','fontsize',18, 'fontname', 'Times New Roman')
set(gca,'fontsize',18, 'fontname', 'Times New Roman')
%text(3,0.2,' C','fontsize',18, 'fontname', 'Times New Roman')

axis square




%%




