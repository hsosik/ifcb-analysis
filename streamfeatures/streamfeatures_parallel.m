function [] = main()

%modified from gettrainingfeatures3c_lowres and gettrainingfeatures4, new approach saving
%results by directory and check to update, 2/26/05

%modified from streamfeatures_24jun05 to include stitching of overlapping pairs of rois
%from the same camera field, Heidi 29 Dec 2009
%edited 8 Jan 2010 to convert img_merge to uint8 and to handle case where
%no stitching is required

% modified to use parallel computing toolbox by Joe Futrelle 9/2011.
% currently untested.

warning('off')

roidaypath = '\\Cheese\G on K\IFCB\ifcb_data_MVCO_jun06\ ';
feapath = 'd:\work\IFCB1\ifcb_data_MVCO_jun06\features2009\';
stitchpath = 'd:\work\IFCB1\ifcb_data_MVCO_jun06\stitch2009s\';
path_separator = '\';

numfea = 210;
time_start = now;
daydir = dir([roidaypath 'IFCB1_2011_*']); % why is this just 2009?
stitch_info_titles = {'first roi#' 'xpos1', 'ypos1', 'xpos2', 'ypos2'};

matlabpool

% TODO collapse day and file iteration into one parfor.
% otherwise a core could idle if it's finished with the files it's doing
% for that day. this is especially important for
for daycount = 1:length(daydir)
    roipath = [roidaypath daydir(daycount).name path_separator];
    roifiles = dir([roipath '*.roi']);
    disp(roifiles); % FIXME debug

    parfor filecount = 1:length(roifiles),
        stitch_info = [];
        filename = roifiles(filecount).name;
        disp([daydir(daycount).name ': File ' num2str(filecount) ' of ' num2str(length(roifiles)) ' : ' filename])
        tempname = [feapath filename(1:end-4) '_features.mat'];
        if exist(tempname,'file'),
            disp('already done')
        elseif roifiles(filecount).bytes > 2 && exist([roipath filename(1:end-4) '.adc'], 'file'),
            fid=fopen([roipath filename]);
            if fid ~= -1  %case for file open errors over network?
                %load([roipath filename(1:15)]);  %load merged adc file
                adcdata = load([roipath filename(1:end-4) '.adc'], '-ascii');  %load merged adc file
                xsize = adcdata(:,12);
                ysize = adcdata(:,13);
                startbyte = adcdata(:,14);
                xpos_all = adcdata(:,10); ypos_all = adcdata(:,11);
                totalrois = size(adcdata,1);
                imgnum = adcdata(:,1);
                stitch_ind = find(~diff(adcdata(:,1)));
                features = NaN.*zeros(numfea,totalrois);
                %      Perimeters = struct('perimeter', cell(1,totalrois));
                %      PixIdx = struct('pixidx', cell(1,totalrois));
                %      FrDescp = struct('frdescp', cell(1,totalrois));
                %      Centroid = NaN.*zeros(2,totalrois);
                disp('     stitching...')
                for count = 1:length(stitch_ind);
                    n = stitch_ind(count);
                    startbyte_temp = startbyte(n:n+1); x = xsize(n:n+1); y = ysize(n:n+1); xpos = xpos_all(n:n+1); ypos = ypos_all(n:n+1);
                    if x(1) == 0 || x(2) == 0, startbyte = []; end; %skip case with a 0 size rois
                    imagedat = [];
                    for imgcount = 1:length(startbyte_temp),
                        fseek(fid, startbyte_temp(imgcount), -1);
                        data = fread(fid, x(imgcount).*y(imgcount), 'ubit8');
                        imagedat{imgcount} = reshape(data, x(imgcount), y(imgcount));
                    end;
                    
                    img_merge = NaN;
                    xpos_merge = NaN;
                    ypos_merge = NaN;
                    if ~isnan(xpos(2)) && ~isempty(imagedat), 
                        [img_merge, xpos_merge, ypos_merge] = stitchrois(imagedat,xpos,ypos);
                        if ~isnan(img_merge(1))
                            [features1, perimeter1, pixidx1, FrDescp1, Centroid1, featitles] = getfeatures(uint8(img_merge));
                            features(:,n) = features1;
                            features(:,n+1) = NaN;
                            stitch_info = [stitch_info; n xpos(1) ypos(1) xpos(2) ypos(2)];
                        end;
                    end;
                end;
                save_stitch([stitchpath filename(1:end-4) '_roistitch.mat'], stitch_info, stitch_info_titles)

                for imgcount = 1:totalrois,
                    if imgcount == 1 || (rem(imgcount,10) == 0)
                        disp([num2str(imgcount) ' of ' num2str(totalrois)])
                    end;
                    if isempty(stitch_info), stitch_info = NaN; end; %avoid crashing on next line for case with no stitching needed
                    if (xsize(imgcount) > 0 && ysize(imgcount) > 0 && ~ismember(imgcount,stitch_info(:,1)) && ~ismember(imgcount, stitch_info(:,1)+1)),
                        position = startbyte(imgcount);
                        fseek(fid, position, -1);
                        img = fread(fid, xsize(imgcount).*ysize(imgcount), 'uint8=>uint8');
                        img = reshape(img, xsize(imgcount), ysize(imgcount));
                        [features1, perimeter1, PixIdx1, FrDescp1, Centroid1, featitles] = getfeatures(img);
                        %            [features1, featitles] = getfeatures(img);
                        if ~isnan(features1(1)),
                            if length(features1) ~= numfea, disp('Problem: numfea does not match length of feature vector'),end;
                            features(:,imgcount) = features1;
                        end;
                        %               Perimeters(imgcount).perimeter = perimeter1;
                        %               PixIdx(imgcount).pixidx = PixIdx1;
                        %               FrDescp(imgcount).frdescp = FrDescp1;
                    end; % if (xsize > 0 & ysize > 0),
                end;  %for imgcount
                
                fclose(fid)
                
                save_features([feapath filename(1:end-4) '_features'], features, imgnum, featitles);
                %clear features Perimeters PixIdx FrDescp Centroid
                pack
            end;
        end;  %if exist(tempname)
    end; %for filecount
end; %for daycount

matlabpool close

time_end = now;
if time_end-time_start < 10/60/24, %5 minutes as day
    pause_sec = 1*3600;  %1 hour as seconds
    pause(pause_sec);
    disp(now)
end;

% clear all


streamfeatures_parallel
end

function [] = save_stitch(path, stitch_info, stitch_info_titles)
save(path, 'stitch_info', 'stitch_info_titles')
end

function [] = save_features(path, features, imgnum, featitles)
save(path, 'features', 'imgnum', 'featitles');
end