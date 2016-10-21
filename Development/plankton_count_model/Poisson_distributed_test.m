% Test of Poisson - distributed observations:

%First let's look at the data:
% For the ciliate data!

load('/Volumes/IFCB_products/MVCO/Manual_fromClass/summary/count_manual_current.mat')
%%
%iclass = strmatch('Laboea_strobila', class2use, 'exact');
%iclass = strmatch('Mesodinium_sp', class2use, 'exact');
%iclass = strmatch('Strombidium_conicum', class2use, 'exact');
%iclass = strmatch('Odontella', class2use, 'exact');
%iclass = strmatch('Chaetoceros_pennate', class2use, 'exact');
%iclass = strmatch('Ciliate_mix', class2use, 'exact');
%iclass = strmatch('Tintinnid', class2use, 'exact');

% stromb=find(cellfun('isempty',strfind(class2use,'Strombidium'))==0);
% j=5;
% iclass = strmatch(class2use(stromb(j)), class2use, 'exact');

plot(matdate, classcount(:,iclass)./ml_analyzed_mat(:,iclass),'.')
datetick
%These are 20 min bins of data - Nan's, Heidi said, are time points that
%either weren't classified or weren't finished....


%%
wk2yrdy = [7*(0:51)+1 366];
% We are looking at a fixed "season" (two-week chunks) per year, where each
% 20 min sample is a 'replicate' of the season, sort of...

%To see if a Poisson distribution is appropriate, we calculate a test
%statistc:

chi_rec=nan(26,9,11);
yearlist=2006:2016;
for Q=1:11 %year
    
    count=0;
    
    for w=1:2:51 %two week chunks
        
        count=count+1;
        jj=find(matdate >= wk2yrdy(w)+datenum(['1-0-' num2str(yearlist(Q))]) &  matdate < wk2yrdy(w+2)+datenum(['1-0-' num2str(yearlist(Q))]));
        if isempty(jj)
            wmdate=NaN;
        else
            wmdate=matdate(jj(1));
        end
        %n trials refers to how many points were samples (in this case manually
        %classified?)
        
        %ii=find(~isnan(classcount(jj,iclass)));
        ii=find(~isnan(ml_analyzed_mat(jj,iclass)));
        qq=jj(ii);
        K=length(qq); %number of replicates
        
        n=sum(classcount(qq,iclass)); %total count of all ciliates
        pk = ml_analyzed_mat(qq,iclass)./nansum(ml_analyzed_mat(qq,iclass)); %probability of sucess, which depends on volume pushed through = pk = vk/sum(vk)
        mm=min(n*pk);
        total_vol=nansum(ml_analyzed_mat(qq,iclass));
        
        %Test statistic is the Chi-Squared goodness of fit test:
        X2= sum(((classcount(qq,iclass) - n*pk).^2)./(n*pk));
        X2_crit = chi2inv(0.95,K-1); %to test against...
        
        if isnan(X2) %meaning 0 counts
            X2=0;
        end
        
        if isnan(X2_crit) %no manual counts available
            X2=NaN;
            n=NaN;
            K=NaN;
            mm=NaN;
            total_vol=NaN;
        end
        
        chi_rec(count,:,Q)=[w X2 X2_crit n K mm total_vol wmdate yearlist(Q)];
        clear X2 X2_crit ii n qq jj pk
    end
    
end

chi_rec_lo=[];
for Q=1:11
    chi_rec_lo=[chi_rec_lo; chi_rec(:,:,Q)];
end


%% for andy:
subplot(1,4,4,'replace'), hold on
cc=jet(11);
for Q=1:11
    plot(chi_rec(:,4,Q)./chi_rec(:,7,Q),chi_rec(:,2,Q)./(chi_rec(:,5,Q)-1),'s','markerfacecolor',cc(Q,:),'markeredgecolor',cc(Q,:))
end
%
set(gca,'fontsize',16,'box', 'on')
grid on
ylabel('\chi^{2} / (K-1)','fontsize',16)
xlabel('Total Count / Total Volume','fontsize',16)
%legend(cellstr(num2str(yearlist')))

%title(class2use(stromb(j)),'Interpreter','none')
title('Tintinnid','Interpreter','none')

%%
% figure
% plot(chi_rec(:,1),chi_rec(:,2),'.-')
% hold on
% plot(chi_rec(:,1),chi_rec(:,3),'.-')
subplot(1,3,1,'replace')
plot(matdate, classcount(:,iclass)./ml_analyzed_mat(:,iclass),'.')
ylabel('Counts per mL','fontsize',16)
title('Ciliate Mix')
grid on
xlim([2006 2017])
datetick

%%
subplot(1,3,2,'replace'), hold on
cc=jet(11);
for Q=1:11
    plot(chi_rec(:,1,Q),chi_rec(:,2,Q)./(chi_rec(:,5,Q)-1),'s','markerfacecolor',cc(Q,:),'markeredgecolor',cc(Q,:))
end

set(gca,'fontsize',16,'box', 'on')
grid on
ylabel('\chi^{2} / (K-1)','fontsize',16)
xlabel('Week number','fontsize',16)
xlim([1 51])

legend(cellstr(num2str(yearlist')))
% See how chi-squared changes over time:

subplot(1,3,3,'replace'), hold on

for Q=1:11
    for i=1:26
        
        if ~isnan(chi_rec(i,3,Q)) %meaning had a sample
            if chi_rec(i,2,Q)==0 %meaning that had samples, but saw no ciliates
                line([chi_rec(i,1,Q) chi_rec(i,1,Q)],[0 chi_rec(i,3,Q)],'color',[0.5 0.5 0.5])
                h1=plot(chi_rec(i,1,Q),0,'p','color',[1 0.8 0]);
                plot(chi_rec(i,1,Q),chi_rec(i,3,Q),'p','color',[1 0.8 0])
            elseif chi_rec(i,2,Q) > chi_rec(i,3,Q)
                line([chi_rec(i,1,Q) chi_rec(i,1,Q)],[chi_rec(i,2,Q) chi_rec(i,3,Q)],'color',[0.5 0.5 0.5])
                h2=plot(chi_rec(i,1,Q),chi_rec(i,2,Q),'p','color','r');
                plot(chi_rec(i,1,Q),chi_rec(i,3,Q),'p','color','r')
            else
                line([chi_rec(i,1,Q) chi_rec(i,1,Q)],[chi_rec(i,2,Q) chi_rec(i,3,Q)],'color',[0.5 0.5 0.5])     
                h3=plot(chi_rec(i,1,Q),chi_rec(i,2,Q),'p','color',[0 0.5 1]);
                plot(chi_rec(i,1,Q),chi_rec(i,3,Q),'p','color',[0 0.5 1])
            end
        end
    end
    %pause
end

set(gca,'fontsize',16,'box', 'on','xlim',[1 51])
grid on
ylabel('\chi^{2} and \chi^{2}_{crit}','fontsize',16)
xlabel('Week number','fontsize',16)
legend([h1; h2; h3],'Zero counts','Reject null','Cannot reject null')

%%
set(gcf,'color','w')
export_fig ~/Desktop/Poisson_test4.pdf

%% One more plot:
figure, hold on
cc=jet(11);
for Q=1:11
    plot(chi_rec(:,8,Q),chi_rec(:,2,Q)./(chi_rec(:,5,Q)-1),'-','color',[0.5 0.5 0.5])
    scatter(chi_rec(:,8,Q),chi_rec(:,2,Q)./(chi_rec(:,5,Q)-1),40,chi_rec(:,5,Q),'filled'), caxis([0 160])
end
hbar=colorbar;
ylabel(hbar,'Replicate #')
datetick('x','yyyy')
set(gca,'xgrid','on')


%% TESTING TO SEE IF SEASONAL OR SMOOTH OVERDISPERSION IS A REAL THING?

chi_rec_seas2=nan(26,8,11);
chi_rec_seas=nan(52,8,11);

for Q=1:11 %year
    
    count=0;
    
    for w=1:2:51 % +/- one "season" (two-week window)
    
    %for w=1:1:52 %five week moving window
        
        count=count+1;

        if w == 1
            jj=find(matdate >= wk2yrdy(51)+datenum(['1-0-' num2str(yearlist(Q)-1)]) &  matdate < wk2yrdy(w+4)+datenum(['1-0-' num2str(yearlist(Q))]));
        elseif w >= 51
            jj=find(matdate >= wk2yrdy(w-2)+datenum(['1-0-' num2str(yearlist(Q))]) &  matdate < wk2yrdy(3)+datenum(['1-0-' num2str(yearlist(Q)+1)]));
        else
           jj=find(matdate >= wk2yrdy(w-2)+datenum(['1-0-' num2str(yearlist(Q))]) &  matdate < wk2yrdy(w+4)+datenum(['1-0-' num2str(yearlist(Q))]));
        end

% % for five week moving window        
%         if w <= 2
%             jj=find(matdate >= wk2yrdy(50+w)+datenum(['1-0-' num2str(yearlist(Q)-1)]) &  matdate < wk2yrdy(w+3)+datenum(['1-0-' num2str(yearlist(Q))]));
%         elseif w >= 51
%             jj=find(matdate >= wk2yrdy(w)+datenum(['1-0-' num2str(yearlist(Q))]) &  matdate < wk2yrdy((w-50)+3)+datenum(['1-0-' num2str(yearlist(Q)+1)]));
%         else
%            jj=find(matdate >= wk2yrdy(w-2)+datenum(['1-0-' num2str(yearlist(Q))]) &  matdate < wk2yrdy(w+3)+datenum(['1-0-' num2str(yearlist(Q))]));
%         end
            
        if isempty(jj)
            wmdate=NaN;
        else
            wmdate=matdate(jj(1));
        end
        %n trials refers to how many points were samples (in this case manually
        %classified?)
        
        %ii=find(~isnan(classcount(jj,iclass)));
        ii=find(~isnan(ml_analyzed_mat(jj,iclass)));
        qq=jj(ii);
        K=length(qq); %number of replicates
        
        n=sum(classcount(qq,iclass)); %total count of all ciliates
        pk = ml_analyzed_mat(qq,iclass)./nansum(ml_analyzed_mat(qq,iclass)); %probability of sucess, which depends on volume pushed through = pk = vk/sum(vk)
        mm=min(n*pk);
        total_vol=nansum(ml_analyzed_mat(qq,iclass));
        
        %Test statistic is the Chi-Squared goodness of fit test:
        X2= sum(((classcount(qq,iclass) - n*pk).^2)./(n*pk));
        X2_crit = chi2inv(0.95,K-1); %to test against...
        
        if isnan(X2) %meaning 0 counts
            X2=0;
        end
        
        if isnan(X2_crit) %no manual counts available
            X2=NaN;
            n=NaN;
            K=NaN;
            mm=NaN;
            total_vol=NaN;
        end
        
        chi_rec_seas2(count,:,Q)=[w X2 X2_crit n K mm total_vol wmdate];
        clear X2 X2_cirt ii n qq jj pk
    end
    
end


%%

subplot(2,1,2,'replace'), hold on
cc=jet(11);
for Q=1:11
    plot(chi_rec_seas2(:,8,Q),chi_rec_seas2(:,2,Q)./(chi_rec_seas2(:,5,Q)-1),'-','color',[0.5 0.5 0.5])
    scatter(chi_rec_seas2(:,8,Q),chi_rec_seas2(:,2,Q)./(chi_rec_seas2(:,5,Q)-1),40,chi_rec_seas2(:,5,Q),'filled'), caxis([0 100])
end
hbar=colorbar;
ylabel(hbar,'Replicate #')
datetick('x','yyyy')
set(gca,'xgrid','on','fontsize',16,'box','on')
ylabel('\chi^{2} / (K-1)','fontsize',16)
title('Two-week seasons, running mean +/- 1 season','fontweight','normal')

% subplot(2,2,4,'replace'), hold on
% cc=jet(11);
% for Q=1:11
%     scatter(chi_rec_seas2(:,1,Q),chi_rec_seas2(:,2,Q)./(chi_rec_seas2(:,5,Q)-1),40,chi_rec_seas2(:,5,Q),'filled'), caxis([0 300])
% end

ylabel('\chi^{2} / (K-1)','fontsize',16)


subplot(2,1,1,'replace'), hold on
cc=jet(11);
for Q=1:11
    plot(chi_rec(:,8,Q),chi_rec(:,2,Q)./(chi_rec(:,5,Q)-1),'-','color',[0.5 0.5 0.5])
    scatter(chi_rec(:,8,Q),chi_rec(:,2,Q)./(chi_rec(:,5,Q)-1),40,chi_rec(:,5,Q),'filled'), caxis([0 50])
end
hbar=colorbar;
ylabel(hbar,'Replicate #')
datetick('x','yyyy')
set(gca,'xgrid','on','fontsize',16,'box','on')
ylabel('\chi^{2} / (K-1)','fontsize',16)
title('Two-week seasons','fontweight','normal')

% subplot(2,2,2,'replace'), hold on
% cc=jet(11);
% for Q=1:11
%     scatter(chi_rec(:,1,Q),chi_rec(:,2,Q)./(chi_rec(:,5,Q)-1),40,chi_rec(:,5,Q),'filled'), caxis([0 300])
% end
% 
% ylabel('\chi^{2} / (K-1)','fontsize',16)

%% Smoothed overdispersion: running mean!

for i=1:length(chi_rec_lo)
            if i == 1
                runavg=nanmean(chi_rec_lo(i:i+2,2)./(chi_rec_lo(i:i+2,5)-1));
            elseif i == length(chi_rec_lo)
                runavg=nanmean(chi_rec_lo(i-2:i,2)./(chi_rec_lo(i-2:i,5)-1));
            else
                runavg=nanmean(chi_rec_lo(i-1:i+1,2)./(chi_rec_lo(i-1:i+1,5)-1));
            end
       chi_rec_lo(i,10)=runavg;                
end


%% Now we plot..

subplot(4,1,4,'replace'), hold on
cc=jet(11);
for Q=1:11
    plot(chi_rec(:,8,Q),chi_rec(:,2,Q)./(chi_rec(:,5,Q)-1),'-','color',[0.5 0.5 0.5])
    scatter(chi_rec(:,8,Q),chi_rec(:,2,Q)./(chi_rec(:,5,Q)-1),40,chi_rec(:,5,Q),'filled'), caxis([0 50])
end
hbar=colorbar;
ylabel(hbar,'Replicate #')

plot(chi_rec_lo(:,8),chi_rec_lo(:,10),'r.-')
datetick('x','yyyy')
set(gca,'xgrid','on','fontsize',16,'box','on')
ylabel('\chi^{2} / (K-1)','fontsize',16)
title('Mesodinium','fontweight','normal')

%%
set(gcf,'color','w')
export_fig ~/Desktop/redo_smoothing.pdf
