%load 'c:\work\IFCB\ifcb_data_mvco_jun06\Manual_fromClass\summary\count_biovol_size_manual_24Jan2014.mat'
load '\\raspberry\d_work\ifcb1\ifcb_data_mvco_jun06\manual_fromClass\summary\count_biovol_size_manual_current.mat'
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
N0_10 = N_day; N20_inf = N_day;
biovol0_10 = N_day; biovol10_20 = N_day; biovol20_inf = N_day;
C0_10 = N_day; C10_20 = N_day; C20_inf = N_day;
eqdiam_day = biovol_day;
for daycount = 1:length(unqday),
    disp(datestr(unqday(daycount)))
    %ii = find(day == unqday(daycount));
    for classcount = 1:length(classes),        
        ii = find(day == unqday(daycount) & ~isnan(ml_analyzed_struct.(classes{classcount})));
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
            cellC = biovol2carbon(biovol_day(daycount).(classes{classcount})(iii),diatom_flag(classcount));
            C0_10(daycount).(classes{classcount}) = nansum(cellC);
        else
            if ml_day(daycount).(classes{classcount}) ~= 0 && ~isnan(ml_day(daycount).(classes{classcount})),
                N0_10(daycount).(classes{classcount}) = 0;
                biovol0_10(daycount).(classes{classcount}) = 0;
                C0_10(daycount).(classes{classcount}) = 0;
            end;
        end;
        iii = find(eqdiam_day(daycount).(classes{classcount}) >= 10 & eqdiam_day(daycount).(classes{classcount}) < 20);
        if ~isempty(iii),
            N10_20(daycount).(classes{classcount}) = length(iii);
            biovol10_20(daycount).(classes{classcount}) = nansum(biovol_day(daycount).(classes{classcount})(iii));
            cellC = biovol2carbon(biovol_day(daycount).(classes{classcount})(iii),diatom_flag(classcount));
            C10_20(daycount).(classes{classcount}) = nansum(cellC);
        else
            if ml_day(daycount).(classes{classcount}) ~= 0 && ~isnan(ml_day(daycount).(classes{classcount})),
            N10_20(daycount).(classes{classcount}) = 0;
            biovol10_20(daycount).(classes{classcount}) = 0;    
            C10_20(daycount).(classes{classcount}) = 0;    
            end;
        end;
        iii = find(eqdiam_day(daycount).(classes{classcount}) >= 20);
        if ~isempty(iii),
            N20_inf(daycount).(classes{classcount}) = length(iii);
            biovol20_inf(daycount).(classes{classcount}) = nansum(biovol_day(daycount).(classes{classcount})(iii));
            cellC = biovol2carbon(biovol_day(daycount).(classes{classcount})(iii),diatom_flag(classcount));
            C20_inf(daycount).(classes{classcount}) = nansum(cellC);
        else
            if ml_day(daycount).(classes{classcount}) ~= 0 && ~isnan(ml_day(daycount).(classes{classcount})),
            N20_inf(daycount).(classes{classcount}) = 0;
            biovol20_inf(daycount).(classes{classcount}) = 0;    
            C20_inf(daycount).(classes{classcount}) = 0;    
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

C0_10_mat = squeeze(cell2mat(struct2cell(C0_10)))'./ml_day_mat/1000; C0_10sum = sum(C0_10_mat,2);
C10_20_mat = squeeze(cell2mat(struct2cell(C10_20)))'./ml_day_mat/1000; C10_20sum = sum(C10_20_mat,2);
C20_inf_mat = squeeze(cell2mat(struct2cell(C20_inf)))'./ml_day_mat/1000; C20_infsum = sum(C20_inf_mat,2);

ind_phyto = get_phyto_ind( classes, classes );
C_phyto = sum(C_day_mat(:,ind_phyto),2); %sum to skip the ones that are incomplete for all diatoms
C0_10phyto = sum(C0_10_mat(:,ind_phyto),2);
C10_20phyto = sum(C10_20_mat(:,ind_phyto),2);
C20_infphyto = sum(C20_inf_mat(:,ind_phyto),2);

[ Cmdate_mat, C0_10phyto_mat, yearlist, yd ] = timeseries2ydmat( unqday, C0_10phyto );
[ Cmdate_mat, C10_20phyto_mat, yearlist, yd ] = timeseries2ydmat( unqday, C10_20phyto );
[ Cmdate_mat, C20_infphyto_mat, Cyearlist, yd ] = timeseries2ydmat( unqday, C20_infphyto );
[ Cmdate_mat, C20_diatom_mat, Cyearlist, yd ] = timeseries2ydmat( unqday, C_diatom );

Notes1 = 'Output from summary_size_classes.m';
Notes2 = 'Carbon values in micrograms per mL';
Cmdate_day = unqday;
%save c:\work\mvco\carbon\IFCB_carbon_manual_Jan2014 Cmdate_mat C0_10phyto_mat C10_20phyto_mat C20_infphyto_mat C_diatom C_day_mat classes Cyearlist yd ind_diatom ind_phyto Notes1 Notes2 Cmdate_day
datestr = date; datestr = regexprep(datestr,'-','');
save(['\\raspberry\d_work\IFCB1\ifcb_data_mvco_jun06\Manual_fromClass\summary\IFCB_carbon_manual_' datestr], 'Cmdate_mat', 'C0_10phyto_mat', 'C10_20phyto_mat', 'C20_infphyto_mat', 'C_diatom', 'C_day_mat', 'classes', 'Cyearlist', 'yd', 'ind_diatom', 'ind_phyto', 'Notes1', 'Notes2', 'Cmdate_day')

