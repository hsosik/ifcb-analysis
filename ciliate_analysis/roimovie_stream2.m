%roipath = 'C:\work\IFCB\ifcb_data_MVCO_jun06\IFCB1_2008_196\';
%adcpath = 'C:\work\IFCB\ifcb_data_MVCO_jun06\IFCB1_2008_196\';

%roipath = 'C:\work\IFCB\ifcb_data_MVCO_jun06\IFCB1_2008_050\';
%adcpath = 'C:\work\IFCB\ifcb_data_MVCO_jun06\IFCB1_2008_050\';

%roipath = '\\cheese\J_IFCB\ifcb_data_MVCO_jun06\IFCB1_2010_001\';
%adcpath = roipath;

roipath= '/Users/markmiller/Documents/Experiments/IFCB_9/Dock_Samples/5-15-13/data/'

%roipath = '\\demi\ifcbnew\IFCB5_2012_024\'; %file 2
%roipath = '\\demi\ifcbnew\IFCB5_2012_045\'; %file 49
%IFCB5_2012_045_185612
adcpath = roipath;

filelist = dir([roipath '*.roi']);
close all
figure;
colormap(gray)
%winsize = get(fig1,'position');
%winsize = [winsize(1) winsize(2)-300 winsize(3)*1.5 winsize(4)*1.5];
%set(fig1,'position',winsize)
%winsize(1:2) = [0 0] ;

%set(fig1,'NextPlot','replacechildren');
%set(0,'screenp',96)
set(gcf,'color',[1 1 1])
set(gcf,'renderer','painters')
set(gcf,'renderermode','manual')
%set(gcf,'position',[350 215 560*2 420*2]) 
%set(gcf,'position',[-3          39        1600        1092]) %maximized for beans
%set(gcf, 'position', [350 50 600 800])
set(gcf, 'position', [350 50 800 600])
for filecount = 1:1, %2:2; %length(filelist),
    filename = filelist(filecount).name;
    disp(filename)
    
    warning off
    %aviobj = avifile([moviepath2 'fcb_test'], 'quality', 75, 'fps', 24);  %initialize movie file
    writerObj = VideoWriter([filename(1:end-4) 'F']); 
    writerObj.FrameRate = 7; 
    open(writerObj)  
% %    aviobj = avifile([roipath filename(1:end-4)], 'compression', 'cinepak', 'quality', 100, 'fps', 1);  %initialize movie file
%     aviobj = avifile([filename(1:end-4)], 'compression', 'none', 'quality', 100, 'fps', 3);  %initialize movie file
    adcdata = load([adcpath filename(1:end-4) '.adc']);
    fid=fopen([roipath filename]);
    startbyte = adcdata(:,18);
%    xsize = adcdata(:,12);
%    ysize = adcdata(:,13);
    sizes = adcdata(:,16:17);
    pos = adcdata(:,14:15);

    totalrois = size(adcdata,1);
    Mcount = 1;
    figure(1),clf
    holdnum = 10;
    holdcount = 1;
    for imgcount = 1:totalrois,
        
        position = startbyte(imgcount);
        fseek(fid, position, -1);
        img = fread(fid, sizes(imgcount,1).*sizes(imgcount,2), 'uint8=>uint8');
        img = reshape(img, sizes(imgcount,1), sizes(imgcount,2));  
        figure(1), hold on, 
        if imgcount < 0% > 1,
            if ~(adcdata(imgcount,1) == adcdata(imgcount-1,1)),
                if exist('ih', 'var'), delete(ih), clear ih, end; if exist('ih2', 'var'), delete(ih2), clear ih2, end;
            else
                if exist('ih', 'var'), ih2 = ih; end;
            end; %only clear if not double roi in same frame
        end;
%        ih(holdcount) = imagesc(img, 'xdata', [round(pos(imgcount,2)), round(pos(imgcount,2))+ sizes(imgcount,2)], 'ydata', [round(pos(imgcount,1)), round(pos(imgcount,1))+ sizes(imgcount,1)]);
        ih(holdcount) = imagesc(img', 'ydata', [round(pos(imgcount,2)), round(pos(imgcount,2))+ sizes(imgcount,2)], 'xdata', [round(pos(imgcount,1)), round(pos(imgcount,1))+ sizes(imgcount,1)]);
        
        caxis([0 255])
        set(gca, 'visible', 'off')
        xlabel([num2str(imgcount) ' of ' num2str(totalrois)])
        axis([0 1400 0 1400])
        set(gca, 'ydir', 'norm', 'units', 'pixels')
        %set(gca, 'position', [-100 0 800 800])  %this puts the field somewhat off center...change later if stream in center
        set(gca, 'position', [0 0 800 800], 'xdir', 'rev')  %
        axis square
        %set(gcf, 'color', [.8 .8 .8])
        set(gcf, 'color', 'k')
        %axis
        M(Mcount) = getframe(gcf);
        %delete(ih)
        if holdcount <= holdnum,
            holdcount = holdcount + 1;
        else
            delete(ih(1))
            ih(1) = []; 
        end;
        
        Mcount = Mcount + 1;
        %keyboard
        if Mcount == 51,
            disp(['Adding frames...' num2str(imgcount) ' of ' num2str(totalrois)])    
            %aviobj = addframe(aviobj, M);  %add to movie file
            writeVideo(writerObj,M);
            clear M
            Mcount = 1;
        end;
        %M(count) = im2frame(img,colormap);
    end;
    %aviobj = close(aviobj)
    close(writerObj)
    clear M
end;
