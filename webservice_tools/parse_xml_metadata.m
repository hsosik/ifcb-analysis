function [ metadata ] = parse_xml_metadata( element )
% Given an XML element describing something, return it as a struct
% only works for very simple XML documents in the form
% <enclosingTag>
%   <key1>value1</key1>
%   <key2>value2</key2>
%   ...
%   </keyn>valuen</keyn>
% </enclosingTag>

import org.w3c.dom.Node;

metadata_nodes = element.getChildNodes;
n = metadata_nodes.getLength;
keys = {};
values = {};
for count = 1:n
    node = metadata_nodes.item(count-1);
    if node.getNodeType == Node.ELEMENT_NODE
        k = char(node.getLocalName);
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
