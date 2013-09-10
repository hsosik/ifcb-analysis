% load '/Users/kristenhunter-cevera/Documents/MATLAB/Synechococcus/Fraction_Distribution_Model/Dirichlet_MN_model/Partial_hour_Dirichlet_MN_plateaugamma/mvco_13par_dmn_2008B'
% load '/Users/kristenhunter-cevera/Documents/MATLAB/Synechococcus/Fraction_Distribution_Model/Dirichlet_MN_model/Onecomp_phours_DMN_plateuagamma/MVCO_7DMN_run_2008'
%
load '/trunk/kristen_model_code/mvco_13par_dmn_2008B';
load '/trunk/kristen_model_code/MVCO_7DMN_run_2008';
%
MR_dmn13=modelresults_dmn13_2008;
MR_dmn7=modelresults_dmn_7p_2008;

%if there is scaling in the solver runs:
% MR_dmn7(:,8)=100*MR_dmn7(:,8);
% MR_dmn13(:,14)=100*MR_dmn13(:,14);
%%
ms=MultiStart('Display','off','TolX',1e-5,'UseParallel','always','StartPointsToRun','bounds');
opts=optimset('Display','off','TolX',1e-8,'Algorithm','interior-point','UseParallel','always','MaxIter', 3000,'MaxFunEvals',10000);

% pathname='/Users/kristenhunter-cevera/Documents/MATLAB/Synechococcus/MVCO_Field_Data/2008_Field_data/input/';
pathname='mnt/queenrose/mvco/MVCO_Jan2008/model/input/'

filelist = dir([pathname 'day*data.mat']);
hr1=7; hr2=25;
icsTol=0.3;

pbs_titles={'modelfits 7p model';'all solver fits 7p model';'modelfits 13p model';'all solver fits 13p model';'simulated data'};
lr_titles={'-logL 7p model';'-logL 13p model';'likelihood ratio'};
%%
pvalues_2008=zeros(length(filelist),2);

for Q=1:length(filelist) %soem test days: [26 52 78 103 129 155 180 206 232]
    
    PBS_sims=cell(500,5);
    LR_res=nan(500,3);
    
    x0_7=MR_dmn7(Q,2:8); %start_points
    x0_13=MR_dmn13(Q,2:14);
    
    filename=filelist(Q).name;
    day=str2num(filename(4:9));
    disp(['Two popn test for day: ' num2str(day) ' file#: ' num2str(Q)])
    
    eval(['load ' pathname filename])
    
    %Fix and Interpolate Light Data:
    time=0:(1/6):25;
    nnind = find(~isnan(Edata(:,2)));
    Einterp = interp1(Edata(nnind,1),Edata(nnind,2),time);
    Einterp(find(isnan(Einterp))) = 0;
    
    lr_orig=-2*(MR_dmn13(Q,15)-MR_dmn7(Q,9));
    disp(['LR to test against: ' num2str(lr_orig)])
    
    % Set bounds:
    %13 param DMN model:
    lb13=-[1e-4 1e-4 1e-4 1e-4 1e-4 1e-4 1e-4 1e-4 1e-4 10 10 1 1e-4];
    ub13=[1 15 max(Einterp) 1 1 15 max(Einterp) 1 0.5 50 50 10 1e4];
    
    a1=-1*eye(13);
    a2=eye(13);
    A13=zeros(26,13);
    A13(1:2:25,:)=a1;
    A13(2:2:26,:)=a2;
    
    B13=zeros(26,1);
    B13(1:2:25)=lb13;
    B13(2:2:26)=ub13;
    
    %7 param DMN model:
    lb7=-[1e-4 1e-4 1e-4 1e-4 10 1 1e-4];
    ub7=[1 15 max(Einterp) 1 50 10 1e4];
    
    a1=-1*eye(7);
    a2=eye(7);
    A7=zeros(14,7);
    A7(1:2:13,:)=a1;
    A7(2:2:14,:)=a2;
    
    B7=zeros(14,1);
    B7(1:2:13)=lb7;
    B7(2:2:14)=ub7;
    
    % Now for the simulations:
    %
    for w=1:500
        
        %Simulate from one component:
        [simdist7]=simdata_dirichlet_sample_7p_plt(Einterp,N_dist,[MR_dmn7(Q,2:7) 100*MR_dmn7(Q,8)],volbins,hr1,hr2); %because s is scaled by 100 in the solver!
        simdist7=[nan(57,6) simdist7];
        
        PBS_sims{w,5}=simdist7;
        
        %Fit both models:
        %7 params:
        tpoints7 = CustomStartPointSet([0.2*rand(15,1) 6*rand(15,1) max(Einterp)*rand(15,1) 0.1*rand(15,1) 30*rand(15,1)+20 10*rand(15,1)+2 1e4*rand(15,1)]);
        problem = createOptimProblem('fmincon','x0',x0_7,'objective',@(theta) loglike_DMN_7params_phours_plateau(Einterp,simdist7,theta,volbins,hr1,hr2),'Aineq',A7,'bineq',B7,'options',opts);
        [xmin7,fmin7,exitflag7,~,soln7] = run(ms,problem,tpoints7);
        
        %13params solver run:
        tpoints13 = CustomStartPointSet([0.2*rand(25,1) 6*rand(25,1) max(Einterp)*rand(25,1) 0.1*rand(25,1) 0.2*rand(25,1) 6*rand(25,1) max(Einterp)*rand(25,1) 0.1*rand(25,1) 0.5*rand(25,1) 30*rand(25,1)+20 30*rand(25,1)+20 10*rand(25,1)+2 1e4*rand(25,1)]);
        problem = createOptimProblem('fmincon','x0',x0_13,'objective',@(theta) loglike_DMN_13params_phours_plateau(Einterp,simdist7,theta,volbins,hr1,hr2),'Aineq',A13,'bineq',B13,'options',opts);
        [xmin13,fmin13,exitflag13,~,soln13] = run(ms,problem,tpoints13);
        
        %open up the soln structure and if soluiton "converged"
        %13p model:
        temp13=zeros(25,15);
        c=1;
        for j=1:length(soln13)
            %check to see if all start points led to an individual solution or not (MultiSTart will only return unique solutions)
            g=cell2mat(soln13(j).X0);
            if length(g)==13 %only one start_point led to that solution
                temp13(c,1:13)=soln13(j).X;
                temp13(c,14)=soln13(j).Fval;
                temp13(c,15)=soln13(j).Exitflag;
                c=c+1;
            else
                num=length(g)/13; %more than one start point led to solution
                temp13(c:c+num-1,1:13)=repmat(soln13(j).X,num,1);
                temp13(c:c+num-1,14)=repmat(soln13(j).Fval,num,1);
                temp13(c:c+num-1,15)=repmat(soln13(j).Exitflag,num,1);
                c=c+num;
            end
        end
        %just in case have rows left as zeros
        qq=find(temp13(:,1)~=0);
        temp13=temp13(qq,:);
        
        %7p model:
        temp7=zeros(15,15);
        c=1;
        for j=1:length(soln7)
            %check to see if all start points led to an individual solution or not (MultiSTart will only return unique solutions)
            g=cell2mat(soln7(j).X0);
            if length(g)==7 %only one start_point led to that solution
                temp7(c,1:7)=soln7(j).X;
                temp7(c,8)=soln7(j).Fval;
                temp7(c,9)=soln7(j).Exitflag;
                c=c+1;
            else
                num=length(g)/7; %more than one start point led to solution
                temp7(c:c+num-1,1:7)=repmat(soln7(j).X,num,1);
                temp7(c:c+num-1,8)=repmat(soln7(j).Fval,num,1);
                temp7(c:c+num-1,9)=repmat(soln7(j).Exitflag,num,1);
                c=c+num;
            end
        end
        %just in case have rows left as zeros
        qq=find(temp7(:,1)~=0);
        temp7=temp7(qq,:);
        
        modelfits7=temp7;
        modelfits13=temp13;
        
        [sortlogL13 i13]=sort(temp13(:,14));
        if abs(sortlogL13(4)-sortlogL13(1)) < icsTol
            flag13 = 0;
        else
            flag13 = 1;
        end;
        
        [sortlogL7 i7]=sort(temp7(:,8));
        if abs(sortlogL7(4)-sortlogL7(1)) < icsTol
            flag7 = 0;
        else
            flag7 = 1;
        end;
        
        disp(['Flag13: ' num2str(flag13) ' Flag7: ' num2str(flag7)])
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% If flag13 =1 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        k13=1;
        while flag13 && k13 <= 4
            
            disp(['k13: ' num2str(k13)])
            k13=k13+1;
            x0_13(13)=1e4*rand;
            
            tpoints13 = CustomStartPointSet([0.2*rand(25,1) 6*rand(25,1) max(Einterp)*rand(25,1) 0.1*rand(25,1) 0.2*rand(25,1) 6*rand(25,1) max(Einterp)*rand(25,1) 0.1*rand(25,1) 0.5*rand(25,1) 30*rand(25,1)+20 30*rand(25,1)+20 10*rand(25,1)+2 1e4*rand(25,1)]);
            problem = createOptimProblem('fmincon','x0',x0_13,'objective',@(theta) loglike_DMN_13params_phours_plateau(Einterp,simdist7,theta,volbins,hr1,hr2),'Aineq',A13,'bineq',B13,'options',opts);
            [xmin13,fmin13,exitflag13,~,soln13] = run(ms,problem,tpoints13);
            
            %open up the soln structure and if soluiton "converged"
            %13p model:
            temp13=zeros(25,15);
            c=1;
            for j=1:length(soln13)
                %check to see if all start points led to an individual solution or not (MultiSTart will only return unique solutions)
                g=cell2mat(soln13(j).X0);
                if length(g)==13 %only one start_point led to that solution
                    temp13(c,1:13)=soln13(j).X;
                    temp13(c,14)=soln13(j).Fval;
                    temp13(c,15)=soln13(j).Exitflag;
                    c=c+1;
                else
                    num=length(g)/13; %more than one start point led to solution
                    temp13(c:c+num-1,1:13)=repmat(soln13(j).X,num,1);
                    temp13(c:c+num-1,14)=repmat(soln13(j).Fval,num,1);
                    temp13(c:c+num-1,15)=repmat(soln13(j).Exitflag,num,1);
                    c=c+num;
                end
            end
            %just in case have rows left as zeros
            qq=find(temp13(:,1)~=0);
            temp13=temp13(qq,:);
            modelfits13=[modelfits13; temp13];
            
            [sortlogL13 i13]=sort(modelfits13(:,14));
            if abs(sortlogL13(4)-sortlogL13(1)) < icsTol
                flag13 = 0;
            else
                flag13 = 1;
            end;
        end
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% If flag7 =1 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        k7=1;
        while flag7 && k7 <= 4
            
            disp(['k7: ' num2str(k7)])
            k7=k7+1;
            x0_7(7)=1e4*rand;
            
            tpoints7 = CustomStartPointSet([0.2*rand(15,1) 6*rand(15,1) max(Einterp)*rand(15,1) 0.1*rand(15,1) 30*rand(15,1)+20 10*rand(15,1)+2 1e4*rand(15,1)]);
            problem = createOptimProblem('fmincon','x0',x0_7,'objective',@(theta) loglike_DMN_7params_phours_plateau(Einterp,simdist7,theta,volbins,hr1,hr2),'Aineq',A7,'bineq',B7,'options',opts);
            [xmin7,fmin7,exitflag7,~,soln7] = run(ms,problem,tpoints7);
            
            %open up the soln structure and if soluiton "converged"
            %7p model:
            temp7=zeros(15,15);
            c=1;
            for j=1:length(soln7)
                %check to see if all start points led to an individual solution or not (MultiSTart will only return unique solutions)
                g=cell2mat(soln7(j).X0);
                if length(g)==7 %only one start_point led to that solution
                    temp7(c,1:7)=soln7(j).X;
                    temp7(c,8)=soln7(j).Fval;
                    temp7(c,9)=soln7(j).Exitflag;
                    c=c+1;
                else
                    num=length(g)/7; %more than one start point led to solution
                    temp7(c:c+num-1,1:7)=repmat(soln7(j).X,num,1);
                    temp7(c:c+num-1,8)=repmat(soln7(j).Fval,num,1);
                    temp7(c:c+num-1,9)=repmat(soln7(j).Exitflag,num,1);
                    c=c+num;
                end
            end
            %just in case have rows left as zeros
            qq=find(temp7(:,1)~=0);
            temp7=temp7(qq,:);
            
            modelfits7=[modelfits7; temp7];
            
            [sortlogL7 i7]=sort(modelfits7(:,8));
            if abs(sortlogL7(4)-sortlogL7(1)) < icsTol
                flag7 = 0;
            else
                flag7 = 1;
            end;
        end

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        PBS_sims{w,1}=modelfits7(i7(1),:);
        PBS_sims{w,2}=modelfits7;
        PBS_sims{w,3}=modelfits13(i13(1),:);
        PBS_sims{w,4}=modelfits13;
        
        LR_res(w,1)=modelfits7(i7(1),8);
        LR_res(w,2)=modelfits13(i13(1),14);
        LR_res(w,3)=-2*(modelfits13(i13(1),14)-modelfits7(i7(1),8)); %form the likelihood ratio
        disp(['Day: ' num2str(day) ' W: ' num2str(w) ' LR: ' num2str(LR_res(w,3))])
        
    end
    
    pval=find(LR_res(:,3) > lr_orig);
    pvalues_2008(filenum,:)=[day length(pval)/500];
    disp(['day: ' num2str(day) ' p-value: ' num2str(length(pval)/500)])
    eval(['save /mnt/queenrose/mvco/MVCO_Jan2008/model/twocomp_significance_tests/twocomp_test_day' num2str(day) ' LR_res PBS_sims pval'])
end

save /mnt/queenrose/mvco/MVCO_Jan2008/model/twocomp_significance_tests/twocomp_signtest_2008 pvalues_2008

