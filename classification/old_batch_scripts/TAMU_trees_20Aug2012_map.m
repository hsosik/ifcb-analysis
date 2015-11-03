function [ classlist_out ] = TAMU_trees_20Aug2012_map( classlist_in, class2useTB )
%   function [ classlist_out ] = TAMU_trees_20Aug2012_map( classlist_in, class2useTB )
%   Function to remap manual classes to match those from the specific classifier TAMU_trees_20Aug2012 
%   Input: classlist as strings from manual annotation, 
%           class2useTB from application of classifier (fixed when TAMU_trees_20Aug2012 was created)
%   Output: Remapped classlist as strings
%   Heidi M. Sosik, Woods Hole Oceanographic Institution, March 2013

%   modify remap_set to adapt this function for other classifiers

unclassified_set = setdiff(class2useTB, unique(classlist_in)); 
remap_set = struct('in_class', {{'Amphidinium' 'Cochlodinium'}, {'dino10' 'dino30' 'Gyrodinium' 'Oxyphysis' 'Oxytoxum' 'Scrippsiella'}, {'cryptophyte' 'Euglena' 'flagellate'}}, 'out_class', {'Warnowia', 'Dino_MIX', 'flagellate_MIX'});
unclassified_set = setdiff(unique(classlist_in), class2useTB); 
unclassified_set = setdiff(unclassified_set, [remap_set.in_class]);
remap_set(end+1).in_class = unclassified_set;
remap_set(end).out_class = 'unclassified';

classlist_out = classlist_in;
for ii = 1:length(remap_set)
    a = find(ismember(classlist_in, remap_set(ii).in_class));
    if ~isempty(a),
        classlist_out(a) = {remap_set(ii).out_class};
    end;
end;

end

