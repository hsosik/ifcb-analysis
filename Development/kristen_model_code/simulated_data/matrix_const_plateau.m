function B=matrix_const_plateau(hr,Einterp,volbins,b,dmax,E_star,Ymax)

%Construct matrix A(t) for each time step within an hour based on delta and
%gammas at each 10 minute time intervals
%then construct B(t) which is A(t)s multiplied for the given hour
%multiply B(t)*w(t) to get the projection to next hour dist

%%%%%%--------Initial Parameters---------------
%dv=0.125;
%j=1+(1/dv);
m=length(volbins);
j = find(2*volbins(1) == volbins);
dt=(1/6); %corresponds to 10 mins (units are hours)
ts=6; %hours after dawn - allow division

%-----------Delta function---------------------
%delta=frac of cells that divide
del=(dmax.*volbins.^b)./(1+(volbins.^b)); 
%d_temp = (volbins>=vmin).*c.*alpha.*volbins.^beta./(1
%+alpha.*volbins.^beta); Heidi's function

%-----------Gamma function---------------------
%gamma (y) is frac of cells that grow into next class, depends on incident radiation (E), which is dependent on time
%Edata (first col time, 2nd col Irradiance):

y=Ymax*ones(size(Einterp));
ind=find(Einterp < E_star);
y(ind)=(Ymax/E_star) * Einterp(ind);

% y=(1-exp(-Einterp/E_star))*Ymax; 

%w(t) is fraction of cells at time t that have volume btw vi and vi+1

%-----------%constructing A---------------%
%A=zeros(m,m);
%%
A=spalloc(m,m,(m+2*(m-1))); %allocate sparse matrix for A, (size of matrix (m x m) and how many nonzeros will be in A
stasis_ind=1:(m+1):m^2;  %indexing for matrix -goes down a column and then right to next column
growth_ind=2:(m+1):m^2;  %corresponds to growth assignments
div_ind=((j-1)*m)+1:(m+1):m^2;  %division assignments  %indexing changed from Heidi & Mike's version, which is off by one bin when setting up the division superdiagonal)
%Brec=zeros(m,m,24);
for t=1:(1/dt)      
     if hr <= ts
     delta=zeros(1,m);
     else
     delta=del;
     end 
     %delta=del;
     %A=spalloc(m,m,(m+2*(m-1)));                %reinitialize A
     A(stasis_ind)=(1-delta)*(1-y(t+6*hr));         % stasis, the 6*hr part in the indexing is because eahc hour is broken up inot 10min segments for the irradiance spline
     A(m,m)=(1-delta(m));
                 
     A(growth_ind)=y(t+6*hr)*(1-delta(1,1:m-1));    %growth on sub-diagonal
        
     A(1,1:j-1)=A(1,1:j-1)+2*delta(1:j-1);                  %division on superdiagonal and on first row partial
     A(div_ind)=2*delta(j:m);
     %Brec(:,:,t)=full(A);
     if t ==1
         B=A;
     else
        B=A*B;
     end
     A = A.*0;
     if isnan(B),
         disp('B has a NaN!')
%                 keyboard, 
    end
end

%% Original Heidi Code:
% [nbins,times] = size(N_dist);
% times = times-1;
% time = hrstart:dt:(hrstart+1-dt);  
% indstart = hrstart*k+1;
% gind = indstart:indstart+k-1;
% g = gall(gind);
% sw = find(2*volbins(1) == volbins);
% %A = zeros(nbins);
% A = spalloc(nbins, nbins, nbins+(nbins-1)+(nbins-1));
% Ak = A;  %in sparse case Ak may get larger than A...will end up "growing" - how avoid, can't predict size of nonzero Ak?
% 
% if hrstart <= 6 
%     d = zeros(nbins,1);
% else
%     d = d_temp';
% end
% step = nbins+1;
% last = nbins^2;
% vv = [1:step:last, 2:step:last, nbins*sw+1:step:last];
% vv3 = 1:sw;
% Record=[];   
% for t = 1:length(time)
%     A(vv) = [(1-g(t))*(1-d); (1-d(1:(nbins-1)))*g(t); 2*d(sw+1:end)];    
%    % A(:,:) = diag((1-g(t))*(1-d)) + diag((1-d(1:(nbins-1)))*g(t),-1) + diag(2*d(sw+1:end),sw);
%     A(1,vv3) = A(1,vv3) + 2*d(vv3)';
%     A(nbins,nbins) = (1-d(nbins));
%     Record(:,:,t)=full(A);
%     if t == 1,
%         Ak = A;
%     else
%         Ak = A*Ak;
%     end;
% %    A = A.*0;    %reset A to zeros for next loop, faster than spalloc  
% end



    