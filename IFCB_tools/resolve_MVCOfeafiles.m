function [ filelist, feafiles ] = resolve_MVCOfeafiles( filelist, feafilestr );
%function [ filelist, feafilelist ] = resolve_MVCOfeafiles( filelist, feafilestr )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

if isstruct(filelist),
    filelist = {filelist.name}';
    [~, ~, ext] = fileparts(filelist{1});
    filelist = regexprep(filelist, ext, ''); %strip off extension
end;
files = char(filelist);

feapath = '\\queenrose\g_work_ifcb1\ifcb_data_mvco_jun06\featuresxxxx_v1\';
matdate = IFCB_file2date(filelist);
[year,~,~] = datevec(matdate);
ii = findstr(feapath, 'xxxx');
feapath = repmat(feapath, length(year),1);
feapath(:,ii:ii+3) = num2str(year);

feafiles = cellstr([feapath files repmat(feafilestr, length(year),1) repmat('.csv', length(year),1)]);

end

