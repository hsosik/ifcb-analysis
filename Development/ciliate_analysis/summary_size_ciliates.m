%load '\\raspberry\d_work\ifcb1\ifcb_data_mvco_jun06\manual_fromClass\summary\count_biovol_size_manual_10Apr2012.mat'

%load 'C:\work\ifcb\ifcb_data_MVCO_jun06\manual_fromClass\summary\count_biovol_size_manual_29Mar2012.mat'
%load 'C:\Users\Emily Fay\Documents\Ciliate_Code\count_biovol_manual_19Mar2013'

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

%clear classcount biovol daycount eqdiam filelist ii matdate ml ml_analyzed_struct day

%class_diatom = {'Asterionellopsis' 'Cerataulina' 'Chaetoceros' 'Corethron' 'Coscinodiscus' 'Cylindrotheca' 'DactFragCerataul' 'Dactyliosolen'...
%    'Ditylum' 'Ephemera' 'Eucampia' 'Guinardia' 'Guinardia_flaccida' 'Guinardia_striata' 'Hemiaulus' 'Lauderia' 'Leptocylindrus' 'Licmophora'...
%    'Odontella' 'Paralia' 'Pleurosigma' 'Pseudonitzschia' 'Rhizosolenia' 'Skeletonema' 'Stephanopyxis' 'Thalassionema' 'Thalassiosira' 'pennate'};
[ind_diatom] = get_diatom_ind(classes,classes);
diatom_flag = zeros(size(classes));
diatom_flag(ind_diatom) = 1;

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
        iii = find(eqdiam_day(daycount).(classes{classcount}) >= 30 & eqdiam_day(daycount).(classes{classcount}) < 60);
        if ~isempty(iii),
            N30_60(daycount).(classes{classcount}) = length(iii);
            biovol20_30(daycount).(classes{classcount}) = nansum(biovol_day(daycount).(classes{classcount})(iii));
            eqdiam30_60(daycount).(classes{classcount}) = nansum(eqdiam_day(daycount). (classes{classcount})(iii));
            cellC = biovol2carbon(biovol_day(daycount).(classes{classcount})(iii),diatom_flag(classcount));
            C20_30(daycount).(classes{classcount}) = nansum(cellC);
        else
            if ml_day(daycount).(classes{classcount}) ~= 0 && ~isnan(ml_day(daycount).(classes{classcount})),
                N30_60(daycount).(classes{classcount}) = 0;
                biovol20_30(daycount).(classes{classcount}) = 0;
                eqdiam30_60(daycount).(classes{classcount}) = 0;
                C20_30(daycount).(classes{classcount}) = 0;
            end;
        end;
        iii = find(eqdiam_day(daycount).(classes{classcount}) >= 30 & eqdiam_day(daycount).(classes{classcount}) < 40);
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
        iii = find(eqdiam_day(daycount).(classes{classcount}) >= 60);
        if ~isempty(iii),
            N60_inf(daycount).(classes{classcount}) = length(iii);
            biovol40_inf(daycount).(classes{classcount}) = nansum(biovol_day(daycount).(classes{classcount})(iii));
            eqdiam60_inf(daycount).(classes{classcount}) = nansum(eqdiam_day(daycount). (classes{classcount})(iii));
            cellC = biovol2carbon(biovol_day(daycount).(classes{classcount})(iii),diatom_flag(classcount));
            C40_inf(daycount).(classes{classcount}) = nansum(cellC);
        else
            if ml_day(daycount).(classes{classcount}) ~= 0 && ~isnan(ml_day(daycount).(classes{classcount})),
                N60_inf(daycount).(classes{classcount}) = 0;
                biovol40_inf(daycount).(classes{classcount}) = 0;
                eqdiam60_inf(daycount).(classes{classcount}) = 0;
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
eqdiam10_30_mat = squeeze(cell2mat(struct2cell(eqdiam10_30)))'./ml_day_mat; eqdiam10_30sum = sum(eqdiam10_30_mat,2);
eqdiam30_60_mat = squeeze(cell2mat(struct2cell(eqdiam30_60)))'./ml_day_mat; eqdiam30_60sum = sum(eqdiam30_60_mat,2);
eqdiam30_40_mat = squeeze(cell2mat(struct2cell(eqdiam30_40)))'./ml_day_mat; eqdiam30_40sum = sum(eqdiam30_40_mat,2);
eqdiam60_inf_mat = squeeze(cell2mat(struct2cell(eqdiam60_inf)))'./ml_day_mat; eqdiam60_infsum = sum(eqdiam60_inf_mat,2);

biovol0_10_mat = squeeze(cell2mat(struct2cell(biovol0_10)))'./ml_day_mat; biovol0_10sum = sum(biovol0_10_mat,2);
biovol10_20_mat = squeeze(cell2mat(struct2cell(biovol10_20)))'./ml_day_mat; biovol10_20sum = sum(biovol10_20_mat,2);
biovol20_30_mat = squeeze(cell2mat(struct2cell(biovol20_30)))'./ml_day_mat; biovol20_30sum = sum(eqdiam20_30_mat,2);
biovol30_40_mat = squeeze(cell2mat(struct2cell(biovol30_40)))'./ml_day_mat; biovol30_40sum = sum(eqdiam30_40_mat,2);
biovol40_inf_mat = squeeze(cell2mat(struct2cell(biovol40_inf)))'./ml_day_mat; biovol40_infsum = sum(biovol40_inf_mat,2);

N0_10_mat = squeeze(cell2mat(struct2cell(N0_10)))'./ml_day_mat; N0_10sum = sum(N0_10_mat,2);
N10_30_mat = squeeze(cell2mat(struct2cell(N10_30)))'./ml_day_mat; N10_30sum = sum(N10_30_mat,2);
N30_60_mat = squeeze(cell2mat(struct2cell(N30_60)))'./ml_day_mat; N30_60sum = sum(N30_60_mat,2);
N30_40_mat = squeeze(cell2mat(struct2cell(N30_40)))'./ml_day_mat; N30_40sum = sum(N30_40_mat,2);
N60_inf_mat = squeeze(cell2mat(struct2cell(N60_inf)))'./ml_day_mat; N60_infsum = sum(N60_inf_mat,2);

[ind_ciliate] = get_ciliate_ind(classes,classes);
ciliate_flag = zeros(size(classes));


eqdiam0_10ciliate = sum(eqdiam0_10_mat(:,ind_ciliate(6)),2);
eqdiam10_30ciliate = sum(eqdiam10_30_mat(:,ind_ciliate(4)),2);
eqdiam30_60ciliate = sum(eqdiam30_60_mat(:,ind_ciliate(4)),2);
eqdiam30_40ciliate = sum(eqdiam30_40_mat(:,ind_ciliate(4)),2);
eqdiam60_infciliate = sum(eqdiam60_inf_mat(:,ind_ciliate(4)),2);

biovol0_10ciliate = sum(biovol0_10_mat(:,ind_ciliate(4)),2);
biovol10_20ciliate = sum(biovol10_20_mat(:,ind_ciliate(4)),2);
biovol20_30ciliate = sum(biovol20_30_mat(:,ind_ciliate(4)),2);
biovol30_40ciliate = sum(biovol30_40_mat(:,ind_ciliate(4)),2);
biovol40_infciliate = sum(biovol40_inf_mat(:,ind_ciliate(4)),2);
totalbiovol_ciliate = biovol0_10ciliate + biovol10_20ciliate + biovol20_30ciliate + biovol30_40ciliate + biovol40_infciliate;

biovol0_10ciliate_all = sum(biovol0_10_mat(:,ind_ciliate(3)),2);
biovol10_20ciliate_all = sum(biovol10_20_mat(:,ind_ciliate(3)),2);
biovol20_30ciliate_all = sum(biovol20_30_mat(:,ind_ciliate(3)),2);
biovol30_40ciliate_all = sum(biovol30_40_mat(:,ind_ciliate(3)),2);
biovol40_infciliate_all = sum(biovol40_inf_mat(:,ind_ciliate(3)),2);
totalbiovol_ciliate_all = biovol0_10ciliate_all + biovol10_20ciliate_all + biovol20_30ciliate_all + biovol30_40ciliate_all + biovol40_infciliate_all;

N0_10ciliate_all = sum(N0_10_mat(:,ind_ciliate(:)),2);
N10_30ciliate_all = sum(N10_30_mat(:,ind_ciliate(:)),2);
N30_60ciliate_all = sum(N30_60_mat(:,ind_ciliate(:)),2);
N30_40ciliate_all = sum(N30_40_mat(:,ind_ciliate(:)),2);
N60_infciliate_all = sum(N60_inf_mat(:,ind_ciliate(:)),2);
totalN_ciliate_all = N0_10ciliate_all + N10_30ciliate_all + N30_60ciliate_all + N600_infciliate_all;

% ind_phyto = get_phyto_ind( classes, classes );
% C_phyto = sum(C_day_mat(:,ind_phyto),2); %sum to skip the ones that are incomplete for all diatoms
% C0_10phyto = sum(C0_10_mat(:,ind_phyto),2);
% C10_20phyto = sum(C10_20_mat(:,ind_phyto),2);
% C20_infphyto = sum(C20_inf_mat(:,ind_phyto),2);

[ Cmdate_mat, eqdiam0_10ciliate_mat, yearlist, yd ] = timeseries2ydmat( unqday, eqdiam0_10ciliate );
[ Cmdate_mat, eqdiam10_30ciliate_mat, yearlist, yd ] = timeseries2ydmat( unqday, eqdiam10_30ciliate );
[ Cmdate_mat, eqdiam30_60ciliate_mat, yearlist, yd ] = timeseries2ydmat( unqday, eqdiam30_60ciliate );
[ Cmdate_mat, eqdiam30_40ciliate_mat, yearlist, yd ] = timeseries2ydmat( unqday, eqdiam30_40ciliate );
[ Cmdate_mat, eqdiam60_infciliate_mat, yearlist, yd ] = timeseries2ydmat( unqday, eqdiam60_infciliate );

[ Cmdate_mat, biovol0_10ciliate_mat, yearlist, yd ] = timeseries2ydmat( unqday, biovol0_10ciliate );
[ Cmdate_mat, biovol10_20ciliate_mat, yearlist, yd ] = timeseries2ydmat( unqday, biovol10_20ciliate );
[ Cmdate_mat, biovol20_30ciliate_mat, yearlist, yd ] = timeseries2ydmat( unqday, biovol20_30ciliate );
[ Cmdate_mat, biovol30_40ciliate_mat, yearlist, yd ] = timeseries2ydmat( unqday, biovol30_40ciliate );
[ Cmdate_mat, biovol40_infciliate_mat, yearlist, yd ] = timeseries2ydmat( unqday, biovol40_infciliate );
[ Cmdate_mat, totalbiovol_ciliate_mat, yearlist, yd ] = timeseries2ydmat( unqday, totalbiovol_ciliate );

[ Cmdate_mat, biovol0_10ciliate_all_mat, yearlist, yd ] = timeseries2ydmat( unqday, biovol0_10ciliate_all );
[ Cmdate_mat, biovol10_20ciliate_all_mat, yearlist, yd ] = timeseries2ydmat( unqday, biovol10_20ciliate_all );
[ Cmdate_mat, biovol20_30ciliate_all_mat, yearlist, yd ] = timeseries2ydmat( unqday, biovol20_30ciliate_all );
[ Cmdate_mat, biovol30_40ciliate_all_mat, yearlist, yd ] = timeseries2ydmat( unqday, biovol30_40ciliate_all );
[ Cmdate_mat, biovol40_infciliate_all_mat, yearlist, yd ] = timeseries2ydmat( unqday, biovol40_infciliate_all );
[ Cmdate_mat, totalbiovol_ciliate_all_mat, yearlist, yd ] = timeseries2ydmat( unqday, totalbiovol_ciliate_all );

[ Cmdate_mat, N0_10ciliate_all_mat, yearlist, yd ] = timeseries2ydmat( unqday, N0_10ciliate_all );
[ Cmdate_mat, N10_30ciliate_all_mat, yearlist, yd ] = timeseries2ydmat( unqday, N10_30ciliate_all );
[ Cmdate_mat, N30_60ciliate_all_mat, yearlist, yd ] = timeseries2ydmat( unqday, N30_60ciliate_all );
[ Cmdate_mat, N30_40ciliate_all_mat, yearlist, yd ] = timeseries2ydmat( unqday, N30_40ciliate_all );
[ Cmdate_mat, N60_infciliate_all_mat, yearlist, yd ] = timeseries2ydmat( unqday, N60_infciliate_all );
[ Cmdate_mat, totalN_ciliate_all_mat, yearlist, yd ] = timeseries2ydmat( unqday, totalN_ciliate_all );

% ciliate_biovol_fraction0_10 = (biovol0_10ciliate_mat./totalbiovol_ciliate_mat);
% ciliate_biovol_fraction10_20 = (biovol10_20ciliate_mat./totalbiovol_ciliate_mat);
% ciliate_biovol_fraction20_30 = (biovol20_30ciliate_mat./totalbiovol_ciliate_mat);
% ciliate_biovol_fraction30_40 = (biovol30_40ciliate_mat./totalbiovol_ciliate_mat);
% ciliate_biovol_fraction40_inf = (biovol40_infciliate_mat./totalbiovol_ciliate_mat);
% 
% ciliate_all_biovol_fraction0_10 = (biovol0_10ciliate_all_mat./totalbiovol_ciliate_all_mat);
% ciliate_all_biovol_fraction10_20 = (biovol10_20ciliate_all_mat./totalbiovol_ciliate_all_mat);
% ciliate_all_biovol_fraction20_30 = (biovol20_30ciliate_all_mat./totalbiovol_ciliate_all_mat);
% ciliate_all_biovol_fraction30_40 = (biovol30_40ciliate_all_mat./totalbiovol_ciliate_all_mat);
% ciliate_all_biovol_fraction40_inf = (biovol40_infciliate_all_mat./totalbiovol_ciliate_all_mat);
% 
% ciliate_all_N_fraction0_10 = (N0_10ciliate_all_mat./totalN_ciliate_all_mat);
% ciliate_all_N_fraction10_20 = (N10_20ciliate_all_mat./totalN_ciliate_all_mat);
% ciliate_all_N_fraction20_30 = (N20_30ciliate_all_mat./totalN_ciliate_all_mat);
% ciliate_all_N_fraction30_40 = (N30_40ciliate_all_mat./totalN_ciliate_all_mat);
% ciliate_all_N_fraction40_inf = (N40_infciliate_all_mat./totalN_ciliate_all_mat);


% [ Cmdate_mat, C0_10phyto_mat, yearlist, yd ] = timeseries2ydmat( unqday, C0_10phyto );
% [ Cmdate_mat, C10_20phyto_mat, yearlist, yd ] = timeseries2ydmat( unqday, C10_20phyto );
% [ Cmdate_mat, C20_infphyto_mat, Cyearlist, yd ] = timeseries2ydmat( unqday, C20_infphyto );
% [ Cmdate_mat, C20_diatom_mat, Cyearlist, yd ] = timeseries2ydmat( unqday, C_diatom );

Notes1 = 'Output from summary_size_classe.m';
Notes2 = 'Carbon values in micrograms per mL';
Cmdate_day = unqday;
%save c:\work\mvco\carbon\IFCB_carbon_manual_May2012 Cmdate_mat C0_10phyto_mat C10_20phyto_mat C20_infphyto_mat C_diatom C_day_mat classes Cyearlist yd ind_diatom ind_phyto Notes1 Notes2 Cmdate_day
%save C:\Users\Emily Fay\Documents\Ciliate_Code\IFCB_carbon_manual_March2012 Cmdate_mat C0_10phyto_mat C10_20phyto_mat C20_infphyto_mat C_diatom C_day_mat classes Cyearlist yd ind_diatom ind_phyto Notes1 Notes2 Cmdate_day
%save biovol0_10ciliate_all_mat yearlist yd biovol10_20ciliate_all_mat biovol20_30ciliate_all_mat biovol30_40ciliate_all_mat biovol40_infciliate_all_mat totalbiovol_ciliate_all_mat

% clear C* 
% clear biovol0_10 biovol0_10_mat biovol0_10ciliate biovol0_10ciliate_mat 
% clear biovol10_20 biovol10_20_mat biovol10_20ciliate biovol10_20ciliate_mat
% clear biovol20_30 biovol20_30_mat biovol20_30ciliate biovol20_30ciliate_mat
% clear biovol30_40 biovol30_40_mat biovol30_40ciliate biovol30_40ciliate_mat
% clear biovol40_inf biovol40_inf_mat biovol40_infciliate biovol40_infciliate_mat
% clear biovol0_10ciliate_all biovol10_20ciliate_all biovol20_30ciliate_all biovol30_40ciliate_all biovol40_infciliate_all 
% clear biovol0_10sum biovol10_20sum biovol20_30sum biovol30_40sum biovol40_infsum
% clear roiID totalbiovol_ciliate totoalbiovol_ciliate_all
% clear eqdiam0* eqdiam1* eqdiam2* eqdiam3* eqdiam4*  
% clear biovol_day ciliate_flag classes diatom_flag ind_ciliate ind_diatom 
                                         
                                      
                                  
                                          
                                            
                                       
