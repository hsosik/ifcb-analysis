function dirsample=simdata_dirichlet_sample_7p_plt(Einterp,N_dist,theta,volbins,hr1,hr2)

gmax=theta(1);
b=theta(2);
E_star=theta(3);
dmax=theta(4);
m1=theta(5);
sigma=theta(6);
s=theta(7);

q=hr2-hr1;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% create all B matrices for the hours:
 
B_day=zeros(57,57,q);   

for t=(hr1-1):(hr2-2)
     B1=matrix_const_plateau(t,Einterp,volbins,b,dmax,E_star,gmax);
     B_day(:,:,t-hr1+2)=B1;
end


% Project forward each subcomponent: %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

y1=normpdf(1:57,m1,sigma);
y1(y1==0)=realmin;
Nt=sum(N_dist(:,hr1))*(y1./sum(y1));

Nt=Nt';

simdist(:,1)=Nt./sum(Nt);  %Only if starting hour has no zeros!

for t=1:q
    
    Nt(:,t+1)=B_day(:,:,t)*Nt(:,t);           %project forward with the numbers
    simdist(:,t+1)=Nt(:,t+1)/sum(Nt(:,t+1)); %normalize to get distribution for likelihood
     
    if any(isnan(simdist(:,t+1))) %just in case
        disp(['DMN 13param...simdist has a nan? theta:' num2str(theta)])
%         keyboard 
    end
end

%simdist is then used to generate aample from the Dirichlet distribution:

dirsample=zeros(57,q);
for i=1:q+1
dirsample(:,i)=gamrnd(s*simdist(:,i),1);
dirsample(:,i)=dirsample(:,i)./sum(dirsample(:,i));
dirsample(:,i)=mnrnd(sum(N_dist(:,hr1+i-1)),dirsample(:,i));
end

end