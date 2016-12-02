function [bnd_test, x, fval]=eval_param_for_CI(counts,volumes,ind,param_value,x0,logL_bnd,opts,year0)
%each 'point' is a re-optimization to find the max likelihood, given the
%specified parameter:

[seasonnum,yearnum]=size(counts);
n=yearnum+seasonnum;

flag=1;
k=0;
while flag && k <=5 %only try 5 times... 
    k=k+1;
    try  
        [x, fval] = fminunc(@(theta) poisson_logL_prof(theta,counts,volumes,ind,param_value,year0),x0,opts);
        flag=0; %Sucessful solve!
    catch ME
        if (strcmp(ME.identifier,'MATLAB:roots:NonFiniteInput'))
            disp('hmmm...had a problem with these start points, trying a different one...')           
            x0=10*(rand(n-2,1)-0.5); %try a different starting point
        else
            disp('Don"t recognize this error...')
            keyboard
        end   
    end  
end

bnd_test=-fval-logL_bnd; %want this to be negative to find the window for the root solver