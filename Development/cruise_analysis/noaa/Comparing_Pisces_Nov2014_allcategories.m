
clear all
load '\\sosiknas1\IFCB_products\IFCB102_PiscesNov2014\Manual_fromClass\summary\count_manual_25Jul2017.mat' %load nonstaining file


[ ind_ciliate, class_label ] = get_ciliate_ind( class2use, class2use );

normal_ciliate_classcount = classcount(:,ind_ciliate); %grabs ciliate counts
normal_ciliate_bin=nansum(normal_ciliate_classcount,1); %sums ciliate counts over whole cruise
normal_ciliate_ml=sum(ml_analyzed); %sums ml_analyzed over whole cruise
normal_ciliate_perml=normal_ciliate_bin/normal_ciliate_ml; %abundance over whole cruise


load '\\sosiknas1\IFCB_products\IFCB014_PiscesNov2014\Manual_fromClass\summary\count_manual_24Jul2017.mat'

load '\\sosiknas1\IFCB_products\IFCB014_PiscesNov2014\Manual_fromClass\surface_ctd_list.mat'

clear total_filelist
for i=1:length(filelist) %making a filelist list that is a vector of cells to compare to the surface_ctd_list
    temp=filelist(i).name;
total_filelist(i,:)=cellstr(temp(1:24));
end


[c,cc]=setdiff(total_filelist,surface_ctd_list); % finding which files are only underway (this function looks at the total filelist and says what is unique that to list compared to what is in the ctd filelist

alt_ciliate_classcount = classcount(cc,ind_ciliate); %cc is indexing only underway files, to index all files, instead of 'cc', put ':'
alt_ciliate_bin=nansum(alt_ciliate_classcount,1);
alt_ciliate_ml=sum(ml_analyzed(cc)); %cc is indexing only underway files
alt_ciliate_perml=alt_ciliate_bin/alt_ciliate_ml;


%Calculating Poisson stats

[normal_ci] = poisson_count_ci(normal_ciliate_bin, 0.95);
normal_ci_low=normal_ci(:,1);
normal_ci_upper=normal_ci(:,2);

[alt_ci] = poisson_count_ci(alt_ciliate_bin, 0.95);
alt_ci_low=alt_ci(:,1);
alt_ci_upper=alt_ci(:,2);


%Plotting bar graph of typical categories
b = [normal_ciliate_bin./normal_ciliate_ml; alt_ciliate_bin./alt_ciliate_ml]';
errdata1 = [b(:,1)'-(normal_ci_low./normal_ciliate_ml)'; (normal_ci_upper./normal_ciliate_ml-b(:,1))']';
errdata2 = [b(:,2)'-(alt_ci_low./alt_ciliate_ml)'; (alt_ci_upper./alt_ciliate_ml-b(:,2))']'; 


lower_errdata=[errdata1(:,1) errdata2(:,1)];
upper_errdata=[errdata1(:,2) errdata2(:,2)];



labels_long={'Ciliate mix'; '\itDidinium\rm sp.';'\itEuplotes\rm';'\itLaboea strobila\rm'; '\itLeegaardiella ovalis\rm';...
    '\itMesodinium\rm sp.';'\itPleuronema\rm sp.';'\itStrobilidium\rm sp.'; '\itStrombidium capitatum\rm';...
    '\itStrombidium conicum\rm'; '\itStrombidium inclinatum\rm'; '\itStrombidium\rm sp. 1'; '\itStrombidium\rm sp.2';...
    '\itStrombidium oculatum\rm';'\itStrombidium wulffi\rm';'\itTiarina fusus\rm';...
    'Misc. Tintinnid';'\itTontonia appendiculariformis\rm'; '\itTontonia gracillima\rm'; '\itEutintinnis\rm spp.';...
    '\itFavella\rm spp.';'\itHelicostomella subulata\rm'; '\itStenosemella\rm sp.'; '\itStenosemella pacifica\rm';...
    '\itTintinnidium mucicola\rm';'\itTintinnopsis\rm spp.'; '\itBalanion\rm spp.'};




% non_zero_ind=find(sum(b,2)>0);
% 
% bar_tick=errorbar_groups(b(non_zero_ind(2:end),:)',lower_errdata(non_zero_ind(2:end),:)',upper_errdata(non_zero_ind(2:end),:)','bar_width',0.7);
% ylabel('Cell concentration (mL^{-1})','fontsize', 24, 'fontname', 'arial');
% lh = legend('Non stained', 'Stained');
% set(lh, 'box', 'off')
% set(gca,'XTickLabel',labels(non_zero_ind(2:end)),...
%     'XTick',[bar_tick],...
%     'LineWidth',2,...
%     'FontSize',18,...
%     'FontName','arial');
% xtickangle(45)
% 
% set(gcf,'color','w')
% set(gcf,'units','inches')
% set(gcf,'PaperOrientation','landscape');
% set(gcf,'position',[6 7 11 9],'paperposition', [0 -0.3 11 9]);
% 
% text(1.5,0.08,'*','color','r','fontsize',40)
% text(11.5,0.06,'*','color','r','fontsize',40)
% text(15.5,0.02,'*','color','r','fontsize',40)
% text(19.5,0.022,'*','color','r','fontsize',40)
% text(21.5,0.022,'*','color','r','fontsize',40)
% text(27.5,0.08,'*','color','r','fontsize',40)





%non_zero_ind=find(sum(b,2)>0); %finds the groups that are not zero counts
non_zero_ind=find(sum(b,2)>=0); %finds the groups that are not zero and zero counts

labels={'Ciliate mix'; '\itDidinium\rm sp.';'\itEuplotes\rm';'\itLaboea strobila\rm'; '\itLeegaardiella ovalis\rm';...
    '\itMesodinium\rm sp.';'\itPleuronema\rm sp.';'\itStrobilidium\rm sp.'; '\itS. capitatum\rm';...
    '\itS. conicum\rm'; '\itS. inclinatum\rm'; '\itS.\rm sp. 1'; '\itS.\rm sp.2';...
    '\itS. oculatum\rm';'\itS. wulffi\rm';'\itTiarina fusus\rm';...
    'Misc. Tintinnid';'\itT. appendiculariformis\rm'; '\itT. gracillima\rm'; '\itEutintinnis\rm spp.';...
    '\itFavella\rm spp.';'\itH. subulata\rm'; '\itStenosemella\rm sp.'; '\itStenosemella pacifica\rm';...
    '\itTintinnidium mucicola\rm';'\itTintinnopsis\rm spp.'; '\itBalanion\rm spp.'};

hf=figure; 
ha1=subaxis(1,5,1,'Spacing',0.02,'Padding',0.02,'Margin',0.12) %intitializing the first subplot
ha2=subaxis(1,5,2:5,'Spacing',0.02,'Padding',0.02,'Margin',0.12) %intitializing the second subplot

bar_tick=errorbar_groups(b(1,:)',lower_errdata(1,:)',upper_errdata(1,:)','FigID',hf,'AxID',ha1,'bar_width',0.8); %creating the first subplot 
ylabel('Cell concentration (mL^{-1})','fontsize', 24, 'fontname', 'arial'); %ylabel for first subplot
set(gca,'XTickLabel',labels(1),...
    'XTick',[bar_tick],...
    'LineWidth',2,...
    'FontSize',12,...
    'FontName','arial','XTickLabelRotation',30); % 
%xtickangle(30)
text(1.5,0.37,'*','color','r','fontsize',40)


bar_tick=errorbar_groups(b(non_zero_ind(2:end),:)',lower_errdata(non_zero_ind(2:end),:)',upper_errdata(non_zero_ind(2:end),:)','FigID',hf,'AxID',ha2,'bar_width',0.7);
lh = legend('Non stained', 'Stained');
set(lh, 'box', 'off')
set(gca,'XTickLabel',labels(non_zero_ind(2:end)),...
    'XTick',[bar_tick],...
    'LineWidth',2,...
    'FontSize',12,...
    'FontName','arial','XTickLabelRotation',30);
%xtickangle(30)


text(9.5,0.08,'*','color','r','fontsize',40)
text(31.5,0.06,'*','color','r','fontsize',40)
text(35.5,0.02,'*','color','r','fontsize',40)
text(41.5,0.022,'*','color','r','fontsize',40)
text(33.5,0.022,'*','color','r','fontsize',40)
text(51.5,0.08,'*','color','r','fontsize',40)

text(11.5,.01,'*','color','g','fontsize',40)
text(29.5,.01,'*','color','g','fontsize',40)
text(31.5,.055,'*','color','g','fontsize',40)
text(33.5,.01,'*','color','g','fontsize',40)
text(37.5,.015,'*','color','g','fontsize',40)
text(39.5,.01,'*','color','g','fontsize',40)
text(14,.08,'n= 15','fontsize',20)


set(gcf,'color','w')
set(gcf,'units','inches')
set(gcf,'PaperOrientation','landscape');
set(gcf,'position',[1 1 13 4.5],'paperposition', [1 1 13 4.5]);
mtit('ECOMON-Pisces, November 3-19, 2014','fontsize',18)

% MVCO counts

biological=load ('\\sosiknas1\IFCB_products\MVCO\Manual_fromClass\summary\count_biovol_manual_current_day.mat');

[ ind_ciliate, class_label ] = get_ciliate_ind( class2use, class2use );

labels={'Ciliate mix'; '\itDidinium\rm sp.';'\itEuplotes\rm';'\itLaboea strobila\rm'; '\itLeegaardiella ovalis\rm';...
    '\itMesodinium\rm sp.';'\itPleuronema\rm sp.';'\itStrobilidium\rm sp.'; '\itS. capitatum\rm';...
    '\itS. conicum\rm'; '\itS. inclinatum\rm'; '\itS.\rm sp. 1'; '\itS.\rm sp.2';...
    '\itS. oculatum\rm';'\itS. wulffi\rm';'\itTiarina fusus\rm';...
    'Misc. Tintinnid';'\itT. appendiculariformis\rm'; '\itT. gracillima\rm'; '\itEutintinnis\rm spp.';...
    '\itFavella\rm spp.';'\itH. subulata\rm'; '\itStenosemella\rm sp.'; '\itStenosemella pacifica\rm';...
    '\itTintinnidium mucicola\rm';'\itTintinnopsis\rm spp.'; '\itBalanion\rm spp.'};

%451, 452, 453, maybe 454, 455

class2use=biological.class2use;
matdate_bin=biological.matdate_bin;
count=biological.classcount_bin;
ml_analyzed=biological.ml_analyzed_mat_bin;
count_perml=count./ml_analyzed;


ciliate_classcount = count(451:455,ind_ciliate);
ciliate_bin=nansum(ciliate_classcount,1);

ciliate_ml=sum(ml_analyzed(451:455,ind_ciliate),1);
ciliate_perml=ciliate_bin/ciliate_ml;


%Calculating Poisson stats

[ci] = poisson_count_ci(ciliate_bin, 0.95);
ci_low=ci(:,1);
ci_upper=ci(:,2);


%Plotting bar graph of typical categories
b = [ciliate_bin./ciliate_ml]';
errdata1 = [b-(ci_low./ciliate_ml') (ci_upper./ciliate_ml'-b)];

lower_errdata=[errdata1(:,1)];
upper_errdata=[errdata1(:,2)];

%non_zero_ind=find(sum(b,2)>0);
non_zero_ind=find(sum(b,2)>=0);
%figure start
hf=figure; 
ha1=subaxis(1,5,1,'Spacing',0.02,'Padding',0.02,'Margin',0.12)
ha2=subaxis(1,5,2:5,'Spacing',0.02,'Padding',0.02,'Margin',0.12)

bar_tick=errorbar_groups(b(1,:)',lower_errdata(1,:)',upper_errdata(1,:)','FigID',hf,'AxID',ha1,'bar_width',0.4); 
ylabel('Cell concentration (mL^{-1})','fontsize', 24, 'fontname', 'arial');

set(gca,'XTickLabel',labels(non_zero_ind(1)),...
    'XTick',[bar_tick],...
    'LineWidth',2,...
    'FontSize',12,...
    'FontName','arial','XTickLabelRotation',30);
%xtickangle(30)


bar_tick=errorbar_groups(b(non_zero_ind(2:end),:)',lower_errdata(non_zero_ind(2:end),:)',upper_errdata(non_zero_ind(2:end),:)','FigID',hf,'AxID',ha2,'bar_width',0.7);


set(gca,'XTickLabel',labels(non_zero_ind(2:end)),...
    'XTick',[bar_tick],...
    'LineWidth',2,...
    'FontSize',12,...
    'FontName','arial','XTickLabelRotation',30);


text(3,0.3,'*','color','g','fontsize',40)
text(4,0.5,'*','color','g','fontsize',40)
text(7,0.3,'*','color','g','fontsize',40)
text(11,0.5,'*','color','g','fontsize',40)
text(12,0.3,'*','color','g','fontsize',40)
text(7.5,3,'n= 14','fontsize',20)

set(gcf,'color','w')
set(gcf,'units','inches')
set(gcf,'PaperOrientation','landscape');
set(gcf,'position',[1 1 13 4.5],'paperposition', [1 1 13 4.5]);

mtit('MVCO, October 31-November 26','fontsize',18)
% 


