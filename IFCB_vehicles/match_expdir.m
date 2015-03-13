function [path2, savefilename2, celltype] = match_expdir(answer);
switch answer
    case 2 %IFCB10 horz Dunaliella
    dirpath = '\\sosiknas1\Lab_data\IFCB_forVehicles\IFCB10\horizontal_dun\';
    savefilename = 'IFCB10-Horz-Dun';
    celltype = 'Dunaliela';
%     startfile = 'D20141119T180908_IFCB010';
%     endfile   = 'D20141121T205531_IFCB010';
    case 4 %IFCB10 Horz Guinardia
    dirpath = '\\sosiknas1\Lab_data\IFCB_forVehicles\IFCB10\horizontal_gui\';
    savefilename = 'IFCB10-Horz-Gui';
    celltype = 'Guinardia';
%     startfile = 'D20141124T162520_IFCB010';
%     endfile   = 'D20141125T194349_IFCB010';
    case 6 %IFCB10 Horz Dock Water, only ~24hrs continuous
    dirpath = '\\sosiknas1\Lab_data\IFCB_forVehicles\IFCB10\horizontal_sw\';
    savefilename = 'IFCB10-Horz-DockSample1_Nov14';
    celltype = 'DockWater';
%     startfile = 'D20141125T205638_IFCB010';
%     endfile   = 'D20141126T204103_IFCB010';
    case 8 %IFCB10 Horz Dock Water, cont for longer period of time
    dirpath = '\\sosiknas1\Lab_data\IFCB_forVehicles\IFCB10\horizontal_sw2\';
    savefilename = 'IFCB10-Horz-DockSample2_Dec14';
    celltype = 'DockWater';
%     startfile = 'D20141202T211618_IFCB010';
%     endfile   = 'D20141204T153036_IFCB010';
    case 10 %IFCB10 Horz Alex culture
    dirpath = '\\sosiknas1\Lab_data\IFCB_forVehicles\IFCB10\horizontal_Alexandrium\';
    savefilename = 'IFCB10-Horz-Alex-5Dec14';
    celltype = 'Alexiandrium';
%IFCB101
    case 1 %IFCB101 Vertical Dunaliella(large flow cell, bevel needle)
    dirpath = '\\sosiknas1\Lab_data\IFCB_forVehicles\IFCB101\horizontal_dun\';
    savefilename = 'IFCB101-Vert-Dun';
    celltype = 'Dunaliela';
%     startfile = 'D20141119T180923_IFCB101';
%     endfile   = 'D20141121T204952_IFCB101';
    case 3 %IFCB101 Vertical Guinardia(large flow cell, bevel needle)
    dirpath = '\\sosiknas1\Lab_data\IFCB_forVehicles\IFCB101\horizontal_gui\';
    savefilename = 'IFCB101-Vert-Gui';
    celltype = 'Guinardia';
%     startfile = 'D20141124T162516_IFCB101';
%     endfile   = 'D20141125T193641_IFCB101';
    case 5 %IFCB101 Vertical Dock Water, only ~24hrs continuous (large flow cell, bevel needle)
    dirpath = '\\sosiknas1\Lab_data\IFCB_forVehicles\IFCB101\horizontal_sw\';
    savefilename = 'IFCB101-Vert-DockSample';
    celltype = 'DockWater';
%     startfile = 'D20141125T205632_IFCB101';
%     endfile   = 'D20141126T203749_IFCB101';
    case 7 %IFCB101 Vert Dock Water, cont for longer period of time
    dirpath = '\\sosiknas1\Lab_data\IFCB_forVehicles\IFCB101\verticle_sw2\'; %IFCB101 Vert Dock Sample, repeat for longer continuous time seris (large flow cell, bevel needle)
    savefilename = 'IFCB101-Vert-DockSample2_Dec14';
    celltype = 'DockWater';
%     startfile = 'D20141202T203836_IFCB101';
%     endfile   = 'D20141204T152412_IFCB101';
    case 9
    dirpath = '\\sosiknas1\Lab_data\IFCB_forVehicles\IFCB101\vertical_Alexandrium\';
    savefilename = 'IFCB101-Vert-Alex-5Dec14';
    celltype = 'Alexandrium';
end
path2 = dirpath;
savefilename2 = savefilename;
clear path savefilename