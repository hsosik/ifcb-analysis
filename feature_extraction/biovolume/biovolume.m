function [ target ] = biovolume( target )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
% Modify from biovolume.m to compute along with other features
% Heidi M. Sosik, Woods Hole Oceanographic Institution

t = target.blob_props;
volume = NaN(size(t));
surface_area = volume;
xr = volume;

area_ratio = [t.ConvexArea]./[t.Area];
p = [t.EquivDiameter]./[t.MajorAxisLength];
for ii = 1:length(t.Area),
    if t.Area(ii), %skip if no blob (area = 0) 
        if area_ratio(ii) < 1.2 || (t.Eccentricity(ii) < 0.8 && p(ii) > 0.8), %solid of revolution cases
            blob_now = target.rotated_blob_images{ii};
            [volume(ii) xr(ii) surface_area(ii)] = surface_area_revolve_2e(blob_now); 
        else %distance map cases
           % set current pid for downstream debug hooks
           global IFCB_DEBUG_PID_CURRENT IFCB_DEBUG_BLOB_INDEX;
           IFCB_DEBUG_PID_CURRENT = '';
           IFCB_DEBUG_BLOB_INDEX = ii;
           if isfield(target, 'pid')
               IFCB_DEBUG_PID_CURRENT = target.pid;
           end
           [volume(ii) xr(ii) surface_area(ii)] = distmap_volume(target.blob_perimeter_images{ii});
        end;
    end;

    % Optional debug dump for a specific pid.
    global IFCB_DEBUG_PID;
    if ~isempty(IFCB_DEBUG_PID) && isfield(target, 'pid') && strcmp(target.pid, IFCB_DEBUG_PID)
        debug_dir = ['distmap_pipeline_debug_' target.pid];
        if ~exist(debug_dir, 'dir')
            mkdir(debug_dir);
        end
        perimeter_img = target.blob_perimeter_images{ii};
        blob_img = target.blob_images{ii};
        image_fill = imfill(perimeter_img,'holes');
        dbg_path = fullfile(debug_dir, sprintf('%s_%04d.mat', target.pid, ii));
        save(dbg_path, 'perimeter_img', 'blob_img', 'image_fill', 'volume', 'xr', 'surface_area', ...
            'ii', 'area_ratio', 'p');
    end
end;
target.blob_props.Biovolume = volume;
target.blob_props.SurfaceArea = surface_area;
target.blob_props.RepresentativeWidth = xr;
end

