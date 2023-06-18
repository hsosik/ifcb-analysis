function [ r ] = binzip_task( w, binzip_pid )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

function log(msg)
    w.log(binzip_pid, msg, 20);
end

zip_path = [tempname '.zip'];
c = onCleanup(@() cleanup(zip_path));

bin_pid = strrep(binzip_pid,'_binzip','');

binzip_create(bin_pid,zip_path);

log(['DEPOSITING ' binzip_pid]);
r = w.deposit_product(binzip_pid,zip_path);
log(['DEPOSITED ' binzip_pid]);

end

function cleanup(zip_path)
    if exist(zip_path,'file')
        delete(zip_path);
    end
end

