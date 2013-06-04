% load '/Users/kristenhunter-cevera/Documents/MATLAB/Synechococcus/Fraction_Distribution_Model/Dirichlet_MN_model/Partial_hour_Dirichlet_MN_plateaugamma/benchtop_13DMN'
% load '/Users/kristenhunter-cevera/Documents/MATLAB/Synechococcus/Fraction_Distribution_Model/Dirichlet_MN_model/Onecomp_phours_DMN_plateuagamma/benchtop_7DMN_run_port3'
% load '/Users/kristenhunter-cevera/Documents/MATLAB/Synechococcus/Fraction_Distribution_Model/Dirichlet_MN_model/Onecomp_phours_DMN_plateuagamma/benchtop_7DMN_run_port2'
% %
load '/trunk/kristen_model_code/benchtop_13DMN_Ebnds' %13p solver runs
load '/trunk/kristen_model_code/benchtop_7DMN_run_port3'
load '/trunk/kristen_model_code/benchtop_7DMN_run_port2'
%
%if there is scaling in the solver runs:
% MR_dmn7(:,8)=100*MR_dmn7(:,8);
% MR_dmn13(:,14)=100*MR_dmn13(:,14);
%%
ms=MultiStart('Display','off','TolX',1e-5,'UseParallel','always','StartPointsToRun','bounds');
opts=optimset('Display','off','TolX',1e-8,'Algorithm','interior-point','UseParallel','always','MaxIter', 3000,'MaxFunEvals',10000);

% pathname='/Users/kristenhunter-cevera/Documents/MATLAB/Synechococcus/MVCO_Field_Data/2008_Field_data/input/';
pathname='/mnt/queenrose/FCB3_benchtop/SynLab2006/model/input/';
% load /Users/kristenhunter-cevera/Documents/MATLAB/Synechococcus/Fraction_Distribution_Model/Frac_Dist_Parital_Hours/indexes.mat
load /trunk/kristen_model_code/indexes.mat

hr1=7; hr2=25;
icsTol=0.3;

pbs_titles={'modelfits 7p model';'all solver fits 7p model';'modelfits 12p + s model';'all solver fits 12p model';'simulated data'};
lr_titles={'-logL 7p model';'-logL 12p + s model';'likelihood ratio'};
%%
for port=2:3
    
    filelist=dir([pathname 'day*_' num2str(port) '_data.mat']);
    eval(['indgood=indgood' num2str(port) ';'])
    
    eval(['MR_dmn13=modelresults_dmn_' num2str(port) ';'])
    eval(['MR_dmn7=modelresults_dmn_7p_' num2str(port) ';'])
    
    pvalues=zeros(length(filelist),2);
    
    for Q=1:length(indgood)
        
        PBS_sims=cell(500,5);
        LR_res=nan(500,3);
        
        x0_7=MR_dmn7(Q,2:8); %start_points
        x0_12=MR_dmn13(Q,2:13);
        
        filename=filelist(Q).name;
        day=str2num(filename(4:9));
        disp(['Two popn test for day: ' num2str(day) ' file#: ' num2str(Q)])
        
        eval(['load ' pathname filename])
        
        %Fix and Interpolate Light Data:
        ind= Edata(:,2) < 6; %deal with extra noise (dark current values)
        noise=mean(Edata(ind,2));
        Edata(:,2)=Edata(:,2)-noise;
        ind = Edata(:,2) < 0;
        Edata(ind,2) = 0;
        ind=find(Edata(:,2) < 4);
        threshold=mean(Edata(ind,2)) + std(Edata(ind,2));
        ii=find(Edata(ind,2) > threshold); %find values that are still too noisy
        Edata(ind(ii),2)=0;
        indh=find(Edata(:,1) < 1 | Edata(:,1) > 16.5); %for spurious light values at end of day...
        ind2=find(Edata(indh,2) > threshold);
        Edata(indh(ind2),2)=0;
        
        clear ind indh ind2
        
        time=0:(1/6):25;
        nnind = find(~isnan(Edata(:,2)));
        Einterp = interp1(Edata(nnind,1),Edata(nnind,2),time);
        Einterp(find(isnan(Einterp))) = 0;
        
        lr_orig=-2*(MR_dmn13(Q,15)-MR_dmn7(Q,9));
        disp(['LR to test against: ' num2str(lr_orig)])
        
        % Set bounds:
      % Set bounds:
    %12 param DMN model:
    lb12=-[1e-4 1e-4 1e-4 1e-4 1e-4 1e-4 1e-4 1e-4 1e-4 10 10 1];
    ub12=[1 15 max(Einterp) 1 1 15 max(Einterp) 1 0.5 50 50 10];
    
    a1=-1*eye(12);
    a2=eye(12);
    A12=zeros(24,12);
    A12(1:2:23,:)=a1;
    A12(2:2:24,:)=a2;
    
    B12=zeros(24,1);
    B12(1:2:23)=lb12;
    B12(2:2:24)=ub12;
    
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
    for w=1:100
        
        %Simulate from one component:
        [simdist7]=simdata_dirichlet_sample_7p_plt(Einterp,N_dist,[MR_dmn7(Q,2:7) 100*MR_dmn7(Q,8)],volbins,hr1,hr2); %because s is scaled by 100 in the solver!
        simdist7=[nan(57,6) simdist7];
        
        PBS_sims{w,5}=simdist7;
        
        %Fit both models:
        %7 params:
        tpoints7 = CustomStartPointSet([0.2*rand(10,1) 6*rand(10,1) max(Einterp)*rand(10,1) 0.1*rand(10,1) 30*rand(10,1)+20 10*rand(10,1)+2 1e4*rand(10,1)]);
        problem = createOptimProblem('fmincon','x0',x0_7,'objective',@(theta) loglike_DMN_7params_phours_plateau(Einterp,simdist7,theta,volbins,hr1,hr2),'Aineq',A7,'bineq',B7,'options',opts);
        [xmin7,fmin7,exitflag7,~,soln7] = run(ms,problem,tpoints7);
        
        %12params solver run + s param separate solve:
        tpoints12 = CustomStartPointSet([0.2*rand(20,1) 6*rand(20,1) max(Einterp)*rand(20,1) 0.1*rand(20,1) 0.2*rand(20,1) 6*rand(20,1) max(Einterp)*rand(20,1) 0.1*rand(20,1) 0.5*rand(20,1) 30*rand(20,1)+20 30*rand(20,1)+20 10*rand(20,1)+2]);
        problem = createOptimProblem('fmincon','x0',x0_12,'objective',@(theta) loglike_12params_phours_plateau(Einterp,simdist7,theta,volbins,hr1,hr2),'Aineq',A12,'bineq',B12,'options',opts);
        [xmin12,fmin12,exitflag12,~,soln12] = run(ms,problem,tpoints12);
        
        %open up the soln structure and if soluiton "converged"
        %13p model:
        temp12=zeros(20,14);
        c=1;
        for j=1:length(soln12)
            %check to see if all start points led to an individual solution or not (MultiSTart will only return unique solutions)
            g=cell2mat(soln12(j).X0);
            if length(g)==12 %only one start_point led to that solution
                temp12(c,1:12)=soln12(j).X;
                temp12(c,13)=soln12(j).Fval;
                temp12(c,14)=soln12(j).Exitflag;
                c=c+1;
            else
                num=length(g)/12; %more than one start point led to solution
                temp12(c:c+num-1,1:12)=repmat(soln12(j).X,num,1);
                temp12(c:c+num-1,13)=repmat(soln12(j).Fval,num,1);
                temp12(c:c+num-1,14)=repmat(soln12(j).Exitflag,num,1);
                c=c+num;
            end
        end
        %just in case have rows left as zeros
        qq=find(temp12(:,1)~=0);
        temp12=temp12(qq,:);
        
        %7p model:
        temp7=zeros(10,9);
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
        modelfits12=temp12;
        
        [sortlogL12 i12]=sort(temp12(:,13));
        if abs(sortlogL12(4)-sortlogL12(1)) < icsTol
            flag12 = 0;
        else
            flag12 = 1;
        end;
        
        [sortlogL7 i7]=sort(temp7(:,8));
        if abs(sortlogL7(4)-sortlogL7(1)) < icsTol
            flag7 = 0;
        else
            flag7 = 1;
        end;
        
        disp(['Flag12: ' num2str(flag12) ' Flag7: ' num2str(flag7)])
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% If flag12 =1 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        k12=1;
        while flag12 && k12 <= 4
            
            disp(['k12: ' num2str(k12)])
            k12=k12+1;
            x0_12=[0.2*rand 6*rand max(Einterp)*rand 0.1*rand 0.2*rand 6*rand max(Einterp)*rand 0.1*rand 0.5*rand 30*rand+20 30*rand+20 10*rand+2];

            
               %12params solver run + s param separate solve:
        tpoints12 = CustomStartPointSet([0.2*rand(20,1) 6*rand(20,1) max(Einterp)*rand(20,1) 0.1*rand(20,1) 0.2*rand(20,1) 6*rand(20,1) max(Einterp)*rand(20,1) 0.1*rand(20,1) 0.5*rand(20,1) 30*rand(20,1)+20 30*rand(20,1)+20 10*rand(20,1)+2]);
        problem = createOptimProblem('fmincon','x0',x0_12,'objective',@(theta) loglike_12params_phours_plateau(Einterp,simdist7,theta,volbins,hr1,hr2),'Aineq',A12,'bineq',B12,'options',opts);
        [xmin12,fmin12,exitflag12,~,soln12] = run(ms,problem,tpoints12);
        
        %open up the soln structure and if soluiton "converged"
        %13p model:
        temp12=zeros(20,14);
        c=1;
        for j=1:length(soln12)
            %check to see if all start points led to an individual solution or not (MultiSTart will only return unique solutions)
            g=cell2mat(soln12(j).X0);
            if length(g)==12 %only one start_point led to that solution
                temp12(c,1:12)=soln12(j).X;
                temp12(c,13)=soln12(j).Fval;
                temp12(c,14)=soln12(j).Exitflag;
                c=c+1;
            else
                num=length(g)/12; %more than one start point led to solution
                temp12(c:c+num-1,1:12)=repmat(soln12(j).X,num,1);
                temp12(c:c+num-1,13)=repmat(soln12(j).Fval,num,1);
                temp12(c:c+num-1,14)=repmat(soln12(j).Exitflag,num,1);
                c=c+num;
            end
        end
        %just in case have rows left as zeros
        qq=find(temp12(:,1)~=0);
        temp12=temp12(qq,:);
        
            modelfits12=[modelfits12; temp12];
            
            [sortlogL12 i12]=sort(modelfits12(:,13));
            if abs(sortlogL12(4)-sortlogL12(1)) < icsTol
                flag12 = 0;
            else
                flag12 = 1;
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
            temp7=zeros(15,9);
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
        
        %one param search for s parameter (over-dispersion parameter)
        [precis, fmin13]=fminbnd(@(s) loglike_DMN_phrs_plt_s_onlyparams(Einterp,simdist7,modelfits(i12(1),1:12),s,volbins,hr1,hr2),1e-4,1e4);
                
        PBS_sims{w,3}=[modelfits12(i12(1),1:12) precis fmin13 modelfits12(i12(1),end)];
        PBS_sims{w,4}=modelfits12;
        
        LR_res(w,1)=modelfits7(i7(1),8);
        LR_res(w,2)=fmin13;
        LR_res(w,3)=-2*(fmin13-modelfits7(i7(1),8)); %form the likelihood ratio
        disp(['Day: ' num2str(day) ' W: ' num2str(w) ' LR: ' num2str(LR_res(w,3))])
        
    end
    
    pval=find(LR_res(:,3) > lr_orig);
    pvalues_2008(filenum,:)=[day length(pval)/100];
    disp(['day: ' num2str(day) ' p-value: ' num2str(length(pval)/100)])
    
        eval(['save /mnt/queenrose/FCB3_benchtop/SynLab2006/model/twocomp_significance_tests/twocomp_test_day' num2str(day) '_' num2str(port) ' LR_res PBS_sims pval *titles'])
    end
    
    eval(['pvalues' num2str(port) '=pvalues'])
    eval(['save /mnt/queenrose/FCB3_benchtop/SynLab2006/model/twocomp_significance_tests/twocomp_signtest_port ' num2str(port) ' pvalues' num2str(port)])
    
end