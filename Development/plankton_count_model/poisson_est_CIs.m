function [CIs]=poisson_est_CIs(counts,volumes,xmin,maxlogL,opts,year0)
%Confidence intervals for estimates of year and season effect for Poisson
%model of plankton counts:

%% We do this via a profile log likelihood:

%Suppose interested in g1:
%log L_prof(g1) = max log L(B,G) with g1 fixed. Aprrox 1-a confidence
%interval for g1 contains all values of g1 satisfying:
% 2*(log L_prof(g1_hat) - logL(g1)) <= X2_1(a)  ...or...
% 2*(maxlogL - (-fval)) <= chi2inv(0.95,1) %in more matlabby terms :)

%but for an over inflated CI to account for overdispersion, we use a
%constructed Pearson's statistic and c-value:
%X2 = sum over i sum over j (y_ij - y_ij-hat)**2/y_ij-hat
%c = max (1, X2 / (I*J - (I + J))
%2*(log Lprof(beta_1-hat) - log Lprof(beta_1)) < 3.84 * c

%However, seasons or years that have zero counts for all the years or
%seasons (parameter is essentially zero), we shouldn't include them in
%trying to account for overdispersion, as they are, well, zero...

%We should be able to do this via a root finder - asking, what is the
%parameter value that results in a logL_prof that equal to the bound of
%logL_bnd=max_logL - 0.5*chi2inv(0.95,1); %This is the value above which the the true theta may be in

%To find the parameter than results in this bound, use a solver (rather than a for loop)
% We can use the root finding solver, fzero, but it will be expecting a
% search region that includes a sign change:

%opts = optimoptions('fminunc','MaxFunctionEvaluations',100000,'MaxIterations',1000,'Display','off','Algorithm','quasi-newton');
fzero_opts=optimset('Display','off','TolX',1e-5,'TolFun',1e-4); %options for fzero

%For a normal Poisson model, the bound is:
%logL_bnd=maxlogL - 0.5*chi2inv(0.95,1); %1 id degrees of freedom...not sure why...

[seasonnum,yearnum]=size(counts);
n=yearnum+seasonnum;

%for overdispersed data:
est_year=repmat(xmin(1:yearnum)',seasonnum,1);
est_seasons=repmat(xmin(yearnum+1:seasonnum+yearnum),1,yearnum);
exp_dens=exp(est_year + est_seasons);
exp_counts=exp_dens.*volumes;

%to estimate overdisperion, only include nonzero estimates:
zeroind=find(exp(xmin) < 1e-5); %pretty much zero - may need to adjust this cutoff
nonzero=setxor(zeroind,1:(seasonnum+yearnum));
jj=find(nonzero <= yearnum);  %year parameter - matches to column
ii=find(nonzero > yearnum); %should be a season parameter, matches to a row

fprintf('Double check: found %2.0f seasons and %2.0f years with all zero counts \n',seasonnum-length(ii),yearnum-length(jj));
fprintf('Excluding these from overdispersion calculation\n')

nonzero_counts=counts(nonzero(ii)-yearnum,nonzero(jj));
nonzero_expcounts=exp_counts(nonzero(ii)-yearnum,nonzero(jj));

X2 = nansum(nansum(((nonzero_counts-nonzero_expcounts).^2)./nonzero_expcounts)); %form the Pearson statistic:
[I,J]=size(nonzero_counts);
c = max(1,X2/(I*J - (I+J))); %use this value in combination to find bound for CI

logL_bnd=maxlogL - 0.5*chi2inv(0.95,1)*c; %chi2inv(0.95,1) = 3.84
%logL_bnd=maxlogL - 0.5*chi2inv(0.95,1); %regular bound assuming Poisson distribution is appropriate

%%

CIs=nan(n,2);

for ind=setxor(year0,1:n)
   % for ind=7%2:36 %don't attempt a confidence interval for param set as 0
    
    zeroflag=0; %current param is not zero
    
    %first we help fzero out by finding where the bounds might be for the lower and then upper CI:
    
    %for the lower bound: decrease param until find a negative:    
    %keyboard 
    test_param=xmin(ind)-1; %an abs number as could be neg or pos...
    x0=xmin(setxor([ind; year0],1:n)); %for starting point for solver, need to remove ind of param for CI as well as param that is set to 0
    %x0=[xmin(2:ind-1); xmin(ind+1:36)]; %remove ind of param for CI, assumes 1st param set to 0
    
    [bnd_test, x_test]=eval_param_for_CI(counts,volumes,ind,test_param,x0,logL_bnd,opts,year0);
    
    k=0;
    while bnd_test > 0  && k<10 %keep going!
        k=k+1;
        test_param=-10*abs(test_param); %an abs number as could be neg or pos...
        bnd_test=eval_param_for_CI(counts,volumes,ind,test_param,x_test,logL_bnd,opts,year0); %use the previous solver param returns as start points for the next point
    end
    
    
     if exp(xmin(ind)) < 1e-5 && k==10  %Special case where the parameter wants to go to zero
        %(cases where 0 counts were observed for a particular season or year). In these cases,
        %skip the lower bound, but estimate the upper bound.
        lower_CI=-Inf;
        zeroflag=1; %then this param is truly trying to be zero...
    else
        %then use as a search interval:
        %keyboard
        lower_CI=fzero(@(param_value) eval_param_for_CI(counts,volumes,ind,param_value,x_test,logL_bnd,opts,year0),[test_param xmin(ind)], fzero_opts);
    end
    
    %keyboard
    %and the upper bound!
    test_param=xmin(ind)+1; %an abs addition as could be neg or pos...
    x0=xmin(setxor([ind; year0],1:n)); %remove ind of param and 0 param for CI calc

    [bnd_test, x_test]=eval_param_for_CI(counts,volumes,ind,test_param,x0,logL_bnd,opts,year0); %calculate regular

    k=0;
    while bnd_test > 0 && k< 300 %keep going!
        k=k+1;
        test_param=test_param+1; %an abs number as could be neg or pos...
%        test_param=10*abs(test_param); %an abs number as could be neg or pos...
        [bnd_test, x_test]=eval_param_for_CI(counts,volumes,ind,test_param,x_test,logL_bnd,opts,year0); %use the previous solver param returns as start points for the next point
    end
    
    if abs(bnd_test) > 1e25
        disp('Oooo - have a very large number, make sure machine is handling it well!')
        keyboard
    end
    
    upper_CI=fzero(@(param_value) eval_param_for_CI(counts,volumes,ind,param_value,x_test,logL_bnd,opts,year0),[xmin(ind) test_param], fzero_opts);
    
    CIs(ind,:)=[lower_CI upper_CI]; %and record those findings!
    fprintf('Completed CIs for parameter %2.0f \n',ind)
    
end


% grid search, if really sticky:
%     x0=[xmin(2:ind-1); xmin(ind+1:36)];
%     logL_rec=[];
%     for param=[-100:10:0 5:5:50]
%         [bnd_test, xB]=eval_param_for_CI(counts,volumes,ind,param,x0,logL_bnd,opts);
%         logL_rec=[logL_rec; bnd_test];
%         x0=xB;
%     end
%end

