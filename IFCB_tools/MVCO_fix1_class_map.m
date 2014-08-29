function [ classlist_out ] = MVCO_fix1_class_map( classlist_in)
%   function [ classlist_out ] = MVCO_fix1_class_map( classlist_in, class2useTB )
%   Template function to remap manual classes (i.e., change string labels, change order, merge classes) 
%   Input: classlist as strings from manual annotation 
%   Output: Remapped classlist as strings
%   Heidi M. Sosik, Woods Hole Oceanographic Institution, March 2013

%   Relabel a few categories in MVCO class2use (going from class2use_MVCOmanual3 to class2use_MVCOmanual4)

%only one out_class string for each case, but multiple OK for in_class to merge
remap_set = struct('in_class', {{'Eucampia_groenlandica'}, {'Guinardia'}, {'ciliate'}},...
    'out_class', {'Cerataulina', 'Guinardia_delicatula', 'Ciliate_mix'});  %Ciliate_mix case ONLY for instances without subdivide info for ciliate

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

