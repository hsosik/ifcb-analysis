function [ filelist ] = get_filelist( in_url, start_day, end_day )
%function [ filelist ] = get_filelist( in_url, start_day, end_day) )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

filelist = [];
start_day = datenum(start_day);
end_day = datenum(end_day);
for daycount = start_day:end_day,
    filelist = [filelist list_day(datestr(daycount,29), in_url)];
end
if length(filelist) > 0,
    [p,~] = fileparts(filelist{1});
    filelist = regexprep(filelist,[p '/'], '')';
end;
end
