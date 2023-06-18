function [ out ] = url_exists( url )
% given a URL, check to see if it exists (returns less than 400)

jurl = java.net.URL(url);
httpCon = jurl.openConnection();
httpCon.setRequestMethod('HEAD');
code = httpCon.getResponseCode();

out = code < 400;

% FIXME debug
if out
    disp([url ' exists']);
end
% end debug

end

