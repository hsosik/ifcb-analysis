function [ id ] = gen_id ( )
% returns a random string

alpha=['a':'z' 'A':'Z' '0':'9' '_'];
id = char(alpha(randi(numel(alpha), [1, 40])));



