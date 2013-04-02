function [ classlist_out ] = ciliate_class_map( classlist_in)
%   function [ classlist_out ] = example_class_map( classlist_in, class2useTB )
%   Template of function to remap manual classes (i.e., change string labels, change order, merge classes) 
%   Input: classlist as strings from manual annotation 
%   Output: Remapped classlist as strings
%   Heidi M. Sosik, Woods Hole Oceanographic Institution, March 2013

%   This is a template
%   modify remap_set to adapt this function for specific cases, then save a
%   new versopm with USER's choice of function name

%remap_set = struct('in_class', {{'classstr1' 'classstr2'}, {'classstr3'}, {'classstr4'}},...
%    'out_class', {'classstr1_2', 'classstr3a', 'classstr3b'});

remap_set = struct...
    ('in_class', {'ciliate_mix' 'Didinium' 'Euplotes' 'Laboea' 'Leegaardiella'...
     'Myrionecta' 'Strobilidium_1' 'Sol' 'S_capitatum' 'S_caudatum'...
     'S_conicum' 'S_inclinatum' 'strombidium_2' 'strawberry' 'strombidium_1'...
     'S_wulffi' 'tiarina' 'tintinnid' 'Tontonia'},...
    'out_class', {'Ciliate_mix' 'Didinium_sp' 'Euplotes_sp' 'Laboea_strobila' 'Leegaardiella_ovalis'...
     'Mesodinium_sp' 'Strobilidium_morphotype1' 'Strobilidium_morphotype2' 'Strombidium_capitatum' 'Strombidium_caudatum'...
     'Strombidium_conicum' 'Strombidium_inclinatum' 'Strombidium_morphotype1' 'Strombidium_morphotype2' 'Strombidium_oculatum'...
     'Strombidium_wulffi' 'Tiarina_fusus' 'Tintinnid' 'Tontonia_gracillima'});

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

