function biovolume_summary_allHDF2(datasetStr,year_range)
% function biovolume_summary_allHDF2(datasetStr,year_range)
% datasetStr = IFCB dataset string (usuually label in dashboard)
% year_range = one or two element vector of start & end years to process
% examples:
% biovolume_summary_allHDF2('OTZ',2020)
% biovolume_summary_allHDF2('MVCO',2020:2022)
% dateStr entry must have a corresponding case in the function
%
% D Catlett added incorporation of Heidi's fixed ml_analyzed on 11/21/2022
% for NES transect, NES broadscale, and MVCO.

% D Catlett added km2coast field to broadscale and transect meta data
% tables on 9/30/2022. Cite this if you use that field:
% Chad A. Greene, Kaustubh Thirumalai, Kelly A. Kearney, Jose Miguel Delgado, Wolfgang Schwanghart, Natalie S. Wolfenbarger, Kristen M. Thyng, David E. Gwyther, Alex S. Gardner, and Donald D. Blankenship. The Climate Data Toolbox for MATLAB. Geochemistry, Geophysics, Geosystems 2019. doi:10.1029/2019GC008392

%resultpath = '\\sosiknas1\IFCB_products\MVCO\summary\';
%classpath_generic = '\\sosiknas1\IFCB_products\MVCO\train_May2019_jmf\RUN-RESULTS\RUN_mvco_Jan10-pt-uw\';
%feapath_generic = '\\sosiknas1\IFCB_products\MVCO\features\featuresxxxx_v2\';
%hdrpath = 'https://ifcb-data.whoi.edu/MVCO/';

%% group selection (dylan's addition):
group_file = '\\sosiknas1\training_sets\IFCB\config\IFCB_classlist_type.csv';
group2use = {'protist_tricho', 'Detritus', 'IFCBArtifact', 'metazoan', ...
    'Diatom_noDetritus', 'Dinoflagellate', 'Ciliate', 'Other_phyto'};
% (NanoFlagCocco added below)...

group_tab = readtable(group_file);
% add in a combined nano with Nano, flagellate, and cocco's:
group_tab.NanoFlagCocco = zeros(size(group_tab,1),1);
group_tab.NanoFlagCocco(group_tab.Nano == 1 | group_tab.flagellate == 1 | group_tab.Coccolithophore == 1) = 1;
group2use_in = cat(2, group2use, {'NanoFlagCocco'});

% this needs to happen for hierarchical classifications: make a table with
% primary groups as vars and subgroups contained in each.
groupXgroup = table;
groupXgroup.protist_tricho = {'Diatom_noDetritus', 'Dinoflagellate', ...
    'Ciliate', 'Other_phyto', 'NanoFlagCocco'};
groupXgroup.Detritus = nan(size(groupXgroup,1),1);
groupXgroup.IFCBArtifact = nan(size(groupXgroup,1),1);
groupXgroup.metazoan = nan(size(groupXgroup,1),1);

group_tab = group_tab(:, cat(2, {'CNN_classlist'}, group2use_in));
% optthresh_group = nan(1, length(group2use_in));
% group_opt_path = '\\sosiknas1\Lab_data\dylan_working\cnn_score_data_byClass\';

load("\\sosiknas1\Lab_data\dylan_working\cnn_score_data_byClass\opt_threshXstatisticXgroup.mat")
% groupXstat = {}; % if empty does prec-rec. Otherwise write group,stat in an group X 2 cell array.
groupXstat = cat(1, group2use, repmat({'prec-rec'}, 1, length(group2use)))';
optthresh_group = optXstatXgroup("prec-rec" , :);

% for i = 1:length(group2use_in)
%     pp = [group_opt_path, group2use_in{i}, '\', group2use_in{i}, '_adhoc_stat_table_groupsum.mat'];
%     if exist(pp, "file")
%         load(pp);
% 
%         if any(ismember(groupXstat, group2use_in{i}), "all")
% 
%             % grab opt thresh specified in classXstat
%             ss = groupXstat{ismember(groupXstat(:,1),group2use_in{i}),2}; % statistic
%             oo = optimize_my_stat_tab(stat_table, ss);
%             optthresh_group(i) = oo;
%         else
%             % grab opt thresh for prec-rec
%             oo = optimize_my_stat_tab(stat_table, 'prec-rec');
%             optthresh_group(i) = min(oo);
% 
%             groupXstat = cat(1, groupXstat, {group2use_in{i}, 'prec-rec'});
%         end
%     end
% end

%%
mvco_flag = 0;
pidlist_flag = 1;

switch datasetStr
    case 'NESLTER_broadscale'
        pidlist_flag = 0;  %% CHANGE LATER IF DESIRED
        resultpath = '\\sosiknas1\IFCB_products\NESLTER_broadscale\summary\';
        classpath_generic = '\\sosiknas1\IFCB_products\NESLTER_broadscale\class\v3\20220209_Jan2022_NES_2.4\';
        feapath_generic = '\\sosiknas1\IFCB_products\NESLTER_broadscale\features\';
        hdrpath = 'https://ifcb-data.whoi.edu/NESLTER_broadscale/';
        opts = delimitedTextImportOptions("NumVariables", 24);
        opts.DataLines = [2 inf];
        %case with 8 tags
        opts.VariableTypes = ["string", "string", "string", "double", "double", "double", "double", "double", "string", "string", "double", "string", "double", "string", "string", "string", "string", "string", "string", "string", "string", "string", "double", "double"];
        opts.VariableNamesLine = 1;
        myreadtable = @(filename)readtable(filename, opts);
        metaT = webread('https://ifcb-data.whoi.edu/api/export_metadata/NESLTER_broadscale', weboptions('Timeout', 60, 'ContentReader', myreadtable));
        metaT.km2coast = dist2coast(metaT.latitude, metaT.longitude);

        metaT = add_fixed_ml_analyzed_to_summary(metaT, 'NESLTER_broadscale');

    case 'NESLTER_transect'
        resultpath = '\\sosiknas1\IFCB_products\NESLTER_transect\summary\';
        classpath_generic = '\\sosiknas1\IFCB_products\NESLTER_transect\class\v3\20220209_Jan2022_NES_2.4\';
        feapath_generic = '\\sosiknas1\IFCB_products\NESLTER_transect\features\';
        opts = delimitedTextImportOptions("NumVariables", 21);
        opts.DataLines = [2 inf];
        %case with 5 tags
        opts.VariableTypes = ["string", "string", "string", "double", "double", "double", "double", "double", "string", "string", "double", "string", "double", "string", "string", "string", "string", "string", "string", "double", "double"];
        opts.VariableNamesLine = 1;
        myreadtable = @(filename)readtable(filename, opts);
        metaT = webread('https://ifcb-data.whoi.edu/api/export_metadata/NESLTER_transect', weboptions('Timeout', 60, 'ContentReader', myreadtable));
        metaT.km2coast = dist2coast(metaT.latitude, metaT.longitude);

        metaT = add_fixed_ml_analyzed_to_summary(metaT, 'NESLTER_transect');

    case 'OTZ'
        resultpath = '\\sosiknas1\IFCB_products\OTZ\summary\';
        %classpath_generic = '\\sosiknas1\IFCB_products\OTZ\class\v3\20220209_Jan2022_NES_2.4_RELABELED\';
        classpath_generic = '\\sosiknas1\IFCB_products\OTZ\class\v3\20230821_NEAtlantic_3.1\';
        feapath_generic = '\\sosiknas1\IFCB_products\OTZ\features\';
        metaT =  webread('https://ifcb-data.whoi.edu/api/export_metadata/OTZ_Atlantic');
        metaT = add_fixed_ml_analyzed_to_summary(metaT, 'OTZ');

    case 'SPIROPA'
        resultpath = '\\sosiknas1\IFCB_products\SPIROPA\summary\';
        classpath_generic = '\\sosiknas1\IFCB_products\SPIROPA\class\v3\20220209_Jan2022_NES_2.4\';
        feapath_generic = '\\sosiknas1\IFCB_products\SPIROPA\features\';
        opts = delimitedTextImportOptions("NumVariables", 20);
        opts.DataLines = [2 inf];
        opts.VariableTypes = ["string", "string", "string", "double", "double", "double", "double", "double", "string", "string", "double", "string", "double", "string", "string", "string", "string", "string", "double", "double"];
        opts.VariableNamesLine = 1;
        myreadtable = @(filename)readtable(filename, opts); %
        metaT =  webread('https://ifcb-data.whoi.edu/api/export_metadata/SPIROPA', weboptions('Timeout', 60, 'ContentReader', myreadtable));

    case 'MVCO'
        resultpath = '\\sosiknas1\IFCB_products\MVCO\summary_v4\';
        classpath_generic = '\\sosiknas1\IFCB_products\MVCO\class\v3\20220209_Jan2022_NES_2.4\';
        feapath_generic = '\\sosiknas1\IFCB_products\MVCO\features_v4\';
        opts = delimitedTextImportOptions("NumVariables", 20);
        opts.DataLines = [2 inf];
        %case 4 tags
        opts.VariableTypes = ["string", "string", "string", "double", "double", "double", "double", "double", "string", "string", "double", "string", "double", "string", "string", "string", "string", "string", "double", "double"];
        opts.VariableNamesLine = 1;
        myreadtable = @(filename)readtable(filename, opts); %
        metaT =  webread('https://ifcb-data.whoi.edu/api/export_metadata/mvco', weboptions('Timeout', 120, 'ContentReader', myreadtable));
        metaT = add_fixed_ml_analyzed_to_summary(metaT, 'MVCO');

        mvco_flag = 1;
        pidlist_flag = 0;

    case 'EXPORTS_2018'
        resultpath = '\\sosiknas1\IFCB_products\EXPORTS\summary\';
        classpath_generic = '\\sosiknas1\IFCB_products\EXPORTS\class\v3\20220225_EXPORTS_pacific_Dec2021_1_3\';
        feapath_generic = '\\sosiknas1\IFCB_products\EXPORTS\features\';
        opts = delimitedTextImportOptions("NumVariables", 2);
        opts.DataLines = [2 inf];
        opts.VariableTypes = ["string", "string", "string", "double", "double", "double", "double", "double", "string", "string", "double", "string", "double", "string", "string", "string", "string", "string", "string", "string", "double", "double"];
        opts.VariableNamesLine = 1;
        myreadtable = @(filename)readtable(filename, opts); %w
        metaT =  webread('https://ifcb-data.whoi.edu/api/export_metadata/EXPORTS', weboptions('Timeout', 60, 'ContentReader', myreadtable));

    case 'EXPORTS_2021'
        resultpath = '\\sosiknas1\IFCB_products\EXPORTS\summary\';
        %classpath_generic = '\\sosiknas1\IFCB_products\EXPORTS\class\v3\20220209_Jan2022_NES_2.4_RELABELED\';
        classpath_generic = '\\sosiknas1\IFCB_products\EXPORTS\class\v3\20230821_NEAtlantic_3.1\';
        feapath_generic = '\\sosiknas1\IFCB_products\EXPORTS\features\';
        opts = delimitedTextImportOptions("NumVariables", 22);
        opts.DataLines = [2 inf];
        opts.VariableTypes = ["string", "string", "string", "double", "double", "double", "double", "double", "string", "string", "double", "string", "double", "string", "string", "string", "string", "string", "string", "string", "double", "double"];
        opts.VariableNamesLine = 1;

        myreadtable = @(filename)readtable(filename, opts); %
        metaT =  webread('https://ifcb-data.whoi.edu/api/export_metadata/EXPORTS', weboptions('Timeout', 60, 'ContentReader', myreadtable));

    case 'SIO_Delmar_mooring'
        resultpath = '\\sosiknas1\IFCB_products\SIO_Delmar_mooring\summary\';
        classpath_generic = '\\sosiknas1\IFCB_products\SIO_Delmar_mooring\class\v3\20220416_Delmar_NES_1\';
        feapath_generic = '\\sosiknas1\IFCB_products\SIO_Delmar_mooring\features_v4\';
        metaT =  webread('https://ifcb-data.whoi.edu/api/export_metadata/SIO_Delmar_mooring', weboptions('Timeout', 30));

    case 'bodega-marine-lab'
        resultpath = '\\sosiknas1\IFCB_products\bodega-marine-lab\summary\';
        classpath_generic = '\\sosiknas1\IFCB_products\bodega-marine-lab\class\v3\20220209_Jan2022_NES_2.4_RELABELED\';
        feapath_generic = '\\sosiknas1\IFCB_products\bodega-marine-lab\features\';
        metaT =  webread('https://ifcb.caloos.org/api/export_metadata/bodega-marine-lab', weboptions('Timeout', 30));
    
    case 'NBP2202'
        resultpath = '\\sosiknas1\IFCB_products\NBP2202_holiver\summary\';
        classpath_generic = '\\sosiknas1\IFCB_products\NBP2202_holiver\class\v3\20230330_Jan2022_NES_forNBP2022_1.0\';
        feapath_generic = '\\sosiknas1\IFCB_products\NBP2202_holiver\features\';
        metaT =  webread('https://ifcb-data.whoi.edu/api/export_metadata/NBP2202', weboptions('Timeout', 30));
    case 'Oleander'
        resultpath = '\\sosiknas1\IFCB_products\Oleander\summary\';
        classpath_generic = '\\sosiknas1\IFCB_products\Oleander\class\v3\20220209_Jan2022_NES_2.4\';
        feapath_generic = '\\sosiknas1\IFCB_products\Oleander\features\';
        metaT =  webread('https://ifcb-data.whoi.edu/api/export_metadata/Oleander', weboptions('Timeout', 30));
   
    otherwise
        disp('Missing dataset case: check the m-file cases')
        return
end
%%
adhocthresh = 0.5;
% optimal thresholds:
% list classes and corresponding statistic you'd like to use the opt-thresh
% in rows of a cell array. class = col 1, stat = col 2, i.e.
% classes not specified here are set to use 'prec-rec' below...
classXstat = {};
% load up the optthreshXstatXclass:
load("\\sosiknas1\Lab_data\dylan_working\cnn_score_data_byClass\opt_threshXstatisticXclass.mat")
for yr = year_range(1):year_range(end)
    ystr = ['D' num2str(yr)];
    classpath = [classpath_generic filesep ystr filesep];
    feapath = [feapath_generic ystr filesep];
    %temp = dir([classpath 'D' num2str(yr) '*.h5']);
    temp = dir([classpath ystr '*']);
    temp = {temp([temp.isdir]).name};
    pathall = []; pathall2 = [];
    names = {};
    if mvco_flag
       feapath_base = regexprep(feapath_generic, 'xxxx', num2str(yr));
    end
    for ii = 1:length(temp)
        pathnow = [classpath temp{ii} filesep];
        pathnow2 = [feapath temp{ii} filesep];
        temp2 = dir([pathnow '*.h5']);
        pathall = [pathall; repmat(pathnow, length(temp2),1)];
        pathall2 = [pathall2; repmat(pathnow2, length(temp2),1)];
        names = [names; {temp2.name}'];
    end
    
    classfiles = strcat(pathall, names);
   % pathall = strcat(feapath_generic, names(:,1:5), filesep, names(:,1:9), filesep);
    if ~mvco_flag
        feafiles = strcat(pathall2, regexprep(names, '_class.h5', '_fea_v4.csv'));
        %xall = repmat('_fea_v4.csv', length(names),1);
        %ii = strmatch('D', names);
        %feafiles(ii) = strcat(pathall(ii,:), regexprep(names(ii), '_class.h5', '_fea_v4.csv'));
        %ii = strmatch('I', names);
        %feafiles(ii) = cellstr([pathall(ii,:) names(ii,1:21) xall(ii,:)]);        
        clear temp* pathall* classpath xall 
    else
       % xall = repmat('_fea_v4.csv', length(names),1);
        ii = strmatch('D', names);
        names_temp = char(names{ii});
        if ~isempty(ii)
%            feafiles(ii) = cellstr( strcat(feapath_base, names_temp(:,1:24), xall(ii,:)));
             feafiles(ii) = cellstr( strcat(feapath_generic, ystr, filesep, names_temp(:,1:9),filesep, char(regexprep(names(ii),'class.h5', 'fea_v4.csv'))));
        end
        ii = strmatch('I', names);
        names_temp = char(names{ii});
        if ~isempty(ii)
            %feafiles(ii) = cellstr( strcat(feapath_base, names_temp(:,1:21), xall(ii,:)));      
            feafiles(ii) = cellstr( strcat(feapath_generic, ystr, filesep, names_temp(:,1:14),filesep, char(regexprep(names(ii),'class.h5', 'fea_v4.csv'))));
        end
        clear temp* pathall classpath xall 
    end
    
    %%%%CHECK
    %temp = char(classfiles);
    %ind = length(classpath_generic)+18;
    %filelist = cellstr(temp(:,ind:ind+23));
    %clear temp

    filelist = regexprep(cellstr(names), '_class.h5', '');
    clear names
    
    [~,a,b] = intersect(filelist, metaT.pid);
    clear meta_data, meta_data(a,:) = metaT(b,:); 
    ind = find(meta_data.ifcb ==0);
    meta_data(ind,:) = []; %omit any files not in dashboard table
    mdate = datenum(meta_data.sample_time, 'yyyy-mm-dd HH:MM:ss+00:00');
    meta_data.matdate = mdate;
    meta_data.datetime = datetime(mdate, 'convertfrom', 'datenum');
    [~,ind] = setdiff(filelist,meta_data.pid);
    classfiles(ind) = [];
    filelist(ind) = [];
    feafiles(ind) = []; 
    
    classTable = load_class_scores(classfiles{1});
    class2use = deblank(classTable.class_labels); 
%     optthresh = optXstatXclass("prec-rec", :);

%     dylans addition Sep 2022 - class opt thresh:
%     this allows to use different statistics for different classes
    optthresh = nan(1, length(class2use)); % start with ones to make classes that aren't specified explicitly useless
    for i = 1:size(class2use, 1)

        cc = class2use{i}; % class name
    
        if any(ismember(classXstat, cc), "all")
            % grab opt thresh specified in classXstat
            ss = classXstat{ismember(classXstat(:,1),cc),2}; % statistic
            oo = optXstatXclass(ss , cc); % opt thresh value
            optthresh(i) = table2array(oo);
        elseif ~any(ismember(optXstatXclass.Properties.VariableNames, cc))
            % validation not available for this class. opt thresh = 1
            optthresh(i) = nan;
        else
            % grab opt thresh for prec-rec
            oo = optXstatXclass("prec-rec", cc);
            optthresh(i) = table2array(oo);

            classXstat = cat(1, classXstat, {cc, 'prec-rec'});
        end

    end

    classcount = NaN(length(classfiles),length(class2use));
    classbiovol = classcount;
    classC = classcount;
    classcount_above_optthresh = classcount;
    classbiovol_above_optthresh = classcount;
    classC_above_optthresh = classcount;
    classcount_above_adhocthresh = classcount;
    classbiovol_above_adhocthresh = classcount;
    classC_above_adhocthresh = classcount;
    num2dostr = num2str(length(classfiles));
    classFeaList = cell(size(classcount));
    if ~pidlist_flag
        classPidList = cell(size(classcount));
    end
    classFeaList_variables = {'ESD' 'maxFeretDiameter' 'summedMajorAxis' 'representativeWidth' 'summedArea' 'summedSurfaceArea' 'summedBiovolume' 'cellC'  'numBlobs' 'pmtA' 'pmtB' 'pmtC' 'pmtD' 'peakA' 'peakB' 'peakC' 'peakD' 'TimeOfFlight' 'roi_numbers' 'score'};
    groupFeaList_variables = {'ESD' 'maxFeretDiameter' 'summedMajorAxis' 'representativeWidth' 'summedArea' 'summedSurfaceArea' 'summedBiovolume' 'cellC'  'numBlobs' 'pmtA' 'pmtB' 'pmtC' 'pmtD' 'peakA' 'peakB' 'peakC' 'peakD' 'TimeOfFlight' 'roi_numbers' 'score_prim', 'score_sec'};
    % repeat for groups:
%     groupcount = NaN(length(classfiles),length(group2use_in)+1); % +1 for an "other" catch-all group
    groupcount = NaN(length(classfiles),length(group2use_in)); % NO +1 for an "other" catch-all group
    groupbiovol = groupcount;
    groupC = groupcount;
    groupcount_above_optthresh = groupcount;
    groupbiovol_above_optthresh = groupcount;
    groupC_above_optthresh = groupcount;
    groupcount_above_adhocthresh = groupcount;
    groupbiovol_above_adhocthresh = groupcount;
    groupC_above_adhocthresh = groupcount;
    num2dostr = num2str(length(classfiles));
    groupFeaList = cell(size(groupcount));
    if ~pidlist_flag
        groupPidList = cell(size(groupcount));
    end
    %%
    for filecount = 1:length(classfiles)

        if ~rem(filecount,10), disp(['reading ' num2str(filecount) ' of ' num2dostr]), end
        if exist( feafiles{filecount}, 'file')
            if pidlist_flag
                [classcount(filecount,:), classbiovol(filecount,:), classC(filecount,:), classcount_above_optthresh(filecount,:), classbiovol_above_optthresh(filecount,:), classC_above_optthresh(filecount,:), classcount_above_adhocthresh(filecount,:), classbiovol_above_adhocthresh(filecount,:), classC_above_adhocthresh(filecount,:), class2use, classFeaList(filecount,:), classPidList(filecount,:)] = summarize_biovol_class_h5(classfiles{filecount}, feafiles{filecount}, adhocthresh, optthresh, pidlist_flag);
                % group data:
%                 [groupcount(filecount,:), groupbiovol(filecount,:), groupC(filecount,:), groupcount_above_optthresh(filecount,:), groupbiovol_above_optthresh(filecount,:), groupC_above_optthresh(filecount,:), groupcount_above_adhocthresh(filecount,:), groupbiovol_above_adhocthresh(filecount,:), groupC_above_adhocthresh(filecount,:), group2use, groupFeaList(filecount,:), groupPidList(filecount,:)] = summarize_biovol_classGroup_h5(classfiles{filecount}, feafiles{filecount}, adhocthresh, optthresh_group, pidlist_flag, group_tab);
                [groupcount(filecount,:), groupbiovol(filecount,:), groupC(filecount,:), groupcount_above_optthresh(filecount,:), groupbiovol_above_optthresh(filecount,:), groupC_above_optthresh(filecount,:), groupcount_above_adhocthresh(filecount,:), groupbiovol_above_adhocthresh(filecount,:), groupC_above_adhocthresh(filecount,:), group2use, groupFeaList(filecount,:), groupPidList(filecount,:)] = summarize_biovol_classGroup_h5_hierarchy(classfiles{filecount}, feafiles{filecount}, adhocthresh, optthresh_group, pidlist_flag, group_tab, groupXgroup);
            else
                [classcount(filecount,:), classbiovol(filecount,:), classC(filecount,:), classcount_above_optthresh(filecount,:), classbiovol_above_optthresh(filecount,:), classC_above_optthresh(filecount,:), classcount_above_adhocthresh(filecount,:), classbiovol_above_adhocthresh(filecount,:), classC_above_adhocthresh(filecount,:), class2use, classFeaList(filecount,:), classPidList] = summarize_biovol_class_h5(classfiles{filecount}, feafiles{filecount}, adhocthresh, optthresh, pidlist_flag);
                % group data:
%                 [groupcount(filecount,:), groupbiovol(filecount,:), groupC(filecount,:), groupcount_above_optthresh(filecount,:), groupbiovol_above_optthresh(filecount,:), groupC_above_optthresh(filecount,:), groupcount_above_adhocthresh(filecount,:), groupbiovol_above_adhocthresh(filecount,:), groupC_above_adhocthresh(filecount,:), group2use, groupFeaList(filecount,:), groupPidList] = summarize_biovol_classGroup_h5(classfiles{filecount}, feafiles{filecount}, adhocthresh, optthresh_group, pidlist_flag, group_tab);
                [groupcount(filecount,:), groupbiovol(filecount,:), groupC(filecount,:), groupcount_above_optthresh(filecount,:), groupbiovol_above_optthresh(filecount,:), groupC_above_optthresh(filecount,:), groupcount_above_adhocthresh(filecount,:), groupbiovol_above_adhocthresh(filecount,:), groupC_above_adhocthresh(filecount,:), group2use, groupFeaList(filecount,:), groupPidList] = summarize_biovol_classGroup_h5_hierarchy(classfiles{filecount}, feafiles{filecount}, adhocthresh, optthresh_group, pidlist_flag, group_tab, groupXgroup);
            end
            %temp MVCO old features
         % %   [classcount(filecount,:), classbiovol(filecount,:), classC(filecount,:), classcount_above_optthresh(filecount,:), classbiovol_above_optthresh(filecount,:), classC_above_optthresh(filecount,:), classcount_above_adhocthresh(filecount,:), classbiovol_above_adhocthresh(filecount,:), classC_above_adhocthresh(filecount,:), class2useTB, classFeaList(filecount,:), classPidList(filecount,:)] = summarize_biovol_class_h5_mvco_temp(classfiles{filecount}, feafiles{filecount}, adhocthresh);
         % %skip classPidList, classFeaList
          %  [classcount(filecount,:), classbiovol(filecount,:), classC(filecount,:), classcount_above_optthresh(filecount,:), classbiovol_above_optthresh(filecount,:), classC_above_optthresh(filecount,:), classcount_above_adhocthresh(filecount,:), classbiovol_above_adhocthresh(filecount,:), classC_above_adhocthresh(filecount,:), class2useTB, classFeaList(filecount,:), classPidList(filecount,:)] = summarize_biovol_class_h5_mvco_temp(classfiles{filecount}, feafiles{filecount}, adhocthresh);
        else
            disp(['skipping, no feature file: ' feafiles{filecount}])
        end                
    end
    %%
    if ~exist(resultpath, 'dir')
        mkdir(resultpath)
    end

    nind = find(isnan(optthresh));
    classcount_above_optthresh(:,nind) = NaN;
    classbiovol_above_optthresh(:,nind) = NaN;
    classC_above_optthresh(:,nind) = NaN;
            
    %format as labeled tables
    tempStr = {'classcount' 'classbiovol' 'classC' 'classcount_above_optthresh' 'classbiovol_above_optthresh'...
        'classC_above_optthresh' 'classcount_above_adhocthresh' 'classbiovol_above_adhocthresh' 'classC_above_adhocthresh'};
    for ii = 1:length(tempStr)
        T = cat(2, meta_data(:, "pid"), array2table(eval(tempStr{ii}), 'VariableNames', class2use)); 
        eval([tempStr{ii} '= T;'])
    end
    tempStr = {'groupcount' 'groupbiovol' 'groupC' 'groupcount_above_optthresh' 'groupbiovol_above_optthresh'...
        'groupC_above_optthresh' 'groupcount_above_adhocthresh' 'groupbiovol_above_adhocthresh' 'groupC_above_adhocthresh'};
    for ii = 1:length(tempStr)
        T = cat(2, meta_data(:, "pid"), array2table(eval(tempStr{ii}), 'VariableNames', group2use));
        eval([tempStr{ii} '= T;'])
    end
    optthresh = array2table(optthresh,'VariableNames', class2use);
    clear T ii
    classFeaList = array2table(classFeaList, 'VariableNames', class2use);
    groupFeaList = array2table(groupFeaList, 'VariableNames', group2use);

    val_stats = get_val_stat_tables('\\sosiknas1\Lab_data\dylan_working\cnn_score_data_byClass\',...
        class2use, group2use, table2array(optthresh), table2array(optthresh_group));
    %save([resultpath 'summary_biovol_allTB' num2str(yr)] , 'class2useTB', 'classcountTB', 'classbiovolTB', 'ml_analyzedTB', 'mdateTB', 'filelistTB', 'classpath_generic', 'feapath_generic')
    %save([resultpath 'summary_biovol_allHDF_min20_' num2str(yr)] , 'class2use', 'classcount*', 'classbiovol*', 'classC*', 'ml_analyzed', 'mdate', 'filelist', 'classpath_generic', 'feapath_generic')
    save([resultpath 'summary_biovol_allHDF_min20_' num2str(yr)] , 'class2use', 'classcount*', 'classbiovol*', 'classC*', 'meta_data', 'mdate', 'filelist', 'classpath_generic', 'feapath_generic', 'adhocthresh', 'classXstat', 'optthresh', ...
        'group2use', 'groupcount*', 'groupbiovol*', 'groupC*', 'meta_data', 'mdate', 'filelist', 'groupXstat', 'optthresh_group', 'val_stats')
    save([resultpath 'summary_biovol_allHDF_min20_' num2str(yr) 'lists'] , 'class2use', 'filelist', 'classpath_generic', 'feapath_generic', 'classFeaList*', '-v7.3')
    save([resultpath 'summary_biovol_allHDF_min20_' num2str(yr) 'lists_group'] , 'group2use', 'filelist', 'classpath_generic', 'feapath_generic', 'groupFeaList*', '-v7.3') 
    disp('results saved: ')
    disp([resultpath 'summary_biovol_allHDF_min20_' num2str(yr)])
    disp([resultpath 'summary_biovol_allHDF_min20_' num2str(yr) 'lists'])
    disp([resultpath 'summary_biovol_allHDF_min20_' num2str(yr) 'lists_group'])
    if pidlist_flag 
        save([resultpath 'summary_biovol_allHDF_min20_' num2str(yr) 'list_pid'] , 'class2use', 'filelist', 'classpath_generic', 'feapath_generic', 'classPidList', '-v7.3')
        disp([resultpath 'summary_biovol_allHDF_min20_' num2str(yr) 'lists_pid'])
    end
    
    clear *files* classcount* classbiovol* classC* meta_data mdate class*List ...
        groupcount* groupbiovol* groupC* group*List
end
clear summarize_biovol_class_h5 summarize_biovol_classGroup_h5 %clear the summarize function to clear the persistent variables
end 