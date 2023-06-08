url_set = {...
    'https://ifcb-data.whoi.edu/SIO_Delmar_mooring'...
    'https://ifcb.caloos.org/del-mar-mooring'...
    'https://ifcb.caloos.org/newport-beach-pier'...
    'https://ifcb.caloos.org/scripps-pier-ifcb-183'...
    };
maxn = 1500;
tag2exclude = {'external detritus' 'blurry' 'uncertain' 'theca fragment' 'gamete'};

%%
for count = 2:2 %3:length(url_set)
    temp = split(url_set{count}, '/');
    outdir_base = ['\\sosiknas1\training_sets\IFCB\TRAIN-DATA\Cal_May2023\' temp{end} filesep];
    url_base = url_set{count};
    tag_roi_table = tag_roi_list_one_timeseries(url_base);
    tag_roi_table.class_tag_label = strcat(tag_roi_table.classlabel, '_TAG_', tag_roi_table.taglabel);
    ii = find(ismember(tag_roi_table.taglabel, tag2exclude));
    tag_roi_table(ii,:) = [];
    if length(unique(tag_roi_table.roi)) < size(tag_roi_table,1)
        %case for multiple tags, same ROI
        keyboard
        unique(tag_roi_table.taglabel)
    end
    class_roi_table = class_roi_list_one_timeseries(url_base);
    [ia,ib] = ismember(tag_roi_table.roi, class_roi_table.roi);
    class_roi_table.classnameTAG = class_roi_table.classname;
    class_roi_table.classnameTAG(ib) = tag_roi_table.class_tag_label(ia);
    class_set = unique(class_roi_table.classnameTAG);
%
%FUDGE for now: Get rid of 'WHAT?'
class_roi_table.classnameTAG = regexprep(class_roi_table.classnameTAG, '?', '');
class_set = regexprep(class_set, '?', '');
    for ii = 1:length(class_set)
        outdir = [outdir_base class_set{ii} filesep];
        disp(outdir)
        if ~exist(outdir)
            mkdir(outdir)
        end
        ind = find(strcmp(class_roi_table.classnameTAG, class_set{ii}));
        if length(ind) > maxn
            r = randperm(length(ind));
            ind = ind(r(1:maxn));
        end
        for iii = 1:length(ind)
            pf = [class_roi_table.roi{ind(iii)} '.png'];
            outf = websave([outdir pf],[url_base '/' pf]);
        end
    end
end
