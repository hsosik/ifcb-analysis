function [prob]=loglike_12params_phours_plateau(Einterp,N_dist,theta,volbins,hr1,hr2)

% theta are parameters gmax, b, E_star and dmax, Einterp is the
% interpolated light for the day, s is the noise parameter, N is the
% actual cell counts and volbins are the cell size bins
lb=[0 0 0 0 0 0 0 0 0 10 10 1];

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


if any(theta < lb)
    prob=NaN;
else
q=hr2-hr1;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
 %create all B matrices for the hours:
 
B_day1=zeros(57,57,q);   
B_day2=zeros(57,57,q);

for t=(hr1-1):(hr2-2)
     B1=matrix_const_plateau(t,Einterp,volbins,b1,dmax1,E_star1,gmax1);
     B_day1(:,:,t-hr1+2)=B1;
     B2=matrix_const_plateau(t,Einterp,volbins,b2,dmax2,E_star2,gmax2);
     B_day2(:,:,t-hr1+2)=B2;
end


%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Nt=N_dist(:,1)+0.001; %tack on a little bit of cell mass for the distributions
% Y1=lognpdf(volbins,M1,S);
% Y2=lognpdf(volbins,M2,S);
% 
% Nt1=(f*sum(N_dist(:,1))*(Y1./sum(Y1)))';
% Nt2=((1-f)*sum(N_dist(:,1))*(Y2./sum(Y2)))';
% Nt1=f*sum(N_dist(:,1))*Vt1;
% Nt2=(1-f)*sum(N_dist(:,1))*Vt2;


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
        disp(['12param...simdist has a nan? theta:' num2str(theta)])
%         keyboard 
    end

end

%Likelihood calculation
ind= simdist==0;
simdist(ind)=realmin; %can't have any zeros in simdist

 logL= sum(sum(N_dist(:,hr1:hr2).*log(simdist)));
 if isnan(logL) || isinf(logL)
     keyboard
 end

prob=-logL;
end