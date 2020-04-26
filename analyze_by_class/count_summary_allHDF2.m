
resultpath = '\\sosiknas1\IFCB_products\EXPORTS\summary\';
%classpath_generic = '\\sosiknas1\IFCB_products\NESLTER_broadscale\class\classxxxx_v1\';
classpath_generic = '\\sosiknas1\IFCB_products\MVCO\train_May2019_jmf\RUN-RESULTS\RUN_EXPORTS__Jan10_8020_seeded_iv3_pt_nn_xyto_min20\';

adhocthresh = 0.5;

metaT =  webread('https://ifcb-data.whoi.edu/api/export_metadata/EXPORTS');

for yr = 2019:2019 %:2012,
    classpath = classpath_generic;
    temp = dir([classpath 'D' num2str(yr) '*.h5']);
    pathall = repmat(classpath, length(temp),1);
    names = char(temp.name);
    classfiles = cellstr([pathall names]);
%    pathall = strcat(feapath_generic, names(:,1:5), filesep, names(:,1:9), filesep);
%    xall = repmat('_fea_v4.csv', length(temp),1);
%    ii = strmatch('D', names);
%    feafiles(ii) = cellstr([pathall(ii,:) names(ii,1:24) xall(ii,:)]);
%    ii = strmatch('I', names);
%    feafiles(ii) = cellstr([pathall(ii,:) names(ii,1:21) xall(ii,:)]);
    clear temp pathall classpath xall

    temp = char(classfiles);
    ind = length(classpath_generic)+1;
    filelist = cellstr(temp(:,ind:ind+23));
    mdate = IFCB_file2date(filelist);
    
%    pathall = repmat(hdrpath, size(temp,1),1);
%    xall = repmat('.hdr', size(temp,1),1);
%    temp = cellstr([pathall temp(:,ind:inds+23) xall]);
%   ml_analyzed = IFCB_volume_analyzed(temp); 
%    ml_analyzed = NaN;
    
    [~, ~, ~, class2use] = load_class_scores(classfiles{1});
    class2use = deblank(class2use); 
    classcount = NaN(length(classfiles),length(class2use));
    num2dostr = num2str(length(classfiles));
    %
    for filecount = 1:length(classfiles)
        if ~rem(filecount,10), disp(['reading ' num2str(filecount) ' of ' num2dostr]), end
%        [classcount(filecount,:), classbiovol(filecount,:), classC(filecount,:), classcount_above_optthresh(filecount,:), classbiovol_above_optthresh(filecount,:), classC_above_optthresh(filecount,:), classcount_above_adhocthresh(filecount,:), classbiovol_above_adhocthresh(filecount,:), classC_above_adhocthresh(filecount,:), class2useTB] = summarize_biovol_classMVCO_h5(classfiles{filecount}, feafiles{filecount}, adhocthresh);
        [classcount(filecount,:), classcount_above_adhocthresh(filecount,:), pid_list{filecount}, score_list{filecount}, class_labels] = summarize_count_class_h5(classfiles{filecount}, adhocthresh);
    end
    
    if ~exist(resultpath, 'dir')
        mkdir(resultpath)
    end
    
    [~,a,b] = intersect(filelist, metaT.pid);
    meta_data(a,:) = metaT(b,:); 
    if length(a) ~= length(filelist) 
        disp('Looks like some metadata is missing?')
        c = setdiff(filelist, metaT.pid)
        %keyboard
    end
    save([resultpath 'summary_count_allHDF' num2str(yr)] , 'class2use', 'classcount*', 'meta_data', 'mdate', 'filelist', 'classpath_generic', 'pid_list', 'score_list', 'adhocthreshold')
    disp(['results saved: ' [resultpath 'summary_count_allHDF' num2str(yr)]])
    clear *file* classcount* pid_list score_list names temp mdate meta_data
end

return

t = load('\\sosiknas1\IFCB_products\NESLTER_transect\summary\summary_count_allHDF2017')

c = strmatch('Dinophysis_acuminata', t.class2use);
c = strmatch('Dinophysis_norvegica', t.class2use);
ii = find(t.classcount(:,c));
for count = 1:length(ii)
    a = t.pid_list{ii(count)}{c};
    b = t.score_list{ii(count)}{c};
    for count2 = 1:length(b)
        imshow(imread(['https://ifcb-data.whoi.edu/NESLTER_transect/' a(count2,:) '.png']))
        if b(count2) < 0.5
            title([a(count2) ' ' num2str(b(count2))], 'color', 'r')
        else
            title([a(count2) ' ' num2str(b(count2))])
        end
        pause
    end
end
