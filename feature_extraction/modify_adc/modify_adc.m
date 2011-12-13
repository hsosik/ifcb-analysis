yr = '2008';
daypath = '\\cheese\IFCB_onD\';
daypath = '\\demi\ifcbold\G\IFCB\ifcb_data_MVCO_jun06\';
stitchpath = ['D:\work\IFCB1\ifcb_data_mvco_jun06\stitch' yr '\'];
dirlist = dir([daypath 'IFCB1_' yr '*']);
adcmodbase = 'D:\work\IFCB1\ifcb_data_mvco_jun06\adcmod\';

for daycount = 1:length(dirlist), %63
    disp(dirlist(daycount).name)
    adcpath = [daypath dirlist(daycount).name '\'];
    roilist = dir([adcpath 'IFCB*.roi']);
    adcmodpath = [adcmodbase dirlist(daycount).name, '\'];
    for adccount = 1:length(roilist),
        adcname = roilist(adccount).name; adcname = adcname(1:end-4);
        adcdata = load([adcpath adcname '.adc']);
        ind_test1 = find(~diff(adcdata(:,1)) & ~diff(adcdata(:,10)) & ~diff(adcdata(:,11))); %check to see if problem exists
        ind_test2 = find(~diff(adcdata(:,1)));
        %if length(ind_test2) > length(ind_test1) & ~isempty(ind_test1), keyboard, end;
        if ~isempty(ind_test1) & ~(length(ind_test1) < length(ind_test2))
         %   keyboard
            load([stitchpath adcname '_roistitch.mat']);
            if ~exist(adcmodpath, 'dir'),
                mkdir(adcmodpath)
            end;
            ind = find(~diff(adcdata(:,1))); %double rois from same camera field
            if ~isempty(ind), %only save modified adc file for cases with double rois
                if ~isempty(stitch_info),
                    adcdata(stitch_info(:,1)+1,10:11) = stitch_info(:,4:5);
                    ind = setdiff(ind,stitch_info(:,1)); %non-overlapping cases with two rois
                end;
                adcdata(ind+1,10:11) = -999;
                %save([adcmodpath adcname '.adc.mod'], 'adcdata', '-ascii')
               % dlmwrite([adcmodpath adcname '.adc.mod'], adcdata, 'delimiter', ',', 'precision', '%10.15f');
               % dlmwrite([adcmodpath adcname '.adc.mod'], adcdata, 'delimiter', ',', 'precision','%d%10.10f%10.14f%10.14f%10.14f%10.14f%10.14f%d%6.6f%d%d%d%d%d%10.14f\n');
               fid = fopen([adcmodpath adcname '.adc.mod'], 'w');
               fprintf(fid, '%d,%.6f,%.14f,%.14f,%.14f,%.14f,%.14f,%.6f,%.6f,%d,%d,%d,%d,%d,%.14f,\n', adcdata');
               fclose(fid);
               %dlmwrite([adcmodpath adcname '.adc.mod'], adcdata, 'delimiter', '','precision','%.10f,%.6f,%.14f,%.14f,%.14f,%.14f,%.14f,%d,%.6f,%d,%d,%d,%d,%d,%.14f');
            end;
        else
            disp('no mod needed')
           % keyboard
        end;
    end;
end;