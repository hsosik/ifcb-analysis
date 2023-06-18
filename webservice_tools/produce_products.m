function [ ] = produce_products ( worker )

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

