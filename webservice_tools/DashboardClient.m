classdef DashboardClient
    properties
        base_url = 'http://localhost:8888';
        time_series = '';
        namespace = '';
        api_key = '';
        authz = [];
    end
    methods
        function this = DashboardClient(base_url, api_key, time_series)
            % DashboardClient create a dashboard client
            % base_url = root of dashboard URL (e.g., http://ifcb-data.whoi.edu)
            % time_series = label of the time series to access
            % api_key = API key for privileged operations
            
            if nargin > 0
                this.base_url = base_url;
            end
            if nargin > 2
                this.time_series = time_series;
            end
            if nargin > 1
                this.api_key = api_key;
                this.authz = weboptions('KeyName','X-Authorization','KeyValue',['Bearer ' api_key]);
            end
            this.namespace = [this.base_url '/' this.time_series];
        end
        % bin-level stuff
        function r = get_bin(~, pid)
            % get_bin get all ROIS and ADC data for a bin as a struct array
            
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
            % bin_metadata get the bin-level metadata (not ROIs)
            
            url = [char(pid) '_short.json'];
            r = webread(url);
        end
        function i = mosaic(this, pid, page, size, scale)
            % mosaic return a mosaic image for a given bin
            
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
            % roi_metadata get metadata for a single ROI
            
            url = [char(pid) '.json'];
            r = webread(url);
        end
        function i = roi_image(~, pid)
            % roi_image get the image for a single ROI
            
            url = [char(pid) '.png'];
            i = webread(url);
        end
        function i = blob_image(~, pid)
            % blob_image get the blob image for a single ROI (if available)
            
            url = [char(pid) '_blob.png'];
            i = webread(url);
        end
        function i = outline_image(~, pid)
            % outline_image get the blob outline overlay image for a ROI
            
            url = [char(pid) '_blob_outline.png'];
            i = webread(url);
        end
        % feed and metrics
        function r = list_day(this, date)
            % list_day list all bins in this time series for a given day
            % date = a date like '2008-12-31'
            
            r = list_day(date, this.namespace);
        end
        function r = latest(this)
            % latest return the URL of the most recent bin in this time series
            
            url = [this.namespace '/api/feed/nearest/3000-01-01'];
            r = webread(url);
        end
        function r = first(this)
            % first return the URL of the earliest bin in this time series
            
            url = [this.namespace '/api/feed/nearest/1970-01-01'];
            r = webread(url);
        end
        function r = nearest(this, date)
            % nearest return the URL of the bin nearest the given date
            
            url = [this.namespace '/api/feed/nearest/' date];
            r = webread(url);
        end
        function r = next(this, pid)
            % next given a bin, return the next bin in the time series
            
            url = [this.namespace '/api/feed/after/n/1/pid/' char(pid)];
            r = webread(url);
        end
        function r = previous(this, pid)
            % previous given a bin, return the previous bin in the time series
            
            url = [this.namespace '/api/feed/before/n/1/pid/' char(pid)];
            r = webread(url);
        end
        function r = get_metric(this, metric, start, ends)
            % get_metric get the given metric between the given dates
            % metrics include temperature, humidity, and trigger_rate
            
            url = [this.namespace '/api/feed/' metric '/start/' start '/end/' ends];
            r = webread(url);
        end
        % tags
        function r = tags(this, pid)
            % tags get the tags for a bin
            
            url = [this.namespace '/api/tags/' char(pid)];
            r = webread(url);
        end
        function r = has_tag(this, pid, tag)
            % has_tag check if a bin has the given tag
            
            r = false;
            tags = this.tags(pid);
            for n=1:length(tags)
                if strcmp(tags{n},tag)
                    r = true;
                    return
                end
            end
        end
        function r = search_tags(this, query)
            % search_tags return a list of bins with the given tag(s)
            % you can separate tags with a comma
            
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
            % add_tag add a tag to a bin
            
            url = [this.namespace '/api/add_tag/' tag '/' char(pid)];
            webread(url, this.authz);
            r = this.tags(pid);
        end
        function r = remove_tag(this, pid, tag)
            % remove_tag remove a tag from a bin
            
            url = [this.namespace '/api/remove_tag/' tag '/' char(pid)];
            webread(url, this.authz);
            r = this.tags(pid);
        end
        % products
        function r = product_exists(this, pid, product_type)
            % product_exists check to see if a given product exists
            % pid = bin pid
            % product_type = includes 'binzip', 'blobs', 'features'
            
            url = [this.base_url '/api_product_exists/' pid];
            if nargin > 2
                url = [url '_' product_type];
            end
            r = url_exists(url);
        end
        function r = get_features(~, pid)
            % get_features get the features for a given bin (if exists)
            
            url = [char(pid) '_features'];
            r = get_fea_file(url);
        end
        function r = get_blobs(~, pid)
            % get_blobs get the blobs for a given bin (if exists)
            
            url = [char(pid) '_blob.zip'];
            r = get_blob_bin_file(url);
        end
        function r = accepts_product(this, pid)
            % will the dashboard accept the given product
            
            url = [this.base_url '/api/accepts_product/' char(pid)];
            w = webwrap(@()webread(url));
            if w.http ~= 200
                r = 0;
            else
                r = w.accepts;
            end
        end
        function r = deposit_product(this, pid, filepath, check)
            % deposit_product upload a product
            % pid = the full pid of the product
            % filepath = local file containing product data
            
            r = deposit_product(filepath, char(pid), this.api_key);
            if nargin > 3 && strcmp(check,'check')
                if r~=200 && ~(this.product_exists(pid))
                    r = 404;
                end
            end
        end
    end
end