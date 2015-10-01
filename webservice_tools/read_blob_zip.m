function [ targets ] = read_blob_zip(zipfile)

zipJavaFile  = java.io.File(zipfile);
zipFile = org.apache.tools.zip.ZipFile(zipJavaFile);

entries = zipFile.getEntries;
c = 1;

while entries.hasMoreElements
    entry = entries.nextElement;
    targets.pid{c,1} = entry.getName.toCharArray';
    entryStream = zipFile.getInputStream(entry);
    jbi = javax.imageio.ImageIO.read(entryStream);
    targets.image{c,1} = jbi2img(jbi);
    c = c + 1;
end

end