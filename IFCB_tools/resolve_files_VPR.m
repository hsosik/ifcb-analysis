function [filelist, classfiles] = resolve_files(filelist, basepath, classpath, class_filestr);
%function [filelist, classfiles] = resolve_files(filelist, basepath, classpath, class_filestr);
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

if isstruct(filelist),
    filelist = {filelist.name}';
    [~, ~, ext] = fileparts(filelist{1});
    filelist = regexprep(filelist, ext, ''); %strip off extension
end;

files = char(filelist);
sep = repmat(filesep,length(filelist),1);
base = repmat(char(basepath), length(filelist),1);
basepath = [base files(:,1:4) sep files(:,5:7) sep];
filelist = cellstr([basepath ]);

classfiles = {};
if ~isempty(classpath),   
    classpath = repmat(classpath, length(filelist),1);
    classfiles = cellstr([classpath files repmat(class_filestr, length(filelist),1) repmat('.mat', length(filelist),1)]);
end;

end

