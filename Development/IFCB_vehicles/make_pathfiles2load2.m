%T Crockford Dec14 make a single mat file to change and reference in multiple m-files
%adjusted from original coad to load both horz&vert paths for comparison
%ref in plotIFCB_horz_vs_vert.m
%plotHISTOpos.m
%movieIFCBplot_roi_pos_DT

exp_list = {''; '';
    'Exp 1) LAB horz vs vert Dun - IFCB10&101'; ...
    'Exp 2) LAB horz vs vert Guin - IFCB10&101'; ...
    'Exp 3) LAB horz vs vert Dock Sample - IFCB10&101'};

disp(exp_list)
answer = input('Enter the number of which experiment would you like to plot?');

%%%%%%%%%%%%%%%%%%%%%%%%
%set path to data, start & end file, name for saved mat file
%%%%%%%%%%%%%%%%%%%%%%%%
switch answer
%SOSIKNAS
%IFCB10
    case 1 %Exp1 inLAB Dunaliella(IFCB10&IFCB101-large flow cell, bevel needle)
    hpath = '\\sosiknas1\Lab_data\IFCB_forVehicles\IFCB10\horizontal_dun\';%horizontal
    vpath = '\\sosiknas1\Lab_data\IFCB_forVehicles\IFCB101\horizontal_dun\';%vertical
    savefilename = 'Exp1Dun-Horz_vs_Vert';
    case 2 %Exp2 inLAB Guinardia(IFCB10&IFCB101-large flow cell, bevel needle)
    hpath = '\\sosiknas1\Lab_data\IFCB_forVehicles\IFCB10\horizontal_gui\';%horizontal
    vpath = '\\sosiknas1\Lab_data\IFCB_forVehicles\IFCB101\horizontal_gui\';%vertical
    savefilename = 'Exp2Gui-Horz_vs_Vert';
    case 3 %Exp3 inLAB Dock Water (IFCB10&IFCB101-large flow cell, bevel needle)
    hpath = '\\sosiknas1\Lab_data\IFCB_forVehicles\IFCB10\horizontal_sw\';%horizontal
    vpath = '\\sosiknas1\Lab_data\IFCB_forVehicles\IFCB101\horizontal_sw\';%vertical
    savefilename = 'DockSample-Horz_vs_Vert';
end
clear exp_list answer

%data on instrument IP
% path = '\\128.128.108.51\data\'; %ifcb10 IP on instr
% path = '\\128.128.108.82\data\beads\'; %ifcb10 beads
%IFCB 101
% path = '\\128.128.110.139\data\'; %IFCB101 IP instr
% path = '\\128.128.110.139\data\beads\'; %IFCB101 beads


%save pathfiles2load path startfile endfile savefilename