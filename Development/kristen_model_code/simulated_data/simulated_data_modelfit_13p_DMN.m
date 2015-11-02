%% Okay, now for some data simulations!


hr1=7; hr2=25;

lb=-[1e-4 1e-4 1e-4 1e-4 1e-4 1e-4 1e-4 1e-4 1e-4 10 10 1 1e-4];
ub=[1 15 max(Einterp) 1 1 15 max(Einterp) 1 0.5 50 50 10 1e4];

a1=-1*eye(13);
a2=eye(13);
A=zeros(26,13);
A(1:2:25,:)=a1;
A(2:2:26,:)=a2;

B=zeros(26,1);
B(1:2:25)=lb;
B(2:2:26)=ub;
%%
theta6=[0.05   0.0001    max(Einterp)   0.004   0.16       8    0.0001      0.99999        0.40       31       36      4.5      700];

ms=MultiStart('Display','off','TolX',1e-8,'UseParallel','always','StartPointsToRun','bounds');
opts=optimset('Display','off','TolX',1e-8,'Algorithm','interior-point','UseParallel','always','MaxIter', 3000,'MaxFunEvals',10000);

% start_points=[0.2*rand(40,1) 6*rand(40,1) max(Einterp)*rand(40,1) 0.1*rand(40,1) 0.2*rand(40,1) 6*rand(40,1) max(Einterp)*rand(40,1) 0.1*rand(40,1) 0.5*rand(40,1) 30*rand(40,1)+20 30*rand(40,1)+20 10*rand(40,1)+1 1e6*rand(40,1)];
% tpoints = CustomStartPointSet(start_points);
x0=[theta6];
    
modelfits_theta6_dmn_13=cell(100,3); simdata_theta6=cell(100,1);
%%
for q=51:75
    
    disp(['Q; ' num2str(q)])
    %simulate a Dirichlet sample: no MN smapling yet:
     dirsample=simdata_dirichlet_sample_plt(Einterp,N_dist,theta6,volbins,hr1,hr2);
     dirsample=[nan(57,6) dirsample];
     simdata_theta5{q}=dirsample;
%     Nproj=[nan(57,6) 5000*dirsample];
%     Nproj=simdata_theta4{q,3};
%     modelfits_theta1_dmn_ws{q,3}=Nproj;
 

    %MultiStart:
    tpoints = CustomStartPointSet([0.2*rand(40,1) 6*rand(40,1) max(Einterp)*rand(40,1) 0.1*rand(40,1) 0.2*rand(40,1) 6*rand(40,1) max(Einterp)*rand(40,1) 0.1*rand(40,1) 0.5*rand(40,1) 30*rand(40,1)+20 30*rand(40,1)+20 10*rand(40,1)+2 1e4*rand(40,1)]);

    problem = createOptimProblem('fmincon','x0',x0,'objective',@(theta) loglike_DMN_13params_phours_plateau(Einterp,dirsample,theta,volbins,hr1,hr2),'Aineq',A,'bineq',B,'options',opts);
    [xmin,fmin,exitflag,output,soln] = run(ms,problem,tpoints);
    
    temp=zeros(40,16);
    stpts=zeros(40,13);
    temp=zeros(40,16);
    c=1;
    for j=1:length(soln)
        %check to see if all start points led to an individual solution or
        %not (MultiSTart will only return unique solutions)
        g=cell2mat(soln(j).X0);
        if length(g)==13 %only one start_point led to that solution
            stpts(c,:)=g;
            temp(c,1:13)=soln(j).X;
            temp(c,14)=soln(j).Fval;
            temp(c,15)=growth_rate_phours_12params_plateau(Einterp,volbins,N_dist,temp(c,1:12),hr1,hr2);
            temp(c,16)=soln(j).Exitflag;
            c=c+1;
        else
            num=length(g)/13;
            stpts(c:c+num-1,:)=squeeze(reshape(g',1,13,num))';
            temp(c:c+num-1,1:13)=repmat(soln(j).X,num,1);
            temp(c:c+num-1,14)=repmat(soln(j).Fval,num,1);
            temp(c:c+num-1,15)=repmat(growth_rate_phours_12params_plateau(Einterp,volbins,N_dist,temp(c,1:12),hr1,hr2),num,1);
            temp(c:c+num-1,16)=repmat(soln(j).Exitflag,num,1);
            c=c+num;
        end
    end
    
    kk=find(temp(:,1)~=0);
    temp=temp(kk,:);
    stpts=stpts(kk,:);
        
    [s ii]=sort(temp(:,14));
   
    modelfits_theta6_dmn_13{q,1}=temp(ii(1),:);
    modelfits_theta6_dmn_13{q,2}=temp;
    modelfits_theta6_dmn_13{q,3}=stpts;

end
