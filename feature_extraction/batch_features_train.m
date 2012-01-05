function [output] = batch_features_train( )

config = configure();

urlbase = 'http://ifcb-data.whoi.edu/mvco/';
trainpath = '\\queenrose\ifcb_data_mvco_jun06\train_04Nov2011_fromWebServices\';

classlist = dir(trainpath);
classlist = cellstr(char(classlist(cat(1,classlist.isdir)).name));
classlist = setdiff(classlist, {'.', '..'});

target.config = config;
output.config = config;
empty_target = target;

%load output2

for cix = 1:length(classlist),
    clear temp
    disp(classlist(cix))
    roilist = dir([trainpath char(classlist(cix)) '\IFCB*']);
    %roinames = {};
    %for idx = 1:length(roilist), %reformat with zero padding on roi num to 5 digits
    %    t = char(roilist(idx).name);
    %    roinames(idx,1) = cellstr([t(1:22) repmat('0',1,31-length(t)) t(23:end)]);
    %end;
    roinames = {roilist.name};
    %temp.targets = cellstr(char(roilist.name));
    temp.targets = roinames; 
    for iix = 1:length(roilist), %min([3 length(roilist)]),
        if rem(iix,10) == 0, disp(iix), end;
        target = empty_target;
        tname = roilist(iix).name; tname = tname(1:end-4); %get_image expects no extension
        %target.image = get_image([urlbase tname]);
        target.image = imread([trainpath char(classlist(cix)) '\' tname '.png']);
        target = blob(target);
        target = blob_rotate(target);
        target = blob_geomprop(target); 
        target = blob_texture(target);
        target = blob_invmoments(target);
        target = blob_shapehist_stats(target);
        target = blob_RingWedge(target);
        target = blob_sumprops(target);
        target = blob_Hausdorff_symmetry(target);
        target = image_HOG(target);
        target = blob_rotated_geomprop(target);
        temp.features(iix) = merge_structs(target.blob_props, target.image_props);
        temp.images(iix).blob_image = target.blob_image;
        temp.images(iix).blob_image_rotated = target.blob_image_rotated;
        temp.images(iix).image = target.image;
    end;
    %eval(['output.' char(classlist(cix)) ' = temp;'])
    %save output2 output
    out = temp;
    save([trainpath char(classlist(cix))], 'out', 'output')
end;

%feamat = struct2cell(output.features);
%feamat = cell2mat(squeeze(feamat)');
%featitles = fieldnames(output.features)';

%f = fields(output);
%for c = 1:length(f),
%    disp(f{c})
%    out = output.(f{c});
%    save(f{c}, 'out')
%end;
    