function [ status ] = write_adcmod( adcdata, stitch_info, adcmodfilename )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

ind = find(~diff(adcdata(:,1))); %double rois from same camera field
if ~isempty(ind), %only save modified adc file for cases with double rois
    if ~isempty(stitch_info),
        adcdata(stitch_info(:,1)+1,10:11) = stitch_info(:,4:5);
        ind = setdiff(ind,stitch_info(:,1)); %non-overlapping cases with two rois
    end;
    adcdata(ind+1,10:11) = -999;
    fid = fopen([adcmodfilename], 'w');
    fprintf(fid, '%d,%.6f,%.14f,%.14f,%.14f,%.14f,%.14f,%.6f,%.6f,%d,%d,%d,%d,%d,%.14f,\n', adcdata');
    status = fclose(fid);
end;
end

