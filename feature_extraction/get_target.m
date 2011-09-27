function [ target ] = get_target( pid )

import org.w3c.dom.Node;

pid = char(pid);
image = get_image(pid);
metadata = wget_xml([pid '.xml']);

metadata_nodes = metadata.getChildNodes;
n = metadata_nodes.getLength;
keys = {'image'};
values = {image};
for count = 1:n
    node = metadata_nodes.item(count-1);
    if node.getNodeType == Node.ELEMENT_NODE
        disp(node.getTagName);
        keys{end+1} = char(node.getLocalName);
        values{end+1} = char(node.getTextContent);
    end
end

target = cell2struct(values, keys, 2);

end
