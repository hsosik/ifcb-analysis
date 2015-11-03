% roi_position_vs_signal_w_duration_4May10.m

%   % to show collages of images of chosen points on a plot of ChC vs ChA integrated values from analog board
% trigger and ChA are from one PMT and ChC is from the other 
clear all; %close all;

linearplot = 1 %0 for log plotting, 1 for linear
lowgainA = 1%1; %set to 0 for plotting highgain, 1 for lowgain
lowgainC = 1%1; %set to 0 for plotting highgain, 1 for lowgain

ChC_lowgain_offset = 0;%-.4; %for log plotting, to avoid negative values
ChA_lowgain_offset = 0;%-.4;
ChC_highgain_offset = 0;%-.4;
ChA_highgain_offset = 0;%-.4;

first = 0;
while 1
    if first == 1
        pause
    end
    first = 1;
    new_file = 'y';%input('New file? [ENTER(default=n) or y]','s');
    all_signals = input('Use all signals? [ENTER(default=n) or y]','s');
    numbering = input('label each roi number? [ENTER(default=n) or y]','s');
    file_chosen = 0;
    screen = get(0, 'ScreenSize');
    width = screen(3);
    height = screen(4); %turtlescreen = [1 1 1400 1050]; pos on turtle = [190 -7 1330 976];
%     x0 = width*.01; y0 = height*.5; rbwd = width*.08; rbht = height*.0190;

    if strmatch(new_file,'y','exact'); %if data has been read already (reprocess=1), don't re-read
%         [file path] = uigetfile('\\128.128.200.3\data\IFCB1_2011_*.roi'); %ifcb5 -- all data is in data subdirectory
%           [file path] = uigetfile('E:\IFCB1\*.roi');
%       [file path] = uigetfile('\\sosiknas1\IFCB_data\MVCO\data\2015\IFCB1_2015_212\*.roi');     %IFCB1 lab tests etc
% [file path] = uigetfile('C:\IFCB5\TestWell_10Oct14\*.roi');
% [file path] = uigetfile('\\128.128.108.203\data\IFCB1_2015*.roi'); %ifcb1 in lab-- all data is in data subdirectory

        [file path] = uigetfile('\\128.128.205.107\data\IFCB5_2015_3*.roi'); %ifcb5 -- all data is in data subdirectory
%         [file path] = uigetfile('\\sosiknas1\Lab_data\IFCB5\IFCB5_2015_*.roi'); %ifcb1 
%         [file path] = uigetfile('\\sosiknas1\IFCB_data\MVCO\data\2015\*.roi'); %ifcb in field
%         [file path] = uigetfile('\\sosiknas1\Instruments\ifcb5\IFCB5_2015_*.roi'); %ifcb1 

%                 [file path] = uigetfile('\\128.128.205.103\data\IFCB1_2015_21*.roi'); %ifcb1 in field 6june2014
%         [file path] = uigetfile('\\sosiknas1\Lab_data\IFCB1\IFCB1_2015*.roi'); %ifcb1 

%         uigetfile('\\128.128.108.102\data\IFCB5_2015_2*.roi'); %ifcb5 in lab
%         [file path] = uigetfile('\\demi\ifcbnew\IFCB5_2015_072\IFCB5_2015_*.roi'); 
%         [file path] = uigetfile('\\demi\ifcbnew\beads\IFCB5_2014_3**.roi'); 
        
%        [file path] = uigetfile('\\128.128.108.224\data\IFCB2_2013_*.roi'); %IFCB2 benchtop
%        [file path] = uigetfile('\\128.128.110.88\data\IFCB4_2014_*.roi'); %IFCB4 sorter

%       [file path] = uigetfile('\\Queenrose\Ditylum_temperature\data\*.roi'); %IFCB2 benchtop

%          [file path] = uigetfile('\\128.128.108.203\data\IFCB1_2014_*.roi'); %IFCB1 in lab
%         [file path] = uigetfile('\\128.128.108.102\data\IFCB*.roi'); %IFCB1 in lab
%          [file path] = uigetfile('\\128.128.110.139\data\*.roi'); %IFCB1 in lab
%        [file path] =  uigetfile('J:\IFCB\ifcb_data_MVCO_jun06\IFCB5_2013_326\IFCB5_2013_*.roi'); 
%       [file path] =  uigetfile('J:\IFCB\ifcb_data_MVCO_jun06\IFCB5_2014_112\*.roi'); 
% [file path] =  uigetfile('Z:\IFCB5_2014_175\*.roi'); 
%       [file path] =  uigetfile('J:\IFCB\ifcb_data_MVCO_jun06\beads\*.roi'); 
 %     [file path] = uigetfile('\\128.128.108.203\data\IFCB1_2014_*.roi'); %ifcb1 in lab
%              [file path] = uigetfile('\\128.128.110.88\data\IFCB4_2014_*.roi'); %IFCB4 sorter
%         [file path] = uigetfile('C:\ifcb\IFCB5_cellcounts4Ben_Jun2014\*.roi'); %cell counts for Ben - ifcb5 in lab

%         [file path] = uigetfile('J:\IFCB\DunNanno\beads\IFCB*.roi');
%         [file path] = uigetfile('D:\IFCB\lab_tests\IFCB1*.roi');
    %    [file path] = uigetfile('J:\IFCB\IFCB1_welltest_May2013\IFCB1_2013_*.roi');        %testwell
%           [file path] = uigetfile('J:\IFCB\lab_tests\IFCB1_2013_*.roi');      %    %tests in the lab
%     [file path] = uigetfile('C:\rob\proposals\ImageBasedSorting_with_EmulsionMicrofluidics\data\*.roi');      %

        file = file(1:findstr(file, '.')-1);
        disp(file)
        fname = [path file '.adc'];
        hdrname = [fname(1:end-3) 'hdr'];
        %dos(['notepad ' hdrname ' &']);

        adcdata = load(fname); xsize = adcdata(:,12);  ysize = adcdata(:,13); %x and y sizes of each image in streamed file, from vb_roi_...
        startbyte = adcdata(:,14);
    end
    disp(file)
    % %adcdata: 1 = nProcessingCount
    %           2 = ADCtime
    %           3 = pmtA low gain
    %           4 = pmtA high gain
    %           5 = pmtC low gain
    %           6 = pmtC high gain
    %           7 = duration of comparator pulse
    %           8 = GrabtimeStart
    %           9 = GrabtimeEnd
    %           10 = x position
    %           11 = y position
    %           12 = roiSizeX
    %           13 = roiSizeY
    %           14 = StartByte

    %%% adcdata(1) = ADCresults(0)
    %             'ADCresults(0)  = nProcessingCount
    %             'ADCresults(1)  = ADCtime
    %             'ADCresults(2)  = AD0 = analog channel A_lowgain_integrated
    %             'ADCresults(3)  = AD1 = analog channel A_highgain_integrated
    %             'ADCresults(4)  = AD2 = analog channel C_lowgain_integrated
    %             'ADCresults(5)  = AD3 = analog channel C_highgain_integrated
    %             '                 AD4 = TempAveV
    %             '                 AD5 = HumAveV
    %             '                 AD6 = ChAAve
    %             '                 AD7 = ChCAve
    %             'ADCresults(6)  = AD8 = duration of comparator pulse (now from B_low_int; prev. from daughter board)
    %             'ADCresults(7)  = GRABtimeStart
    %             'ADCresults(8)  = GRABtimeEnd
    %             'ADCresults(9)  = xmin
    %             'ADCresults(10) = ymin
    %             'ADCresults(11) = roiSizeX
    %             'ADCresults(12) = roiSizeY
    %             'ADCresults(13) = StartByte
    %             'ADCresults(14) = AD9 = solenoid V (comparator_out)
    %             'ADCresults(15) = AD10 = peak_detect_2_analog channel A
    %             'ADCresults(16) = AD11 = peak_detect_1_trigger
    %             'ADCresults(17) = AD12 = B_hi_int (also duration, but with different time constant)

    %     %for merging low/high gain data...
    %     plot(-adcdata(:,3), -adcdata(:,4),'.'); axis([-.1 1 0 10]); %inspect chl high vs low gain
    %     plot(-adcdata(:,5), -adcdata(:,6),'.') %inspect chl high vs low gain

%     chl_overlap_region = [.1 .2]; %low gain values where high vs low seems ok
%     ssc_overlap_region = [.02 .04]; %low gain values where high vs low seems ok
%     overlapind_chl = intersect(find(chl>chl_overlap_region(1)),find(chl<chl_overlap_region(2)));% to calculate merging for chl
%     overlapind_ssc = intersect(find(ssc>ssc_overlap_region(1)),find(ssc<ssc_overlap_region(2)));% to calculate merging for chl
%     chl_factor = mean(adcdata(overlapind_chl,4)./adcdata(overlapind_chl,3));
%     ssc_factor = mean(adcdata(overlapind_ssc,4)./adcdata(overlapind_ssc,3));
%     if isnan(chl_factor), chl_factor = 28; end
%     if isnan(ssc_factor), ssc_factor = 28; end
%     chl(find(chl<chl_overlap_region(2))) = -adcdata(find(chl<chl_overlap_region(2)),4)./chl_factor;
%     ssc(find(ssc<ssc_overlap_region(2))) = -adcdata(find(ssc<ssc_overlap_region(2)),6)./ssc_factor;
    xpos = adcdata(:,10);
    ypos = adcdata(:,11);
    ChA_lowgain = -adcdata(:,3);
    ChA_highgain = -adcdata(:,4);
    ChC_lowgain = -adcdata(:,5);
    ChC_highgain = -adcdata(:,6);
    %get volume analyzed
    negind = find(adcdata(:,8)<0);
    adcdata(negind,8) = adcdata(negind,8) + 24*60*60;
    negind = find(adcdata(:,9)<0);
    adcdata(negind,9) = adcdata(negind,9) + 24*60*60;
    adctime = adcdata(:,8:9)';
    
    if strmatch(file(5), '6')
        deadtime = .0862; % 72 ms estimate from IFCB4 test with fast triggers from function generator.
    elseif strmatch(file(5), '4')
        deadtime = .072; % 72 ms estimate from IFCB4 test with fast triggers from function generator.
    else deadtime = .072; % 72 ms estimate from IFCB4 test with fast triggers from function generator.
    end

        runtime = adcdata(end,9); %Heidi, added in place of earlier version after Rob fixed midnight crossing problem above
    longproc_ind = find(adcdata(2:end,8)-adcdata(1:end-1,9)>deadtime);
    %only use adcdata line once in cases with 2 or more rois each with new line
    [junk,i]= unique(adcdata(longproc_ind,1));
    longproc_ind = longproc_ind(i);
    looktime = adcdata(end,9)- adcdata(end,1)*deadtime - sum(adcdata(longproc_ind+1,8)-adcdata(longproc_ind,9)) + length(longproc_ind)*deadtime;

    disp(['fraction looking: ' num2str(looktime/runtime)])
    steps_per_sec = 40;
    ml_per_step = 5/48000;
    flowrate = ml_per_step * steps_per_sec;  %ml/sec
    totalevents = size(adcdata,1);
    disp(['total events: ' num2str(totalevents)])
    cellsperml = totalevents/(flowrate * looktime);
    disp(['ml analyzed: ' num2str(flowrate *looktime)])
    disp(['events per ml: ' num2str(cellsperml)])
    
    if linearplot == 0  %log plotting
        if lowgainA==1 & lowgainC==1
            C2plot = ChC_lowgain - ChC_lowgain_offset; xlab = 'ChC low gain';
            A2plot = ChA_lowgain - ChA_lowgain_offset; ylab = 'ChA low gain';
        elseif lowgainA==1 & lowgainC==0
            C2plot = ChC_highgain - ChC_highgain_offset; xlab = 'ChC high gain';
            A2plot = ChA_lowgain - ChA_lowgain_offset; ylab = 'ChA low gain';
        elseif lowgainA==0 & lowgainC==0
            C2plot = ChC_highgain - ChC_highgain_offset; xlab = 'ChC high gain';
            A2plot = ChA_highgain - ChA_highgain_offset; ylab = 'ChA high gain';
        end
    else % linear plotting
        if lowgainA==1 & lowgainC==1
            C2plot = ChC_lowgain; xlab = 'ChC low gain';
            A2plot = ChA_lowgain; ylab = 'ChA low gain';
        elseif lowgainA==1 & lowgainC==0
            C2plot = ChC_highgain; xlab = 'ChC high gain';
            A2plot = ChA_lowgain; ylab = 'ChA low gain';
        elseif lowgainA==0 & lowgainC==0
            C2plot = ChC_highgain; xlab = 'ChC high gain';
            A2plot = ChA_highgain; ylab = 'ChA high gain';
        end
    end

    dur_plot = input('plot signal duration rather than SSC? [ENTER(default=n) or y]  ','s');
    if strmatch(dur_plot,'y','exact');
        dur = -adcdata(:,7);
        C2plot = dur;
        xlab = 'duration (V)';
    end
    
%     close all
    h1 = figure(1); set(h1,'position',[10 10 1380/1.5 1038/1.5])

    tind = find(xsize==0);
    if linearplot==1,
        plot(C2plot,A2plot,'.'); %axis([-.1 1.5 0 10])
        hold on
        plot(C2plot(tind),A2plot(tind),'r.');
    else
%         %C2plot = C2plot+.05;
%         %A2plot = A2plot+.05;
%         C2plot = C2plot+.1;
%         A2plot = A2plot+.1;
        loglog(C2plot,A2plot,'.');
        hold on
        loglog(C2plot(tind),A2plot(tind),'r.');
    end

    set(gca,'fontname','times','fontsize',18);
    xlabel(xlab, 'fontsize',18); ylabel(ylab, 'fontsize',18);

    if strmatch(all_signals,'y','exact'); % to do all the points without drawing poly
        xpoly = [min(C2plot); max(C2plot); max(C2plot); min(C2plot)];
        ypoly = [min(A2plot); min(A2plot); max(A2plot); max(A2plot)];
    else
        [xpoly,ypoly] = ginput; %choose a region to see images of
    end

    hold on
    p = plot([xpoly; xpoly(1)], [ypoly; ypoly(1)], 'r', 'linewidth', 3);
    hold off
    pause
    %set(gcf, 'visible','off')  %to show command line screen again...


    %test to see if roi pos affects focus of images
    roipos_focus = input('see images from a region of roipos? [ENTER(default=n) or y]  ','s');
    if strmatch(roipos_focus,'y','exact');
        figure(97); plot(xpos,ypos,'.r');hold on; xlabel('xpos'); ylabel('ypos'); axis([0 1380 0 1034])
        [xpoly,ypoly] = ginput; %choose a region to see images of
        isin = find(isinpoly(xpos, ypos, xpoly, ypoly));
    else
        if strmatch(dur_plot,'y','exact');
            isin = find(isinpoly(dur, A2plot, xpoly, ypoly));
        else
            isin = find(isinpoly(C2plot, A2plot, xpoly, ypoly));
        end
    end
    hold on
    p = plot([xpoly; xpoly(1)], [ypoly; ypoly(1)], 'r', 'linewidth', 3);
    hold off
    
        data_choosing = input('use only last half of data? [ENTER(default=n) or y]  ','s');
    if strmatch(data_choosing,'y','exact');
        isin = isin(length(isin)/2:end);
    end

%     pause

    %pause
    CVplots = input('plot image positions and signal distributions? [ENTER(default=n) or y]  ','s');
    if strmatch(CVplots,'y','exact')%CVplots == 1
        f2 = figure(96);
        set(f2,'position',[width*0 height*0.1 width*.8 height*.8])
        subplot(121)
        endch = max(A2plot(isin));
        startch = unique(min(A2plot(isin)'));
%         if linearplot == 1,
            binsA = linspace(startch, endch, 256);
%         else
%             binsA = logspace(startch, endch, 256);
%         end
        histChA = hist([startch; endch; A2plot(isin)], binsA); 
        histChA_raw = histChA;  %save original 
        plot(binsA, histChA_raw,'.-');
        histChA = fastsmooth(histChA,3);
        hold on
        plot(binsA, histChA, 'linewidth', 2)
        if ~isempty(find(histChA(2:end-1)>=0.5*max(histChA)))
            tA1 = min(binsA(find(histChA(2:end-1)>=0.5*max(histChA)))); %channel value at left side of peak
            tA2 = max(binsA(find(histChA(2:end-1)>=0.5*max(histChA)))); %channel value at right side of peak
            tempA1 = (find(binsA==tA1):find(binsA==tA2)); %indices of channels of peak
            tempA2 = tempA1(2:end-1);
            SDA1 = (binsA(tempA1(end)) - binsA(tempA1(1))) / 2.36;
            if length(tempA1)>2
                SDA2 = (binsA(tempA2(end)) - binsA(tempA2(1))) / 2.36;
            else
                tempA2 = tempA1;
                SDA2 = SDA1;
            end
            meanchA1 = sum(histChA(tempA1(1):tempA1(end)) .* binsA(tempA1(1):tempA1(end))) / sum(histChA(tempA1(1):tempA1(end)));
            meanchA2 = sum(histChA(tempA2(1):tempA2(end)) .* binsA(tempA2(1):tempA2(end))) / sum(histChA(tempA2(1):tempA2(end)));
            meanchA = mean([meanchA1 meanchA2]);
            CVA1 = SDA1 / meanchA1; CVA2 = SDA2 / meanchA2; CVA = mean([CVA1 CVA2]);
            hold on; plot(binsA(tempA1), histChA(tempA1),'r.'); plot(binsA(tempA2), histChA(tempA2),'g.');%show in red the ch's above halfheight
            if max(binsA)>0, axis([0 max(binsA) 0 inf]), end
            CVA_all = std(ChA_highgain(isin))/mean(ChA_highgain(isin));
            st = title(file); set(st,'interpreter','none', 'fontsize',12)
            if strmatch(dur_plot,'y','exact');
                str=sprintf(['mean Duration=' num2str(meanchA,2) 'V  CV(half-ht)=' num2str(round(CVA*1000)/10) '%%' '  CV(isin)=' num2str(round(CVA_all*1000)/10) '%%'])
                title(str);
            elseif lowgainA == 0
                str=sprintf(['mean ChA highgain=' num2str(meanchA,2) 'V  CV(half-ht)=' num2str(round(CVA*1000)/10) '%%' '  CV(isin)=' num2str(round(CVA_all*1000)/10) '%%'])
                title(str);
            elseif lowgainA == 1
                str=sprintf(['mean ChA lowgain=' num2str(meanchA,2) 'V  CV(half-ht)=' num2str(round(CVA*1000)/10) '%%' '  CV(isin)=' num2str(round(CVA_all*1000)/10) '%%'])
                title(str);
            end
        end
        subplot(122)
        endch = max(C2plot(isin));
        startch = unique(min(C2plot(isin)'));
%         if linearplot == 1,
            binsC = linspace(startch, endch, 256);
%         else
%             binsC = logspace(startch, endch, 256);
%         end
        histChC = hist([startch; endch; C2plot(isin)], binsC); 
        histChC_raw = histChC;  %save original 
        plot(binsC, histChC_raw,'.-');
        histChC = fastsmooth(histChC,3);
        hold on
        plot(binsC, histChC, 'linewidth', 2)
        if ~isempty(find(histChC(2:end-1)>=0.5*max(histChC)))
            tC1 = min(binsC(find(histChC(2:end-1)>=0.5*max(histChC)))); %channel value at left side of peak
            tC2 = max(binsC(find(histChC(2:end-1)>=0.5*max(histChC)))); %channel value at right side of peak
            tempC1 = (find(binsC==tC1):find(binsC==tC2)); %indices of channels of peak
            tempC2 = tempC1(2:end-1);
            SDC1 = (binsC(tempC1(end)) - binsC(tempC1(1))) / 2.36;
            if length(tempC1)>2
                SDC2 = (binsC(tempC2(end)) - binsC(tempC2(1))) / 2.36;
            else
                tempC2 = tempC1;
                SDC2 = SDC1;
            end
            meanchC1 = sum(histChC(tempC1(1):tempC1(end)) .* binsC(tempC1(1):tempC1(end))) / sum(histChC(tempC1(1):tempC1(end)));
            meanchC2 = sum(histChC(tempC2(1):tempC2(end)) .* binsC(tempC2(1):tempC2(end))) / sum(histChC(tempC2(1):tempC2(end)));
            meanchC = mean([meanchC1 meanchC2]);
            CVC1 = SDC1 / meanchC1; CVC2 = SDC2 / meanchC2; CVC = mean([CVC1 CVC2]);
            hold on; plot(binsC(tempC1), histChC(tempC1),'r.'); plot(binsC(tempC2), histChC(tempC2),'g.');%show in red the ch's above halfheight
            if max(binsC)>0, axis([0 max(binsC) 0 inf]), end
%             axis([0 max(binsC) 0 inf])
            CVC_all = std(ChC_highgain(isin))/mean(ChC_highgain(isin));
            st = title(file); set(st,'interpreter','none', 'fontsize',12)
            if strmatch(dur_plot,'y','exact');
                str=sprintf(['mean Duration=' num2str(meanchC,2) 'V  CV(half-ht)=' num2str(round(CVC*1000)/10) '%%' '  CV(isin)=' num2str(round(CVC_all*1000)/10) '%%'])
                title(str);
            elseif lowgainC == 0
                str=sprintf(['mean ChC highgain=' num2str(meanchC,2) 'V  CV(half-ht)=' num2str(round(CVC*1000)/10) '%%' '  CV(isin)=' num2str(round(CVC_all*1000)/10) '%%'])
                title(str);
            elseif lowgainC == 1
                str=sprintf(['mean ChC lowgain=' num2str(meanchC,2) 'V  CV(half-ht)=' num2str(round(CVC*1000)/10) '%%' '  CV(isin)=' num2str(round(CVC_all*1000)/10) '%%'])
                title(str);
            end
        end


        figure(97); plot(xpos(isin),ypos(isin),'.r');hold on; xlabel('xpos'); ylabel('ypos'); axis([0 1380 0 1034])
        figure(98); a=adcdata(:,11); hist(a,100); b=length(find(a<10))/length(find(a>10)); xlabel ('roiY pos'); ylabel ('frequency')
        disp(['roiY<10/roiY>10)' num2str(b)])
        pause
        figure(99); plot(ypos(isin), C2plot(isin), '.b');hold on; xlabel('ypos'); ylabel('C2plot');axis([0 1380 0 10])
        figure(101); plot(ypos(isin), A2plot(isin), '.b');hold on; xlabel('ypos'); ylabel('triggerchannel');axis([0 1380 0 10])
    end
    imgnum = adcdata(:,1);
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
    h2 = figure(2); clf
%     set(h2,'position',[width*0 height*0.1 width*.8 height*.8])
    set(h2,'position',[width*0 height*0 1380 1034])
    colormap(gray);
    set(gcf,'color', [1 1 1]);
    count = 0; pagefull = 0; rownum = 1; newrow = 1; yrowmaxall=[];
    if max(adcdata(:,14))==1, disp('No non-zero size rois... quitting.   '); return; end
%     keyboard
    while pagefull < 1 & count < length(startbyte) & count < length(isin) % with "count < length(startbyte)-1", it doesn't do last roi (e.g., IFCB2_2009_284_221426)
        count = count + 1;
        if count >= length(startbyte), pagefull=1; end % so the last page of images is shown
        if newpageflag == 1,
            newpageflag = 0; xcum = 0; ycum = 0; yrowmax = 0;
        end % to avoid skipping an image when the new image is too big to fit on the same page...
        position = startbyte(isin(count)); %sum(xsize(1:test-1) .* ysize(1:test-1));
        fseek(fid, position, -1);
        data = fread(fid, xsize(isin(count)).*ysize(isin(count)), 'ubit8');
        imagedat = reshape(data, xsize(isin(count)), ysize(isin(count)));
        x = size(imagedat,1); y = size(imagedat,2);
        if ycum + y <= camy & xcum + x <= camx, %stay on same page and same row
%             h = imagesc(imagedat', 'xdata', [xcum+border xcum+x], 'ydata', [ycum+border ycum+y]); colormap(gray); shading flat; hold on; axis([1 1380 1 1034]);
            h = imagesc(imagedat', 'xdata', [xcum+border xcum+x], 'ydata', [ycum+border ycum+y]); colormap(gray); hold on; axis([1 1380 1 1034]);
%             keyboard
            num = isin(count);
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
                h2 = figure(2); clf
%                 set(h2,'position',[width*0 height*0.1 width*.8 height*.8])
%                 colormap(gray);
%                 set(gcf,'color', [1 1 1]);
                delete(gca)
                startroi = count;% - 1;
                newpageflag = 1;
                yrowmax=y;
            end
            if newpageflag == 0
                h = imagesc(imagedat', 'xdata', [xcum+border xcum+x], 'ydata', [ycum+border ycum+y]); colormap(gray); shading flat; hold on; axis([1 1380 1 1034]);
                %set(gca,'position',[xpos/1378 1-(ypos/1012+size(imagedat,1)/1012) size(imagedat,2)/1378 size(imagedat,1)/1012])
                if strmatch(numbering,'y','exact')
                    text(xcum+border,ycum+border,num2str(isin(count)))  %label each image
                end
                %pause
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
            count = count - 1;
        end
    end
    fclose(fid)
end
%to print a page...
%eval(['print -dpng ' path file '.png'])