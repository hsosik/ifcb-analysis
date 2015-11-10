function [ out ] = product_exists( pid )
% given the pid of a product, check to see if it exists

url = java.net.URL(pid);
httpCon = url.openConnection();
httpCon.setRequestMethod('HEAD');
code = httpCon.getResponseCode();

out = code < 400;

end

