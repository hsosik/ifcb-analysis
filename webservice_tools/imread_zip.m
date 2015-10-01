function [ img ] = imread_zip(zipfile, entryname)
% reads a single image from a zipfile
% note that the zipfile parameter must be the path to a real zipfile
% and not a URL.

zipJavaFile  = java.io.File(zipfile);
zipFile = org.apache.tools.zip.ZipFile(zipJavaFile);

entry = zipFile.getEntry(entryname);
entryStream = zipFile.getInputStream(entry);
jbi = javax.imageio.ImageIO.read(entryStream);

img = jbi2img(jbi);

zipFile.close;