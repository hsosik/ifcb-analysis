%plots from Guava FCS files 2.0:

%Read in desired files:
[fcsdat, fcshdr, fcsdatscaled] = fca_readfcs('30Sept2016_testsamples_fcs/2016-09-30_at_03-15-00pm2_0/2016-09-30_at_03-15-00pm2_0-1.fcs');
filters = {fcshdr.par.name}';

filename='A1';

%these are:
%     'FSC-HLin'
%     'SSC-HLin'
%     'GRN-B-HLin'
%     'YEL-B-HLin'  %PE?
%     'RED-B-HLin'  %CHL?
%     'GRN-B-ALin'
%     'GRN-B-W'
%     'FSC-HLog'
%     'SSC-HLog'
%     'GRN-B-HLog'
%     'YEL-B-HLog'
%     'RED-B-HLog'
%     'GRN-B-ALog'
%     'GRN-B-WLog'
  
%%
figure(6), clf
%set(gcf,'Position',[291         365        1080         621])

subplot(3,4,1,'replace')
plot(fcsdatscaled(:,8),fcsdatscaled(:,11),'k.','markersize',1) %FSC, PE
hold on
xlabel('FSC','Fontsize',14)
ylabel('PE','Fontsize',14)
set(gca,'yscale','log','xscale','log','box','on','xtick',[1 1e1 1e2 1e3 1e4 1e5])
axis square
title(filename,'fontsize',14,'interpreter','none')

subplot(3,4,3,'replace')
hold on
plot(fcsdatscaled(:,9),fcsdatscaled(:,11),'k.','markersize',1) %SSC, PE
hold on
xlabel('SSC','Fontsize',14)
ylabel('PE','Fontsize',14)
set(gca,'yscale','log','xscale','log','box','on','xtick',[1 1e1 1e2 1e3 1e4 1e5])
axis square

subplot(3,4,2,'replace')
hold on
plot(fcsdatscaled(:,8),fcsdatscaled(:,12),'k.','markersize',1)
xlabel('FSC','Fontsize',14)
ylabel('CHL','Fontsize',14)
set(gca,'yscale','log','xscale','log','box','on','xtick',[1 1e1 1e2 1e3 1e4 1e5])
axis square

subplot(3,4,4,'replace')
hold on
plot(fcsdatscaled(:,9),fcsdatscaled(:,12),'k.','markersize',1)
xlabel('SSC','Fontsize',14)
ylabel('CHL','Fontsize',14)
set(gca,'yscale','log','xscale','log','box','on','xtick',[1 1e1 1e2 1e3 1e4 1e5])
axis square
% Histogram plots:

maxvalue=5; %1e5;
bins=linspace(0,maxvalue,250);

subplot(3,4,5,'replace')
[n x nbins]=histmulti5(log10(fcsdatscaled(:,[8 11])),[bins' bins']);
n(n==0)=NaN;
surf(x(:,1),x(:,2),n')
view(2), caxis([0 200])
shading flat
xlabel('FSC','Fontsize',14)
ylabel('PE','Fontsize',14)
set(gca,'box','on')
axis square

subplot(3,4,6,'replace')
[n x nbins]=histmulti5(log10(fcsdatscaled(:,[8 12])),[bins' bins']);
n(n==0)=NaN;
surf(x(:,1),x(:,2),n')
view(2), caxis([0 200])
shading flat
xlabel('FSC','Fontsize',14)
ylabel('CHL','Fontsize',14)
set(gca,'box','on')
axis square

subplot(3,4,7,'replace')
[n x nbins]=histmulti5(log10(fcsdatscaled(:,[9 11])),[bins' bins']);
n(n==0)=NaN;
surf(x(:,1),x(:,2),n')
view(2), caxis([0 200])
shading flat
xlabel('SSC','Fontsize',14)
ylabel('PE','Fontsize',14)
set(gca,'box','on')
axis square

subplot(3,4,8,'replace')
[n x nbins]=histmulti5(log10(fcsdatscaled(:,[9 12])),[bins' bins']);
n(n==0)=NaN;
surf(x(:,1),x(:,2),n')
view(2), caxis([0 200])
shading flat
xlabel('SSC','Fontsize',14)
ylabel('CHL','Fontsize',14)
axis square

apos=get(gca,'position');
colorbar
set(gca,'position',apos,'box','on')

% One parameter histograms:

subplot(3,4,9,'replace')
binned=histc(log10(fcsdatscaled(:,8)),bins);
plot(bins,binned)
xlabel('FSC','Fontsize',14)
set(gca,'box','on')
ylim([0 5000])
axis square

subplot(3,4,10,'replace')
binned=histc(log10(fcsdatscaled(:,9)),bins);
plot(bins,binned)
xlabel('SSC','Fontsize',14)
set(gca,'box','on')
ylim([0 5000])
axis square

subplot(3,4,11,'replace')
binned=histc(log10(fcsdatscaled(:,11)),bins);
plot(bins,binned)
xlabel('PE','Fontsize',14)
set(gca,'box','on')
ylim([0 5000])
axis square

subplot(3,4,12,'replace')
binned=histc(log10(fcsdatscaled(:,12)),bins);
plot(bins,binned)
xlabel('CHL','Fontsize',14)
set(gca,'box','on')
ylim([0 5000])
axis square

%% % If want to gate a population:

%First do a separate figure for plots:

%enter in plot and data for that plot that you'd like to gate:
[syn_ind, vertices]=point_in_poly(fcsdatscaled(:,[9 11]),subplot(3,4,3));

%plot what you have returned:
hold on
plot(fcsdatscaled(syn_ind,9),fcsdatscaled(syn_ind,11),'r.','markersize',1)
count=sum(syn_ind);