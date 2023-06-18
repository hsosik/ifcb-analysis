function [ targets ] = read_blob_zip(ziploc, entryName)
% read all targets from a blob zip.
% ziploc = filename or url of blob zip
% returns struct with
% .pid = cell array of blob pids
% .image = cell array of images
% or returns single image if entryName is specified

tmpPath = 0;

if strfind(ziploc,'://')
    % url case, copy to temp file
    tmpPath = tempname;
    % FIXME if the following is interrupted there is no way to
    % delete the temp file
    zipPath = tmpPath;
    urlwrite(ziploc, zipPath);
else
    zipPath = ziploc;
end

% open zipfile
zipJavaFile  = java.io.File(zipPath);
zipFile = org.apache.tools.zip.ZipFile(zipJavaFile);
cleanupZipObj = onCleanup(@() cleanup_zip(tmpPath, zipFile));

function [ image ] = entry2img(entryName)
    % read BufferedImage from entry stream
    entry = zipFile.getEntry(entryName);
    entryStream = zipFile.getInputStream(entry);
    jbi = javax.imageio.ImageIO.read(entryStream);
    % convert to MATLAB image and add to target image
    image = logical(jbi2img(jbi));
end

if nargin == 2
    targets = entry2img(entryName);
else
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
        % convert to MATLAB image and add to target image
        targets.image{c,1} = entry2img(entryName);
    end
end

zipFile.close();

end

function cleanup_zip(tmpPath, zipFile)
zipFile.close();
if ~(tmpPath == 0)
    if exist(tmpPath,'file')==2
        delete(tmpPath);
    end
end
end