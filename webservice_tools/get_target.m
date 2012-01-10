function [ target ] = get_target( target_pid )
% given a target's URL, return a structure representing that target
pid = char(target_pid);
target = parse_target_xml(wget_xml([pid '.xml']));

end
