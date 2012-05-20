function [] = batch_features_train(trainpath,maxn_perclass,urlbase)
%function [] = batch_features_train(trainpath,maxn_perclass,urlbase)
%trainpath is location of example pngs organized in subdirectories by class
%maxn is maximum number to randomly draw from examples in each class
%urlbase is webservice location, if urlbase is not passed in pngs are loaded from trainpath
%urlbase = 'http://ifcb-data.whoi.edu/saltpond/';
%trainpath = '\\mellon\saltpond\manual_fromWeb\';

config = configure();

webflag = 0; %read pngs from local path
if exist('urlbase', 'var'), webflag = 1; end; %otherwise get via webservices

classlist = dir(trainpath);
classlist = cellstr(char(classlist(cat(1,classlist.isdir)).name));
classlist = setdiff(classlist, {'.', '..'});

target.config = config;
output.config = config;
empty_target = target;

for cix = 1:length(classlist),
    clear temp
    disp(classlist(cix))
    roilist = dir([trainpath char(classlist(cix)) '\*.png']);
    if length(roilist) > maxn_perclass,
        roilist = roilist(randi(length(roilist),1000));
    end;
    roinames = {roilist.name};
    temp.targets = roinames; 
    for iix = 1:length(roilist), %min([3 length(roilist)]),
        if rem(iix,10) == 0, disp(iix), end;
        target = empty_target;
        tname = roilist(iix).name; tname = tname(1:end-4); %get_image expects no extension
        if webflag,
            target.image = get_image([urlbase tname]);
            target.blob_image = get_image([urlbase tname '_blob']);
        else
            target.image = imread([trainpath char(classlist(cix)) '\' tname '.png']);
            target = blob(target);
        end;
        %FIX!!! only need for numblobs??
        target = apply_blob_min( target ); %get rid of blobs < blob_min
        
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
    out = temp;
    save([trainpath char(classlist(cix))], 'out', 'output')
end;

    