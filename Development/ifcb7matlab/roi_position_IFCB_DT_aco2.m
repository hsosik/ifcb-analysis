%   % to show collages of images of chosen points on a plot of ChC vs ChA integrated values from analog board
% trigger and ChA are from one PMT and ChC is from the other

% fid=fopen([path file '.roi']); fseek(fid, 1, -1); hist(data,256); axis([1 256 0 inf])  % to look at hist of pixel intensities for all rois

linearplot = 0 %0 for log plotting, 1 for linear
lowgain = 1%0%1; %set to 0 for plotting highgain, 1 for lowgain
show_non_roi_triggers = 1;%0
screen = get(0, 'ScreenSize');
width = screen(3);
height = screen(4); %turtlescreen = [1 1 1400 1050]; pos on turtle = [190 -7 1330 976];

Ch2_lowgain_offset = -.4; %for log plotting, to avoid negative values
PMTA_offset = -.4;
Ch2_highgain_offset = -.4;
PMTB_offset = -.4;

first = 0;
while 1
    if first == 1
        pause
        
        
    end
    first = 1;
    new_file = input('New file? [ENTER(default=n) or y]','s');
    all_signals = input('Use all signals? [ENTER(default=n) or y]','s');
    %         if strmatch(all_signals, 'y')
    %             all_signals = 1;
    %         else
    %             all_signals = 0;
    %         end
    numbering = input('label each roi number? [ENTER(default=n) or y]','s');
    pmts3 = input('3 PMTs (plot chl vs green fluor}? [ENTER(default=n) or y]','s');
    file_chosen = 0;
    if strmatch(new_file,'y','exact'); %if data has been read already (reprocess=1), don't re-read
        %                 [file path] = uigetfile('\\128.128.111.147\IFCB9_data\*.roi'); %ifcb5 -- all data is in data subdirectory
        %        [file path] = uigetfile('\\128.128.108.90\data\D20120426*.roi'); %ifcb7 -- all data is in data subdirectory
        %        [file path] = uigetfile('\\128.128.108.90\data\D20120*.roi'); %ifcb7 -- all data is in data subdirectory
        %         [file path] = uigetfile('\\128.128.108.51\data\D20120*.roi'); %ifcb10
        %          [file path] = uigetfile('\\128.128.108.82\data\D20120711*.roi'); %ifcb11
        %          [file path] = uigetfile('\\128.128.108.82\data\beads\D20120615*'); %ifcb10 -- all data is in data subdirectory
        %        [file path] = uigetfile('\\128.128.111.247\data\*.roi'); %ifcb7 -- all data is in data subdirectory
        %        [file path] = uigetfile('C:\IFCB7\data\D20120503*.roi');
        %        [file path] = uigetfile('C:\IFCB7\data\D20140331*.roi');
        %
        %        [file path] = uigetfile('\\128.128.111.147\data\D20141213T*.roi');
        %        [file path] = uigetfile('C:\rob\proposals\ImageBasedSorting_with_EmulsionMicrofluidics\AcousticFocusing\data\D20141226*.roi');
        %        [file path] = uigetfile('\\128.128.109.65\data\D201404*.adc');
        [file path] = uigetfile('C:\AcousticFocusingWHOI\data\D20150505*.aco');
        %        [file path] = uigetfile('\\128.128.110.213\data\D20140319*.roi');%ifcb101 with WHOI spare computer
        %        [file path] = uigetfile('\\smb:\\mellon.whoi.edu\ifcb/ifcb101\D2014*.roi');%ifcb101 with WHOI spare computer
        
        %        [file path] = uigetfile('C:\rob\proposals\ImageBasedSorting_with_EmulsionMicrofluidics\AcousticFocusing\data\D201402*.roi');%focusing tests from ifcb9
        %        [file path] = uigetfile('C:\rob\proposals\NSF_Grazers\2014\D201*.roi');
        
        %        [file path] = uigetfile('\\128.128.108.248\data\D201402*.roi'); %ifcb10(?) in MikeB lab
        %        [file path] = uigetfile('C:\rob\proposals\MRI_2013_IFCB_WaveGlider\data\*.roi');
        
        %        [file path] = uigetfile('\\128.128.108.248\data\D201302*.roi'); %ifcb12
        %        [file path] = uigetfile('\\128.128.108.248\data\D2013*.roi'); %ifcb9 -- all data is in data subdirectory
        %        [file path] = uigetfile('\\128.128.108.248\data\D*.roi'); %ifcb9 -- all data is in data subdirectory
        %        [file path] = uigetfile('C:\IFCB7\data\D2012*.roi'); %ifcb9 -- all data is in data subdirectory
        %         [file path] = uigetfile('\\128.128.110.88\data\IFCB*.roi'); %ifcb5 -- all data is in data subdirectory
        %         [file path] = uigetfile('\\128.128.108.248\data\D2013*.roi'); %ifcb5 -- all data is in data subdirectory
        %         [file path] = uigetfile('\\128.128.108.51\data\D20130*.roi'); %ifcb10 -- all data is in data subdirectory
        %         [file path] = uigetfile('\\128.128.109.65\data\D201*.roi'); %ifcb13 -- all data is in data subdirectory
        %        [file path] = uigetfile('J:\ifcb13\data\D20130325T*.roi'); %ifcb13 -- all data is in data subdirectory
        %         [file path] = uigetfile('C:\IFCB7\data\Tara\beads\*.roi');
        %         [file path] = uigetfile('\\128.128.108.214\data\D2013*.roi'); %ifcb14 -- all data is in data subdirectory
        %         [file path] = uigetfile('\\128.128.108.214\data\D20130*.roi'); %ifcb5 -- all data is in data subdirectory
        %         [file path] = uigetfile('H:\Hshared_to_write\tempdata2\D2013*.roi'); %ifcb5 -- all data is in data subdirectory
        %         [file path] = uigetfile('C:\IFCB7\data\D2013*.roi'); %ifcb5 -- all data is in data subdirectory
        %         [file path] = uigetfile('C:\IFCB7\data\*_IFCB011.roi');
        %         [file path] = uigetfile('\\128.128.108.51\data\D2012*.roi'); %ifcb5 -- all data is in data subdirectory
        
        %         [file path] = uigetfile('\\128.128.110.139\data\*.roi'); %ifcb13012-01 (McLane's first) at WHOI
        
        %         [file path] = uigetfile('W:\D2013\D20130505\*.roi'); %mellon\saltpond
        %         [file path] = uigetfile('\\Mellon\saltpond\D2012\*.roi'); %ifcb5 -- all data is in data subdirectory
        
        %         [file path] = uigetfile('W:\D2012\D20120616\*.roi'); %ifcb5 -- all data is in data subdirectory
        %
        %         [file path] = uigetfile('C:\rob\proposals\AccessToTheSea2011\data\D*.roi'); %ifcb5 -- all data is in data subdirectory
        %         [file path] = uigetfile('IFCB9_co?n*.roi'); %ifcb5 -- all data is in data subdirectory
        %         [file path] = uigetfile('C:\IFCB7\pico6\data\IFCB9\VB_data\IFCB*.roi'); %ifcb5 -- all data is in data subdirectory
        %                  [file path] = uigetfile('\\72.72.77.26\data\beads\*.roi'); %ifcb5 -- all data is in data subdirectory
        %         [file path] = uigetfile('C:\IFCB1\ifcb_data_mvco_jun06\beads\*.roi'); %ifcb5 -- all data is in data subdirectory
        %                  [file path] = uigetfile('c:\IFCB7\data\D20140331*.roi');
        %                  [file path] = uigetfile('\\128.128.109.65\data\D201404*.adc'); %ifcb13 with no camera
        
        %                  [file path] = uigetfile('\\128.128.110.139\data\D201404*.adc'); %ifcb10 with no camera
        %                  [file path] = uigetfile('C:\ifcb7\IFCB_style_FCB\data\D201404*.adc');
        
        %                  [file path] = uigetfile('C:\ifcb7\data\*.adc'); %
        %                  [file path] = uigetfile('\\128.128.108.51\data\D201404*.adc'); %ifcb10 with no camera
        %                  [file path] = uigetfile('C:\ifcb7\IFCB_style_FCB\data\D201404*.adc'); %ifcb10 with no camera
        %                  [file path] = uigetfile('C:\ifcb7\data\D201503*.adc'); %ifcb10 with no camera
        
        %                 \\sosiknas1\Lab_data\IFCB_forVehicles\IFCB102
        file = file(1:findstr(file, '.')-1);
        disp(file)
        fname = [path file '.adc'];
        hdrname = [fname(1:end-3) 'hdr'];
        adcdata = load(fname);
        % % %         if  adcdata(1+floor(size(adcdata,1)/2),18) == 0
        % % %             adcdata = adcdata(1:size(adcdata,1)/2,:); %to deal with bug in Martin's software, which repeats adcdata...
        % % %         end
        %for IFCB1 through IFCB6, adcdata have the following format:
        % %adcdata: 1 = nProcessingCount
        %           2 = ADCtime
        %           3 = pmtA int% pmtA low gain
        %           4 = pmtB int%pmtA high gain
        %           5 = ???pmtC low gain
        %           6 = ???pmtC high gain
        %           7 = duration of comparator pulse
        %           8 = GrabtimeStart
        %           9 = GrabtimeEnd
        %           10 = x position
        %           11 = y position
        %           12 = roiSizeX
        %           13 = roiSizeY
        %           14 = StartByte
        %for IFCB7 on, peak values were added (and high/low gain no longer), so adcdata have the following format:
        % %adcdata: 1 = nProcessingCount
        %           2 = ADCtime  ( = same as GrabtimeStart...)
        %           3 = pmtA int (scattering)
        %           4 = pmtB int (fluorescence)
        %           5 = pmtC int
        %           6 = pmtD int
        %           7 = pmtA peak
        %           8 = pmtB peak
        %           9 = pmtC peak
        %           10 = pmtD peak
        %           11 = duration of comparator pulse
        %           12 = GrabtimeStart (= TriggerTickCount - StartTickCount).  TriggerTickCount = tick count when the camera callback occurred
        %                               (when the camera is ready for a new trigger)
        %           13 = GrabtimeEnd   (= GetTickCount() - StartTickCount , just before rearming trigger.
        %           14 = x position
        %           15 = y position
        %           16 = roiSizeX
        %           17 = roiSizeY
        %           18 = StartByte
        
        dotpos = findstr(fname,'.'); dotpos = dotpos(end);
        slashpos = findstr(fname,'\'); slashpos = slashpos(end);
        %         instr_num = fname(slashpos+5);
        instr_num = str2num(fname(dotpos-3:dotpos-1));
        %         if str2num(instr_num)>6 | str2num(instr_num)==0 % new IFCBs using Martin's software
        xsize = adcdata(:,16);  ysize = adcdata(:,17); startbyte = adcdata(:,18);
        peakA = adcdata(:,7); peakB = adcdata(:,8); peakC = adcdata(:,9); peakD = adcdata(:,10);
        xpos = adcdata(:,14); ypos = adcdata(:,15); PMTA = adcdata(:,3); PMTB = adcdata(:,4); PMTC = adcdata(:,5); PMTD = adcdata(:,6);
        GrabtimeStart = adcdata(:,12); GrabtimeEnd = adcdata(:,13);
        %         else
        %             xsize = adcdata(:,12);  ysize = adcdata(:,13); startbyte = adcdata(:,14);
        %             xpos = adcdata(:,10); ypos = adcdata(:,11); PMTA_low = -adcdata(:,3); PMTC_low = -adcdata(:,5);
        %             PMTA = -adcdata(:,4); PMTB = -adcdata(:,6); % (high gain) A=chl, B=ssc, opposite new IFCBs
        %             GrabtimeStart = adcdata(:,8); GrabtimeEnd = adcdata(:,9);
        %         end
    end
    %     disp(file)
    %     keyboard
    hdr = IFCBxxx_readhdr_acoustic([path file '.hdr']);
    %     hdrfilename(i) = {hdrdir(i).name};
    fastfactor = hdr.RunFastFactor; if fastfactor == 0, fastfactor = 1; end
    if ~isfield(hdr, 'runSampleFast') %if it doesn't exist in hdr, set it here
        hdr.runSampleFast = 0;
    end
    runSampleFast = hdr.runSampleFast;
    samplevol = hdr.SyringeSampleVolume;
    fluidsActive = 1;%hdr.fluidsActive;
    if runSampleFast > 0
        flowrate = 0.25 * fastfactor; % ml/min
    else flowrate = 0.25;
    end
    %     lasttriggertime = 60*samplevol/flowrate %sec to last trigger
    runtime = hdr.runtime;
    inhibittime = hdr.inhibittime;
    %     fluidicsActive = 0; % special case for testing with no camera
    sec2event2 = adcdata(2,2);
    %     ml_analyzed = IFCB_volume_analyzed_Rob2([path file '.hdr'], sec2event2, fluidsActive)
    ml_analyzed = IFCB_volume_analyzed_Rob2([path file '.hdr'], fluidsActive)
    numtriggers = length(unique(adcdata(:,1)));
    cellconc = numtriggers/ml_analyzed;
    disp(['runSampleFast  = ' num2str(runSampleFast)])
    disp(['fastfactor  = ' num2str(fastfactor)])
    disp(['sec2event2  = ' num2str(sec2event2)])
    disp(['flowrate  = ' num2str(flowrate)])
    disp(['samplevol  = ' num2str(samplevol)])
    disp(['runtime  = ' num2str(runtime)])
    disp(['inhibittime  = ' num2str(inhibittime)])
    disp(['ml_analyzed  = ' num2str(ml_analyzed)])
    disp(['numtriggers  = ' num2str(numtriggers)])
    disp(['cellconc  = ' num2str(cellconc)])
    
    y2plot = PMTB; ylab = 'PMT B';
    x2plot = PMTA; xlab = 'PMT A';
    if strmatch(pmts3,'y','exact');
        x2plot = PMTB; xlab = 'PMT B';
        y2plot = PMTC; ylab = 'PMT C';
    end
    %     x2plot(find(x2plot<=0)) = NaN;  %get rid of -9.997's -- why are they present?
    %     y2plot(find(y2plot<=0)) = NaN;
    dur_plot = 'n';
    dur_plot = input('plot signal duration rather than SSC? [ENTER(default=n) or y]  ','s');
    if strmatch(dur_plot,'y','exact');
        dur = -adcdata(:,7);
        x2plot = dur;
        xlab = 'duration (V)';
    end
    plot_roi_gray = input('plot roi_gray (mean pixel intensities)? [ENTER(default=n) or y]  ','s');
    
    close all
    %     h1 = figure(1); set(h1,'position',[10 10 1380/1.5 1038/1.5])
    h1 = figure(1); set(h1,'position',[10 10 1380/1.1 1038/1.1])
    axis square
    
    tind = find(xsize==0);
    xmax = max(x2plot);%(isinlessthanmax));
    ymax = max(y2plot);%(isinlessthanmax));
    
    if linearplot==1,
        plot(x2plot,y2plot,'.'); %axis([-.1 1.5 0 10])
        hold on
        if show_non_roi_triggers
            plot(x2plot(tind),y2plot(tind),'r.');
        end
    else
        loglog(x2plot,y2plot,'.');
        %         loglog(x2plot(xsize>0),y2plot(ysize>0),'.'); % don't show odd-looking correlated signals with no rois
        hold on
        if show_non_roi_triggers
            loglog(x2plot(tind),y2plot(tind),'r.');
        end
    end
    if ~isnan(ymax)
        axis([0 abs(xmax) 0 abs(ymax)])
    end
    %     axis([0 1    0 1]); disp('axis restricted for testing')
    set(gca,'fontname','times','fontsize',18);
    xlabel(xlab, 'fontsize',18); ylabel(ylab, 'fontsize',18);
    if strmatch(all_signals,'y','exact'); % to do all the points without drawing poly
        xpoly = [min(x2plot); max(x2plot); max(x2plot); min(x2plot)];
        ypoly = [min(y2plot); min(y2plot); max(y2plot); max(y2plot)];
    else
        commandwindow
        new_window = input('draw a new window? [ENTER(default=n) or y]  ','s');
        if strmatch(new_window,'y','exact');
            [xpoly,ypoly] = ginput; %choose a region to see images of
            %eval(['print -dpng c:\rob\AGU2004IFCB\sscchl_' file])
            %save chaetpoly xpoly ypoly
            isin = find(isinpoly(x2plot, y2plot, xpoly, ypoly));
            isin_orig = isin;
        end
    end
    hold on
    p = plot([xpoly; xpoly(1)], [ypoly; ypoly(1)], 'r', 'linewidth', 4);
    hold off
    pause%(.5)
    commandwindow; %set(gcf, 'visible','off')  %to show command line screen again...
    
    %test to see if roi pos affects focus of images
    roipos_focus = input('see images from a region of roipos? [ENTER(default=n) or y]  ','s');
    if strmatch(roipos_focus,'y','exact');
        figure(97); plot(xpos,ypos,'.r');hold on; xlabel('xpos'); ylabel('ypos'); axis([0 1400 0 1040])
        [xpoly,ypoly] = ginput; %choose a region to see images of
        p2 = plot([xpoly; xpoly(1)], [ypoly; ypoly(1)], 'r', 'linewidth', 4);
        isin2 = isin;
        isin = intersect(isin2,find(isinpoly(xpos, ypos, xpoly, ypoly)));
    else
        if strmatch(dur_plot,'y','exact');
            isin = find(isinpoly(dur, y2plot, xpoly, ypoly));
        else
            %             keyboard
            isin = find(isinpoly(x2plot, y2plot, xpoly, ypoly));
        end
    end
    
    time = adcdata(:,2);
    data_choosing1 = input('use only initial third of data? [ENTER(default=n) or y]  ','s');
    ind13 = find(time<time(round(length(time)*(1/3))));
    ind23 = find(time>time(round(length(time)*(1/3))) & time<time(round(length(time)*(2/3))))
    ind33 = find(time>time(round(length(time)*(2/3))));
    if strmatch(data_choosing1,'y','exact');
        isin = intersect(isin_orig,ind13);
    end
    data_choosing2 = input('use only middle third of data? [ENTER(default=n) or y]  ','s');
    if strmatch(data_choosing2,'y','exact');
        isin = intersect(isin_orig,ind23);
    end
    data_choosing3 = input('use only final third of data? [ENTER(default=n) or y]  ','s');
    if strmatch(data_choosing3,'y','exact');
        isin = intersect(isin_orig,ind33);
    end
    
    CVplots = input('plot image positions and signal distributions? [ENTER(default=n) or y]  ','s');
    if strmatch(CVplots,'y','exact')%CVplots == 1
        h96 = figure(96);
        set(h96,'position',[width*0 height*0.1 width*.8 height*.85])
        subplot(121)
        toplot = PMTA; lab = 'Integrated A';
        [CV] = func_findCV(toplot, isin, file, lab);
        subplot(122)
        toplot = PMTB; lab = 'Integrated B';
        [CV] = func_findCV(toplot, isin, file, lab);
        pause
        if (instr_num)>6  % new IFCBs using Martin's software
            h95 = figure(95);
            set(h95,'position',[width*0 height*0.1 width*.8 height*.85])
            subplot(121)
            toplot = peakA; lab = 'Peak A';
            [CV] = func_findCV(toplot, isin, file, lab);
            subplot(122)
            toplot = peakB; lab = 'Peak B';
            [CV] = func_findCV(toplot, isin, file, lab);
            pause
            figure(103); plot(peakB(isin), ypos(isin), '.b');hold on; ylabel('ypos'); xlabel('peak B');axis([0 max(peakB(isin)) 0 1030])
            figure(104); plot(peakA(isin), ypos(isin), '.b');hold on; ylabel('ypos'); xlabel('peak A');axis([0 max(peakA(isin)) 0 1030])
        end
        figure(97); plot(xpos(isin),ypos(isin),'.r');hold on; xlabel('xpos'); ylabel('ypos'); axis([0 1400 0 1040])
        figure(101); plot(PMTB(isin), ypos(isin), '.b');hold on; ylabel('ypos'); xlabel('PMT B');axis([0 max(PMTB(isin)) 0 1030])
        figure(102); plot(PMTA(isin), ypos(isin), '.b');hold on; ylabel('ypos'); xlabel('PMT A');axis([0 max(PMTA(isin)) 0 1030])
        pause
    end
    
    figure(103)
    
    %     modeYpos = mode(ypos(intersect(isin(ypos(isin)>0),isin(ypos(isin)>0))))
    fit=createFit2(ypos(isin))
    ysorted=sort(ypos(isin));
    length1=length(ypos(isin));
    lower5=ysorted(round(length1*0.05))
    upper95=ysorted(round(length1*0.95))
    width90 = upper95-lower5;
    axis([0 1034 0 inf])
    xlabel('roi Y position (pixel)')
    %     title(file,'interpreter','none')
    legend('off')
    t=title([file '  : Sample rate = 2.5 ml/min, Field = 40 V']); set(t, 'interpreter','none')
    
    figure(104)
    plot(adcdata(isin(2:end),2),ypos(isin(2:end)),'.')
    axis([0 inf 0 1030])
    title(file,'interpreter','none','fontsize',18)
    xlabel('Time (s)')
    ylabel('roi Y position (pixel)')
    eval(['print -dpng ' path file '_scan'])
    
    disp(['call read_resonance_control_files5.m, to look at roipos as a function of frequency'])
    read_resonance_control_files5
    
    % from calc_width_90.m --- get the width of ypos of central 90% of points
    % for each time bin during frequency scan
    numbins = 10; %~450 sec divided into 10 bins
    win = max(time) * 1/numbins;
    startbin = 0;%win*max(time);
    timebin = startbin;
    loop = mean(diff(ms));
    ms2 = (ms-ms(1));
    for bincount = 1:numbins,
        ind = find(time > timebin & time <= timebin + win);
        time_bin(bincount) = timebin + win/2;
        if ~isempty(ind),            
            ysorted = sort(ypos(ind));
            length1 = length(ypos(ind));
            lower5 = ysorted(round(length1*0.05));
            upper95 = ysorted(round(length1*0.95));
            width90 = upper95-lower5;
            ypos_ind = ypos(ind);
        end
        width90_bin(bincount) = width90;
        freq_bin(bincount) = mean(freq(intersect(find((ms-ms(1))<(time_bin(bincount))*1000+loop), find((ms-ms(1))>(time_bin(bincount))*1000-loop)))./1e6);
        timebin = timebin + win;
    end
    figure(106)
    plot(time_bin, width90_bin, '-o')
    axis([0 inf 0 1034])
    xlabel('Time (s)')
    ylabel('roiYpos width (90%)')
    
    ax1_pos = get(ax1, 'Position'); % position of first axes
    ax2 = axes;
    set(ax2, 'fontsize',18);
    set(ax2,'XAxisLocation','top','YAxisLocation','right')
    set(ax2,'color','none')
    hold on
    h2 = plot(ax2, freq_bin, width90_bin, 'Parent', ax2, 'Color', 'k','linewidth',3);
%     keyboard
%     h2 = plot(ax2, (ms(:)-ms(1))./1000, freq./1e6, 'Parent', ax2, 'Color', 'k','linewidth',3);
set(gca,'xlim',[freq(1), freq(end)])
    figure(107)
      [pAx, pLine1, pLine2] = plotyy(width90_bin, time_bin, width90_bin, freq_bin);
      set(pAx(1),'ylim',[time(2) time(end)]); 
      set(pAx(2),'ylim',[freq(1)/1e6 freq(end)/1e6]);
      best = find((width90_bin==min(width90_bin)));
      xlabel('Width of distribution of central 90% of roiYpos  ')
      set(pAx(1),'xlim',[0 1034])
      set(pAx(2),'xlim',[0 1034])
      ylabel(pAx(1),'Time (s)')
      ylabel(pAx(2),'Frequency (MHz)')
      title([file '    ' 'freq = ' num2str(freq_bin(best)) ' MHz;   time = ' num2str(time_bin(best)) ' s'])
      textfile2 = [file '.ac2'];
      eval(['print -dpng ' textpath textfile(1:end-4) '_ac2'])

     
    
%     % get freq from time
%     loop = mean(diff(ms));
%     ms2 = (ms-ms(1));
%     f_bincount = freq(intersect(find((ms-ms(1))<(time_bin(bincount))*1000+loop), find((ms-ms(1))>(time_bin(bincount))*1000-loop)))./1e6; 
%     
%     keyboard
    
    imgnum = adcdata(:,1);
    screen = get(0, 'ScreenSize');
    width = screen(3);
    height = screen(4); %turtlescreen = [1 1 1400 1050]; pos on turtle = [190 -7 1330 976];
    x0 = width*.01; y0 = height*.5; rbwd = width*.08; rbht = height*.0190;
    fid=fopen([path file '.roi']);
    warning off
    startroi = 0;
    camx = 1380;
    camy = 1034;  %camera image size
    xcum = 0; ycum = 0;
    yrowmax = 0; x=0; y=0;
    count=1;
    border = 3; %to separate images
    newpageflag = 0;
    %    h2=figure;
    set(h1, 'visible','on') % make initial dotplot visible again
    h2 = figure(2); clf
    set(h2,'position',[width*0 height*0.1 width*.8 height*.85])
    colormap(gray);
    set(gcf,'color', [1 1 1]);
    %toobigflag=0; %rob 28Jun07
    count = 0; pagefull = 0; rownum = 1; newrow = 1; yrowmaxall=[]; roi_gray = [];
    %     while pagefull < 1 & count < length(startbyte)-1
    %keyboard
    %while pagefull < 1 & count < length(startbyte)-1 & count < length(isin)
    while pagefull < 1 & count < length(startbyte) & count < length(isin) % with "count < length(startbyte)-1", it doesn't do last roi (e.g., IFCB2_2009_284_221426)
        count = count + 1;
        if count >= length(startbyte), pagefull=1; end % so the last page of images is shown
        %if count >= length(startbyte)-1, pagefull=1; end % so the last page of images is shown
        %         if count >= length(isin)-1, pagefull=1; end % so the last page of images is shown
        if newpageflag == 1,
            newpageflag = 0; xcum = 0; ycum = 0; yrowmax = 0;
        end % to avoid skipping an image when the new image is too big to fit on the same page...
        %         keyboard
        position = startbyte(isin(count)); %sum(xsize(1:test-1) .* ysize(1:test-1));
        fseek(fid, position, -1);
        data = fread(fid, xsize(isin(count)).*ysize(isin(count)), 'ubit8');
        imagedat = reshape(data, xsize(isin(count)), ysize(isin(count)));
        x = size(imagedat,1); y = size(imagedat,2);
        if strmatch(plot_roi_gray,'y','exact')
            roi_gray = [roi_gray; mean(mean(imagedat))];
        end
        
        %         if count==16
        %             keyboard
        %         end%show_roi_in_fov, end;  %
        
        %if isin(count)==1609, keyboard, end %testing - rob
        if ycum + y <= camy & xcum + x <= camx, %stay on same page and same row
            h = imagesc(imagedat', 'xdata', [xcum+border xcum+x], 'ydata', [ycum+border ycum+y]); colormap(gray); shading flat; hold on; axis([1 1380 1 1034]);
            %             h = image(imagedat', 'xdata', [xcum+border xcum+x], 'ydata', [ycum+border ycum+y]);% colormap(gray); shading flat; hold on; axis([1 1380 1 1034]);
            %             keyboard
            %             num = isin(count);
            if strmatch(numbering,'y','exact') & x > 0  % don't put numbers for non-existent rois
                text(xcum+border,ycum+border,num2str(isin(count)))  %label each image
            end
            xcum = xcum + x;
            temp = [get(h,'xdata') get(h,'ydata')];
            if y > yrowmax, yrowmax = y; end
        elseif ycum + y <= camy & xcum + x > camx, %stay on same page but make new row
            xcum = 0;
            ycum = ycum + yrowmax;
            yrowmax = y;  %added March 27, 2007 - avoids wide subsequent rows after big roi
            if ycum +y > camy,
                
                pause %to stop at the end of each page of images
                %                h2=figure;
                h2 = figure(2); clf
                set(h2,'position',[width*0 height*0.1 width*.8 height*.85])
                colormap(gray);
                set(gcf,'color', [1 1 1]);
                delete(gca)
                startroi = count;% - 1;
                newpageflag = 1;
                yrowmax=y;
            end
            if newpageflag == 0
                h = imagesc(imagedat', 'xdata', [xcum+border xcum+x], 'ydata', [ycum+border ycum+y]); colormap(gray); shading flat; hold on; axis([1 1380 1 1034]);
                %                 h = image(imagedat', 'xdata', [xcum+border xcum+x], 'ydata', [ycum+border ycum+y]); colormap(gray); shading flat; hold on; axis([1 1380 1 1034]);
                %                 h = image(imagedat', 'xdata', [xcum+border xcum+x], 'ydata', [ycum+border ycum+y]); colormap(gray); shading flat; hold on; axis([1 1380 1 1034]);
                %set(gca,'position',[xpos/1378 1-(ypos/1012+size(imagedat,1)/1012) size(imagedat,2)/1378 size(imagedat,1)/1012])
                if strmatch(numbering,'y','exact')
                    text(xcum+border,ycum+border,num2str(isin(count)))  %label each image
                end
                %                 keyboard
                xcum = xcum + x;
                temp = [get(h,'xdata') get(h,'ydata')];
                if y > yrowmax, yrowmax = y; end
            end
            title(file,'interpreter','none')
        else % go to new page
            title(file,'interpreter','none')
            
            
            pause %to stop at the end of each page of images
            delete(gca)
            startroi = count;% - 1;
            newpageflag = 1;
            %             if y+ycum>=camy | x+xcum>=camx %rob 28Jun07
            %                 toobigflag=1;
            %             end
            count = count - 1;
        end
    end
    fclose(fid)
    if plot_roi_gray
        figure(999)
        clf
        hist(roi_gray,256)
        xlabel('mean pixel intensity of rois')
        ylabel('frequency')
        ti=title([file])
    end
end

%to print a page...
%eval(['print -dpng ' path file '.png'])

% to look at roi pos vs time for acoustic concentration testing...

