%Heidi 9/26/11 work in progress towards new feature extraction incorporating refined blob ID approach; 
%starting here with no stitching implemented and just one feature (summed large blob area); 
%plan to work with Joe to add back stitching and other features during code "refactoring"

warning('off')

feapath = 'C:\work\IFCB\ifcb_data_MVCO_jun06\features2\';
numfea = 1;
stitch_info_titles = {'first roi#' 'xpos1', 'ypos1', 'xpos2', 'ypos2'};
roipath = 'C:\work\IFCB\ifcb_data_MVCO_jun06\IFCB1_2009_046\';
roifiles = dir([roipath '*.roi']);
for filecount = 1:1:length(roifiles),
    filename = roifiles(filecount).name;
    disp([': File ' num2str(filecount) ' of ' num2str(length(roifiles)) ' : ' filename])
    tempname = [feapath filename(1:end-4) '_features.mat'];
    if 0, exist(tempname,'file'),
        disp('already done')
    elseif roifiles(filecount).bytes > 2 && exist([roipath filename(1:end-4) '.adc'], 'file'),
        fid=fopen([roipath filename]);
        if fid ~= -1  %case for file open errors over network?
            adcdata = load([roipath filename(1:end-4) '.adc'], '-ascii');  %load merged adc file
            xsize = adcdata(:,12);
            ysize = adcdata(:,13);
            startbyte = adcdata(:,14);
            xpos_all = adcdata(:,10); ypos_all = adcdata(:,11);
            totalrois = size(adcdata,1);
            imgnum = adcdata(:,1);
            features = NaN.*zeros(numfea,totalrois);
            for imgcount = 1:totalrois,
                if imgcount == 1 || (rem(imgcount,10) == 0)
                    disp([num2str(imgcount) ' of ' num2str(totalrois)])
                end;
                if (xsize(imgcount) > 0 && ysize(imgcount) > 0) %&& ~ismember(imgcount,stitch_info(:,1)) && ~ismember(imgcount, stitch_info(:,1)+1)),
                    position = startbyte(imgcount);
                    fseek(fid, position, -1);
                    img = fread(fid, xsize(imgcount).*ysize(imgcount), 'uint8=>uint8');
                    img = reshape(img, xsize(imgcount), ysize(imgcount));
                    [features1, featitles] = getfeatures2(img,1); %combine phasecong3 and kmeans
                    if ~isnan(features1(1)),
                        if length(features1) ~= numfea, disp('Problem: numfea does not match length of feature vector'),end;
                        features(:,imgcount) = features1;
                    end;
                end; % if (xsize > 0 & ysize > 0),
            end;  %for imgcount
            fclose(fid);
            %save([feapath filename(1:end-4) '_features'], 'features', 'imgnum', 'featitles');
            clear features Perimeters PixIdx FrDescp Centroid
            pack
        end;
    end;  %if exist(tempname)
end; %for filecount
