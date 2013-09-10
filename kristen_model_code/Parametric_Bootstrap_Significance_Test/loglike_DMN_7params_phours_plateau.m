function [prob]=loglike_DMN_7params_phours_plateau(Einterp,N_dist,theta,volbins,hr1,hr2)

% theta are parameters gmax, b, E_star and dmax, Einterp is the
% interpolated light for the day, s is the noise parameter, N is the
% actual cell counts and volbins are the cell size bins

gmax=theta(1);
b=theta(2);
E_star=theta(3);
dmax=theta(4);
m1=theta(5);
sigma=theta(6);
s=100*theta(7);

q=hr2-hr1;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% create all B matrices for the hours:
 
B_day=zeros(57,57,q);   

for t=(hr1-1):(hr2-2)
     B1=matrix_const_plateau(t,Einterp,volbins,b,dmax,E_star,gmax);
     B_day(:,:,t-hr1+2)=B1;
end


%% Project forward each subcomponent: %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

y1=normpdf(1:57,m1,sigma);
Nt=sum(N_dist(:,hr1))*(y1./sum(y1));
Nt=Nt';

simdist=Nt./sum(Nt);  %Only if starting hour has no zeros!

for t=1:q %t doesn't corresponding to the actaul hours anymmore
    
    Nt(:,t+1)=B_day(:,:,t)*Nt(:,t);           %project forward with the numbers
    simdist(:,t+1)=Nt(:,t+1)./sum(Nt(:,t+1)); %normalize to get distribution for likelihood
    
end

if any(any(isnan(simdist))) %just in case
    disp(['DMN 13param...simdist has a nan? theta:' num2str(theta)])
    %         keyboard
end



%% Now calculate the log likelihood using the Dirichlet Multinomial distribution: %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%specifiy the expected distribution:
alpha=s*simdist;
TotN=sum(N_dist);

logL=zeros(q+1,1);
for t=1:q+1
C = gammaln(s) - gammaln(TotN(:,t+hr1-1)+s); %constant out in front
logL(t)=C+sum(gammaln(N_dist(:,t+hr1-1)+alpha(:,t)) - gammaln(alpha(:,t)));
end

% if any(isnan(logL))
%     keyboard
% end

prob=-sum(logL); %negative for the minimiation routine fmincon

