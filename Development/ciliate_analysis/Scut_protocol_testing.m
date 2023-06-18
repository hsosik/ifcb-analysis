

%% green trigger no stain
%ml_analyzed = 2.5114
%  %scut=0%
%  %detritus= 100%
adcdata=load ('/Users/markmiller/Documents/Experiments/IFCB_14/Stain_Protocol_Testing/8-8-13/D20130808T150500_IFCB013.adc');
load '/Users/markmiller/Documents/Experiments/IFCB_14/Stain_Protocol_Testing/8-8-13/Manual_fromClass/D20130808T150500_IFCB013.mat'

ciliate_roi_ind=find(classlist(:,4)== 1);
other_roi_ind=find(classlist(:,2)== 46);

%ciliate_green=adcdata(2:end,4);
ciliate_green=adcdata(ciliate_roi_ind,4);
%ciliate_ssc=adcdata(2:end,3);
ciliate_ssc=adcdata(ciliate_roi_ind,3);
other_green=adcdata(other_roi_ind,4);
other_ssc=adcdata(other_roi_ind,3);
%%
figure

subplot(1,3,2)
loglog(other_ssc,other_green,'k.','markersize',6);
hold on
loglog(ciliate_ssc,ciliate_green,'r.','markersize',6);
% ylim([0.001 0.1])
% xlim([0.005 10])
 ylim([0.001 0.1])
 xlim([0.005 1])
xlabel('Side scattering','fontsize',12, 'fontname', 'Times New Roman')
%ylabel('FDA fluorescence\bf','fontsize',24, 'fontname', 'Times New Roman')
set(gca,'fontsize',12, 'fontname', 'Times New Roman')
text(0.006,0.06,' B','fontsize',14, 'fontname', 'Times New Roman')
axis square
%%
%scatter trigger no stain
%ml_analyzed= 2.2626
%  %scut= 41%
%  %detritus= 59%
adcdata=load ('/Users/markmiller/Documents/Experiments/IFCB_14/Stain_Protocol_Testing/8-8-13/D20130808T151648_IFCB013.adc');
load '/Users/markmiller/Documents/Experiments/IFCB_14/Stain_Protocol_Testing/8-8-13/Manual_fromClass/D20130808T151648_IFCB013.mat'

ciliate_roi_ind=find(classlist(:,4)== 1);
other_roi_ind=find(classlist(:,2)== 46);

ciliate_green=adcdata(ciliate_roi_ind,4);
ciliate_ssc=adcdata(ciliate_roi_ind,3);
other_green=adcdata(other_roi_ind,4);
other_ssc=adcdata(other_roi_ind,3);
% 
% ciliate_green=adcdata(2:end,4);
% ciliate_ssc=adcdata(2:end,3);


subplot(1,3,1)
loglog(other_ssc,other_green,'k.','markersize',6);
hold on
loglog(ciliate_ssc,ciliate_green,'r.','markersize',6);
% ylim([0.001 0.1])
% xlim([0.005 10])
 ylim([0.001 0.1])
 xlim([0.005 1])
%xlabel('Side Scattering','fontsize',24, 'fontname', 'Times New Roman')
ylabel('FDA fluorescence','fontsize',12, 'fontname', 'Times New Roman')
set(gca,'fontsize',12, 'fontname', 'Times New Roman')
text(0.006,0.06,' A','fontsize',14, 'fontname', 'Times New Roman')
axis square

%green trigger with stain
%ml_analyzed= 2.2729
%  %scut= 75%
%  %detritus= 25%
adcdata=load ('/Users/markmiller/Documents/Experiments/IFCB_14/Stain_Protocol_Testing/8-8-13/D20130808T154634_IFCB013.adc');
load '/Users/markmiller/Documents/Experiments/IFCB_14/Stain_Protocol_Testing/8-8-13/Manual_fromClass/D20130808T154634_IFCB013.mat'

ciliate_roi_ind=find(classlist(:,4)== 1);
other_roi_ind=find(classlist(:,2)== 46);

ciliate_green=adcdata(ciliate_roi_ind,4);
ciliate_ssc=adcdata(ciliate_roi_ind,3);
other_green=adcdata(other_roi_ind,4);
other_ssc=adcdata(other_roi_ind,3);

% ciliate_green=adcdata(2:end,4);
% ciliate_ssc=adcdata(2:end,3);

subplot(1,3,3)
loglog(other_ssc,other_green,'k.','markersize',6);
hold on
loglog(ciliate_ssc,ciliate_green,'r.','markersize',6);
% xlim([0.001 0.1])
% ylim([0.005 10])
 ylim([0.001 0.1])
 xlim([0.005 1])
%xlabel('Side Scattering','fontsize',18, 'fontname', 'Times New Roman')
%ylabel('FDA fluorescence','fontsize',18, 'fontname', 'Times New Roman')
set(gca,'fontsize',12, 'fontname', 'Times New Roman')
text(0.006,0.06,' C','fontsize',14, 'fontname', 'Times New Roman')

axis square


%%


