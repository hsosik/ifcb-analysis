function [ filelist ] = get_filelist_manual(filename, colnum, year2get, caseflag)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
load(filename)
%ind = find(cell2mat(manual_list(2:end,colnum)));
temp = char(manual_list(2:end,1));
yrtemp = str2num(temp(:,7:10));
%ind = find(cell2mat(manual_list(2:end,colnum)) & ~(str2num(temp(:,16:17)) == 0) & ismember(yrtemp,year2get));
if strcmp(caseflag, 'all'), %include all rows with colnum marked
    ind = find(cell2mat(manual_list(2:end,colnum)) & ismember(yrtemp,year2get));
elseif strcmp(caseflag, 'only'), %include rows with ONLY colnum marked
    marksum = sum(cell2mat(manual_list(2:end,2:end-1)),2);
    ind = find(cell2mat(manual_list(2:end,colnum)) & ismember(yrtemp,year2get) & marksum == 1);
else
    disp('invalid case flag in get_filelist_manual')
end;
filelist = cell2struct(manual_list(ind+1,1),{'name'},2);
end

