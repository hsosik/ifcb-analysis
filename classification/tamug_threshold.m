function [ adhocthresh ] = tamug_threshold( class2use )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

adhocthresh = zeros(size(class2use)); %initially assign all classes the same adhoc decision threshold set to 0
adhocthresh(strmatch('Ditylum', class2use, 'exact')) = 0.2; %reassign value for specific class
adhocthresh(strmatch('Rhizosolenia', class2use, 'exact')) = 0.0;
adhocthresh(strmatch('Flagellate_MIX', class2use, 'exact')) = 0.6;
end

