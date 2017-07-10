function out_bin = ifcb_stitch_bin(in_bin, infill)
% Given the output of ifcb_open_raw or ifcb_open_url, perform stitching
% and return an adjusted sample bin structure (see ifcb_open_raw for
% details) in which the 'images' field contains
% stitched images. Also adds a field called 'stitched' which lists the
% ROI numbers of stitched, infilled images (see ifcb_infill_image
% for details on infilling)
% An optional second argument can be set to 'noinfill' which leaves
% missing data as NaNs.

    if nargin < 2
        infill = 1;
    elseif strcmp(infill,'noinfill')
        infill = 0;
    end

    cols = ifcb_columns('I');

    coo = in_bin.adc(:,[cols.TRIGGER cols.ROI_X cols.ROI_Y cols.ROI_WIDTH cols.ROI_HEIGHT]);

    a = struct();
    a.trig = 1;
    a.x1 = 2;
    a.y1 = 3;
    a.x2 = 4;
    a.y2 = 5;

    % convert width/height to x/y
    coo(:, a.x2) = coo(:, a.x1) + coo(:, a.x2);
    coo(:, a.y2) = coo(: ,a.y1) + coo(:, a.y2);
    
    % place adjacent targets side-by-side
    coo = horzcat(coo,circshift(coo,-1,1));
    coo = coo(1:end-1, :);
     
    b = struct();
    b.trig = 6;
    b.x1 = 7;
    b.y1 = 8;
    b.x2 = 9;
    b.y2 = 10;
    
    % add target numbers
    [len, ~] = size(coo);
    coo = horzcat(coo, (1:len)');
    targ = 11;
    
    % cell array to hold result images
    images = in_bin.images;
    
    % consider only targets where trigger is the same
    coo = coo(coo(:, a.trig)==coo(:, b.trig),:);
    
    % consider only ROIs that overlap by more than overlap_thresh pixels
    overlap_thresh = 2;
    lix = (coo(:, a.x1) < coo(:, b.x2) - overlap_thresh) & ...
          (coo(:, a.x2) > coo(:, b.x1) + overlap_thresh) & ...
          (coo(:, a.y1) < coo(:, b.y2) - overlap_thresh) & ...
          (coo(:, a.y2) > coo(:, b.y1) + overlap_thresh);
      
    coo = coo(lix,:);

    % compute stitched boxes
    s = struct();
    s.x1 = 12;
    s.y1 = 13;
    s.x2 = 14;
    s.y2 = 15;
    
    % add columns for stitched boxes
    [len, ~] = size(coo);
    coo = horzcat(coo, zeros(len,4));
    
    % compute stitched box coords
    coo(:, s.x1) = min(coo(:, a.x1), coo(:, b.x1));
    coo(:, s.y1) = min(coo(:, a.y1), coo(:, b.y1));
    coo(:, s.x2) = max(coo(:, a.x2), coo(:, b.x2));
    coo(:, s.y2) = max(coo(:, a.y2), coo(:, b.y2));
    
    % now stitch, leaving NaNs where there is no data
    for i=1:len
        target = coo(i, targ);
        row = coo(i, :);
        
        % create appropriate size empty image
        w = row(s.x2) - row(s.x1);
        h = row(s.y2) - row(s.y1);
        
        im = NaN(h, w);
        
        % for each of the two adjacent ROIs
        for j=1:2
            if j==1
                ab = a;
                t = target;
            else
                ab = b;
                t = target+1;
            end
            
            % compute location in stitched box
            rx1 = row(ab.x1) - row(s.x1);
            ry1 = row(ab.y1) - row(s.y1);
            rx2 = rx1 + row(ab.x2) - row(ab.x1);
            ry2 = ry1 + row(ab.y2) - row(ab.y1);
            
            % fetch image from bin and composite it
            target_img = in_bin.images{t};
            im(ry1+1:ry2, rx1+1:rx2) = target_img;
        end
        
        % now infill the image unless noinfill is specified
        if infill
            im = ifcb_infill_image(im);
        end
        images{target} = im;
        images{target+1} = [];
    end
        
    stitched_ix = int64(coo(:, targ));
    
    out_bin = struct();
    out_bin.stitched = stitched_ix;
    out_bin.images = images;
end