[filename,dir,~] = uigetfile('*.hdr');
basename = filename(1:end-4);
outdir = ['/Users/jfutrelle/dev/workspace/ifcb/IFCB_tools/stitch/' basename '/' ];
mkdir(outdir)
disp(['opening ' dir basename '.roi']);
fid=fopen([dir basename '.roi']);
total_time = 0
n_stitches = 0
if fid ~= -1  %case for file open errors over network?
    adcdata = load([dir basename '.adc'], '-ascii');  %load merged adc file
    xsize = adcdata(:,12);
    ysize = adcdata(:,13);
    startbyte = adcdata(:,14);
    xpos_all = adcdata(:,10); ypos_all = adcdata(:,11);
    totalrois = size(adcdata,1);
    imgnum = adcdata(:,1);
    stitch_ind = find(~diff(adcdata(:,1)));
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
            tic;
            [img_merge, xpos_merge, ypos_merge] = old_stitchrois(imagedat,xpos,ypos);
            disp(toc);
            total_time = total_time + toc;
            n_stitches = n_stitches + 1;
            if ~isnan(img_merge(1))
                img_merge = flipud(imrotate(img_merge,90));
                roi_fn = [outdir basename '_' sprintf('%05d',n) '.png'];
                disp(roi_fn);
                %imshow(img_merge,[0 255]);
                imwrite(uint8(img_merge),roi_fn,'png');
            end;
        end;
    end;
    disp(['avg ' num2str(total_time / n_stitches)]);
end