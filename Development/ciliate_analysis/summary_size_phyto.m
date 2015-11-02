%load '\\raspberry\d_work\ifcb1\ifcb_data_mvco_jun06\manual_fromClass\summary\count_biovol_size_manual_10Apr2012.mat'

%load 'C:\work\ifcb\ifcb_data_MVCO_jun06\manual_fromClass\summary\count_biovol_size_manual_29Mar2012.mat'
load 'C:\Users\Emily Fay\Documents\Ciliate_Code\count_biovol_size_manual_21May2012'

%load 'C:\work\ifcb\ifcb_data_MVCO_jun06\manual_fromClass\summary\count_biovol_size_manual_21May2012.mat'
%oad 'C:\Users\Emily Fay\Documents\Ciliate_Code\count_biovol_size_manual_28Apr2012'

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
end;
%C_day = biovol_day;
N_day = ml_day;
N0_10 = N_day; N10_20 = N_day; N20_30 = N_day; N30_40 = N_day; N40_inf = N_day;
biovol0_10 = N_day; biovol10_20 = N_day; biovol20_30 = N_day; biovol30_40 = N_day; biovol40_inf = N_day;
eqdiam0_10 = N_day; eqdiam10_20 = N_day; eqdiam20_30 = N_day; eqdiam30_40 = N_day; eqdiam40_inf = N_day;
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

clear classcount biovol daycount eqdiam filelist ii matdate ml ml_analyzed_struct day

%class_diatom = {'Asterionellopsis' 'Cerataulina' 'Chaetoceros' 'Corethron' 'Coscinodiscus' 'Cylindrotheca' 'DactFragCerataul' 'Dactyliosolen'...
%    'Ditylum' 'Ephemera' 'Eucampia' 'Guinardia' 'Guinardia_flaccida' 'Guinardia_striata' 'Hemiaulus' 'Lauderia' 'Leptocylindrus' 'Licmophora'...
%    'Odontella' 'Paralia' 'Pleurosigma' 'Pseudonitzschia' 'Rhizosolenia' 'Skeletonema' 'Stephanopyxis' 'Thalassionema' 'Thalassiosira' 'pennate'};
[ind_diatom] = get_diatom_ind(classes,classes);
diatom_flag = zeros(size(classes));
diatom_flag(ind_diatom) = 1;

for daycount = 1:length(unqday),
    disp(datestr(unqday(daycount)))
    for classcount = 1:length(classes),
        iii = find(eqdiam_day(daycount).(classes{classcount}) < 10);
        if ~isempty(iii),
            N0_10(daycount).(classes{classcount}) = length(iii);
            biovol0_10(daycount).(classes{classcount}) = nansum(biovol_day(daycount).(classes{classcount})(iii));
            eqdiam0_10(daycount).(classes{classcount}) = nansum(eqdiam_day(daycount). (classes{classcount})(iii));
            cellC = biovol2carbon(biovol_day(daycount).(classes{classcount})(iii),diatom_flag(classcount));
            C0_10(daycount).(classes{classcount}) = nansum(cellC);
        else
            if ml_day(daycount).(classes{classcount}) ~= 0 && ~isnan(ml_day(daycount).(classes{classcount})),
                N0_10(daycount).(classes{classcount}) = 0;
                biovol0_10(daycount).(classes{classcount}) = 0;
                eqdiam0_10(daycount).(classes{classcount}) = 0;
                C0_10(daycount).(classes{classcount}) = 0;
            end;
        end;
        iii = find(eqdiam_day(daycount).(classes{classcount}) >= 10 & eqdiam_day(daycount).(classes{classcount}) < 12);
        if ~isempty(iii),
            N10_20(daycount).(classes{classcount}) = length(iii);
            biovol10_20(daycount).(classes{classcount}) = nansum(biovol_day(daycount).(classes{classcount})(iii));
            eqdiam10_20(daycount).(classes{classcount}) = nansum(eqdiam_day(daycount). (classes{classcount})(iii));
            cellC = biovol2carbon(biovol_day(daycount).(classes{classcount})(iii),diatom_flag(classcount));
            C10_20(daycount).(classes{classcount}) = nansum(cellC);
        else
            if ml_day(daycount).(classes{classcount}) ~= 0 && ~isnan(ml_day(daycount).(classes{classcount})),
                N10_20(daycount).(classes{classcount}) = 0;
                biovol10_20(daycount).(classes{classcount}) = 0;
                eqdiam10_20(daycount).(classes{classcount}) = 0;
                C10_20(daycount).(classes{classcount}) = 0;
            end;
        end;
        iii = find(eqdiam_day(daycount).(classes{classcount}) >= 12 & eqdiam_day(daycount).(classes{classcount}) < 24);
        if ~isempty(iii),
            N20_30(daycount).(classes{classcount}) = length(iii);
            biovol20_30(daycount).(classes{classcount}) = nansum(biovol_day(daycount).(classes{classcount})(iii));
            eqdiam20_30(daycount).(classes{classcount}) = nansum(eqdiam_day(daycount). (classes{classcount})(iii));
            cellC = biovol2carbon(biovol_day(daycount).(classes{classcount})(iii),diatom_flag(classcount));
            C20_30(daycount).(classes{classcount}) = nansum(cellC);
        else
            if ml_day(daycount).(classes{classcount}) ~= 0 && ~isnan(ml_day(daycount).(classes{classcount})),
                N20_30(daycount).(classes{classcount}) = 0;
                biovol20_30(daycount).(classes{classcount}) = 0;
                eqdiam20_30(daycount).(classes{classcount}) = 0;
                C20_30(daycount).(classes{classcount}) = 0;
            end;
        end;
        iii = find(eqdiam_day(daycount).(classes{classcount}) >= 24 & eqdiam_day(daycount).(classes{classcount}) < 80);
        if ~isempty(iii),
            N30_40(daycount).(classes{classcount}) = length(iii);
            biovol30_40(daycount).(classes{classcount}) = nansum(biovol_day(daycount).(classes{classcount})(iii));
            eqdiam30_40(daycount).(classes{classcount}) = nansum(eqdiam_day(daycount). (classes{classcount})(iii));
            cellC = biovol2carbon(biovol_day(daycount).(classes{classcount})(iii),diatom_flag(classcount));
            C30_40(daycount).(classes{classcount}) = nansum(cellC);
        else
            if ml_day(daycount).(classes{classcount}) ~= 0 && ~isnan(ml_day(daycount).(classes{classcount})),
                N30_40(daycount).(classes{classcount}) = 0;
                biovol30_40(daycount).(classes{classcount}) = 0;
                eqdiam30_40(daycount).(classes{classcount}) = 0;
                C30_40(daycount).(classes{classcount}) = 0;
            end;
        end;
        iii = find(eqdiam_day(daycount).(classes{classcount}) >= 12 & eqdiam_day(daycount).(classes{classcount}) < 20);
        if ~isempty(iii),
            N40_inf(daycount).(classes{classcount}) = length(iii);
            biovol40_inf(daycount).(classes{classcount}) = nansum(biovol_day(daycount).(classes{classcount})(iii));
            eqdiam40_inf(daycount).(classes{classcount}) = nansum(eqdiam_day(daycount). (classes{classcount})(iii));
            cellC = biovol2carbon(biovol_day(daycount).(classes{classcount})(iii),diatom_flag(classcount));
            C40_inf(daycount).(classes{classcount}) = nansum(cellC);
        else
            if ml_day(daycount).(classes{classcount}) ~= 0 && ~isnan(ml_day(daycount).(classes{classcount})),
                N40_inf(daycount).(classes{classcount}) = 0;
                biovol40_inf(daycount).(classes{classcount}) = 0;
                eqdiam40_inf(daycount).(classes{classcount}) = 0;
                C40_inf(daycount).(classes{classcount}) = 0;
            end;
        end;
    end;
end;
    
clear daycount classcount iii cellC

for daycount = 1:length(unqday),
    disp(datestr(unqday(daycount)))
    for classcount = 1:length(classes),
        if N_day(daycount).(classes{classcount}) == 0,
            C_day(daycount).(classes{classcount}) = 0;
        elseif isnan(N_day(daycount).(classes{classcount})),
            C_day(daycount).(classes{classcount}) = NaN;
        else    
            cellC = biovol2carbon(biovol_day(daycount).(classes{classcount}),diatom_flag(classcount));
            C_day(daycount).(classes{classcount}) = nansum(cellC);
        end;
    end;
end;
clear daycount classcount iii cellC
%C_diatom_day = NaN(length(unqday), length(class_diatom));
%for count = 1:length(class_diatom),
%    C_diatom_day(:,count) = [C_day.(class_diatom{count})]';
%end;

ml_day_mat = squeeze(cell2mat(struct2cell(ml_day)))'; 
C_day_mat = squeeze(cell2mat(struct2cell(C_day)))'./ml_day_mat/1000; %microgC per mL
C_diatom = sum(C_day_mat(:,ind_diatom),2); %sum to skip the ones that are incomplete for all diatoms

% C0_10_mat = squeeze(cell2mat(struct2cell(C0_10)))'./ml_day_mat/1000; C0_10sum = sum(C0_10_mat,2);
% C10_20_mat = squeeze(cell2mat(struct2cell(C10_20)))'./ml_day_mat/1000; C10_20sum = sum(C10_20_mat,2);
% C20_inf_mat = squeeze(cell2mat(struct2cell(C20_inf)))'./ml_day_mat/1000; C20_infsum = sum(C20_inf_mat,2);

eqdiam0_10_mat = squeeze(cell2mat(struct2cell(eqdiam0_10)))'./ml_day_mat; eqdiam0_10sum = sum(eqdiam0_10_mat,2);
eqdiam10_20_mat = squeeze(cell2mat(struct2cell(eqdiam10_20)))'./ml_day_mat; eqdiam10_20sum = sum(eqdiam10_20_mat,2);
eqdiam20_30_mat = squeeze(cell2mat(struct2cell(eqdiam20_30)))'./ml_day_mat; eqdiam20_30sum = sum(eqdiam20_30_mat,2);
eqdiam30_40_mat = squeeze(cell2mat(struct2cell(eqdiam30_40)))'./ml_day_mat; eqdiam30_40sum = sum(eqdiam30_40_mat,2);
eqdiam40_inf_mat = squeeze(cell2mat(struct2cell(eqdiam40_inf)))'./ml_day_mat; eqdiam40_infsum = sum(eqdiam40_inf_mat,2);

biovol0_10_mat = squeeze(cell2mat(struct2cell(biovol0_10)))'./ml_day_mat; biovol0_10sum = sum(biovol0_10_mat,2);
biovol10_20_mat = squeeze(cell2mat(struct2cell(biovol10_20)))'./ml_day_mat; biovol10_20sum = sum(biovol10_20_mat,2);
biovol20_30_mat = squeeze(cell2mat(struct2cell(biovol20_30)))'./ml_day_mat; biovol20_30sum = sum(eqdiam20_30_mat,2);
biovol30_40_mat = squeeze(cell2mat(struct2cell(biovol30_40)))'./ml_day_mat; biovol30_40sum = sum(eqdiam30_40_mat,2);
biovol40_inf_mat = squeeze(cell2mat(struct2cell(biovol40_inf)))'./ml_day_mat; biovol40_infsum = sum(biovol40_inf_mat,2);

[ind_phyto] = get_phyto_ind(classes,classes);
ciliate_flag = zeros(size(classes));



eqdiam0_10phyto = sum(eqdiam0_10_mat(:,ind_phyto),2);
eqdiam10_20phyto = sum(eqdiam10_20_mat(:,ind_phyto),2);
eqdiam20_30phyto = sum(eqdiam20_30_mat(:,ind_phyto),2);
eqdiam30_40phyto = sum(eqdiam30_40_mat(:,ind_phyto),2);
eqdiam40_infphyto = sum(eqdiam40_inf_mat(:,ind_phyto),2);

biovol0_10phyto = sum(biovol0_10_mat(:,ind_phyto),2);
biovol10_20phyto = sum(biovol10_20_mat(:,ind_phyto),2);
biovol20_30phyto = sum(biovol20_30_mat(:,ind_phyto),2);
biovol30_40phyto = sum(biovol30_40_mat(:,ind_phyto),2);
biovol40_infphyto = sum(biovol40_inf_mat(:,ind_phyto),2);
totalbiovol_phyto = biovol0_10phyto + biovol10_20phyto + biovol20_30phyto + biovol30_40phyto + biovol40_infphyto;

% biovol0_10ciliate_all = sum(biovol0_10_mat(:,ind_ciliate(3)),2);
% biovol10_20ciliate_all = sum(biovol10_20_mat(:,ind_ciliate(3)),2);
% biovol20_30ciliate_all = sum(biovol20_30_mat(:,ind_ciliate(3)),2);
% biovol30_40ciliate_all = sum(biovol30_40_mat(:,ind_ciliate(3)),2);
% biovol40_infciliate_all = sum(biovol40_inf_mat(:,ind_ciliate(3)),2);
% totalbiovol_ciliate_all = biovol0_10ciliate_all + biovol10_20ciliate_all + biovol20_30ciliate_all + biovol30_40ciliate_all + biovol40_infciliate_all;

% ind_phyto = get_phyto_ind( classes, classes );
% C_phyto = sum(C_day_mat(:,ind_phyto),2); %sum to skip the ones that are incomplete for all diatoms
% C0_10phyto = sum(C0_10_mat(:,ind_phyto),2);
% C10_20phyto = sum(C10_20_mat(:,ind_phyto),2);
% C20_infphyto = sum(C20_inf_mat(:,ind_phyto),2);

% [ Cmdate_mat, eqdiam0_10ciliate_mat, yearlist, yd ] = timeseries2ydmat( unqday, eqdiam0_10ciliate );
% [ Cmdate_mat, eqdiam10_20ciliate_mat, yearlist, yd ] = timeseries2ydmat( unqday, eqdiam10_20ciliate );
% [ Cmdate_mat, eqdiam20_30ciliate_mat, yearlist, yd ] = timeseries2ydmat( unqday, eqdiam20_30ciliate );
% [ Cmdate_mat, eqdiam30_40ciliate_mat, yearlist, yd ] = timeseries2ydmat( unqday, eqdiam30_40ciliate );
% [ Cmdate_mat, eqdiam40_infciliate_mat, yearlist, yd ] = timeseries2ydmat( unqday, eqdiam40_infciliate );

[ Cmdate_mat, biovol0_10phyto_mat, yearlist, yd ] = timeseries2ydmat( unqday, biovol0_10phyto );
[ Cmdate_mat, biovol10_20phyto_mat, yearlist, yd ] = timeseries2ydmat( unqday, biovol10_20phyto );
[ Cmdate_mat, biovol20_30phyto_mat, yearlist, yd ] = timeseries2ydmat( unqday, biovol20_30phyto );
[ Cmdate_mat, biovol30_40phyto_mat, yearlist, yd ] = timeseries2ydmat( unqday, biovol30_40phyto );
[ Cmdate_mat, biovol40_infphyto_mat, yearlist, yd ] = timeseries2ydmat( unqday, biovol40_infphyto );
[ Cmdate_mat, totalbiovol_phyto_mat, yearlist, yd ] = timeseries2ydmat( unqday, totalbiovol_phyto );
% 
% [ Cmdate_mat, biovol0_10ciliate_all_mat, yearlist, yd ] = timeseries2ydmat( unqday, biovol0_10ciliate_all );
% [ Cmdate_mat, biovol10_20ciliate_all_mat, yearlist, yd ] = timeseries2ydmat( unqday, biovol10_20ciliate_all );
% [ Cmdate_mat, biovol20_30ciliate_all_mat, yearlist, yd ] = timeseries2ydmat( unqday, biovol20_30ciliate_all );
% [ Cmdate_mat, biovol30_40ciliate_all_mat, yearlist, yd ] = timeseries2ydmat( unqday, biovol30_40ciliate_all );
% [ Cmdate_mat, biovol40_infciliate_all_mat, yearlist, yd ] = timeseries2ydmat( unqday, biovol40_infciliate_all );
% [ Cmdate_mat, totalbiovol_ciliate_all_mat, yearlist, yd ] = timeseries2ydmat( unqday, totalbiovol_ciliate_all );

phyto_biovol_fraction0_10 = (biovol0_10phyto_mat./totalbiovol_phyto_mat);
phyto_biovol_fraction10_20 = (biovol10_20phyto_mat./totalbiovol_phyto_mat);
phyto_biovol_fraction20_30 = (biovol20_30phyto_mat./totalbiovol_phyto_mat);
phyto_biovol_fraction30_40 = (biovol30_40phyto_mat./totalbiovol_phyto_mat);
phyto_biovol_fraction40_inf = (biovol40_infphyto_mat./totalbiovol_phyto_mat);

% phyto_all_biovol_fraction0_10 = (biovol0_10ciliate_all_mat./totalbiovol_ciliate_all_mat);
% phyto_all_biovol_fraction10_20 = (biovol10_20ciliate_all_mat./totalbiovol_ciliate_all_mat);
% ciliate_all_biovol_fraction20_30 = (biovol20_30ciliate_all_mat./totalbiovol_ciliate_all_mat);
% ciliate_all_biovol_fraction30_40 = (biovol30_40ciliate_all_mat./totalbiovol_ciliate_all_mat);
% ciliate_all_biovol_fraction40_inf = (biovol40_infciliate_all_mat./totalbiovol_ciliate_all_mat);

%plot(yd, ciliate_biovol_fraction10_20(:,1), 'r*')

% [ Cmdate_mat, C0_10phyto_mat, yearlist, yd ] = timeseries2ydmat( unqday, C0_10phyto );
% [ Cmdate_mat, C10_20phyto_mat, yearlist, yd ] = timeseries2ydmat( unqday, C10_20phyto );
% [ Cmdate_mat, C20_infphyto_mat, Cyearlist, yd ] = timeseries2ydmat( unqday, C20_infphyto );
% [ Cmdate_mat, C20_diatom_mat, Cyearlist, yd ] = timeseries2ydmat( unqday, C_diatom );

Notes1 = 'Output from summary_size_classe.m';
Notes2 = 'Carbon values in micrograms per mL';
Cmdate_day = unqday;
%save c:\work\mvco\carbon\IFCB_carbon_manual_May2012 Cmdate_mat C0_10phyto_mat C10_20phyto_mat C20_infphyto_mat C_diatom C_day_mat classes Cyearlist yd ind_diatom ind_phyto Notes1 Notes2 Cmdate_day
%save C:\Users\Emily Fay\Documents\Ciliate_Code\IFCB_carbon_manual_March2012 Cmdate_mat C0_10phyto_mat C10_20phyto_mat C20_infphyto_mat C_diatom C_day_mat classes Cyearlist yd ind_diatom ind_phyto Notes1 Notes2 Cmdate_day

clear C* N*
clear biovol0_10 biovol0_10_mat biovol0_10phyto 
clear biovol10_20 biovol10_20_mat biovol10_20phyto 
clear biovol20_30 biovol20_30_mat biovol20_30phyto 
clear biovol30_40 biovol30_40_mat biovol30_40phyto 
clear biovol40_inf biovol40_inf_mat biovol40_infphyto 
clear biovol0_10phyto biovol10_20phyto biovol20_30phyto biovol30_40phyto_all biovol40_infphyto 
clear biovol0_10sum biovol10_20sum biovol20_30sum biovol30_40sum biovol40_infsum
clear roiID totalbiovol_phyto totoalbiovol_phyto
clear eqdiam0* eqdiam1* eqdiam2* eqdiam3* eqdiam4*  
clear biovol_day ciliate_flag classes diatom_flag ind_ciliate ind_diatom ind_phyto

  