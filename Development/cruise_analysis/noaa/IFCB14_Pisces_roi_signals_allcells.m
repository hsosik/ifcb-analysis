
load '\\sosiknas1\IFCB_products\IFCB014_PiscesNov2014\Manual_fromClass\summary\count_manual_24Jul2017.mat' % to get filelist we are interested in plotting
basepath='\\sosiknas1\IFCB_data\IFCB014_PiscesNov2014\data\2014\';
resultpath='\\sosiknas1\IFCB_products\IFCB014_PiscesNov2014\Manual_fromClass\';
folders=dir([basepath 'D*']);

%for i=2:length(filelist) %where is D20141103 folder? There is a file in
%the filelist, but I can't find the raw data for it, hence why I'm starting
%on the second file

for i=2:length(filelist);
    filename=char(filelist(i).name);%get the filename you want to load in character from
    disp(filename)
    foldername=filename(1:9); %find the right folder where the files are
    adcdata=load([basepath '/' foldername '/' filename(1:24) '.adc']); %load the adc file
    load([resultpath '/' filename])  ; %load individual result file so we can index what roi is a ciliate and then grab that roi's adcdata 

    chl = adcdata(:,5); green = adcdata(:,4); scattering = adcdata(:,3); %index the adc data for what signals we want
    peak_chlorophyll=adcdata(:,9); peak_green = adcdata(:,8);
 
    
    for ii=1:length(class2use)
    temp=class2use{ii};
    ind=find(classlist(:,2)==ii);
    Green_pmt_signals.(temp)(i)={green(ind)};
    Chl_pmt_signals.(temp)(i)={chl(ind)};
    Green_peak_signals.(temp)(i)={peak_green(ind)};
    Chl_peak_signals.(temp)(i)={peak_chlorophyll(ind)};
    end
     
end

save ('Pisces_IFCB014_roisignals',  'Green*', 'Chl*', 'filelist')
%after the file of signals is saved you can just run the part below here:
load 'Pisces_IFCB014_roisignals.mat'

figure1 = figure;
axes1 = axes('Parent',figure1,'YScale','log','YMinorTick','on','XScale','log','XMinorTick','on',...
    'PlotBoxAspectRatio',[1 1 1],'FontSize',14);
box(axes1,'on'); hold(axes1,'all');
hold on

for i=1:length(filelist)
    plot(Green_pmt_signals.Ciliate_mix{i}, Chl_pmt_signals.Ciliate_mix{i}, 'r*','markersize', 10);%plot ciliate mix adc signals
    hold on
    plot(Green_pmt_signals.Tintinnid{i}, Chl_pmt_signals.Tintinnid{i}, 'g*','markersize', 10);
    plot(Green_pmt_signals.Mesodinium_sp{i}, Chl_pmt_signals.Mesodinium_sp{i}, 'b*','markersize', 10);
    plot(Green_pmt_signals.Balanion_sp{i}, Chl_pmt_signals.Balanion_sp{i}, 'm*','markersize', 10);
end

h1=plot(1000,1000,'r*','markersize',10);
h2=plot(1000,1000,'g*','markersize',10);
h3=plot(1000,1000,'b*','markersize',10);
h4=plot(1000,1000,'m*','markersize',10);

axis square
ylabel('Chlorophyll fluorescence', 'fontsize', 24, 'fontname', 'arial');
xlabel('FDA fluorescence','fontsize', 24, 'fontname', 'arial');
set(gca, 'FontSize',24);
lh=legend([h1 h2 h3 h4],'Ciliate mix','Tintinnid','Mesodinium','Balanion')
set(lh,'fontsize',14,'location','southeast')
xlim([0.0016 0.2]) 
ylim([0.0025 1.5])
    
