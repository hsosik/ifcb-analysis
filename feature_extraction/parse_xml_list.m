function [ metadata ] = parse_xml_list( element )
% parses files like
% <Thing>
%   <Subthing>
%     <prop1>value1</prop1>
%     <prop2>value2</prop2>
%     ...
%     <propn>valuen</propn>
%   </Subthing>
%   <Subthing>
%     ...
%   </Subthing>
%   ...
% </Thing>
% into a struct of vectors or cell arrays, one for each prop

import org.w3c.dom.Node;

kids = element.getChildNodes;
n = kids.getLength;
metadata = struct;
for count = 1:n
    node = kids.item(count-1);
    if node.getNodeType == Node.ELEMENT_NODE,
        kid = parse_xml_metadata(node);
        fields = fieldnames(kid);
        for fc = 1:length(fields),
            field = char(fields(fc));
            if ~isfield(metadata,field),
                metadata.(field) = [];
            end
            if ischar(kid.(field)),
                metadata.(field){end+1} = kid.(field);
            else
                metadata.(field)(end+1) = kid.(field);
            end
        end
    end
end

end

