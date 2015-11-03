%% ALT SETTINGS, NO STAIN, SCATTERING ONLY

load '/Users/markmiller/Documents/Experiments/IFCB_14/Chl_limits/10-20-14/Manual_fromClass/D20141020T160918_IFCB014.mat'
adcdata=load ('/Users/markmiller/Documents/Experiments/IFCB_14/Chl_limits/10-20-14/D20141020T160918_IFCB014.adc');


chl = adcdata(:,9); green = adcdata(:,8); scattering = adcdata(:,7);

scut_ind=find(classlist(:,2)==70);
detritus_ind=find(classlist(:,2)==24);
dun_ind=find(classlist(:,2)==30);

figure
plot(green(detritus_ind),chl(detritus_ind),'.b', 'markersize',20,'markersize',20)
hold on
plot(green(dun_ind),chl(dun_ind),'.r', 'markersize',20)
plot(green(scut_ind),chl(scut_ind),'.m', 'markersize',20)
set(gca, 'yscale','log','xscale','log')
xlabel('green','fontsize',18)
ylabel('red','fontsize',18)
xlim([0.009 0.2])  
%ylim([0.003 .5])
title('alt, no stain, scattering only','fontsize',18)
legend('detritus','dun','scut')
set(gca, 'fontsize', 18, 'fontname','arial')

%% ALT SETTINGS, NO STAIN, CHL ONLY

load '/Users/markmiller/Documents/Experiments/IFCB_14/Chl_limits/10-20-14/Manual_fromClass/D20141020T162834_IFCB014.mat'
adcdata=load ('/Users/markmiller/Documents/Experiments/IFCB_14/Chl_limits/10-20-14/D20141020T162834_IFCB014.adc');


chl = adcdata(:,9); green = adcdata(:,8); scattering = adcdata(:,7);

scut_ind=find(classlist(:,2)==70);
detritus_ind=find(classlist(:,2)==24);
dun_ind=find(classlist(:,2)==30);

figure
plot(green(detritus_ind),chl(detritus_ind),'.b', 'markersize',20)
hold on
plot(green(dun_ind),chl(dun_ind),'.r', 'markersize',20)
plot(green(scut_ind),chl(scut_ind),'.m', 'markersize',20)
set(gca, 'yscale','log','xscale','log')
xlabel('green','fontsize',18)
ylabel('red','fontsize',18)
xlim([0.009 0.2])  
%ylim([0.003 .5])
title('alt, no stain, chl only','fontsize',18)
legend('detritus','dun','scut')
set(gca, 'fontsize', 18, 'fontname','arial')

%%  ALT SETTINGS, NO STAIN, GREEN ONLY 

load '/Users/markmiller/Documents/Experiments/IFCB_14/Chl_limits/10-20-14/Manual_fromClass/D20141020T163342_IFCB014.mat'
adcdata=load ('/Users/markmiller/Documents/Experiments/IFCB_14/Chl_limits/10-20-14/D20141020T163342_IFCB014.adc');


chl = adcdata(:,9); green = adcdata(:,8); scattering = adcdata(:,7);

scut_ind=find(classlist(:,2)==70);
detritus_ind=find(classlist(:,2)==24);
dun_ind=find(classlist(:,2)==30);

figure
plot(green(detritus_ind),chl(detritus_ind),'.b', 'markersize',20)
hold on
plot(green(dun_ind),chl(dun_ind),'.r', 'markersize',20)
plot(green(scut_ind),chl(scut_ind),'.m', 'markersize',20)
set(gca, 'yscale','log','xscale','log')
xlabel('green','fontsize',18)
ylabel('red','fontsize',18)
xlim([0.009 0.2])   
% ylim([0.003 .5])
title('alt, no stain, green only','fontsize',18)
legend('detritus','dun','scut')
set(gca, 'fontsize', 18, 'fontname','arial')

%%  ALT SETTINGS, NO STAIN, CHL AND GREEN 

load '/Users/markmiller/Documents/Experiments/IFCB_14/Chl_limits/10-20-14/Manual_fromClass/D20141020T163911_IFCB014.mat'
adcdata=load ('/Users/markmiller/Documents/Experiments/IFCB_14/Chl_limits/10-20-14/D20141020T163911_IFCB014.adc');


chl = adcdata(:,9); green = adcdata(:,8); scattering = adcdata(:,7);

scut_ind=find(classlist(:,2)==70);
detritus_ind=find(classlist(:,2)==24);
dun_ind=find(classlist(:,2)==30);

figure
plot(green(detritus_ind),chl(detritus_ind),'.b', 'markersize',20)
hold on
plot(green(dun_ind),chl(dun_ind),'.r', 'markersize',20)
plot(green(scut_ind),chl(scut_ind),'.m', 'markersize',20)
set(gca, 'yscale','log','xscale','log')
xlabel('green','fontsize',18)
ylabel('red','fontsize',18)
xlim([0.009 0.2])   
% ylim([0.003 .5])
title('no stain, chl and green','fontsize',18)
legend('detritus','dun','scut')
set(gca, 'fontsize', 18, 'fontname','arial')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%  NORMAL SETTINGS, NO STAIN, SCATTERING ONLY

load '/Users/markmiller/Documents/Experiments/IFCB_14/Chl_limits/10-20-14/Manual_fromClass/D20141020T164510_IFCB014.mat'
adcdata=load ('/Users/markmiller/Documents/Experiments/IFCB_14/Chl_limits/10-20-14/D20141020T164510_IFCB014.adc');


chl = adcdata(:,9); green = adcdata(:,8); scattering = adcdata(:,7);

scut_ind=find(classlist(:,2)==70);
detritus_ind=find(classlist(:,2)==24);
dun_ind=find(classlist(:,2)==30);

figure
plot(green(detritus_ind),chl(detritus_ind),'.b', 'markersize',20)
hold on
plot(green(dun_ind),chl(dun_ind),'.r', 'markersize',20)
plot(green(scut_ind),chl(scut_ind),'.m', 'markersize',20)
set(gca, 'yscale','log','xscale','log')
xlabel('PE','fontsize',18)
ylabel('red','fontsize',18)
xlim([0.009 0.2])  
%ylim([0.003 .5])
title('normal, no stain, scattering only','fontsize',18)
legend('detritus','dun','scut')
set(gca, 'fontsize', 18, 'fontname','arial')

%%  NORMAL SETTINGS, NO STAIN, CHL ONLY

load '/Users/markmiller/Documents/Experiments/IFCB_14/Chl_limits/10-20-14/Manual_fromClass/D20141020T165003_IFCB014.mat'
adcdata=load ('/Users/markmiller/Documents/Experiments/IFCB_14/Chl_limits/10-20-14/D20141020T165003_IFCB014.adc');

chl = adcdata(:,9); green = adcdata(:,8); scattering = adcdata(:,7);

scut_ind=find(classlist(:,2)==70);
detritus_ind=find(classlist(:,2)==24);
dun_ind=find(classlist(:,2)==30);

figure
plot(green(detritus_ind),chl(detritus_ind),'.b', 'markersize',20)
hold on
plot(green(dun_ind),chl(dun_ind),'.r', 'markersize',20)
plot(green(scut_ind),chl(scut_ind),'.m', 'markersize',20)
set(gca, 'yscale','log','xscale','log')
xlabel('PE','fontsize',18)
ylabel('red','fontsize',18)
xlim([0.009 0.2])  
% ylim([0.003 .5])

title('normal, no stain, chl only','fontsize',18)
legend('detritus','dun','scut')
set(gca, 'fontsize', 18, 'fontname','arial')

%%  NORMAL SETTINGS, NO STAIN, PE ONLY
%no triggers

%%  NORMAL SETTINGS, NO STAIN, PE and CHL
load '/Users/markmiller/Documents/Experiments/IFCB_14/Chl_limits/10-20-14/Manual_fromClass/D20141020T165944_IFCB014.mat'
adcdata=load ('/Users/markmiller/Documents/Experiments/IFCB_14/Chl_limits/10-20-14/D20141020T165944_IFCB014.adc');

chl = adcdata(:,9); green = adcdata(:,8); scattering = adcdata(:,7);

scut_ind=find(classlist(:,2)==70);
detritus_ind=find(classlist(:,2)==24);
dun_ind=find(classlist(:,2)==30);

figure
plot(green(detritus_ind),chl(detritus_ind),'.b', 'markersize',20)
hold on
plot(green(dun_ind),chl(dun_ind),'.r', 'markersize',20)
plot(green(scut_ind),chl(scut_ind),'.m', 'markersize',20)
set(gca, 'yscale','log','xscale','log')
xlabel('PE','fontsize',18)
ylabel('red','fontsize',18)
xlim([0.009 0.2])  
% ylim([0.003 .5])

title('normal, no stain, chl and PE','fontsize',18)
legend('detritus','dun','scut')
set(gca, 'fontsize', 18, 'fontname','arial')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%  ALT SETTINGS, STAIN, CHL ONLY
load '/Users/markmiller/Documents/Experiments/IFCB_14/Chl_limits/10-20-14/Manual_fromClass/D20141020T170616_IFCB014.mat'
adcdata=load ('/Users/markmiller/Documents/Experiments/IFCB_14/Chl_limits/10-20-14/D20141020T170616_IFCB014.adc');

chl = adcdata(:,9); green = adcdata(:,8); scattering = adcdata(:,7);

scut_ind=find(classlist(:,2)==70);
detritus_ind=find(classlist(:,2)==24);
dun_ind=find(classlist(:,2)==30);

figure
plot(green(detritus_ind),chl(detritus_ind),'.b', 'markersize',20)
hold on
plot(green(dun_ind),chl(dun_ind),'.r', 'markersize',20)
plot(green(scut_ind),chl(scut_ind),'.m', 'markersize',20)
set(gca, 'yscale','log','xscale','log')
xlabel('green','fontsize',18)
ylabel('red','fontsize',18)
xlim([0.009 1]) 
ylim([0.01 10])

title('alt, stain, chl only','fontsize',18)
legend('detritus','dun','scut')
set(gca, 'fontsize', 18, 'fontname','arial')

%%  ALT SETTINGS, STAIN, GREEN ONLY
load '/Users/markmiller/Documents/Experiments/IFCB_14/Chl_limits/10-20-14/Manual_fromClass/D20141020T171131_IFCB014.mat'
adcdata=load ('/Users/markmiller/Documents/Experiments/IFCB_14/Chl_limits/10-20-14/D20141020T171131_IFCB014.adc');

chl = adcdata(:,9); green = adcdata(:,8); scattering = adcdata(:,7);

scut_ind=find(classlist(:,2)==70);
detritus_ind=find(classlist(:,2)==24);
dun_ind=find(classlist(:,2)==30);

figure
plot(green(detritus_ind),chl(detritus_ind),'.b', 'markersize',20)
hold on
plot(green(dun_ind),chl(dun_ind),'.r', 'markersize',20)
plot(green(scut_ind),chl(scut_ind),'.m', 'markersize',20)
set(gca, 'yscale','log','xscale','log')
xlabel('green','fontsize',18)
ylabel('red','fontsize',18)
xlim([0.009 1])  
ylim([0.01 10])

title('alt, stain, green only','fontsize',18)
legend('detritus','dun','scut')
set(gca, 'fontsize', 18, 'fontname','arial')

%%  ALT SETTINGS, STAIN, CHL and GREEN
load '/Users/markmiller/Documents/Experiments/IFCB_14/Chl_limits/10-20-14/Manual_fromClass/D20141020T171656_IFCB014.mat'
adcdata=load ('/Users/markmiller/Documents/Experiments/IFCB_14/Chl_limits/10-20-14/D20141020T171656_IFCB014.adc');

scut_ind=find(classlist(:,2)==70);
detritus_ind=find(classlist(:,2)==24);
dun_ind=find(classlist(:,2)==30);

%load '/Users/markmiller/Documents/IFCB14_Pisces/data/Manual_fromClass/D20141103T230846_IFCB014.mat'
% use IFCB 14  D20130825T161009_IFCB014
%Lysotracker_analysis
%refline(0.020, 0.0033)
chl = adcdata(:,5); green = adcdata(:,4); scattering = adcdata(:,3);

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

plot(green(detritus_ind),chl(detritus_ind),'.b', 'markersize',20)
hold on
plot(green(dun_ind),chl(dun_ind),'.r', 'markersize',20)
plot(green(scut_ind),chl(scut_ind),'.m', 'markersize',20)
%plot(green(high_green_ind), chl(high_green_ind), 'g*','markersize', 4)
hold on
%plot(x, m*x+b, '-k');
xlim([0.0017 0.1])
ylim([0.0035 0.9])
axis square
ylabel('Chlorophyll fluorescence', 'fontsize', 24, 'fontname', 'arial');
xlabel('FDA fluorescence','fontsize', 24, 'fontname', 'arial');
set(gca, 'FontSize',24);


load '/Users/markmiller/Documents/Experiments/IFCB_14/Chl_limits/10-20-14/Manual_fromClass/D20141020T171656_IFCB014.mat'
adcdata=load ('/Users/markmiller/Documents/Experiments/IFCB_14/Chl_limits/10-20-14/D20141020T171656_IFCB014.adc');

chl = adcdata(:,9); green = adcdata(:,8); scattering = adcdata(:,7);

scut_ind=find(classlist(:,2)==70);
detritus_ind=find(classlist(:,2)==24);
dun_ind=find(classlist(:,2)==30);



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

plot(green(detritus_ind),chl(detritus_ind),'.b', 'markersize',20)
hold on
plot(green(dun_ind),chl(dun_ind),'.r', 'markersize',20)
plot(green(scut_ind),chl(scut_ind),'.m', 'markersize',20)
%plot(x, m*x+b, '-k');
% xlim([0.0017 0.1])
% ylim([0.0045 0.9])

axis square
ylabel('Chlorophyll fluorescence', 'fontsize', 24, 'fontname', 'arial');
xlabel('FDA fluorescence','fontsize', 24, 'fontname', 'arial');
set(gca, 'FontSize',24);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%  NORMAL SETTINGS, STAIN, CHL ONLY
load '/Users/markmiller/Documents/Experiments/IFCB_14/Chl_limits/10-20-14/Manual_fromClass/D20141020T172303_IFCB014.mat'
adcdata=load ('/Users/markmiller/Documents/Experiments/IFCB_14/Chl_limits/10-20-14/D20141020T172303_IFCB014.adc');

chl = adcdata(:,9); green = adcdata(:,8); scattering = adcdata(:,7);

scut_ind=find(classlist(:,2)==70);
detritus_ind=find(classlist(:,2)==24);
dun_ind=find(classlist(:,2)==30);

figure
plot(green(detritus_ind),chl(detritus_ind),'.b', 'markersize',20)
hold on
plot(green(dun_ind),chl(dun_ind),'.r', 'markersize',20)
plot(green(scut_ind),chl(scut_ind),'.m', 'markersize',20)
set(gca, 'yscale','log','xscale','log')
xlabel('PE','fontsize',18)
ylabel('red','fontsize',18)
xlim([0.009 0.2]) 
% ylim([0.003 .5])

title('normal, stain, chl only','fontsize',18)
legend('detritus','dun','scut')
set(gca, 'fontsize', 18, 'fontname','arial')

%%  NORMAL SETTINGS, STAIN, PE ONLY
% no triggers


%%  NORMAL SETTINGS, STAIN, PE AND CHL
load '/Users/markmiller/Documents/Experiments/IFCB_14/Chl_limits/10-20-14/Manual_fromClass/D20141020T173321_IFCB014.mat'
adcdata=load ('/Users/markmiller/Documents/Experiments/IFCB_14/Chl_limits/10-20-14/D20141020T173321_IFCB014.adc');

chl = adcdata(:,9); green = adcdata(:,8); scattering = adcdata(:,7);

scut_ind=find(classlist(:,2)==70);
detritus_ind=find(classlist(:,2)==24);
dun_ind=find(classlist(:,2)==30);

figure
plot(green(detritus_ind),chl(detritus_ind),'.b', 'markersize',20)
hold on
plot(green(dun_ind),chl(dun_ind),'.r', 'markersize',20)
plot(green(scut_ind),chl(scut_ind),'.m', 'markersize',20)
set(gca, 'yscale','log','xscale','log')
xlabel('PE','fontsize',18)
ylabel('red','fontsize',18)
xlim([0.009 0.2]) 
% ylim([0.003 .5])

title('normal, stain, PE and chl','fontsize',18)
legend('detritus','dun','scut')
set(gca, 'fontsize', 18, 'fontname','arial')