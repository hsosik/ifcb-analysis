function [ target ] = get_target( target_pid )

pid = char(target_pid);
target = parse_target_xml(wget_xml([pid '.xml']));

end
