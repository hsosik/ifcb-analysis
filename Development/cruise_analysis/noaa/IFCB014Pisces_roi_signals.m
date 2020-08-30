
load '\\sosiknas1\IFCB_products\IFCB014_PiscesNov2014\Manual_fromClass\summary\count_manual_24Jul2017.mat' % to get filelist we are interested in plotting
basepath='\\sosiknas1\IFCB_data\IFCB014_PiscesNov2014\data\2014\';
resultpath='\\sosiknas1\IFCB_products\IFCB014_PiscesNov2014\Manual_fromClass\';
folders=dir([basepath 'D*']);

%for i=2:length(filelist) %where is D20141103 folder? There is a file in
%the filelist, but I can't find the raw data for it, hence why I'm starting
%on the second file

figure1 = figure;
% Create axes
axes1 = axes('Parent',figure1,'YScale','log','YMinorTick','on',...
    'XScale','log',...
    'XMinorTick','on',...
    'PlotBoxAspectRatio',[1 1 1],...
    'FontSize',14);
box(axes1,'on');
hold(axes1,'all');
hold on

for i=2:length(filelist);
    filename=char(filelist(i).name); %get the filename you want to load in character form
    display(filename);
    foldername=filename(1:9); %find the right folder where the files are
    adcdata=load([basepath '/' foldername '/' filename(1:24) '.adc']); %load the adc file
    load([resultpath '/' filename])  ; %load individual result file so we can index what roi is a ciliate and then grab that roi's adcdata 
    
    chl = adcdata(:,5); green = adcdata(:,4); scattering = adcdata(:,3); %index the adc data for what signals we want
    peak_chlorophyll=adcdata(:,9); peak_green = adcdata(:,8);
    
    
    Ciliate_mix_roi_ind=find(classlist(:,2)==70); %find manually assigned ciliate mix rois
    Tintinnid_roi_ind=find(classlist(:,2)==86); %find manually assigned misc. tintinnid rois
    Mesodinium_roi_ind=find(classlist(:,2)==75);%find manually assigned mesodinium rois
    Balanion_roi_ind=find(classlist(:,2)==122);%find manually assigned balanion rois

    
    %plot(green,chl, 'k*', 'markersize', 1); %plot all roi adc signals
    hold on
    plot(green(Ciliate_mix_roi_ind), chl(Ciliate_mix_roi_ind), 'r*','markersize', 10);%plot ciliate mix adc signals
    hold on
    plot(green(Tintinnid_roi_ind), chl(Tintinnid_roi_ind), 'g*','markersize', 10);
    plot(green(Mesodinium_roi_ind), chl(Mesodinium_roi_ind), 'b*','markersize', 10);
    plot(green(Balanion_roi_ind), chl(Balanion_roi_ind), 'k*','markersize', 20);
    
    %really klugy way to have a legend that is correct. Sometimes when the
    %loop is plotting, if there isn't a certain category, the legend won't
    %have the right colors, so I make sure that for every time something is
    %plotted, there is at least one point of one of the four colors, that
    %way the legend is sure to be populated. The xlim and ylim make sure we
    %don't see these extra points. I'm sure there is a better way to do
    %this. 
    h1=plot(1000,1000,'r*','markersize',10);
    h2=plot(1000,1000,'g*','markersize',10);
    h3=plot(1000,1000,'b*','markersize',10);
    h4=plot(1000,1000,'k*','markersize',10);
    
end


xlim([0.0016 0.3])
ylim([0.0025 0.11])
axis square
ylabel('Chlorophyll fluorescence', 'fontsize', 24, 'fontname', 'arial');
xlabel('FDA fluorescence','fontsize', 24, 'fontname', 'arial');
set(gca, 'FontSize',24);
lh=legend([h1 h2 h3 h4],'Ciliate mix','Tintinnid','Mesodinium','Balanion')
set(lh,'fontsize',14)
