clear all
close all

resultpath = 'C:\Documents\Ciliate_Code\IFCB_14\results\';
micron_factor = 1/3.4; %microns per pixel

%[file path] = uigetfile('C:\Users\Emily Fay\Documents\IFCB14_OkeanosExplorerAug2013\data\D20130902T*.roi')
%[file path] = uigetfile('\\queenrose\IFCB014_OkeanosExplorerAug2013\data\D20130825T*.roi')
%[file path] = uigetfile('C:\Users\Emily Fay\Documents\Ciliate_Code\IFCB_14\Meso1-7-14\Result_Files\D2014*.roi')
[file path] = uigetfile('/Users/markmiller/Documents/Experiments/Experiments/D201403*.roi');
 file = file(1:findstr(file, '.')-1);
        disp(file)
        fname = [path file '.adc'];
        hdrname = [fname(1:end-3) 'hdr'];
        adcdata = load(fname);
        if  adcdata(1+floor(size(adcdata,1)/2),18) == 0
            adcdata = adcdata(1:size(adcdata,1)/2,:); %to deal with bug in Martin's software, which repeats adcdata...
        end
        
  %           7 = pmtA peak
  %           8 = pmtB peak
  %           16 = roiSizeX
  %           17 = roiSizeY
  
  xsize = ((adcdata(:,16))*micron_factor);  
  ysize = ((adcdata(:,17))*micron_factor);
  pmtA = adcdata(:,3);  %IFCB_10= scatter
  pmtB = adcdata(:,4); %IFCB_14: Orange/Green, in IFCB_10=red
  pmtC = adcdata(:,5);  %IFCB_14: red
  
  run_time = adcdata(end,23);
  inhibit_time = adcdata(end,24);
  
  ml_analyzed = (((run_time - inhibit_time)*0.25)/60);
  
  area_size = xsize.*ysize;
  area_bins = 0:20:2000;
  chlorophyll_bins = 0:0.001:1;
  
  h=hist(area_size, area_bins);
  h_2=hist(pmtB,chlorophyll_bins);
  
%   figure
%   loglog(chlorophyll_bins,h_2);
%   %xlim([0 0.06]);
  
%   figure 
%   plot(area_bins,h/ml_analyzed);
%   ylabel('Abundance (cell mL^{-1})', 'fontsize', 12);
%   xlabel('area (\mum)')
%   
%   average_pmt= (pmtC./pmtB);
%   whole_average=mean(average_pmt); %2.5882
 
  
  
  
 %IFCB_10_info_mat= [pmtA'; pmtB'; area_size'];
 IFCB_14_info_mat= [pmtB'; pmtC'; area_size'];
 %IFCB_10_correct_info_mat= IFCB_10_info_mat';
 IFCB_14_correct_info_mat= IFCB_14_info_mat';

 IFCB_14_small_ind=find(IFCB_14_correct_info_mat(:,3) < 500 & IFCB_14_correct_info_mat(:,3) >= 105);%5000 for crypto and meso %8000 for Oxy%10000 for pulex?
IFCB_14_small_mat= IFCB_14_correct_info_mat(IFCB_14_small_ind,:);
IFCB_14_large_ind= find(IFCB_14_correct_info_mat(:,3) >=500);
IFCB_14_large_mat= IFCB_14_correct_info_mat(IFCB_14_large_ind,:);

% IFCB_10_small_ind=find(IFCB_10_correct_info_mat(:,3) < 500 & IFCB_10_correct_info_mat(:,3) >= 105);%5000 for crypto and meso %8000 for Oxy%10000 for pulex?
% IFCB_10_small_mat= IFCB_10_correct_info_mat(IFCB_10_small_ind,:);
% IFCB_10_large_ind= find(IFCB_10_correct_info_mat(:,3) >=500);
% IFCB_10_large_mat= IFCB_10_correct_info_mat(IFCB_10_large_ind,:);
% 
% figure
% loglog((IFCB_14_small_mat(:,1)),(IFCB_14_small_mat(:,2)), '*')
% % xlim([0.01 1])
% % ylim([0.01 1])
% ylabel('chl', 'fontsize', 12);
% xlabel('FDA')

% figure
% plot((IFCB_10_small_mat(:,1)),(IFCB_10_small_mat(:,2)), '*')
% xlim([0.01 1])
% ylim([0.01 1])
% ylabel('chl', 'fontsize', 12);
% xlabel('SSC')
% % 
% figure
% plot((IFCB_10_large_mat(:,1)),(IFCB_10_large_mat(:,2)), '*')
% xlim([0.01 1])
% ylim([0.01 1])
% ylabel('chl', 'fontsize', 12);
% xlabel('SSC')

% figure
% plot((IFCB_14_large_mat(:,1)),(IFCB_14_large_mat(:,2)), '*')
% % xlim([0.01 1])
% % ylim([0.01 1])
% ylabel('chl', 'fontsize', 12);
% xlabel('FDA')
% 
figure
loglog((IFCB_14_large_mat(:,1)),(IFCB_14_large_mat(:,2)), '*')
hold on
loglog((IFCB_14_small_mat(:,1)),(IFCB_14_small_mat(:,2)), '*')
hold on
%refline(0.25,0.0015);
%refline(0.028,0.0023); %good one
refline(0.005, 0.0027)% low one
%refline(0.028, 0.0021)
 xlim([0.0016 1])
 ylim([0.0025 0.11])
ylabel('Chlorophyll fluorescence', 'fontsize', 14, 'fontname', 'arial');
xlabel('FDA fluorescence','fontsize', 14, 'fontname', 'arial');
set(gca, 'FontSize',14);

figure
plot(log(pmtB), '*')

% figure
% plot((adcdata(:,4)),(adcdata(:,5)), '*');
% xlim([0 0.2]);
% ylim([0 0.03]);
% refline(0.03, .0033)

% figure
% plot(log10(adcdata(:,4)),log10(adcdata(:,5)), '*');
% refline(0.28 ,-1.8) %for really high green: chl ratio
% refline(0.20 ,-2.05) %even higher
% % xlim([0.002 1])
% % ylim([0.0025 0.11])
% ylabel('chl', 'fontsize', 12, 'fontname', 'arial');
% xlabel('Green','fontsize', 12, 'fontname', 'arial');
% 
% figure
% plot(log10(adcdata(:,4)),log10(adcdata(:,5)), '*');
% refline(0.4 ,-1.5) %for low green: chl ratio
% xlim([0.002 1])
% ylim([0.0025 0.11])
% ylabel('chl', 'fontsize', 12, 'fontname', 'arial');
% xlabel('Green','fontsize', 12, 'fontname', 'arial');

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

m = 0.020; b = 0.0033;  x = 0.0001:0.01:2;
plot((adcdata(:,4)),(adcdata(:,5)), '*', 'markersize', 1);
hold on
plot(x, m*x+b, '-r');
xlim([0.0016 0.3])
ylim([0.0025 0.11])
axis square
ylabel('Chlorophyll fluorescence', 'fontsize', 14, 'fontname', 'arial');
xlabel('FDA fluorescence','fontsize', 14, 'fontname', 'arial');
set(gca, 'FontSize',14);


 figure
plot((adcdata(:,4)),(adcdata(:,5)), '*', 'markersize', 1);
hold on
m = 0.03; b = 0.0033;  x = 0.0001:0.01:0.2;
plot(x, m*x+b, '-r');
xlim([0 0.2]);
ylim([0 0.03]);




%low_green_ind = find(green > (chl-0.0015)/0.25);


% format short g
%  
% mean_meso_mat_green=mean(meso_mat (:,1));
% std_meso_mat_green=std(meso_mat (:,1));
% mean_meso_mat_red=mean(meso_mat(:,2));
% std_meso_mat_red=std(meso_mat (:,2));
% 
% mean_crypto_mat_green=mean(crypto_mat (:,1));
% std_crypto_mat_green=std(crypto_mat (:,1));
% mean_crypto_mat_red=mean(crypto_mat(:,2));
% std_crypto_mat_red=std(crypto_mat (:,2));


  
  
  
  
  
  
  
  