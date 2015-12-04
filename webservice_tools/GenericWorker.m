classdef GenericWorker
    %UNTITLED2 Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        wf = WorkflowClient();
        db = DashboardClient();
    end
    
    methods
        function this = GenericWorker(host, port, api_key)
            this.wf = WorkflowClient(['http://' char(host) ':9270']);
            this.db = DashboardClient(['http://' char(host) ':' num2str(port)],api_key);
        end
        function log(this, pid, message, ttl)
            disp(message);
            this.wf.heartbeat(pid, message, ttl);
        end
        function r = deposit_product(this, pid, file)
            r = this.db.deposit_product(pid, file, 'check');
        end
        function not_done = do_one_job(this, role, callback, ttl)
            not_done = true;
            if ~exist('ttl','var')
                ttl = 120;
            end
            disp('looking for next job');
            this.wf.expire();
            r = this.wf.start_next(role, ttl);
            if r.http == 404
                disp('no more jobs');
                not_done = false;
            else
                product_pid = r.pid;
                disp(['START ' product_pid]);
                try
                    r = callback(this, product_pid);
                    if r
                        disp(['DONE ' product_pid]);
                        this.wf.complete(product_pid);
                    else
                        disp(['NOT DONE ' product_pid]);
                        this.wf.abort(product_pid);
                    end
                catch exc
                    disp(getReport(exc));
                    disp(['ERROR ' product_pid]);
                    this.wf.abort(product_pid);
                end
            end
        end
        function do_all_jobs(this, role, callback, ttl)
            if ~exist('ttl','var')
                ttl = 120;
            end
            not_done = true;
            while not_done
                not_done = this.do_one_job(role, callback, ttl);
            end
        end
    end
end

