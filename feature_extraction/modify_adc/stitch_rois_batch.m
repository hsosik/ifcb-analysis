basedir = '\\demi\vol3\';  %%USER set, roi files, adc files
feapath = '\\queenrose\g_work_ifcb1\ifcb_data_mvco_jun06\features2008_v2\'; %USER set, feature files
stitchpath = '\\queenrose\ifcb1\ifcb_data_mvco_jun06\stitch2008\temp2\'; %USER set, stitch files

daylist = dir([basedir 'IFCB1_2008_001*']);

stitch_info_titles = {'first roi#' 'xpos1', 'ypos1', 'xpos2', 'ypos2'};
for daycount = 1:length(daylist),
    streampath = [basedir daylist(daycount).name '\']; 
    filelist = dir([streampath 'IFCB*.roi']);
    
   % temp = char(filelist.name); temp = str2num(temp(:,16:17));
   % temp = find(temp > 3); 
    %for filecount = 1:temp(1)-1,  %just do hours 00 - 04
    for filecount = 2:length(filelist),
        streamfile = filelist(filecount).name(1:end-4);
        disp(streamfile);
        if ~exist([stitchpath streamfile '_roistitch.mat'], 'file') && exist([streampath streamfile '.adc']),
        adcdata = load([streampath streamfile '.adc']);
        fid=fopen([streampath streamfile '.roi']);
        x_all = adcdata(:,12);  y_all = adcdata(:,13); startbyte_all = adcdata(:,14); xpos_all = adcdata(:,10); ypos_all = adcdata(:,11);
        ind = find(~diff(adcdata(:,1)));
        if ~isempty(find(diff(ind) == 0, 1)) %possible cases that need double merge???
            disp('more than two rois from one camera field?')
            keyboard
        end;
        
        stitch_info = [];
        keyboard
        for count = 1:length(ind);
            n = ind(count);
            startbyte = startbyte_all(n:n+1); x = x_all(n:n+1); y = y_all(n:n+1); xpos = xpos_all(n:n+1); ypos = ypos_all(n:n+1);
            if x(1) == 0 | x(2) == 0, startbyte = [];, end; %skip case with a 0 size rois
            imagedat = [];
            for imgcount = 1:length(startbyte),
                fseek(fid, startbyte(imgcount), -1);
                data = fread(fid, x(imgcount).*y(imgcount), 'ubit8');
                imagedat{imgcount} = reshape(data, x(imgcount), y(imgcount));
            end;
            
            %FIX THIS LATER IF THERE ARE MORE THAN TWO IMAGES TO BE MERGED
            if (diff(ypos)==0 & diff(xpos)==0),  %if positions are the same (mistake in pre-mid 2008 files) 
                [dxpos_est, dypos_est] = find_overlap(imagedat{1}, imagedat{2});  %get the overlap by comparing the images
                xpos(2) = xpos(1)+ dxpos_est;  % recover the positions of the second image
                ypos(2) = ypos(1)+ dypos_est;
            end;
            img_merge = NaN;
            xpos_merge = NaN;
            ypos_merge = NaN;
            if ~isnan(xpos(2)) && ~isempty(imagedat), %skip this for cases where above loop returns no overlap
                [img_merge, xpos_merge, ypos_merge] = stitchrois(imagedat,xpos,ypos);
                 if ~isnan(img_merge(1))
                    %load([feapath streamfile '_features.mat'])
                    %[features1, perimeter1, pixidx1, FrDescp1, Centroid1,featitles] = getfeatures(uint8(img_merge));
                    %features(:,n) = features1;
                    %features(:,n+1) = NaN;
                    %save([feapath streamfile '_features.mat'], 'features', '-append')
                    stitch_info = [stitch_info; n xpos(1) ypos(1) xpos(2) ypos(2)];
                 end;
            end;     
            
            if 0 && ~isnan(img_merge(1)),
                figure(1), clf
                subplot(2,1,1)
                imagesc(ypos(1), xpos(1), imagedat{1})
                hold on
                imagesc(ypos(2), xpos(2), imagedat{2})
                colormap('gray'); axis([0 1300 0 1300]), axis square
                subplot(2,1,2)
                imagesc(ypos_merge, xpos_merge, img_merge)
                %title(['overlap: ' num2str(size(intersect(xr(1,1):xr(1,2), xr(2,1):xr(2,2)),2)) '; ' num2str(size(intersect(yr(1,1):yr(1,2), yr(2,1):yr(2,2)),2))])
                colormap('gray'); axis([0 1300 0 1300]), axis square
                pause
            end;
        end;
        fclose(fid);
        %disp([length(ind); size(merge_info,1)]');
        save([stitchpath streamfile '_roistitch.mat'], 'stitch_info', 'stitch_info_titles')
        else
            disp('already done...')
        end;
    end;
end;