function [ classlist_out ] = example_class_map( classlist_in)
%   function [ classlist_out ] = example_class_map( classlist_in, class2useTB )
%   Template function to remap manual classes (i.e., change string labels, change order, merge classes) 
%   Input: classlist as strings from manual annotation 
%   Output: Remapped classlist as strings
%   Heidi M. Sosik, Woods Hole Oceanographic Institution, March 2013

%   This is a template
%   modify remap_set to adapt this function for specific cases, then save a
%   new versopm with USER's choice of function name

%only one out_class string for each case, but multiple OK for in_class to merge
remap_set = struct('in_class', {{'classstr1' 'classstr2'}, {'classstr3'}, {'classstr4'}},...
    'out_class', {'classstr1_2', 'classstr3a', 'classstr3b'});

%initialize same as input
classlist_out = classlist_in;
%revise according to remap_set
for ii = 1:length(remap_set)
    a = find(ismember(classlist_in, remap_set(ii).in_class));
    if ~isempty(a),
        classlist_out(a) = {remap_set(ii).out_class};
    end;
end;

end

