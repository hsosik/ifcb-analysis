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

%if X2 > X2_crit -> reject null, and counts are overdispersed relative to
%Poisson
%% less formal metric:

metric=chi_rec(:,2,Q)./(chi_rec(:,5,Q)-1);
