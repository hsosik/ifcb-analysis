function [] = get_roifile_features( roifile, roipath, feapath, stitchpath )

numfea = 210;
stitch_info_titles = {'first roi#' 'xpos1', 'ypos1', 'xpos2', 'ypos2'};

function log(msg,filename,comment)
    disp([datestr(now,'yyyy-mm-ddTHH:MM:SS') ' streamfeatures ' filename ' ' msg ' ' comment]);
end

function [] = save_stitch(path, stitch_info, stitch_info_titles) %#ok<INUSD>
save(path, 'stitch_info', 'stitch_info_titles')
end

function [] = save_features(path, features, imgnum, featitles) %#ok<INUSD>
save(path, 'features', 'imgnum', 'featitles');
end

featitles = [];
stitch_info = [];
filename = roifile.name;
tempname = [feapath filename(1:end-4) '_features.mat'];
if exist(tempname,'file'),
    log('SKIP',filename,'');
elseif roifile.bytes > 2 && exist([roipath filename(1:end-4) '.adc'], 'file'),
    fid=fopen([roipath filename]);
    if fid ~= -1  %case for file open errors over network?
        start_time = tic;
        log('START',filename,'');
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
        then = tic;
        for count = 1:length(stitch_ind);
            n = stitch_ind(count);
            startbyte_temp = startbyte(n:n+1); x = xsize(n:n+1); y = ysize(n:n+1); xpos = xpos_all(n:n+1); ypos = ypos_all(n:n+1);
            if x(1) == 0 || x(2) == 0, startbyte = []; end; %skip case with a 0 size rois
            imagedat = [];
            for imgcount = 1:length(startbyte_temp),
                fseek(fid, startbyte_temp(imgcount), -1);
                data = fread(fid, x(imgcount).*y(imgcount), 'ubit8');
                imagedat{imgcount} = reshape(data, x(imgcount), y(imgcount)); %#ok<*AGROW>
            end;
            
            if ~isnan(xpos(2)) && ~isempty(imagedat),
                [img_merge, ~, ~] = stitchrois(imagedat,xpos,ypos);
                if ~isnan(img_merge(1))
                    [features1, ~, ~, ~, ~, featitles] = getfeatures(uint8(img_merge));
                    features(:,n) = features1;
                    features(:,n+1) = NaN;
                    stitch_info = [stitch_info; n xpos(1) ypos(1) xpos(2) ypos(2)];
                end;
            end;
        end;
        save_stitch([stitchpath filename(1:end-4) '_roistitch.mat'], stitch_info, stitch_info_titles);
        elapsed = toc(then); % elapsed time in s
        n_stitched = size(stitch_info,1);
        rps = [num2str(floor(elapsed)) 's'];
        if n_stitched > 0,
            rps = [rps ' ' num2str(n_stitched / elapsed) ' rois/s'];
        end;
        log('STITCH',filename,rps);

        then = tic;
     
        for imgcount = 1:totalrois,
            if rem(imgcount,500) == 0,
                ct = toc(then);
                remaining = ((ct / imgcount) * (totalrois - imgcount)) / 60;
                pct = floor(imgcount * 100 / totalrois);
                log('PROGRESS',filename,[num2str(pct) '%, ' num2str(imgcount) '/' num2str(totalrois) ' rois, ' num2str(floor(remaining)) ' minutes remaining']);
            end;
            if isempty(stitch_info), stitch_info = NaN; end; %avoid crashing on next line for case with no stitching needed
            if (xsize(imgcount) > 0 && ysize(imgcount) > 0 && ~ismember(imgcount,stitch_info(:,1)) && ~ismember(imgcount, stitch_info(:,1)+1)),
                position = startbyte(imgcount);
                fseek(fid, position, -1);
                img = fread(fid, xsize(imgcount).*ysize(imgcount), 'uint8=>uint8');
                img = reshape(img, xsize(imgcount), ysize(imgcount));
                [features1, ~, ~, ~, ~, featitles] = getfeatures(img);
                if ~isnan(features1(1)),
                    if length(features1) ~= numfea,
                        log('WARNING',filename,'numfea does not match length of feature vector');
                    end;
                    features(:,imgcount) = features1;
                end;
            end; % if (xsize > 0 & ysize > 0),
        end;  %for imgcount
        
        fclose(fid);
        
        save_features([feapath filename(1:end-4) '_features'], features, imgnum, featitles);
        elapsed = toc(start_time);
        log('DONE',filename,[num2str(elapsed/60) ' minutes, ' num2str(totalrois / elapsed) ' rois/s']);
    end;
end;
end
    
