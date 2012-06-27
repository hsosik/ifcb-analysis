resultpath = '\\raspberry\d_work\IFCB1\ifcb_data_mvco_jun06\Manual_fromClass\';
filelist = get_filelist_manual([resultpath 'manual_list'],2,[2006:2012], 'all'); %manual_list, column to use, year to find
feafilestr = '_fea_v1';
[ filelist, feafiles ] = resolve_MVCOfeafiles( filelist, feafilestr );
classifierName = 'MVCO_trees_25Jun2012';

header = textread(feafiles{1}, '%s',235, 'delimiter', ',');
[~,feaorder] = setdiff(header, {'FilledArea' 'summedFilledArea' 'Area' 'ConvexArea' 'MajorAxisLength' 'MinorAxisLength' 'Perimeter', 'roi_number'});
featitles_file = header(feaorder);
if true, %isequal(featitles, featitles_file), 
    num2dostr = num2str(length(filelist))
    tic
    for filecount = 1:length(filelist),
        disp(['classifying ' num2str(filecount) ' of ' num2dostr])
        apply_TBclassifierMVCO(feafiles{filecount}, feaorder, classifierName);
    end;
    toc
else, 
    disp('Classification incomplete - feature titles do not match with classifier.')
end;
