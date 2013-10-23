function [filelist, classfiles] = resolve_files(filelist, basepath, classpath, class_filestr);
%function [filelist, classfiles] = resolve_files(filelist, basepath, classpath, class_filestr);
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

if isstruct(filelist),
    filelist = {filelist.name}';
    [~, ~, ext] = fileparts(filelist{1});
    filelist = regexprep(filelist, ext, ''); %strip off extension
end;

matdate = IFCB_file2date(filelist);
[year,~,~] = datevec(matdate);
files = char(filelist);
sep = repmat(filesep,length(year),1);
base = repmat(char(basepath), length(year),1);
%if files(1,1) == 'D',
%    basepath = [base files(:,1:5) sep files(:,1:9) sep];
%elseif files(1,1:5) == 'IFCB8'
    basepath = base;
%else      
%    basepath = [base files(:,1:14) sep];
%end;
filelist = cellstr([basepath files]);
classfiles = {};
%if exist('classpath', 'var')
if ~isempty(classpath),   
    ii = findstr(classpath(1,:), 'xxxx');
    classpath = repmat(classpath, length(year),1);
    if ~isempty(ii),
        classpath(:,ii:ii+3) = num2str(year);
    end;
    classfiles = cellstr([classpath files repmat(class_filestr, length(year),1) repmat('.mat', length(year),1)]);
end;

end

