function neglogL = poisson_logL_prof(theta0,counts,volumes,ind,param_est,year0)
% profile log likelihhod function for poisson model of time series plankton
% counts with specified parameter held constant

%input theta0 should be 34x1; 2 other parameters come from holding one param constant and then
%requiring a year effect to be 0 for calculating the profile log likelihood

[seasonnum,yearnum]=size(counts);
n=yearnum+seasonnum;

theta=nan(n,1);
theta(setxor([ind; year0],1:n))=theta0; %fill in theta with parameters used by solver
theta(ind)=param_est;  %replace parameter with specified value from fzero solver (evaluating likelihood at this parameter value!)
theta(year0)=-nansum(theta(1:yearnum)); %replace beta with identificability constraint

%to calculate, must put these parameters back in their correct locations:
% theta=[theta(1:ind0); 0; theta(ind0:end)]; %for identifiability
% 
% %construct full theta by swapping in fixed parameter:
% if ind==1
%     theta=[param_est; theta];
% elseif ind==36
%     theta=[theta; param_est];
% else
%     theta=[theta(1:ind-1); param_est; theta(ind:end)];
% end

betas=repmat(theta(1:yearnum)',seasonnum,1); %year effects (26 x 10)
gammas=repmat(theta(yearnum+1:n),1,yearnum); %season effects (26 x 10)

%matrix is season x year; 26 x 10
matlogL = counts.*(betas+gammas + log(volumes)) - exp(betas+gammas).*volumes;
logL=nansum(nansum(matlogL));
neglogL=-logL;
