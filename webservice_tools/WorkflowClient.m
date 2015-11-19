classdef WorkflowClient
    properties
        base_url = 'http://localhost:9270';
        api_prefix = '/workflow/api/v1/';
        FOREVER = -1;
    end
    methods
        function this = WorkflowClient(base_url)
            if nargin > 0
                this.base_url = base_url;
            end
        end
        function u = url_for(this, endpoint, pid)
            if nargin==3
                pid_part = ['/' pid];
            else
                pid_part = '';
            end
            u = [this.base_url this.api_prefix endpoint pid_part];
        end
        function r = create(this, pid, state)
            if nargin < 3;
                state = 'available';
            end
            url = this.url_for('create',pid');
            r = webwrap(@()webwrite(url,'state',state));
        end
        function r = get(this, pid, product_type)
            if nargin < 3
                product_type = 'raw';
            end
            url = this.url_for('get',[pid '_' product_type]);
            r = webwrap(@()webread(url));
        end
        function r = depend(this, pid, upstream, role, priority)
            if nargin < 5
                priority = 100;
            end
            url = this.url_for('depend',pid);
            r = webwrap(@()webwrite(url,'upstream',upstream,'role',role,'priority',priority));
        end
        function r = update(this, pid, state, event, message, ttl)
            if nargin < 3
                state = 'running';
            end;if nargin < 4
                event = 'heartbeat';
            end;if nargin < 5
                message = '';
            end;if nargin < 6;
                ttl = this.FOREVER;
            end
            url = this.url_for('update',pid);
            r = webwrap(@()webwrite(url,'state',state,'event',event,'message',message,'ttl',ttl));
        end
        function r = complete(this, pid, state, event, message)
            if nargin < 3
                state = 'available';
            end;if nargin < 4
                event = 'completed';
            end;if nargin < 5
                message = '';
            end
            url = this.url_for('update',pid);
            r = webwrap(@()webwrite(url,'state',state,'event',event,'message',message,'ttl',-1));
        end
        function r = update_if(this, pid, state, new_state, event, message, ttl)
            if nargin < 3
                state = 'waiting';
            end;if nargin < 4
                new_state = 'running';
            end;if nargin < 5
                event = 'started';
            end;if nargin < 6
                message = '';
            end;if nargin < 7;
                ttl = this.FOREVER;
            end
            url = this.url_for('update_if',pid);
            r = webwrap(@()webwrite(url,'state',state,'new_state',new_state,'event',event,'message',message,'ttl',ttl));
        end
        function r = abort(this, pid)
            r = this.update_if(pid,'running','waiting','aborted');
        end
        function r = expire(this, state, new_state, event, message, ttl)
            if nargin < 3
                state = 'running';
            end;if nargin < 4
                new_state = 'waiting';
            end;if nargin < 5
                event = 'expired';
            end;if nargin < 6
                message = '';
            end;if nargin < 7;
                ttl = this.FOREVER;
            end
            url = this.url_for('expire');
            r = webwrap(@()webwrite(url,'state',state,'new_state',new_state,'event',event,'message',message,'ttl',ttl));
        end
        function r = heartbeat(this, pid, message, ttl)
            if nargin < 3
                message = '';
            end;if nargin < 4
                ttl = -2;
            end
            if ttl==-2
                url = this.url_for('update',pid);
                r = webwrap(@()webwrite(url,'state','running','event','heartbeat','message',message));
            else
                r = this.update(pid, 'running', 'heartbeat', message, ttl);
            end
        end
        function r = start_next(this, role, ttl, state)
            if nargin < 4
                state = 'waiting';
            end;if nargin < 3;
                ttl = this.FOREVER;
            end
            url = this.url_for('start_next',role);
            r = webwrap(@()webwrite(url,'state',state,'ttl',ttl));
        end
    end
end

