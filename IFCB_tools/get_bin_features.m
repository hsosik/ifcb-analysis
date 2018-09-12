function [ target ] = get_bin_features( feafilename, fea2get)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

%    [~,file] = fileparts(filename);
    feastruct = importdata(feafilename, ',');
    for ii = 1:length(fea2get)
        ind = strmatch(fea2get{ii}, feastruct.colheaders);
        target.(fea2get{ii}) = feastruct.data(:,ind);
    end 
    ind = strmatch('roi_number', feastruct.colheaders);
    tind = feastruct.data(:,ind);
    [~,f] = fileparts(feafilename);
    f = regexprep(f,'_fea_v2', ' ');
    target.pid = cellstr(strcat(f,'_', num2str(tind, '%05.0f')));
end

