function [ ] = produce_products ( host, api_key, port )

the_port = 8888;
if exist('port','var')
    the_port = port;
end
worker = GenericWorker(host,the_port,api_key);

spmd
    pause(labindex());
    not_done = true;
    while not_done
        done = true;
        done = done && ~worker.do_one_job('raw2binzip',@binzip_task);
        done = done && ~worker.do_one_job('binzip2blobs',@blob_task);
        done = done && ~worker.do_one_job('blobs2features',@features_task);
        not_done = ~done;
    end
end

end

