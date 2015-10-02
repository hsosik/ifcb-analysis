function [ targets ] = read_blob_zip(ziploc)
% read all targets from a blob zip.
% ziploc = filename or url of blob zip
% returns struct with
% .pid = cell array of blob pids
% .image = cell array of images

if strfind(ziploc,'://')
    % url case, copy to temp file
    zipfile = urlwrite(ziploc, tempname);
else
    zipfile = ziploc;
end

% open zipfile
zipJavaFile  = java.io.File(zipfile);
zipFile = org.apache.tools.zip.ZipFile(zipJavaFile);

% consume zip entries
entries = zipFile.getEntries;
c = 1;
while entries.hasMoreElements
    entry = entries.nextElement;
    entryName = entry.getName.toCharArray';
    [~,~,ext] = fileparts(entryName);
    if strcmp(ext,'.png')
        % target pid is entry name
        targets.pid{c,1} = entryName;
        % read BufferedImage from entry stream
        entryStream = zipFile.getInputStream(entry);
        jbi = javax.imageio.ImageIO.read(entryStream);
        % convert to MATLAB image and add to target image
        targets.image{c,1} = logical(jbi2img(jbi));
        c = c + 1;
    end
end

end