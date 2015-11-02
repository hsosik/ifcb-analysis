function [ pids ] = search_tags( ts_url, tag )
% returns pids of all bins with the given tag
% ts_url - full URL of time series, e.g.,
% http://ifcb-data.whoi.edu/mvco
% tag - the tag to search for
pids = {};
page = 1;
n = 1;

while n>0
    url = [ ts_url '/api/search_tags/' tag '/page/' num2str(page) ];
    s = webread(url);
    n = length(s);
    for i=1:n
        pids = vertcat(pids,{s(i).pid});
    end
    page = page + 1;
end

end

