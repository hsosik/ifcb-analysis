function [ config ] = config_classifier( classifierName )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

disp('loading classifier...')
load(classifierName)
config.class2useTB = [b.ClassNames; 'unclassified'];
config.TBclassifier = b; 
config.maxthre = maxthre;
config.featitles = featitles;
config.classifierName = classifierName;
end
    

