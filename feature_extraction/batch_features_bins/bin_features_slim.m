function [ ] = bin_features( in_dir, file, out_dir, opt1 , in_dir_blob, log_callback)
%function [ ] = bin_features( in_dir, file, out_dir )
%BIN_FEATURES Summary of this function goes here
%modified from bin_blobs
%Modified to incorporate biovolume computations (taken from bin_volume.m), Jan 2013
%Heidi M. Sosik, Woods Hole Oceanographic Institution
%
%March 2015, Heidi - updated to handle case for no web services access (local
%access for Rois and blobs)

debug = false;  %USER leave as is, not for parallel processing

function log(msg) % not to be confused with logarithm function
    m = ['bin_features ' msg];
    if exist('log_callback','var')
        log_callback(m);
    else
        logmsg(m,debug);
    end
end

% FIXME for more options, iterate over varags
if ~exist('opt1', 'var') || isempty(opt1),
  chatty = false;
elseif opt1 == 'chatty',
  chatty = true;
end

if ~exist(out_dir, 'dir')
    mkdir(out_dir)
end

% load the zip file
log(['LOAD targets ' file]);
%http://ifcb-data.whoi.edu/mvco/IFCB1_2009_174_055621_blob.zip
[~,~,x] = fileparts(file);
roi_flag = strmatch('.roi',x);
if roi_flag
    targets = get_images_fromROI([in_dir file]);
else %assume zip
    targets = get_bin_file([in_dir file]);
end;
nt = length(targets.pid);
if nt > 0,
    log(['LOAD blobs ' file]);
    if roi_flag
        targets_blob = get_blob_bin_file([in_dir_blob regexprep(file, '.roi', '_blobs_v4.zip')]);
    else
        targets_blob = get_blob_bin_file([in_dir regexprep(file, '.zip', '_blob.zip')]);
    end;
end;
log(['PROCESSING ' num2str(nt) ' target(s) from ' file]);

config = configure();
target.config = config;
output.config = config;
empty_target = target;

for i = 1:nt
    %disp(i)
    target = empty_target;
    target.pid = char(targets.pid(i));
    % get the image
    target.image = cell2mat(targets.image(i));
    target.blob_image = cell2mat(targets_blob.image(i));
    target = blob_geomprop(target); 
    target = blob_rotate(target);
    %target = blob_texture(target);
    %target = blob_invmoments(target);
    %target = blob_shapehist_stats(target);
    %target = blob_RingWedge(target);
    target = biovolume(target);
    if strcmp(target.pid, 'D20231112T090350_IFCB102_00268')
        area_ratio = target.blob_props.ConvexArea / target.blob_props.Area;
        pval = target.blob_props.Area / target.blob_props.Perimeter;
        ecc = target.blob_props.Eccentricity;
        use_sor = (area_ratio < 1.2) || (ecc < 0.8 && pval > 0.8);
        fprintf('DEBUG PID %s use_sor=%d area_ratio=%.16g p=%.16g ecc=%.16g\n', ...
            target.pid, use_sor, area_ratio, pval, ecc);
        if use_sor
            rot = target.rotated_blob_images{1};
            [V, xr, SA] = surface_area_revolve_2e(rot);
            fprintf('DEBUG PID %s sor_volume=%.16g sor_surface_area=%.16g sor_rw=%.16g\n', ...
                target.pid, V, SA, xr);
            debug_path = sprintf('sor_debug_%s.mat', target.pid);
            mask = target.blob_images{1} > 0;
            centered = center_blob(mask);
            [~, y1] = max(rot);
            r = sum(rot);
            ri = find(r);
            r = r / 2;
            r = r(ri);
            y1 = y1(ri);
            da = .25;
            angvec = 0:da:180;
            angR = angvec*pi/180;
            i2 = 1:length(r)-1;
            i1 = 2:length(r);
            ia2 = 1:length(angvec)-1;
            ia1 = 2:length(angvec);
            angR = repmat(angR,length(r),1);
            r = repmat(r',1,length(angvec));
            y1 = repmat(y1',1,length(angvec));
            center = y1+r;
            center([1,end],:) = center([2,end-1],:);
            Y = center + cos(angR).*r;
            Z = sin(angR).*r;
            x = (1:size(Y,1));
            x(1) = x(1)-0.5; x(end) = x(end)+.5;
            X = repmat(x',1,length(angvec));
            AB1 = X(i2,ia2) - X(i1,ia2);
            AB2 = Y(i2,ia2) - Y(i1,ia2);
            AB3 = Z(i2,ia2) - Z(i1,ia2);
            AD1 = X(i2,ia2) - X(i1,ia1);
            AD2 = Y(i2,ia2) - Y(i1,ia1);
            AD3 = Z(i2,ia2) - Z(i1,ia1);
            CD1 = X(i2,ia1) - X(i1,ia1);
            CD2 = Y(i2,ia1) - Y(i1,ia1);
            CD3 = Z(i2,ia1) - Z(i1,ia1);
            leg1 = (AB2.*AD3 - AB3.*AD2).^2;
            leg2 = (AB3.*AD1 - AB1.*AD3).^2;
            leg3 = (AB1.*AD2 - AB2.*AD1).^2;
            area_bot = 0.5*sqrt(leg1 + leg2 + leg3);
            leg1 = (CD2.*AD3 - CD3.*AD2).^2;
            leg2 = (CD3.*AD1 - CD1.*AD3).^2;
            leg3 = (CD1.*AD2 - CD2.*AD1).^2;
            area_top = 0.5*sqrt(leg1 + leg2 + leg3);
            sa_manual = 2*(sum(area_bot(:)) + sum(area_top(:)));
            sa_manual = sa_manual + sum(pi*r([1,end],1).^2);
            b1 = pi * r(i1,1).^2;
            b2 = pi * r(i2,1).^2;
            h = diff(x)';
            v_manual = sum(h/3 .* (b1 + b2 + sqrt(b1.*b2)));
            rw_manual = mean(r(:,1)*2);
            rot_sum = sum(rot);
            rot_shape = size(rot);
            center_shape = size(centered);
            save(debug_path, 'area_bot', 'area_top', 'X', 'Y', 'Z', 'r', 'y1', 'center', 'x', 'rot_sum', 'rot_shape', 'rot', ...
                'centered', 'center_shape', 'b1', 'b2', 'h', ...
                'sa_manual', 'v_manual', 'rw_manual');
            fprintf('DEBUG PID %s sor_volume_manual=%.16g sor_surface_area_manual=%.16g sor_rw_manual=%.16g\n', ...
                target.pid, v_manual, sa_manual, rw_manual);
            if evalin('base','exist(''debug_pixel_row'',''var'') && exist(''debug_pixel_col'',''var'')')
                rr = evalin('base','debug_pixel_row'); % 0-based
                cc = evalin('base','debug_pixel_col'); % 0-based
                [h, w] = size(centered);
                cx = (w + 1) / 2;
                cy = (h + 1) / 2;
                x = cc + 1;
                y = rr + 1;
                x0 = x - cx;
                y0 = y - cy;
                ang = deg2rad(-1 * target.blob_props.Orientation(1));
                cos_a = cos(-ang);
                sin_a = sin(-ang);
                x_in = cos_a * x0 - sin_a * y0 + cx;
                y_in = sin_a * x0 + cos_a * y0 + cy;
                x_idx = round(x_in);
                y_idx = round(y_in);
                in_bounds = (x_idx >= 1) && (x_idx <= w) && (y_idx >= 1) && (y_idx <= h);
                if in_bounds
                    src_val = centered(y_idx, x_idx);
                else
                    src_val = 0;
                end
                fprintf('DEBUG PID %s rotmap theta=%.16g out(r,c)=(%d,%d) x_in=%.16g y_in=%.16g x_idx=%d y_idx=%d in_bounds=%d src_val=%d\n', ...
                    target.pid, -1 * target.blob_props.Orientation(1), rr, cc, x_in, y_in, x_idx, y_idx, in_bounds, src_val);
            end
        else
            perim = compute_perimeter_img(target.blob_images{1});
            [V, x, SA] = distmap_volume(perim);
            fprintf('DEBUG PID %s dist_volume=%.16g dist_surface_area=%.16g dist_x=%.16g\n', ...
                target.pid, V, SA, x);
        end
    end
    target = blob_sumprops(target);
    %target = blob_Hausdorff_symmetry(target);
    %target = blob_binary_symmetry(target);
    %target = image_HOG(target);
    %target = blob_rotated_geomprop(target);
    %temp.features(i) = merge_structs(target.blob_props, target.image_props);
    temp.features(i) = target.blob_props;
    if chatty && rem(i,100) == 0,
      log(['PROCESSED ' char(targets.pid(i)) ' (' num2str(i) ' of ' num2str(nt) ')']);
    end;
end

if nt > 0,
    temp.pid = targets.pid;
    [ feature_mat, featitles, multiblob_features, multiblob_titles ] = make_feature_matrices(temp);

    %write the compiled feature csv file
    fileout = regexprep(file, '.zip', '_fea_v4.csv');
    fileout = regexprep(fileout, '.roi', '_fea_v4.csv');
    log(['SAVING ' fileout]);
   
    csvwrite_with_headers( [out_dir fileout], feature_mat, featitles );
    
    %write the raw multi-blob features to separate csv file
    fileout = regexprep(file, '.zip', '_multiblob_v4.csv');   
    fileout = regexprep(fileout, '.roi', '_multiblob_v4.csv');   
    if ~isempty(multiblob_features),
        mkdir([out_dir filesep 'multiblob']);
        csvwrite_with_headers( [out_dir filesep 'multiblob' filesep fileout], multiblob_features, multiblob_titles );
    end; 
    log(['DONE ' file]);
else
    log(['no targets SKIPPING ' file]);
end;
end
