% file for messing around and testing stuff. - Joe Futrelle 9/2011

function [output] = batch_add_features_train( )

config = configure();

%urlbase = 'http://demi.whoi.edu/';
%trainpath = '\\raspberry\d_work\IFCB1\ifcb_data_mvco_jun06\train_04Nov2011\';
%classlist = dir(trainpath);
%classlist = cellstr(char(classlist(cat(1,classlist.isdir)).name));
%classlist = setdiff(classlist, {'.', '..'});

%target.config = config;
%output.config = config;
empty_target.config = config;

load output
classlist = setdiff(fields(output), 'config');

for cix = 1:length(classlist),
    clear temp
    disp(classlist(cix))
    %roilist = dir([trainpath char(classlist(cix)) '\IFCB*']);
    %temp.targets = cellstr(char(roilist.name));
    class = char(classlist(cix));
    temp = output.(class);
    if isfield(temp, 'features'),
        temp = rmfield(temp, 'features');
        %end;
        for iix = 1:length(output.(class).targets),
            if rem(iix,10) == 0, disp(iix), end;
            %target = empty_target;
            %tname = roilist(iix).name; tname = tname(1:end-4); %get_image expects no extension
            %target.image = get_image([urlbase tname]);
            target.image = output.(class).images(iix).image;
            %target.blob_image = output.(class).images(iix).blob_image;
            %target.blob_image_rotated = output.(class).images(iix).blob_image_rotated;
            target.blob_props = output.(class).features(iix);
            target.config = empty_target.config;
            %target = blob(target);
            %target = blob_geomprop(target);
            %target = blob_texture(target);
            %target = blob_invmoments(target);
            %target = blob_shapehist_stats(target);
            %target = blob_RingWedge(target);
            %target = blob_sumprops(target);
            target = image_HOG(target);
            %target = blob_rotated_geomprop(target);
            temp.features(iix) = merge_structs(target.blob_props, target.image_props);
            %temp.images(iix).blob_image = target.blob_image;
            %temp.images(iix).image = target.image;
        end;
    end;
    eval(['output.' char(classlist(cix)) ' = temp;'])
    save output2 output
end;

%feamat = struct2cell(output.features);
%feamat = cell2mat(squeeze(feamat)');
%featitles = fieldnames(output.features)';