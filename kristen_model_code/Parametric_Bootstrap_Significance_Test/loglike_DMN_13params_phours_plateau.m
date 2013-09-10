function [prob]=loglike_DMN_13params_phours_plateau(Einterp,N_dist,theta,volbins,hr1,hr2)

% theta are parameters gmax, b, E_star and dmax, Einterp is the
% interpolated light for the day, s is the noise parameter, N is the
% actual cell counts and volbins are the cell size bins

gmax1=theta(1);
b1=theta(2);
E_star1=theta(3);
dmax1=theta(4);
gmax2=theta(5);
b2=theta(6);
E_star2=theta(7);
dmax2=theta(8);
f=theta(9); %fraction of starting distribution
m1=theta(10);
m2=theta(11);
sigma=theta(12);
s=100*theta(13);

q=hr2-hr1;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% create all B matrices for the hours:
 
B_day1=zeros(57,57,q);   
B_day2=zeros(57,57,q);

for t=(hr1-1):(hr2-2)
     B1=matrix_const_plateau(t,Einterp,volbins,b1,dmax1,E_star1,gmax1);
     B_day1(:,:,t-hr1+2)=B1;
     B2=matrix_const_plateau(t,Einterp,volbins,b2,dmax2,E_star2,gmax2);
     B_day2(:,:,t-hr1+2)=B2;
end


%% Project forward each subcomponent: %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

y1=normpdf(1:57,m1,sigma);
y2=normpdf(1:57,m2,sigma);

Nt1=f*sum(N_dist(:,hr1))*(y1./sum(y1));
Nt2=(1-f)*sum(N_dist(:,hr1))*(y2./sum(y2));

Nt1=Nt1';
Nt2=Nt2';

simdist(:,1)=(Nt1+Nt2)./sum(Nt1+Nt2);  %Only if starting hour has no zeros!

for t=1:q
    
    Nt1(:,t+1)=B_day1(:,:,t)*Nt1(:,t);           %project forward with the numbers
    Nt2(:,t+1)=B_day2(:,:,t)*Nt2(:,t);
    
    simdist(:,t+1)=(Nt1(:,t+1)+Nt2(:,t+1))./sum(Nt1(:,t+1)+Nt2(:,t+1)); %normalize to get distribution for likelihood
     
    if any(isnan(simdist(:,t+1))) %just in case
        disp(['DMN 13param...simdist has a nan? theta:' num2str(theta)])
%         keyboard 
    end

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

