function [ filelist ] = get_filelist_manual( filename, colnum, year2get)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
load(filename)
%ind = find(cell2mat(manual_list(2:end,colnum)));
temp = char(manual_list(2:end,1));
yrtemp = str2num(temp(:,7:10));
%ind = find(cell2mat(manual_list(2:end,colnum)) & ~(str2num(temp(:,16:17)) == 0) & ismember(yrtemp,year2get));
ind = find(cell2mat(manual_list(2:end,colnum)) & ismember(yrtemp,year2get));
filelist = cell2struct(manual_list(ind+1,1),{'name'},2);
end

