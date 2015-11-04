classpath = '\\sosiknas1\Lab_data\VPR\NBP1201\vpr8\class_RossSea_Trees_30Oct2015_six_classes\';
roibase = '\\SOSIKNAS1\Lab_data\VPR\NBP1201\rois\vpr8\d018\';
subnum = 0;
filelist = dir([classpath '*.mat']);
for filecount = 1:length(filelist),
    fname = filelist(filecount).name;
    display(fname)
    load([classpath fname])
    hstr = fname(5:7);
    [~,TBclass_num] = ismember(TBclass,class2useTB) ;
    %[~,TBclass_num] = ismember(TBclass_above_threshold,class2useTB) ;
    for classcount = 1:length(class2useTB),
        ii = find(TBclass_num == classcount);
        if ~isempty(ii),
            display(class2useTB(classcount))
            %keyboard
            for num = 1:10:min([length(ii),150]),
             %for num = 1:25:length(ii),
                subnum = subnum + 1;
                x = 5; y = 5;
                subplot(x,y,subnum)
                roi_id = ['roi0.' num2str(roinum(ii(num),1), '%010.0f') '.tif'];
                img = imread([roibase filesep hstr filesep roi_id]);
                %keyboard
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
