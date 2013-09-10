function [mu mu1 mu2 p1 p2]=growth_rate_phours_12params_plateau(Einterp,volbins,N_dist,theta,hr1,hr2)
%really, only the first hour of N_dist or Vhists is needed

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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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
        disp('hmmm...simdist has a nan?')
         keyboard 
    end

end


mu=(log(sum((Nt1(:,end)+Nt2(:,end)))./sum(Nt1(:,1)+Nt2(:,1))));
mu1=log(sum((Nt1(:,end)))./sum(Nt1(:,1)));
mu2=log(sum((Nt2(:,end)))./sum(Nt2(:,1)));

p1=sum(Nt1(:,end))./sum(Nt1(:,end)+Nt2(:,end));
p2=sum(Nt2(:,end))./sum(Nt1(:,end)+Nt2(:,end));