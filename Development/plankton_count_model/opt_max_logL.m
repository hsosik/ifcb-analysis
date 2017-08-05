%ESTIMATE SEASONAL/YEARLY PLANKTON DENSITIES, ASSUMING POISSON
%DISTRIBUTION WITH OVERDISPERSION

% wrapper script that sets up data and finds parameters that maximize log
% likelihood for the Poisson count model with season and year effect, but
% confidence intervals that can account for overdispersion (via an ad-hoc
% metric). This does not work, however, for expected counts that are
% identically zero...

%% if want to first simulate data to check that everything is working:

%Simdata1:
% season_lambdas = [0.6 linspace(0.1,3,5) linspace(3,0.1,5) 0 0.1  0 linspace(0.1,3,5) linspace(3,0.1,5) 0 0.1];
% year_lambdas = [1 3 6 0 1 0.2 0.4 0.3 0.2 3];

%Simdata2:
% season_lambdas = [0 0.1:0.05:0.6 1 2 -linspace(0.1,0.6,5) 0 0.2 -0.2 -0.4 -0.6 1 0.3];
% year_lambdas = [1 -0.3 -2 0 1 0.2 -0.4 0.3 -2 3];

%Simdata 3:
season_lambdas = [0.6 linspace(0.1,3,5) linspace(3,0.1,5) 0 0.1  0 linspace(0.1,3,5) linspace(3,0.1,5) 0 0.1];
year_lambdas = [-1 -2 -0.4 -3 -1 -2 6 -0.3 -0.2 -0.1];

test_volumes=25*ones(26,10);
lambdas=exp(repmat(season_lambdas',1,10)+repmat(year_lambdas,26,1)).*test_volumes; %density * volume to get mean counts


poisson_sample=nan(26,10);
for i=1:length(year_lambdas)
    for j=1:length(season_lambdas)
        poisson_sample(j,i)=poissrnd(lambdas(j,i));
    end
end

counts=poisson_sample;
volumes=test_volumes;


%% FOR REAL DATA:

load('\\sosiknas1\IFCB_products\MVCO\Manual_fromClass\summary\count_manual_current.mat')

%%
iclass = strmatch('Heterocapsa_rotundata', class2use, 'exact');
%iclass = strmatch('Ciliate_mix', class2use, 'exact');
%iclass = strmatch('Mesodinium_sp', class2use, 'exact');
%iclass = strmatch('Odontella', class2use, 'exact');
%iclass = strmatch('Chaetoceros_pennate', class2use, 'exact');

%% set up the data matrices:

wk2yrdy = [7*(0:51)+1 366];

counts=nan(26,10);
volumes=nan(26,10);
time=nan(26,10);
yearlist=2006:2015;

for Q=1:length(yearlist) %year
    for w=1:2:51 %two week chunks
        
        jj=find(matdate >= wk2yrdy(w)+datenum(['1-0-' num2str(yearlist(Q))]) &  matdate < wk2yrdy(w+2)+datenum(['1-0-' num2str(yearlist(Q))]));
        %20 min bins of data...
        
        if ~isempty(jj)
            
            ii=find(~isnan(ml_analyzed_mat(jj,iclass))); %NaNs are time points that either weren't classified or weren't finished
            qq=jj(ii);
            
            counts((w+1)/2,Q)=sum(classcount(qq,iclass)); %total count of all ciliates
            volumes((w+1)/2,Q)=nansum(ml_analyzed_mat(qq,iclass)); %total volume analyzed for these counts
            time((w+1)/2,Q)=matdate(jj(1));
        end
    end
end

%% Now, use fminunc (or another matlab solver) to find the maximum likelihood, assuming a Posisson distribution:

[seasonnum,yearnum]=size(counts);
%to solve:
opts = optimoptions('fminunc','MaxFunctionEvaluations',100000,'MaxIterations',1000,'Display','off','Algorithm','quasi-newton');
x0=-2*rand(sum(size(counts))-1,1); %starting points for solver
year0=1; %year to set as zero

% script is expecting a column vector of parameters that have year effects
%first, then season effects...
[x, fval, exitflag] = fminunc(@(theta) poisson_logL(theta,counts,volumes,year0),x0,opts);

maxlogL=-fval;
bI=-sum(x(1:yearnum-1));
xmin=[x(1:year0-1); bI ; x(year0:end)]; %put back a "0" for year effect - the parameters return relative b's and g's with respect to b1,
%which is set at 0, but it doesn't actually matter, because the mean is a combiantion of both beta and gamma 
%- all that matters is the absolute difference between them, and it works!

%% Compare the results if have simulated data:
% [xmin [year_lambdas'; season_lambdas']] %these won't match, but if offset
% by beta(1), should retrieve the original params:
% temp=[xmin(1:10)+year_lambdas(1); xmin(11:end)-year_lambdas(1)];
% [temp [year_lambdas'; season_lambdas']]

%Now, for data that is over-dispersed relative to a Poisson distribution,
%according to Andy, the simplest way to account for this is to...

[CIs]=poisson_est_CIs(counts,volumes,xmin,maxlogL,opts,year0);


%% PLOTTING...

% parameter check!
est_year=xmin(1:yearnum);
est_seas=xmin(yearnum+1:end);
figure, subplot(1,2,1,'replace')
plot(1:26,est_seas,'s')
hold on
plot(1:26,season_lambdas,'r*')

subplot(1,2,2,'replace')
plot(1:yearnum, year_lambdas,'ro')
hold on
plot(1:yearnum, est_year,'s')
line([1 yearnum],[0 0])
legend('true year effects','year effects mean 0')

%% a rough plot - do the expected counts match the sample?

est_year=repmat(xmin(1:10)',26,1);
est_seasons=repmat(xmin(11:end),1,10);
exp_dens=exp(est_year + est_seasons);
exp_counts=exp_dens.*volumes;


%% 
clf
plot(counts,'.-','markersize',16), hold on
plot(exp_counts,'s--','color',[0.5 0.5 0.5])

%% or plots over time:
clf
plot(time(:),counts(:),'.:'), hold on
plot(time(:),exp_counts(:),'s--','color',[1 0 0])


%% CLIMATOLOGY

% Andy had said that the seasonal effect (which is the same in all years) 
%multiplies the annual mean by a factor exp(gamma_j) irrespective of the annual mean. 

%So, maybe it makes more sense to look at average year means first and then
%look seperately at the climatology?

% separate density affects for season and year:

clf
subplot(2,2,1)
plot(2007:2016,xmin(1:10),'*')
line(xlim,[0 0])
ylabel('Yearly parameter values relative to \beta_1')
subplot(2,2,2)
plot(2007:2016,exp(xmin(1:10)),'*')
ylabel('Expected year density effect (cells/vol)')

subplot(2,2,3)
plot(1:26,xmin(11:end),'*-','color',[0.4 0.4 0.4],'markeredgecolor',[0 0.4470 0.7410])
%line(xlim,[0 0])
ylabel('Seasonal parameter values relative to \beta_1')
subplot(2,2,4)
plot(1:26,exp(xmin(11:end)),'*-','color',[0.4 0.4 0.4],'markeredgecolor',[0 0.4470 0.7410])
ylabel('Expected year density effect (cells/vol)')

%% so, then the seasonal climatological density is just the exp(gammas) ??

% with CIs:
figure
plot(wk2yrdy(1:2:end-1),exp(xmin(11:end)),'.-','linewidth',2,'color','k','markersize',15)
hold on
plot(wk2yrdy(1:2:end-1),exp(CIs(11:end,1)),'-','color',[0.5 0.5 0.5])
plot(wk2yrdy(1:2:end-1),exp(CIs(11:end,2)),'-','color',[0.5 0.5 0.5])

%% desnities for each year, overlaid with seasonal densities:
%expected counts:
% seas_volumes=nansum(volumes,2);
% exp_seas_counts=exp(xmin(11:end)).*seas_volumes;

clf
h1=plot(wk2yrdy(1:2:end-1),counts./volumes,'o-','color',[0.6 0.6 0.6]); hold on
% plot(exp(xmin(11:end)-xmin(2)),'.--','linewidth',2,'color',[0.5 0.5 0.5])
% plot(exp(xmin(11:end)+0.74866),'.--','linewidth',2,'color','k')
h2=plot(wk2yrdy(1:2:end-1),exp(xmin(11:end)),'b.-','linewidth',2,'color','b');
h4=plot(wk2yrdy(1:2:end-1),exp(CIs(11:end,1)),'--','color',[0 0 1]);
plot(wk2yrdy(1:2:end-1),exp(CIs(11:end,2)),'--','color',[0 0 1])

%and compare to what you'd get if you were just to average:
h3=plot(wk2yrdy(1:2:end-1),nanmean(counts./volumes,2),'r.-','linewidth',2);
%plot(wk2yrdy(1:2:end-1),nanmedian(counts./volumes,2),'b.-','linewidth',2)

ylabel('Cell density or expected seasonal density effect (cells/mL)')
xlabel('Year day')

legend([h1(1); h2;h4;h3;],'Observed density','Expected seasonal density effect','95% CI','Mean density')

%%
set(gca,'fontsize',14)
title('Laboea_strobila','Interpreter','none')
xlim([1 358])
set(gcf,'color','w')
%export_fig /Users/kristenhunter-cevera/Desktop/Laboea_summary.pdf

%% trying to recreate each year effect:

% clf, hold on
% cc=parula(10);
% for q=1:10 
%     plot(exp(xmin(11:end)-xmin(q)),'.--','linewidth',2,'color',cc(q,:))
% end