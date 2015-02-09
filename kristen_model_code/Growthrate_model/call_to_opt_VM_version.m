%main script to process both benchtop and field data using the dirichlet
%multinomial distribution:

%script is set up to run batches of random startpoints using multistart as
%this seems to be faster than running fmincon one solver run at time to
%find the answer:

%some front matter:
hr1=7; hr2=25;

restitles={'day';'gmax1';'b1';'E*1';'dmax1';'gmax2';'b2';'E*2';'dmax2';'proportion';'m1';'m2';'sigma';'s';'-logL';'mu';'mu1';'mu2';'ending proportion 1';'ending proportion 2'; 'exitflag';'number solver runs'};
notes='E* bounds are from 0 to max(Einterp)';

ms=MultiStart('Display','off','TolX',1e-5,'UseParallel','always','StartPointsToRun','bounds');
opts=optimset('Display','off','TolX',1e-8,'Algorithm','interior-point','UseParallel','always','MaxIter', 3000,'MaxFunEvals',10000);
icsTol=0.2;
tolvec=[0.01 0.01 100 0.005 0.01 0.01 100 0.005 0.01 0.5 0.5 0.5 10];

% for
%year=2009;

switch year
    case 2003
        yearlabel='May';
    case 2004
        yearlabel='Apr';
    case 2005
        yearlabel='Apr';
    case 2006
        yearlabel='May';
    case 2007
        yearlabel='Mar';
    otherwise
        yearlabel='Jan';
end

eval(['pathname=''/mnt/lab_data/MVCO/FCB/MVCO_' yearlabel num2str(year) '/model/input_beadmean_Jan2015/'';'])
eval(['savepath=''/mnt/lab_data/MVCO/FCB/MVCO_' yearlabel num2str(year) '/model/'';']);

filelist = dir([pathname 'day*data.mat']);

% setup result variables:
modelresults=zeros(length(filelist),22);
allmodelruns=cell(length(filelist),2);

%
for filenum=1:length(filelist)
    
    filename=filelist(filenum).name;
    day=str2num(filename(4:9));
    
%     if ~isempty(find(daylist==day))
        disp(['optimizing day: ' num2str(day) ' file#: ' num2str(filenum)])
        
        eval(['load ' pathname filename])
        
        %Fix and Interpolate Light Data:
        time=0:(1/6):25;
        nnind = find(~isnan(Edata(:,2)));
        Edata=Edata(nnind,:);
        [unqE eind]=unique(Edata(:,1));
        Einterp = interp1(Edata(eind,1),Edata(eind,2),time);
        Einterp(find(isnan(Einterp))) = 0;
        
        %Set bounds:
%         lb=-[1e-4 1e-4 1e-4 1e-4 1e-4 1e-4 1e-4 1e-4 1e-4 10 10 1 1e-4];
%         ub=[1 15 max(Einterp) 1 1 15 max(Einterp) 1 0.5 50 50 10 1e4];
        lb=-[1e-4 1e-4 1e-4 1e-4 1e-4 1e-4 1e-4 1e-4 1e-4 5 5 1 1e-4];
        ub=[1 15 max(Einterp) 1 1 15 max(Einterp) 1 0.5 50 50 15 1e4];
        
        a1=-1*eye(13);
        a2=eye(13);
        A=zeros(26,13);
        A(1:2:25,:)=a1;
        A(2:2:26,:)=a2;
        
        B=zeros(26,1);
        B(1:2:25)=lb;
        B(2:2:26)=ub;
        %
        %     qq=find(MR_param12(:,1)==day);
        %     x0=[MR_param12(qq(1),2:13) 1e2];
        
        %         stream = RandStream.getGlobalStream;
        %         reset(stream)
        x0=[0.2*rand 6*rand max(Einterp)*rand 0.1*rand 0.2*rand 6*rand max(Einterp)*rand 0.1*rand 0.5*rand 30*rand+20 30*rand+20 10*rand+2 1e4*rand]; %random start point
        
        tpoints = CustomStartPointSet([0.2*rand(40,1) 6*rand(40,1) max(Einterp)*rand(40,1) 0.1*rand(40,1) 0.2*rand(40,1) 6*rand(40,1) max(Einterp)*rand(40,1) 0.1*rand(40,1) 0.5*rand(40,1) 30*rand(40,1)+20 30*rand(40,1)+20 10*rand(40,1)+2 1e4*rand(40,1)]);
        
        problem = createOptimProblem('fmincon','x0',x0,'objective',@(theta) loglike_DMN_13params_phours_plateau(Einterp,N_dist,theta,volbins,hr1,hr2),'Aineq',A,'bineq',B,'options',opts);
        [xmin,fmin,exitflag,~,soln] = run(ms,problem,tpoints);
        
        %open up the soln sturcutre:
        temp=zeros(40,16);
        start_points=zeros(40,13);
        temp=zeros(40,16);
        c=1;
        
        for j=1:length(soln)
            %check to see if all start points led to an individual solution or
            %not (MultiSTart will only return unique solutions)
            g=cell2mat(soln(j).X0);
            if length(g)==13 %only one start_point led to that solution
                start_points(c,:)=g;
                temp(c,1:13)=soln(j).X;
                temp(c,14)=soln(j).Fval;
                temp(c,15)=growth_rate_phours_12params_plateau(Einterp,volbins,N_dist,temp(c,1:12),hr1,hr2);
                temp(c,16)=soln(j).Exitflag;
                c=c+1;
            else
                num=length(g)/13;
                start_points(c:c+num-1,:)=squeeze(reshape(g',1,13,num))';
                temp(c:c+num-1,1:13)=repmat(soln(j).X,num,1);
                temp(c:c+num-1,14)=repmat(soln(j).Fval,num,1);
                temp(c:c+num-1,15)=repmat(growth_rate_phours_12params_plateau(Einterp,volbins,N_dist,temp(c,1:12),hr1,hr2),num,1);
                temp(c:c+num-1,16)=repmat(soln(j).Exitflag,num,1);
                c=c+num;
            end
        end
        %just in case have rows left as zeros
        qq=find(temp(:,1)~=0);
        temp=temp(qq,:);
        
        largepopn=zeros(length(temp),6);
        smallpopn=zeros(length(temp),6);
        for h=1:length(temp)
            if temp(h,10) > temp(h,11)
                largepopn(h,:) = temp(h,[1:4 9 10]);
                smallpopn(h,:) = [temp(h,5:8) 1-temp(h,9) temp(h,11)];
            else %11 > 10
                largepopn(h,:) = [temp(h,5:8) 1-temp(h,9) temp(h,11)];
                smallpopn(h,:) = temp(h,[1:4 9 10]);
            end
        end
        
        modelfits=[smallpopn(:,1:4) largepopn(:,1:4) smallpopn(:,5) smallpopn(:,6) largepopn(:,6) temp(:,12:end)];
        
        
        start_points=start_points(qq,:);
        allstarts=start_points;
        %let's now ask, in the first batch run, did the solver "converge"?
        [sortlogL ii]=sort(temp(:,14));
        
        if abs(sortlogL(5)-sortlogL(1)) < icsTol
            flag1 = 0;
        else
            disp(num2str(sortlogL(1:5)))
            flag1 = 1;
        end;
        
        partol=max(modelfits(ii(1:5),1:13))-min(modelfits(ii(1:5),1:13));
        if sum(abs(partol) < tolvec)==13 || sum((abs(partol./modelfits(ii(1),1:13)) < 0.05))==13 %either the modelfits are within an absolute tolerance or within a relative tolerance
            flag2 = 0;
        else
            flag2 = 1;
        end
        
        
        disp(['flag1 = ' num2str(flag1) ' flag2=' num2str(flag2)])
        
        k=1; %batch number
        while (flag1 || flag2) && k <= 5
            
            %         k=1;
            %         while k <=5
            disp(['k: ' num2str(k)])
            k=k+1;
            x0(13)=1e4*rand;
            
            %         tpoints = CustomStartPointSet([0.2*rand(40,1) 6*rand(40,1) max(Einterp)*rand(40,1) 0.1*rand(40,1) 0.2*rand(40,1) 6*rand(40,1) max(Einterp)*rand(40,1) 0.1*rand(40,1) 0.5*rand(40,1) 30*rand(40,1)+20 30*rand(40,1)+20 10*rand(40,1)+2 1e4*rand(40,1)]);
            %low  growth rate start points:
            tpoints = CustomStartPointSet([0.1*rand(40,1) 3*rand(40,1) max(Einterp)*rand(40,1) 0.05*rand(40,1) 0.01*rand(40,1) 3*rand(40,1) max(Einterp)*rand(40,1) 0.05*rand(40,1) 0.5*rand(40,1) 30*rand(40,1)+20 30*rand(40,1)+20 10*rand(40,1)+2 1e4*rand(40,1)]);
            
            problem = createOptimProblem('fmincon','x0',x0,'objective',@(theta) loglike_DMN_13params_phours_plateau(Einterp,N_dist,theta,volbins,hr1,hr2),'Aineq',A,'bineq',B,'options',opts);
            [xmin,fmin,exitflag,~,soln] = run(ms,problem,tpoints);
            
            %open up the soln sturcutre:
            temp=zeros(40,16);
            zeros(40,13);
            c=1;
            for j=1:length(soln)
                %check to see if all start points led to an individual solution or
                %not (MultiSTart will only return unique solutions)
                g=cell2mat(soln(j).X0);
                if length(g)==13 %only one start_point led to that solution
                    start_points(c,:)=g;
                    temp(c,1:13)=soln(j).X;
                    temp(c,14)=soln(j).Fval;
                    temp(c,15)=growth_rate_phours_12params_plateau(Einterp,volbins,N_dist,temp(c,1:12),hr1,hr2);
                    temp(c,16)=soln(j).Exitflag;
                    c=c+1;
                else
                    num=length(g)/13;
                    start_points(c:c+num-1,:)=squeeze(reshape(g',1,13,num))';
                    temp(c:c+num-1,1:13)=repmat(soln(j).X,num,1);
                    temp(c:c+num-1,14)=repmat(soln(j).Fval,num,1);
                    temp(c:c+num-1,15)=repmat(growth_rate_phours_12params_plateau(Einterp,volbins,N_dist,temp(c,1:12),hr1,hr2),num,1);
                    temp(c:c+num-1,16)=repmat(soln(j).Exitflag,num,1);
                    c=c+num;
                end
            end
            %just in case have rows left as zeros
            qq=find(temp(:,1)~=0);
            temp=temp(qq,:);
            start_points=start_points(qq,:);
            largepopn=zeros(length(temp),6);
            smallpopn=zeros(length(temp),6);
            for h=1:length(temp)
                if temp(h,10) > temp(h,11)
                    largepopn(h,:) = temp(h,[1:4 9 10]);
                    smallpopn(h,:) = [temp(h,5:8) 1-temp(h,9) temp(h,11)];
                else %11 > 10
                    largepopn(h,:) = [temp(h,5:8) 1-temp(h,9) temp(h,11)];
                    smallpopn(h,:) = temp(h,[1:4 9 10]);
                end
            end
            
            modelfits=[modelfits; smallpopn(:,1:4) largepopn(:,1:4) smallpopn(:,5) smallpopn(:,6) largepopn(:,6) temp(:,12:end)];
            allstarts=[allstarts; start_points];
            
            %okay, now see after this batch run, did the solver "converge"?
            [sortlogL ii]=sort(modelfits(:,14));
            
            if abs(sortlogL(5)-sortlogL(1)) < icsTol
                flag1 = 0;
            else
                disp(num2str(sortlogL(1:5)))
                flag1 = 1;
            end;
            
            partol=max(modelfits(ii(1:5),1:13))-min(modelfits(ii(1:5),1:13));
            if sum(abs(partol) < tolvec)==13 || sum((abs(partol./modelfits(ii(1),1:13)) < 0.05))==13 %either the modelfits are within an absolute tolerance or within a relative tolerance
                flag2 = 0;
            else
                flag2 = 1;
            end
            
        end
        
        [s jj]=sort(modelfits(:,14));
        xmin=modelfits(jj(1),1:13);
        fmin=modelfits(jj(1),14);
        exitflag=modelfits(jj(1),16);
        
        [mu mu1 mu2 p1 p2]=growth_rate_phours_12params_plateau(Einterp,volbins,N_dist,xmin(1:12),hr1,hr2);
        
        modelresults(filenum,:)=[day xmin fmin mu mu1 mu2 p1 p2 exitflag length(modelfits)];
        allmodelruns{filenum,1}=modelfits;
        allmodelruns{filenum,2}=allstarts;
        
        eval(['save ' savepath 'mvco_13par_dmn_' num2str(year) '_beadmean_Jan2015 modelresults allmodelruns'])
%     end
end

eval(['modelresults' num2str(year) '_np=modelresults;'])
eval(['allmodelruns' num2str(year) '_np=allmodelruns;'])
eval(['save ' savepath 'mvco_13par_dmn_' num2str(year) '_beadmean_Jan2015 modelresults' num2str(year) '_np allmodelruns' num2str(year) '_np restitles notes'])

