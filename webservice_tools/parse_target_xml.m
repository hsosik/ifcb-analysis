function [ metadata ] = parse_target_xml( element )
% Given an XML element describing a target, return it as a struct

metadata = parse_xml_metadata(element);

% change "identifier" (dc:identifier) to "pid"
metadata.pid = metadata.identifier;
rmfield(metadata,'identifier');

end

