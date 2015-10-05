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

% consume zip entry names and place lids in cell string array
entries = zipFile.getEntries;
c = 1;
while entries.hasMoreElements
    entry = entries.nextElement;
    entryName = entry.getName.toCharArray';
    [~,lid,ext] = fileparts(entryName);
    if strcmp(ext,'.png')
        lids{c} = lid; %#ok<AGROW>
        c = c + 1;
    end
end

% now sort entry names
lids = sort(lids);

for c = 1:numel(lids)
    % target "pid" is lid
    targets.pid{c,1} = lids{c};
    % entry name is lid + '.png'
    entryName = [lids{c} '.png'];
    % read BufferedImage from entry stream
    entry = zipFile.getEntry(entryName);
    entryStream = zipFile.getInputStream(entry);
    jbi = javax.imageio.ImageIO.read(entryStream);
    % convert to MATLAB image and add to target image
    targets.image{c,1} = logical(jbi2img(jbi));
end

end