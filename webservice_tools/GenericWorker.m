classdef GenericWorker
    %UNTITLED2 Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        wf = WorkflowClient();
        db = DashboardClient();
    end
    
    methods
        function this = GenericWorker(workflow_client, dashboard_client)
            this.wf = workflow_client;
            this.db = dashboard_client;
        end
        function do_all_work(this, role, ttl, callback)
            not_done = true;
            while not_done
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
        end
    end
end

