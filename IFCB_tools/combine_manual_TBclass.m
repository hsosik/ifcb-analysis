%combine_manual_TBclass.m
%case for TAMUG manual annotation files that were done partially in raw_roi
%mode and with subsequent need to complete in correct_or_subdivide mode
%merge in results from classifier output to pre-existing manual files

manual_path = 'C:\work\TAMUG\manual\';
class_path = 'C:\work\TAMUG\class\';

filelist = dir([manual_path '*.mat']);
filelist = {filelist.name};
auto_col = 3;

for count = 1:length(filelist),
    [~,filename] = fileparts(filelist{count});
    m = load([manual_path filename]);
    classnum_default = strmatch('other', m.class2use_manual);
    classlist = m.classlist;
    yr = filename(2:5);
    t = load([class_path yr filesep filename '_class_v1']);
    [~,ia] = ismember(t.TBclass_above_threshold, m.class2use_manual);
    classlist(t.roinum,auto_col)  = ia;
    classlist(classlist(:,auto_col) == 0,auto_col) = classnum_default;
    classlist(classlist(:,2) == classnum_default,2) = NaN;
    save([manual_path filename], 'classlist', '-append')
end;