classpath = '\\sosiknas1\Lab_data\VPR\vpr3\class_RossSea_Trees_09Mar2015\';
roibase = '\\sosiknas1\Lab_data\VPR\vpr3\d009\';
subnum = 0;
filelist = dir([classpath '*.mat']);
for filecount = 3:length(filelist),
    fname = filelist(filecount).name;
    display(fname)
    load([classpath fname])
    hstr = fname(5:7);
    [~,TBclass_num] = ismember(TBclass_above_threshold,class2useTB) ;
    for classcount = 1:length(class2useTB),
        ii = find(TBclass_num == classcount);
        if ~isempty(ii),
            display(class2useTB(classcount))
            %keyboard
            %for num = 1:10:min([length(ii),150]),
             for num = 1:25:length(ii),
                subnum = subnum + 1;
                x = 5; y = 5;
                subplot(x,y,subnum)
                roi_id = ['roi0.' num2str(roinum(ii(num),1), '%010.0f') '.tif'];
                img = imread([roibase filesep hstr filesep roi_id]);
                if classcount < length(class2useTB),
                    imshow(img), title([char(roi_id) '; score = ' num2str(TBscores(ii(num),classcount), '%.2f')], 'interpreter', 'none')
                else
                    imshow(img), title([char(roi_id)], 'interpreter', 'none')
                end;
                if subnum == min(x*y,length(ii)),
                    pause
                    clf
                    subnum = 0;
                end;
            end;
        end;
        clf
        subnum = 0;
    end;
end;
