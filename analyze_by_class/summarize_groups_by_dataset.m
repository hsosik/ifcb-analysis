function [] = summarize_groups_by_dataset(dataset_name)

base_path = ['\\sosiknas1\IFCB_products\' dataset_name '\summary\'];
if isequal(lower(dataset_name), 'mvco')
    base_path = ['\\sosiknas1\IFCB_products\' dataset_name '\summary_v4\'];
end
%base_path = ['\\sosiknas1\IFCB_products\' dataset_name '\summary\'];
TS_path = ['\\sosiknas1\IFCB_data\' dataset_name '\match_up\'];
outname = 'carbon_group_class';
outname2 = 'count_group_class';
%yr = 2018:2022;
flist = dir([base_path 'summary_biovol_allHDF_min20_????.mat']);
%flist = flist(end);
%flist = dir([base_path 'summary_biovol_allHDF_min20_2021.mat']);
%flist(strcmp({flist.name},'summary_biovol_allHDF_min20_2021.mat')) = [];
meta_data = table;
groupC_opt = table;
groupC = table;
groupC_adhoc = table;
classC_opt = table;
classC = table;
classC_adhoc = table;
groupcount_opt = table;
groupcount = table;
groupcount_adhoc = table;
classcount_opt = table;
classcount = table;
classcount_adhoc = table;

%groups1 = {'protist_tricho', 'Detritus', 'IFCBArtifact', 'metazoan'}; %primary
for ii = 1:length(flist)
    disp(flist(ii).name)
    T = load([base_path flist(ii).name]);
    T2 = load([base_path regexprep(flist(ii).name, '.mat', 'lists_group.mat')]);
    %T2 = load([base_path 'summary_biovol_allHDF_min20_' num2str(yr(ii)) 'lists_group']);
    %%T3 = load([base_path 'summary_biovol_allHDF_min20_' num2str(yr(ii)) 'lists']);
    primary_score_ind = find(strcmp('score_prim', T2.groupFeaList_variables));
    second_score_ind = find(strcmp('score_sec', T2.groupFeaList_variables));
    cellC_ind = find(strcmp('cellC', T2.groupFeaList_variables));
    ESD_ind = find(strcmp('ESD', T2.groupFeaList_variables));
    %%
    for iii = 1:size(T.meta_data,1)
        if ~isempty(T2.groupFeaList.NanoFlagCocco{iii})
            ind = (T2.groupFeaList.NanoFlagCocco{iii}(:,ESD_ind)>=5 & T2.groupFeaList.NanoFlagCocco{iii}(:,primary_score_ind) >= T.optthresh_group.protist_tricho & T2.groupFeaList.NanoFlagCocco{iii}(:,second_score_ind) >= T.optthresh_group.NanoFlagCocco);
            T.groupC_above_optthresh.NanoFlagCocco_gt5(iii) = sum(T2.groupFeaList.NanoFlagCocco{iii}(ind,cellC_ind));
            T.groupcount_above_optthresh.NanoFlagCocco_gt5(iii) = sum(ind);      
            
            ind = (T2.groupFeaList.NanoFlagCocco{iii}(:,ESD_ind)>=5 & T2.groupFeaList.NanoFlagCocco{iii}(:,primary_score_ind) >= T.optthresh_group.protist_tricho & T2.groupFeaList.NanoFlagCocco{iii}(:,second_score_ind) >= T.optthresh_group.NanoFlagCocco);
            T.groupC_above_adhocthresh.NanoFlagCocco_gt5(iii) = sum(T2.groupFeaList.NanoFlagCocco{iii}(ind,cellC_ind));
            T.groupcount_above_adhocthresh.NanoFlagCocco_gt5(iii) = sum(ind);
            
            ind = (T2.groupFeaList.NanoFlagCocco{iii}(:,ESD_ind)>=5 & T2.groupFeaList.NanoFlagCocco{iii}(:,primary_score_ind) >= T.optthresh_group.protist_tricho);
            T.groupC.NanoFlagCocco_gt5(iii) = sum(T2.groupFeaList.NanoFlagCocco{iii}(ind,cellC_ind));
            T.groupcount.NanoFlagCocco_gt5(iii) = sum(ind);
%            ind = (T2.groupFeaList.NanoFlagCocco{iii}(:,primary_score_ind) >= T.optthresh_group.protist_tricho);

            %tally those >5 micron, yes protist, but no for more specific groups
            glist = {"NanoFlagCocco" "Diatom_noDetritus" "Dinoflagellate" "Ciliate"};
            temp = 0;
            temp2 = 0;
            for ig = 1:length(glist)
                ind = (T2.groupFeaList.(glist{ig}){iii}(:,ESD_ind)>=5 & T2.groupFeaList.(glist{ig}){iii}(:,primary_score_ind) >= T.optthresh_group.protist_tricho & T2.groupFeaList.(glist{ig}){iii}(:,second_score_ind) < T.optthresh_group.(glist{ig}));
                temp = temp + sum(T2.groupFeaList.(glist{ig}){iii}(ind,cellC_ind));
                temp2 = temp2 +sum(ind);
            end
            T.groupC_above_optthresh.miscProtist_gt5(iii) = temp;
            T.groupcount_above_optthresh.miscProtist_gt5(iii) = temp2;
        else
            T.groupC_above_optthresh.NanoFlagCocco_gt5(iii) = NaN;
            T.groupC_above_adhocthresh.NanoFlagCocco_gt5(iii) = NaN;
            T.groupC.NanoFlagCocco_gt5(iii) = NaN;
            T.groupC_above_optthresh.miscProtist_gt5(iii) = NaN;
            T.groupcount_above_optthresh.NanoFlagCocco_gt5(iii) = NaN;
            T.groupcount_above_adhocthresh.NanoFlagCocco_gt5(iii) = NaN;
            T.groupcount.NanoFlagCocco_gt5(iii) = NaN;
            T.groupcount_above_optthresh.miscProtist_gt5(iii) = NaN;
        end
    end
    %%
    groupC_opt = [groupC_opt; T.groupC_above_optthresh];
    groupC_adhoc = [groupC_adhoc; T.groupC_above_adhocthresh];
    groupC = [groupC; T.groupC];
    classC_opt = [classC_opt; T.classC_above_optthresh];
    classC_adhoc = [classC_adhoc; T.classC_above_adhocthresh];
    classC = [classC; T.classC];
    
    groupcount_opt = [groupcount_opt; T.groupcount_above_optthresh];
    groupcount_adhoc = [groupcount_adhoc; T.groupcount_above_adhocthresh];
    groupcount = [groupcount; T.groupcount];
    classcount_opt = [classcount_opt; T.classcount_above_optthresh];
    classcount_adhoc = [classcount_adhoc; T.classcount_above_adhocthresh];
    classcount = [classcount; T.classcount];

    meta_data = [meta_data; T.meta_data];
end
optthresh = T.optthresh;
%save([base_path 'carbon_group_class'], 'meta_data', 'classC*', 'groupC*', 'optthresh')

if exist([TS_path 'compiledTS_tables.mat'], 'file')
    allTS = load([TS_path 'compiledTS_tables']);
    [~,ia,ib] = intersect(meta_data.pid, allTS.match_uw.pid);
    meta_data.temperature(:) = NaN;
    meta_data.salinity(:) = NaN;
    meta_data.temperature(ia) = allTS.match_uw.temperature(ib);
    meta_data.salinity(ia) = allTS.match_uw.salinity(ib);
    if isfield(allTS, 'match_cast')
        [~,ia,ib] = intersect(meta_data.pid, allTS.match_cast.pid); 
        meta_data.temperature(ia) = allTS.match_cast.t090c(ib);
        meta_data.salinity(ia) = allTS.match_cast.sal00(ib);
    end
    outname = 'carbon_group_class_withTS';
    outname2 = 'count_group_class_withTS';
else
    disp('no compiled TS data; run compile_*_ancillary if needed')
end

classC_opt_adhoc_merge = classC_adhoc;
classcount_opt_adhoc_merge = classcount_adhoc;
nind = find(~isnan(optthresh{:,:}))+1; %index into class table
classC_opt_adhoc_merge(:,nind) = classC_opt(:,nind);
classcount_opt_adhoc_merge(:,nind) = classcount_opt(:,nind);

group_table = readtable('\\sosiknas1\training_sets\IFCB\config\IFCB_classlist_type.csv');
diatom_label = intersect(classC.Properties.VariableNames, [group_table.CNN_classlist(find(group_table.Diatom_noDetritus))]);
dino_label = intersect(classC.Properties.VariableNames, [group_table.CNN_classlist(find(group_table.Dinoflagellate))]);
ciliate_label = intersect(classC.Properties.VariableNames, [group_table.CNN_classlist(find(group_table.Ciliate))]);
protist_tricho_label = intersect(classC.Properties.VariableNames,[group_table.CNN_classlist(find(group_table.protist_tricho))]);
detritus_label = intersect(classC.Properties.VariableNames,[group_table.CNN_classlist(find(group_table.Detritus))]);
artifact_label = intersect(classC.Properties.VariableNames,[group_table.CNN_classlist(find(group_table.IFCBArtifact))]);
metazoan_label = intersect(classC.Properties.VariableNames,[group_table.CNN_classlist(find(group_table.metazoan))]);
nanoflagcocco_label = intersect(classC.Properties.VariableNames, [group_table.CNN_classlist(find(group_table.Nano)); group_table.CNN_classlist(find(group_table.flagellate)); group_table.CNN_classlist(find(group_table.Coccolithophore))]);

save([base_path  outname], 'meta_data', 'classC*', 'groupC*', 'optthresh', '*_label')
save([base_path  outname2], 'meta_data', 'classcount*', 'groupcount*', 'optthresh', '*_label')

disp('Results saved:')
disp([base_path outname])
disp([base_path outname2])

%    uwind = find(strcmp(meta_data.sample_type, 'underway') & ~meta_data.skip);
%    uwind40 = find(strcmp(meta_data.sample_type, 'underway') & ~meta_data.skip & meta_data.latitude < 40);
end

