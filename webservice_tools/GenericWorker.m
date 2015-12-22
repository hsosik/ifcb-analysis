classdef GenericWorker
    %UNTITLED2 Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        wf = WorkflowClient();
        db = DashboardClient();
    end
    
    methods(Static)
        function gw = new(host,api_key,port,wf_port)
            if nargin < 1
                host = 'localhost';
            end
            if nargin < 3
                port = 8888;
            end
            if nargin < 4
                wf_port = 9270;
            end
            base_url = ['http://' host];
            w = WorkflowClient([base_url ':' num2str(wf_port)]);
            d = DashboardClient([base_url ':' num2str(port)], api_key);
            gw = GenericWorker(w, d);
        end
    end
    
    methods
        function this = GenericWorker(wf, db)
            this.wf = wf;
            this.db = db;
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
            disp(['looking for next ' role ' job']);
            this.wf.expire();
            r = this.wf.start_next(role, ttl);
            if r.http == 404
                disp(['no more ' role ' jobs']);
                not_done = false;
            else
                product_pid = r.pid;
                if ~this.db.accepts_product(product_pid)
                    disp(['SKIP ' product_pid]);
                    this.wf.skip(product_pid);
                else
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

