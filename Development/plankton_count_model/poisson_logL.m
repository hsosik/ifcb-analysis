function neglogL = poisson_logL(theta,counts,volumes,year0)
% log likelihhod function for poisson model of time series plankton counts

%the model:

%for each "season" (here, a two-week period) in each year, there are
%replicate manual counts of a plankton:
%Yij = sum Yijk over k, where K=number of replicates
%along side these counts are individual volume measurements, Vij= sum Vijk

%For a Poisson assumption, Yij ~ Posisson(mu_ij * Vij), where mu_ij =
%exp(Bi + Gj), the mean has a year effect, Bi and a seasonal effect, Gj,
%and is in an exponential to assure that it is positive. So there will be
%10 yearly effects and 26 seasonal effects. For identifiability, we can set
%B1 = 0, otherwise, you could get several different combinations of parameters that would
%result in the same likelihood values...With B1=0, the yearly effects are
%then interpretted relative to this year.

%The Poisson pmf is:
%pv(yij)= [ mu_ij * vij)^yij * exp(-mu_ij*vij) ] / yij!, putting the pieces
%togther, the log likelihood then becomes:

%log(pv(yij)) = yij[log(mu_ij) + log(vij)] - (mu_ij*vij)
%             = yij[Bi+Gj + log(vij)] - (exp(Bi + Gj)*vij)

%then then the log likelihood woud be:
% log L(B,G) = sum(i=1)^10 sum(j=1)^26  yij[Bi+Gj + log(vij)] - (exp(Bi + Gj)*vij)
%The yij! factorial in the denominator is ignored in the maximum log likelihood evaluation
% as this does not depend on the parameter
[seasonnum,yearnum]=size(counts);

%I've constructed theta to be a column vector of first the year effects
%(beta) and then the season effects (gamma). Year index to sawp out as zero
%is placed in expecting this structure:
theta=[theta(1:year0-1); 0; theta(year0:end)]; %force beta1 to be 0 for identifability
%theta=[theta(1:10); 0; theta(11:end)]; %force gamma1 to be 0 for identifability

if size(theta,1) ~= sum(size(counts)) %should have parameters for both number of years and seasons
    keyboard
end

betas=repmat(theta(1:yearnum)',seasonnum,1); %year effects (26 x 10)
gammas=repmat(theta(yearnum+1:seasonnum+yearnum),1,10); %season effects (26 x 10)

%matrix is season x year; 26 x 10
matlogL = counts.*(betas+gammas + log(volumes)) - exp(betas+gammas).*volumes;
logL=nansum(nansum(matlogL));
neglogL=-logL;

