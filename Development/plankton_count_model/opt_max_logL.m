%ESTIMATE SEASONAL/YEARLY PLANKTON DENSITIES, ASSUMING POISSON
%DISTRIBUTION WITH OVERDISPERSION

% wrapper script that sets up data and finds parameters that maximize log
% likelihood for the Poisson count model with season and year effect, but
% confidence intervals that can account for overdispersion (via an ad-hoc
% metric). This does not work, however, for expected counts that are
% identically zero...

%% if want to first simulate data to check that everything is working:

%Simdata1:
season_lambdas = [0.6 linspace(0.1,3,5) linspace(3,0.1,5) 0 0.1  0 0.5*linspace(0.1,3,5) 0.5*linspace(3,0.1,5) 0 0.1];
year_lambdas = [1 -2 3 0 1 -0.2 -0.8 1 -0.2 2.5];

%Simdata2:
% season_lambdas = [0 0.1:0.05:0.6 1 2 -linspace(0.1,0.6,5) 0 0.2 -0.2 -0.4 -0.6 1 0.3];
% year_lambdas = [1 -0.3 -2 0 1 0.2 -0.4 0.3 -2 3];

%Simdata 3:
% season_lambdas = [0.6 linspace(0.1,3,5) linspace(3,0.1,5) 0 0.1  0 linspace(0.1,3,5) linspace(3,0.1,5) 0 0.1];
% year_lambdas = [-1 -2 -0.4 -3 -1 -2 6 -0.3 -0.2 -0.1];

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

load('/Volumes/IFCB_products/MVCO/Manual_fromClass/summary/count_manual_current.mat')

%%
iclass = strmatch('Laboea_strobila', class2use, 'exact');
%iclass = strmatch('Ciliate_mix', class2use, 'exact');
%iclass = strmatch('Mesodinium_sp', class2use, 'exact');
%iclass = strmatch('Odontella', class2use, 'exact');
%iclass = strmatch('Chaetoceros_pennate', class2use, 'exact');

%%

% load /Volumes/IFCB_products/MVCO/class/summary/summary_allTB_bythre_Laboea
% [matdate_bin, classcount_bin, ml_analyzed_mat_bin] = make_day_bins(mdateTB,classcountTB_above_thre(:,6), ml_analyzedTB);
% [ mdate_mat, ml_yd_mat, yearlist, yd ] = timeseries2ydmat(matdate_bin,ml_analyzed_mat_bin);
% [ mdate_mat, classcount_yd_mat, yearlist, yd ] = timeseries2ydmat(matdate_bin,classcount_bin);
% [Laboea_wk_mat, mdate_wkmat, yd_wk ] = ydmat2weeklymat(classcount_yd_mat, yearlist);
% [ml_wk_mat, mdate_wkmat, yd_wk ] = ydmat2weeklymat(ml_yd_mat, yearlist);
%
% counts=Laboea_wk_mat; %/0.7994;
% iclass=1;
% matdate=mdate_wkmat;
% volumes=ml_wk_mat;
%% set up the data matrices:

wk2yrdy = [7*(0:51)+1 366];

counts=nan(26,10);
volumes=nan(26,10);
time=nan(26,10);
yearlist=2007:2016;

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
            
        else
            time((w+1)/2,Q)=wk2yrdy(w)+datenum(['1-0-' num2str(yearlist(Q))]);
        end
    end
end

%% Now, use fminunc (or another matlab solver) to find the maximum likelihood, assuming a Posisson distribution:

%Hmmm, with real data, solver does not always seem to converge - seemed to
%be aleviated by decreasing optimality tolerances (gradient, I believe)

[seasonnum,yearnum]=size(counts);
%to solve:
opts = optimoptions('fminunc','MaxFunctionEvaluations',100000,'MaxIterations',1000,'Display','off','Algorithm','quasi-newton','OptimalityTolerance',1e-8);
x0=-2*rand(sum(size(counts))-1,1); %starting points for solver

%
%x0=x1;
brec=[]; fval_rec=[]; ef=[];
for year0=1:10; %year to set as zero
    
    % script is expecting a column vector of parameters that have year effects
    %first, then season effects...
    [x, fval, exitflag] = fminunc(@(theta) poisson_logL(theta,counts,volumes,year0),x0,opts);
    
    maxlogL=-fval; fval_rec=[fval_rec; -fval];
    bI=-sum(x(1:yearnum-1)); brec=[brec; bI];
    ef=[ef; exitflag];
    xmin=[x(1:year0-1); bI ; x(year0:end)]; %put back a "0" for year effect - the parameters return relative b's and g's with respect to b1,
    eval(['xmin' num2str(year0) '=xmin;'])
    eval(['x' num2str(year0) '=x;'])
end

%which is set at 0, but it doesn't actually matter, because the mean is a combiantion of both beta and gamma
%- all that matters is the absolute difference between them, and it works!

%and a quick plot:
clf, cc=jet(10);
for j=1:10 %[1 6 10]
    
    eval(['xmin=xmin' num2str(j) ';'])
    subplot(1,2,1), hold on
    plot(xmin(1:10),'o-','color',cc(j,:))
    subplot(1,2,2), hold on
    plot(xmin(11:end),'o-','color',cc(j,:))
    pause
end

%% Compare the results if have simulated data:
% [xmin [year_lambdas'; season_lambdas']] %these won't match, but if offset
% by beta(1), should retrieve the original params:
% temp=[xmin(1:10)+year_lambdas(1); xmin(11:end)-year_lambdas(1)];
% [temp [year_lambdas'; season_lambdas']]

%Now, for data that is over-dispersed relative to a Poisson distribution,
%according to Andy, the simplest way to account for this is to...

[CIs]=poisson_est_CIs(counts,volumes,xmin,maxlogL,opts,year0);

% grid search for checking CIs:

% ind=19;
% x0=xmin(setxor([ind; year0],1:n)); %for starting point for solver, need to remove ind of param for CI as well as param that is set to 0
% x_test=x0;
% rec=[]; rec_fval=[];
% for k=-10:0.5:10
%     [bnd_test, x_test, fval]=eval_param_for_CI(counts,volumes,ind,xmin(ind)+k,x_test,logL_bnd,opts,year0); %use the previous solver param returns as start points for the next point
%     rec=[rec; bnd_test];
%     rec_fval=[rec_fval; fval];
% end

%% PLOTTING...

% FRONT MATTER PARAMTER VALUE:

est_year=xmin(1:yearnum);
est_seas=xmin(yearnum+1:end);

est_year=repmat(xmin(1:yearnum)',seasonnum,1);
est_seasons=repmat(xmin(yearnum+1:end),1,yearnum);

exp_dens=exp(est_year + est_seasons);
exp_counts=exp_dens.*volumes;

%% IF HAVE SIMULATED DATA:
subplot(1,2,1,'replace')
hold on
plot(1:26,season_lambdas,'r*')
plot(1:26,est_seas,'s')
hleg1=legend('seasonal parameters for simulation','estimated parameters','location','NorthOutside');
set(hleg1,'box','off')
xlim([1 26])
ylabel('Season parameters','fontsize',16)
xlabel('Season','fontsize',16)
set(gca,'box','on','fontsize',16)

subplot(1,2,2,'replace')
hold on
plot(1:yearnum, year_lambdas,'r*')
plot(1:yearnum, est_year,'s')
line([1 yearnum],[0 0])
xlim([1 10])
hleg2=legend('year parameters for simulation','estimated parameters','location','NorthOutside');
set(hleg2,'box','off')
ylabel('Year parameters','fontsize',16)
set(gca,'box','on','fontsize',16)
xlabel('Year','fontsize',16)

set(gcf,'color','w')
export_fig /Users/kristenhunter-cevera/Desktop/simdata1.pdf

%ALSO FOR SIMDATA:
clf
plot(counts(:)./volumes(:),'.-'), hold on
plot(exp_dens(:),'s')

ylabel('Density (counts/volume)','fontsize',16)
xlabel('Time','fontsize',16)
set(gca,'fontsize',16,'xtick',0:25:275)
xlim([1 260])
legend('Simulated data','Model fit')

set(gcf,'color','w')
export_fig /Users/kristenhunter-cevera/Desktop/simdata2.pdf


%% OBS AND EXPECTED DENSITY:
%do the expected counts match the sample?

%COMPOSITE DENSITY AND YEAR AFFECTS:

subplot(1,2,1,'replace'), hold on
dens=counts./volumes;
avgdens=nanmean(dens,2);
ptime=1:26;
for j=1:yearnum
    h1=plot(ptime(~isnan(dens(:,j))),dens(~isnan(dens(:,j)),j),'o-','color',[0.5 0.5 0.5]);
end
h2=plot(exp(xmin(yearnum+1:end)),'b.-','linewidth',3);
h3=plot(exp(CIs(yearnum+1:end,1)),'-','color',[0 0.5 1]);
h4=plot(exp(CIs(yearnum+1:end,2)),'-','color',[0 0.5 1]);
h5=plot(ptime,avgdens,'r-','linewidth',2);
hleg2=legend([h1(1); h2(1);h3(1);h5(1)],'Observed density','Estimated seasonal density','95% CI','Avg. density','location','NorthEast');
set(hleg2,'box','off')
xlim([1 26])
ylabel('Density (cells/mL)','fontsize',16)
set(gca,'box','on','fontsize',16)
xlabel('Season','fontsize',16)
text(2.5,2.3,'A','fontsize',16)

subplot(1,2,2,'replace'), hold on
plot(2007:2016,exp(xmin(1:yearnum)),'*')
h3=plot(2007:2016,exp(CIs(1:yearnum,1)),'-','color',[0 0.5 1]);
h4=plot(2007:2016,exp(CIs(1:yearnum,2)),'-','color',[0 0.5 1]);
line([2006.5 2016.5],[1 1],'color','k')
set(gca,'box','on','fontsize',16)
xlim([2006.5 2016.5])
ylabel('Year Multiplier','fontsize',16)
text(2007,6.5,'B','fontsize',16)

%%
set(gcf,'color','w')
export_fig /Users/kristenhunter-cevera/Desktop/Laboea1.pdf

%% TIME SERIES OF OBSERVED AND EXPECTED DENSITIES:

clf, hold on
h2=plot(time,exp_dens,'b.-','linewidth',3);
for j=1:yearnum
    h1=plot(time(~isnan(dens(:,j)),j),dens(~isnan(dens(:,j)),j),'o-','color',[0.5 0.5 0.5]);
end

xlim([datenum('1-0-2007') datenum('1-0-2017')])
set(gca,'fontsize',16,'box','on')
ylabel('Density (cells/mL)','fontsize',16)
datetick('x','yyyy','keeplimits','keepticks')
legend([h1(1); h2(1)],'Observed density','model fit')

%%
set(gcf,'color','w')
export_fig /Users/kristenhunter-cevera/Desktop/Laboea2.pdf
