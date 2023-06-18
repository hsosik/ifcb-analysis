function [ r ] = blob_task( w, blob_pid )
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here

function log(msg)
    w.log(blob_pid, msg, 120);
end

blob_tempdir = tempname;
c = onCleanup(@()cleanup(blob_tempdir));

mkdir(blob_tempdir);

bin_pid = strrep(blob_pid,'_blobs','');
zip_url = [bin_pid '.zip'];
bin_lid = lid(bin_pid);
blob_zip_file = [blob_tempdir filesep bin_lid '_blobs_v2.zip'];

bin_blobs(bin_pid, zip_url, blob_tempdir, @log);

if exist(blob_zip_file,'file')
    log(['DEPOSITING ' blob_pid]);
    w.deposit_product(blob_pid, blob_zip_file);
    log(['DEPOSITED ' blob_pid]);
else
    throw MException('ProductNotFound','bin_blobs produced no output')
end

r = 1;

end

function cleanup(blob_tempdir)
    if exist(blob_tempdir,'dir')
        rmdir(blob_tempdir,'s');
    end
end

