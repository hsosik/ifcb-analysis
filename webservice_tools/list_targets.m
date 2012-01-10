function [ targets ] = list_targets( bin_pid )
% given the URL of a bin, list the URL's of each target in that bin.
import org.xml.sax.InputSource
import java.io.StringReader

bin = wget_xml([char(bin_pid) '.xml']);
target_nodes = bin.getElementsByTagNameNS(ifcb.TERM_NAMESPACE, 'Target');
n = target_nodes.getLength;
targets = cell(1,n);
for count = 1:n
    targets(:,count) = {char(target_nodes.item(count-1).getAttributeNS(ifcb.DC_NAMESPACE, 'identifier'))};
end

end

