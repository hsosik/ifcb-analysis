%% ALT SETTINGS, NO STAIN, CHL ONLY

load '/Users/markmiller/Documents/Experiments/IFCB_14/Chl_limits/10-7-14/Manual_fromClass/D20141007T151655_IFCB014.mat'
adcdata=load ('/Users/markmiller/Documents/Experiments/IFCB_14/Chl_limits/10-7-14/D20141007T151655_IFCB014.adc');


chl = adcdata(:,5); green = adcdata(:,4); scattering = adcdata(:,3);

scut_ind=find(classlist(:,2)==70);
detritus_ind=find(classlist(:,2)==24);
dun_ind=find(classlist(:,2)==30);

figure
plot(green(detritus_ind),chl(detritus_ind),'.b')
hold on
plot(green(scut_ind),chl(scut_ind),'.m')
plot(green(dun_ind),chl(dun_ind),'.r')
set(gca, 'yscale','log','xscale','log')
xlabel('green')
ylabel('red')
xlim([0.0032 1]) 
ylim([0.003 .5])
title('no stain, chl only')
legend('detritus', 'dun')

%%  ALT SETTINGS, NO STAIN, CHL AND GREEN 

load '/Users/markmiller/Documents/Experiments/IFCB_14/Chl_limits/10-7-14/Manual_fromClass/D20141007T152152_IFCB014.mat'
adcdata=load ('/Users/markmiller/Documents/Experiments/IFCB_14/Chl_limits/10-7-14/D20141007T152152_IFCB014.adc');


chl = adcdata(:,5); green = adcdata(:,4); scattering = adcdata(:,3);

scut_ind=find(classlist(:,2)==70);
detritus_ind=find(classlist(:,2)==24);
dun_ind=find(classlist(:,2)==30);

figure
plot(green(detritus_ind),chl(detritus_ind),'.b')
hold on
plot(green(scut_ind),chl(scut_ind),'.m')
plot(green(dun_ind),chl(dun_ind),'.r')
set(gca, 'yscale','log','xscale','log')
xlabel('green')
ylabel('red')
xlim([0.0032 1]) 
ylim([0.003 .5])
title('no stain, chl and green')
legend('detritus', 'dun')


%%  ALT SETTINGS,STAIN, CHL ONLY

load '/Users/markmiller/Documents/Experiments/IFCB_14/Chl_limits/10-7-14/Manual_fromClass/D20141007T152838_IFCB014.mat'
adcdata=load ('/Users/markmiller/Documents/Experiments/IFCB_14/Chl_limits/10-7-14/D20141007T152838_IFCB014.adc');


chl = adcdata(:,5); green = adcdata(:,4); scattering = adcdata(:,3);

scut_ind=find(classlist(:,2)==70);
detritus_ind=find(classlist(:,2)==24);
dun_ind=find(classlist(:,2)==30);

figure
plot(green(detritus_ind),chl(detritus_ind),'.b')
hold on
plot(green(scut_ind),chl(scut_ind),'.m')
plot(green(dun_ind),chl(dun_ind),'.r')
set(gca, 'yscale','log','xscale','log')
xlabel('green')
ylabel('red')
xlim([0.0032 1]) 
ylim([0.003 .5])
title('stain, chl only')
legend('detritus','scut', 'dun')

%%  ALT SETTINGS,STAIN, CHL AND GREEN

load '/Users/markmiller/Documents/Experiments/IFCB_14/Chl_limits/10-7-14/Manual_fromClass/D20141007T153407_IFCB014.mat'
adcdata=load ('/Users/markmiller/Documents/Experiments/IFCB_14/Chl_limits/10-7-14/D20141007T153407_IFCB014.adc');


chl = adcdata(:,5); green = adcdata(:,4); scattering = adcdata(:,3);

scut_ind=find(classlist(:,2)==70);
detritus_ind=find(classlist(:,2)==24);
dun_ind=find(classlist(:,2)==30);

figure
plot(green(detritus_ind),chl(detritus_ind),'.b')
hold on
plot(green(scut_ind),chl(scut_ind),'.m')
plot(green(dun_ind),chl(dun_ind),'.r')
set(gca, 'yscale','log','xscale','log')
xlabel('green')
ylabel('red')
xlim([0.0032 1]) 
ylim([0.003 .5])

title('stain, chl and green')
legend('detritus','scut', 'dun')

%%
