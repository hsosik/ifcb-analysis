classdef DashboardClient
    properties
        base_url = 'http://localhost:8888';
        time_series = '';
        namespace = '';
        api_key = '';
        authz = [];
    end
    methods
        function this = DashboardClient(base_url, time_series, api_key)
            % DashboardClient create a dashboard client
            % base_url = root of dashboard URL (e.g.,
            % http://ifcb-data.whoi.edu)
            
            if nargin > 0
                this.base_url = base_url;
            end
            if nargin > 1
                this.time_series = time_series;
            end
            if nargin > 2
                this.api_key = api_key;
                this.authz = weboptions('KeyName','X-Authorization','KeyValue',['Bearer ' api_key]);
            end
            this.namespace = [this.base_url '/' this.time_series];
        end
        % bin-level stuff
        function r = get_bin(~, pid)
            r = get_bin(char(pid));
        end
        function r = bin_rois(~, pid)
            % bin_rois list the ROIs for a given bin
            % pid = full URL of bin
            
            url = [char(pid) '_medium.json'];
            r = webread(url);
            r = r.targets;
        end
        function r = bin_metadata(~, pid)
            url = [char(pid) '_short.json'];
            r = webread(url);
        end
        function i = mosaic(this, pid, page, size, scale)
            if nargin < 3
                page=1;
            end
            if nargin < 4
                size = '800x600';
            end
            if nargin < 5
                scale = 0.33;
            end
            url = [this.namespace '/api/mosaic/size/' size '/scale/' num2str(scale) '/page/' num2str(page) '/pid/' char(pid) '.png'];
            i = webread(url);
        end
        % roi-level stuff
        function r = roi_metadata(~, pid)
            url = [char(pid) '.json'];
            r = webread(url);
        end
        function i = roi_image(~, pid)
            url = [char(pid) '.png'];
            i = webread(url);
        end
        function i = blob_image(~, pid)
            url = [char(pid) '_blob.png'];
            i = webread(url);
        end
        function i = outline_image(~, pid)
            url = [char(pid) '_blob_outline.png'];
            i = webread(url);
        end
        % feed and metrics
        function r = list_day(this, date)
            r = list_day(date, this.namespace);
        end
        function r = latest(this)
            url = [this.namespace '/api/feed/nearest/3000-01-01'];
            r = webread(url);
        end
        function r = first(this)
            url = [this.namespace '/api/feed/nearest/1970-01-01'];
            r = webread(url);
        end
        function r = nearest(this, date)
            url = [this.namespace '/api/feed/nearest/' date];
            r = webread(url);
        end
        function r = next(this, pid)
            url = [this.namespace '/api/feed/after/n/1/pid/' char(pid)];
            r = webread(url);
        end
        function r = previous(this, pid)
            url = [this.namespace '/api/feed/before/n/1/pid/' char(pid)];
            r = webread(url);
        end
        function r = get_metric(this, metric, start, ends)
            url = [this.namespace '/api/feed/' metric '/start/' start '/end/' ends];
            r = webread(url);
        end
        % tags
        function r = tags(this, pid)
            url = [this.namespace '/api/tags/' char(pid)];
            r = webread(url);
        end
        function r = search_tags(this, query)
            page = 1;
            r = [];
            while page > 0
                url = [this.namespace '/api/search_tags/' query '/page/' num2str(page)];
                o = webread(url);
                if isempty(o)
                    page = -1;
                else
                    if isempty(r); r = o; else r = cat(1,r,o); end
                    page = page+1;
                end
            end
        end
        function r = add_tag(this, pid, tag)
            url = [this.namespace '/api/add_tag/' tag '/' char(pid)];
            webread(url, this.authz);
            r = this.tags(pid);
        end
        function r = remove_tag(this, pid, tag)
            url = [this.namespace '/api/remove_tag/' tag '/' char(pid)];
            webread(url, this.authz);
            r = this.tags(pid);
        end
        % products
        function r = product_exists(~, pid, product_type)
            r = product_exists([char(pid) '_' product_type]);
        end
        function r = get_features(~, pid)
            url = [char(pid) '_features'];
            r = get_fea_file(url);
        end
        function r = get_blobs(~, pid)
            url = [char(pid) '_blob.zip'];
            r = get_blob_bin_file(url);
        end
        function r = deposit_product(this, pid, filepath)
            r = deposit_product(filepath, char(pid), this.api_key);
        end
    end
end