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
    date_param = date;
end

if nargin < 2 || isempty(data_namespace)
    data_namespace = ifcb.DATA_NAMESPACE;
end

if data_namespace(end)~='/'
    data_namespace = [data_namespace '/'];
end

% use the IFCB V>=3 web services API
feed = webread([data_namespace 'api/feed/day/' date_param]);

if isempty(feed)
    bins = {};
else
    bins = cellstr(vertcat(feed.pid));
end

end

