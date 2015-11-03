% [path, savefilename, startfile, endfile] = make_pathfile2load;
%T Crockford Dec14 make a single mat file to change and reference in multiple m-files
%ref in plotIFCB_horz_vs_vert.m
%plotHISTOpos.m
%movieIFCBplot_roi_pos_DT

exp_list = {''; '';
    '1) horz, Dun - IFCB10'; ...
    '2) vert, Dun = IFCB101, big flowcell, bevel needle'; ...
    '3) horz, Guin - IFCB10'; ...
    '4) vert, Guin - IFCB101, big flowcell, bevel needle'; ...
    '5) horz, DockSample_Nov14 - IFCB10'; ...
    '6) vert, DockSample_Nov14 - IFCB101, big flowcell, bevel needle'; ...
    '7) horz, DockSample2_Dec14 - IFCB10, still ongoing'; ...
    '8) vert, DockSample2_Dec14 - IFCB101, - DACerrors Dec3data,big flowcell, bevel needle, hvb=0.8'; ...
    '9) horz, Alexandrium_5Dec14 - IFCB10'; ...
    '10)vert, Alexandrium_5Dec14 - IFCB101, big flowcell, bevel needle, hvb=0.8'};

disp(exp_list)

answer = input('Enter the number of which experiment would you like to plot?');

%%%%%%%%%%%%%%%%%%%%%%%%
%set path to data, start & end file, name for saved mat file
%%%%%%%%%%%%%%%%%%%%%%%%
switch answer
%SOSIKNAS
%IFCB10
    case 1 %IFCB10 horz Dunaliella
    celltype = 'Dun';
    dirpath = '\\sosiknas1\Lab_data\IFCB_forVehicles\IFCB10\horizontal_dun\';
    savefilename = 'IFCB10-Horz-Dun';
    startfile = 'D20141119T180908_IFCB010';
    endfile   = 'D20141121T205531_IFCB010';
    case 3 %IFCB10 Horz Guinardia
        celltype = 'Guin';
    dirpath = '\\sosiknas1\Lab_data\IFCB_forVehicles\IFCB10\horizontal_gui\';
    savefilename = 'IFCB10-Horz-Gui';
    startfile = 'D20141124T162520_IFCB010';
    endfile   = 'D20141125T194349_IFCB010';
    case 5 %IFCB10 Horz Dock Water, only ~24hrs continuous
    celltype = 'DockWater';
    dirpath = '\\sosiknas1\Lab_data\IFCB_forVehicles\IFCB10\horizontal_sw\';
    savefilename = 'IFCB10-Horz-DockSample1_Nov14';
    startfile = 'D20141125T205638_IFCB010';
    endfile   = 'D20141126T204103_IFCB010';
    case 7 %IFCB10 Horz Dock Water, cont for longer period of time
%     dirpath = '\\128.128.108.51\data\Horizontal_SW2\';
    celltype = 'DockWater';
    dirpath = '\\sosiknas1\Lab_data\IFCB_forVehicles\IFCB10\horizontal_sw2\';
    savefilename = 'IFCB10-Horz-DockSample2_Dec14';
    startfile = 'D20141202T211618_IFCB010';
    endfile   = 'D20141204T153036_IFCB010';
    case 9 %IFCB10 Horz Alex culture
    celltype = 'Alexiandrium';
    dirpath = '\\sosiknas1\Lab_data\IFCB_forVehicles\IFCB10\horizontal_Alexandrium\';
    savefilename = 'IFCB10-Horz-Alex-5Dec14';
    startfile = 'D20141205T210543_IFCB010';
    endfile = 'D20141205T223228_IFCB010';
    case 9 %IFCB10 TestWell first time, horz, vert, condensor in FOV
    celltype = 'TestWell1';
    dirpath = '\\sosiknas1\Lab_data\IFCB_forVehicles\IFCB10\DockTest1\';
    savefilename = 'IFCB10-Horz-Alex-5Dec14';
    startfile = 'D20141205T210543_IFCB010';
    endfile = 'D20141205T223228_IFCB010';
%IFCB101
    case 2 %IFCB101 Vertical Dunaliella(large flow cell, bevel needle)
    celltype = 'Dun';
    dirpath = '\\sosiknas1\Lab_data\IFCB_forVehicles\IFCB101\horizontal_dun\';
    savefilename = 'IFCB101-Vert-Dun';
    startfile = 'D20141119T180923_IFCB101';
    endfile   = 'D20141121T204952_IFCB101';
    case 4 %IFCB101 Vertical Guinardia(large flow cell, bevel needle)
    celltype = 'Guin';
    dirpath = '\\sosiknas1\Lab_data\IFCB_forVehicles\IFCB101\horizontal_gui\';
    savefilename = 'IFCB101-Vert-Gui';
    startfile = 'D20141124T162516_IFCB101';
    endfile   = 'D20141125T193641_IFCB101';
    case 6 %IFCB101 Vertical Dock Water, only ~24hrs continuous (large flow cell, bevel needle)
    celltype = 'DockWater';
    dirpath = '\\sosiknas1\Lab_data\IFCB_forVehicles\IFCB101\horizontal_sw\';
    savefilename = 'IFCB101-Vert-DockSample';
    startfile = 'D20141125T205632_IFCB101';
    endfile   = 'D20141126T203749_IFCB101';
    case 8 %IFCB101 Vert Dock Water, cont for longer period of time
    celltype = 'DockWater';
    dirpath = '\\sosiknas1\Lab_data\IFCB_forVehicles\IFCB101\verticle_sw2\'; %IFCB101 Vert Dock Sample, repeat for longer continuous time seris (large flow cell, bevel needle)
    savefilename = 'IFCB101-Vert-DockSample2_Dec14';
    startfile = 'D20141202T203836_IFCB101';
    endfile   = 'D20141204T152412_IFCB101';
    case 10
    celltype = 'Alexandrium';
    dirpath = '\\sosiknas1\Lab_data\IFCB_forVehicles\IFCB101\vertical_Alexandrium\';
    savefilename = 'IFCB101-Vert-Alex-5Dec14';
    startfile = 'D20141205T211135_IFCB101';
    endfile = 'D20141205T223135_IFCB101';
end
% clear exp_list answer

%data on instrument IP
% path = '\\128.128.108.51\data\'; %ifcb10 IP on instr
% path = '\\128.128.108.82\data\beads\'; %ifcb10 beads
%IFCB 101
% path = '\\128.128.110.139\data\'; %IFCB101 IP instr
% path = '\\128.128.110.139\data\beads\'; %IFCB101 beads


%save pathfiles2load path startfile endfile savefilename