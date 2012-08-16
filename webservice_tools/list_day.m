function [ bins ] = list_day( date, data_namespace )
% given a date (or with no argument, today), list the URL's of all
% bins on that date. date must be in yyyy-mm-dd format.
% data_namespace is the URL prefix to use. defaults to ifcb.DATA_NAMESPACE.
% but you can set it to something like http://ifcb-data.whoi.edu/saltpond/
% instead. don't forget the trailing slash.
% for example:
% list_day('2012-06-20','http://ifcb-data.whoi.edu/saltpond/');

if nargin < 1 || isempty(date)
    date_param = 'now';
else
    date_param = [date 'T23:59:59Z'];
end

if nargin < 2 || isempty(data_namespace)
    data_namespace = ifcb.DATA_NAMESPACE;
end

feed = wget_xml([data_namespace 'rss.py?format=atom&date=' date_param '&n=150']);
item_nodes = feed.getElementsByTagNameNS('http://www.w3.org/2005/Atom', 'entry');
n = item_nodes.getLength;
bins = cell(1,0);
for count = 1:n
    entry = item_nodes.item(count-1);
    id = char(entry.getElementsByTagNameNS(ifcb.ATOM_NAMESPACE, 'id').item(0).getTextContent);
    entry_date = char(entry.getElementsByTagNameNS(ifcb.ATOM_NAMESPACE, 'updated').item(0).getTextContent);
    entry_day = regexprep(entry_date,'T.*','');
    if count > 1 && ~strcmp(entry_day,prev_date),
        break;
    end
    bins{count} = id;
    prev_date = regexprep(entry_date,'T.*','');
end

end

