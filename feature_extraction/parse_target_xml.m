function [ metadata ] = parse_target_xml( element )
% Given an XML element describing a target, return it as a struct

import org.w3c.dom.Node;

metadata_nodes = element.getChildNodes;
n = metadata_nodes.getLength;
keys = {};
values = {};
for count = 1:n
    node = metadata_nodes.item(count-1);
    if node.getNodeType == Node.ELEMENT_NODE
        k = char(node.getLocalName);
        if strcmp(k,'identifier') % downcovert from Dublin Core
            k = 'pid';
        end
        v = char(node.getTextContent);
        if regexp(v,'^-?\d+\.?\d*$') % is it a number?
            v = str2double(v);
        end
        keys{end+1} = k;
        values{end+1} = v;
    end
end

metadata = cell2struct(values, keys, 2);

end

