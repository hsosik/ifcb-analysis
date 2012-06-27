function [ filelist, classfiles ] = resolve_MVCOclassfiles( filelist, classfilestr );
%function [ filelist, feafilelist ] = resolve_MVCOfeafiles( filelist, feafilestr )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

if isstruct(filelist),
    filelist = {filelist.name}';
    [~, ~, ext] = fileparts(filelist{1});
    filelist = regexprep(filelist, ext, ''); %strip off extension
end;
files = char(filelist);

classpath = '\\queenrose\g_work_ifcb1\ifcb_data_mvco_jun06\classxxxx_v1\';
matdate = IFCB_file2date(filelist);
[year,~,~] = datevec(matdate);
ii = findstr(classpath, 'xxxx');
classpath = repmat(classpath, length(year),1);
classpath(:,ii:ii+3) = num2str(year);

classfiles = cellstr([classpath files repmat(classfilestr, length(year),1) repmat('.mat', length(year),1)]);

end

