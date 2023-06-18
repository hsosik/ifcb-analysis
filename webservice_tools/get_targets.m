function [ targets ] = get_targets( bin_pid )
% given the URL of a bin, return a list of structures representing the
% targets in that bin.

url = [char(bin_pid) '.csv'];
[content, ~] = urlread(url);

targets = csv2targets(content);

end

