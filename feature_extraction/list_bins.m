function [ bins, next_date ] = list_bins( date )

if nargin < 1 || isempty(date)
    date = 'now';
end

feed = wget_xml([ifcb.DATA_NAMESPACE 'rss.py?format=atom&date=' date]);
item_nodes = feed.getElementsByTagNameNS('http://www.w3.org/2005/Atom', 'entry');
n = item_nodes.getLength;
bins = cell(1,n);
for count = 1:n
    entry = item_nodes.item(count-1);
    id = entry.getElementsByTagNameNS(ifcb.ATOM_NAMESPACE, 'id').item(0).getTextContent;
    bins{count} = char(id);
end
next_date = char(entry.getElementsByTagNameNS(ifcb.ATOM_NAMESPACE, 'updated').item(0).getTextContent);

end

