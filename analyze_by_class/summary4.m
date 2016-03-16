load '\\raspberry\d_work\IFCB1\ifcb_data_mvco_jun06\Manual_fromClass\summary\count_biovol_manual_current_day'

[ ind_diatoms, class_label ] = get_diatom_ind( class2use, class2use );

yd = (1:366)';
dv = datevec(matdate_bin);
yd_ifcb = matdate_bin-datenum(dv(:,1),0,0);
year_ifcb = (dv(1,1):dv(end,1));
mdate_year = datenum(year_ifcb,0,0);
mdate_ifcb = repmat(yd,1,length(year_ifcb))+repmat(mdate_year,length(yd),1);
clear mdate_year

x = sum(classbiovol_bin(:,ind_diatoms)./ml_analyzed_mat_bin(:,ind_diatoms),2); indall = find(~isnan(x));
x = classbiovol_bin(indall,ind_diatoms)./ml_analyzed_mat_bin(indall,ind_diatoms); %class specific biomass/mL for cases with all diatom classes counted
[~, cind] = sort(sum(x), 'descend'); %rank order biomass

x = classbiovol_bin(:,ind_diatoms)./ml_analyzed_mat_bin(:,ind_diatoms);
xsum = sum(x,2); %NaN if any categories are NaN
for count = 1:length(year_ifcb),    
    iii = find(dv(:,1) == year_ifcb(count));
    for day = 1:366,
        ii = find(floor(yd_ifcb(iii)) == day);
        Dallday(day,count,:) = nanmean(x(iii(ii),:),1);
        Dsumday(day,count) = nanmean(xsum(iii(ii)),1);
    end;
end;
Dallmean = squeeze(nanmean(Dallday,2));
for count = 1:length(ind_diatoms),
    Dallmean_sm(:,count) = smooth(Dallmean(:,count),10);
end;
for count = 1:length(year_ifcb),
    Dallanom_sm(:,count,:) = squeeze(Dallday(:,count,:)) - Dallmean_sm;
end;

Dsumanom = Dsumday-repmat(smooth(nanmean(Dsumday,2)),1,length(year_ifcb));


load c:\work\mvco\carbon\conc_summary_fcb
mdate_year_fcb = datenum(yearall,0,0);
mdate_fcb = repmat(yd_fcb,1,length(yearall))+repmat(mdate_year_fcb,length(yd_fcb),1);
Synmean = nanmean(log10(synperml),2);
Synanom = log10(synperml) - repmat(Synmean,1,length(yearall));
Picoeukmean = nanmean(log10(picoeukperml),2);
Picoeukanom = log10(picoeukperml) - repmat(Picoeukmean,1,length(yearall));



[ Tday, Tanom_fcb, Tanom_ifcb ] = get_Tanom_node( year_fcb, year_ifcb );

[~,month,~] = datevec(datenum(0,0,yd));

