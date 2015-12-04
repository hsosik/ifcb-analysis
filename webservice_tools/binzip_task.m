function [ r ] = binzip_task( w, binzip_pid )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

zip_path = [tempname '.zip'];
c = onCleanup(@() cleanup(zip_path));

bin_pid = strrep(binzip_pid,'_binzip','');

binzip_create(bin_pid,zip_path);

r = w.db.deposit_product(binzip_pid,zip_path,'check');

end

function cleanup(zip_path)
    if exist(zip_path,'file')
        delete(zip_path);
    end
end

