%load 'C:\Users\Emily Fay\Documents\Ciliate_Code\count_biovol_size_manual_17May2013.mat'




%Mesodinium_large_ind=find(IFCB_14_correct_info_mat(:,3) < 500 & IFCB_14_correct_info_mat(:,3) >= 105);%5000 for crypto and meso %8000 for Oxy%10000 for pulex?


  
ii = find(floor(matdate) == datenum('2-9-2010')); %skip this day with one partial sample
matdate(ii) = []; filelist(ii) = [];
fnames = fields(biovol);
for fcount = 1:length(fnames),
%    disp(fcount)
    biovol.(fnames{fcount})(ii) = [];
    eqdiam.(fnames{fcount})(ii) = [];
    ml_analyzed_struct.(fnames{fcount})(ii) = [];
end;
clear ii fnames fcount

day = floor(matdate);
unqday = unique(day);
classes = fields(ml_analyzed_struct);
for classcount = 1:length(classes),
    [biovol_day(1:length(unqday)).(classes{classcount})] = deal([]);
    [ml_day(1:length(unqday)).(classes{classcount})] = deal(NaN);
    [eqdiam_day(1:length(unqday)).(classes{classcount})] = deal([]);
end;
%C_day = biovol_day;
N_day = ml_day;
N0_10 = N_day; N10_30 = N_day; N30_60 = N_day; N30_40 = N_day; N60_inf = N_day;
biovol0_10 = N_day; biovol10_20 = N_day; biovol20_30 = N_day; biovol30_40 = N_day; biovol40_inf = N_day;
eqdiam0_10 = N_day; eqdiam10_30 = N_day; eqdiam30_60 = N_day; eqdiam30_40 = N_day; eqdiam60_inf = N_day;
C0_10 = N_day; C10_20 = N_day; C20_30 = N_day; C30_40 = N_day; C40_inf = N_day;
eqdiam_day = biovol_day;
for daycount = 1:length(unqday),
    disp(datestr(unqday(daycount)))
    %ii = find(day == unqday(daycount));
    for classcount = 1:length(classes),
        ii = find(day == unqday(daycount) & ~isnan(ml_analyzed_struct.(classes{classcount})'));
        biovol_day(daycount).(classes{classcount}) = cat(1,biovol.(classes{classcount}){ii});
        eqdiam_day(daycount).(classes{classcount}) = cat(1,eqdiam.(classes{classcount}){ii});
        ml = nansum(ml_analyzed_struct.(classes{classcount})(ii));
        if ml ~= 0,
            ml_day(daycount).(classes{classcount}) = ml;
            N_day(daycount).(classes{classcount}) = length(biovol_day(daycount).(classes{classcount}));
        end;
    end;
end;

for daycount = 1:length(unqday),
    disp(datestr(unqday(daycount)))
    for classcount = 1:length(classes),
        iii = find(eqdiam_day(daycount).(classes{classcount}) < 27.5);
        if ~isempty(iii),
            N0_10(daycount).(classes{classcount}) = length(iii);
            biovol0_10(daycount).(classes{classcount}) = nansum(biovol_day(daycount).(classes{classcount})(iii));
            eqdiam0_10(daycount).(classes{classcount}) = nansum(eqdiam_day(daycount). (classes{classcount})(iii));
            %cellC = biovol2carbon(biovol_day(daycount).(classes{classcount})(iii),diatom_flag(classcount));
            %C0_10(daycount).(classes{classcount}) = nansum(cellC);
        else
            if ml_day(daycount).(classes{classcount}) ~= 0 && ~isnan(ml_day(daycount).(classes{classcount})),
                N0_10(daycount).(classes{classcount}) = 0;
                biovol0_10(daycount).(classes{classcount}) = 0;
                eqdiam0_10(daycount).(classes{classcount}) = 0;
                %C0_10(daycount).(classes{classcount}) = 0;
            end;
        end;
        iii = find(eqdiam_day(daycount).(classes{classcount}) >= 27.5 & eqdiam_day(daycount).(classes{classcount}) < 100);
        if ~isempty(iii),
            N10_30(daycount).(classes{classcount}) = length(iii);
            biovol10_20(daycount).(classes{classcount}) = nansum(biovol_day(daycount).(classes{classcount})(iii));
            eqdiam10_30(daycount).(classes{classcount}) = nansum(eqdiam_day(daycount). (classes{classcount})(iii));
            %cellC = biovol2carbon(biovol_day(daycount).(classes{classcount})(iii),diatom_flag(classcount));
            %C10_20(daycount).(classes{classcount}) = nansum(cellC);
        else
            if ml_day(daycount).(classes{classcount}) ~= 0 && ~isnan(ml_day(daycount).(classes{classcount})),
                N10_30(daycount).(classes{classcount}) = 0;
                biovol10_20(daycount).(classes{classcount}) = 0;
                eqdiam10_30(daycount).(classes{classcount}) = 0;
                %C10_20(daycount).(classes{classcount}) = 0;
            end;
        end;
    end;
end;

ml_day_mat = squeeze(cell2mat(struct2cell(ml_day)))'; 

[ind_ciliate] = get_ciliate_ind(classes,classes);
ciliate_flag = zeros(size(classes));

eqdiam0_10_mat = squeeze(cell2mat(struct2cell(eqdiam0_10)))'./ml_day_mat; eqdiam0_10sum = sum(eqdiam0_10_mat,2);
eqdiam10_30_mat = squeeze(cell2mat(struct2cell(eqdiam10_30)))'./ml_day_mat; eqdiam10_30sum = sum(eqdiam10_30_mat,2);

eqdiam0_10Meso=eqdiam0_10_mat(:,ind_ciliate(6));
eqdiam10_30Meso =eqdiam10_30_mat(:,ind_ciliate(6));

[ Cmdate_mat, eqdiam0_10Meso_mat, yearlist, yd ] = timeseries2ydmat( unqday, eqdiam0_10Meso );
[ Cmdate_mat, eqdiam10_30Meso_mat, yearlist, yd ] = timeseries2ydmat( unqday, eqdiam10_30Meso);

sum_eqdiam_Meso_mat= eqdiam0_10Meso_mat + eqdiam10_30Meso_mat;

percent_eqdiam0_10_mat= eqdiam0_10Meso_mat./sum_eqdiam_Meso_mat;
percent_eqdiam10_30_mat= eqdiam10_30Meso_mat./sum_eqdiam_Meso_mat;

percent_eqdiam10_30_mat(isnan(percent_eqdiam10_30_mat))=0;

figure;
hold on
for ii = 1:8
 plot(yd,percent_eqdiam10_30_mat(:,ii), '-')
end


sum_eqdiam_Meso= eqdiam0_10Meso + eqdiam10_30Meso;

percent_eqdiam0_10_timeseries= eqdiam0_10Meso./sum_eqdiam_Meso;
percent_eqdiam10_30_timeseries= eqdiam10_30Meso./sum_eqdiam_Meso;


% large_ind=find(eqdiam.Mesodinium_sp < 27.5);
% figure
% plot(matdate, 
% 
% ind = find(dv(:,1) == year_list(year_count) & dv(:,2) == month & ~isnan([ml_day.Ciliate_mix]'));


Meso_0_10_string= [eqdiam0_10Meso_mat(:,1); eqdiam0_10Meso_mat(:,2);eqdiam0_10Meso_mat(:,3);eqdiam0_10Meso_mat(:,4);eqdiam0_10Meso_mat(:,5);eqdiam0_10Meso_mat(:,6);eqdiam0_10Meso_mat(:,7);eqdiam0_10Meso_mat(:,8)];
Meso_0_10_string(isnan(Meso_0_10_string))=0;
Meso_10_30_string= [eqdiam10_30Meso_mat(:,1); eqdiam10_30Meso_mat(:,2);eqdiam10_30Meso_mat(:,3);eqdiam10_30Meso_mat(:,4);eqdiam10_30Meso_mat(:,5);eqdiam10_30Meso_mat(:,6);eqdiam10_30Meso_mat(:,7);eqdiam10_30Meso_mat(:,8)];
Meso_10_30_string(isnan(Meso_10_30_string))=0;

sum_eqdiam_Meso_string= Meso_0_10_string + Meso_10_30_string;
percent_string_0_10= Meso_0_10_string./sum_eqdiam_Meso_string;
percent_string_10_30= Meso_10_30_string./sum_eqdiam_Meso_string;

percent_string_10_30(isnan(percent_string_10_30))=0;