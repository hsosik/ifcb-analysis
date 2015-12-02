function [ r ] = deposit_product ( filepath, pid, api_key )
% perform HTTP PUT to deposit product
% filepath - path to local file containing product data
% pid - web URL of product
% api_key - API key to use for authentication

url = java.net.URL(pid);
httpCon = url.openConnection();
httpCon.setDoOutput(true);
httpCon.setRequestMethod('PUT');
httpCon.setRequestProperty('X-Authorization',['Bearer ' api_key]);
out = httpCon.getOutputStream();
java.nio.file.Files.copy(java.io.File(filepath).toPath(), out);
out.close();
in = httpCon.getInputStream();
sw = java.io.StringWriter();
org.apache.commons.io.IOUtils.copy(in,sw);
in.close();

r = httpCon.getResponseCode();

end