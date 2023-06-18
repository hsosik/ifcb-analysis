classdef WorkflowClient
    properties
        base_url = 'http://localhost:9270';
        api_prefix = '/workflow/api/v1/';
        FOREVER = -1;
    end
    methods
        function this = WorkflowClient(base_url)
            % create a workflow client
            % base_url = base URL of workflow service (e.g., http://localhost:9270)
            
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
            % create create a product
            % pid = URL of product
            % state = initial state (default: 'available')
            
            if nargin < 3;
                state = 'available';
            end
            url = this.url_for('create',pid');
            r = webwrap(@()webwrite(url,'state',state));
        end
        function r = get(this, pid, product_type)
            % get get status information about a product
            % pid = URL of bin
            % product_type = one of 'binzip','blobs','features', etc.
            
            if nargin < 3
                product_type = 'raw';
            end
            url = this.url_for('get',[pid '_' product_type]);
            r = webwrap(@()webread(url));
        end
        function r = depend(this, pid, upstream, role, priority)
            % depend establish a dependency between two products
            % pid = the URL of the "downstream" product
            % upstream = the URL of the "upstream" product
            % role = the relationship between them (e.g., 'raw2binzip')
            % priority = the priority of this job (lower is higher priority)
            
            if nargin < 5
                priority = 100;
            end
            url = this.url_for('depend',pid);
            r = webwrap(@()webwrite(url,'upstream',upstream,'role',role,'priority',priority));
        end
        function r = update(this, pid, state, event, message, ttl)
            % update update the status of a product
            % pid = product URL
            % state = new state (default "running")
            % event = new event (default "heartbeat")
            % message = new message
            % ttl = time-to-live (default forever)
            
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
            % complete mark a product as completed
            % pid = product URL
            % state = final state (default "available")
            % event = final event (default "completed")
            % message = final message
            
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
            % update_if update only if in given state
            % pid = product URL
            % state = state the product must be in (default "waiting")
            % new_state = state to change to if possible (default "running")
            % event = event for this state change (default "started")
            % message = message for this state change
            % ttl = time-to-live for this state change (default forever)
            
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
            % abort equivalent to update if running to waiting/aborted
            
            r = this.update_if(pid,'running','waiting','aborted');
        end
        function r = skip(this, pid, ttl)
            if nargin < 3
                ttl = 240;
            end
            r = this.update(pid, 'running', 'skipped', 'skipped', ttl);
        end
        function r = expire(this, state, new_state, event, message, ttl)
            % expire cause any expired objects to make the given state transition
            % state = state the products must be in now (default "running")
            % new_state = state after transition (default "waiting")
            % event = state change event (default "expired")
            % ttl = time to live for new state (default forever)
            
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
            % heartbeat keep a product from expiring
            % pid = product URL
            % message = message for this update
            % ttl = new time-to-live
            
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
            % start_next start the next product for the given role
            % role = the role
            % ttl = new time-to-live
            % state = state the product must be in (default "waiting")
            
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

