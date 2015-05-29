function [ classlist ] = selectrois(instructions_handle, imagemap, classlist, class2pick1, maxlist1)
%function [ classlist, change_flag, go_back_flag ] = selectrois(instructions_handle, imagemap, classlist, class2pick1, mark_col)
%For Imaging FlowCytobot roi viewing; Use with manual_classify scripts;
%Sets up a graph window for manual identification from a roi collage (use
%fillscreen.m to add the rois);
%Heidi M. Sosik, Woods Hole Oceanographic Institution, 30 May 2009
%modified 6 January 2010 to omit save line (all saves are now in manual_classify proper)
%modifedi 15 January 2010 to change mode of overriding a IDs between main list and subdivide lists, set so latest ID wins
%April 2015, revised to remove subdivide functionality and recast for manual_classify_4_1

%INPUT:
%instructions_handles - handle to text box for instructions
%imagemap = pixel map of roi index numbers as plotted, for use with ginput in manual_classify scripts
%classlist - matrix of class identity results
%class2pick1 - cell array of classes to consider for main selection (left buttons)
%mark_col - column of classlist to edit with manual identifications

%OUTPUT:
%classlist - matrix of (modified) class identity results
%

global category MCflags

MCflags.changed_selectrois = 0;
MCflags.go_back = 0;
button = 1;  %reset to stop for ginput on next screen
mark_col_now = 2;
while button(end) < 3 
    try
        [x1,y1,button] = ginput_crosshair;  % choose image locations using left button of mouse
    catch
        button = 1;
        msgbox('ginput error; try again; if you can reproduce this error, tell Heidi how!')
    end
    if ~isempty(x1),
        if length(x1) >= 1 && button(end) <= 3,
            if ~isempty(category),
                x1 = round(x1); y1 = round(y1);
                if 0 < x1(end) & x1(end) < 200 & -50 < y1(end) & y1(end) < 0, %select all box
                    selected_roi = unique(imagemap(~isnan(imagemap)));
                else
                    temp = find(x1 > 0 & x1 <=size(imagemap,1) & y1 > 0 & y1 <=size(imagemap,2));
                    x1 = x1(temp); y1 = y1(temp); clear temp  %eliminate pts outside axes
                    selected_roi = imagemap(sub2ind(size(imagemap),x1,y1)); %
                end;
                selected_roi = selected_roi(~isnan(selected_roi)); %make sure click was on a ROI, moved before button_flag loop 1/15/10
                if MCflags.button == 1, %left side listbox
                    catnum = strmatch(category(5:end),class2pick1, 'exact');
                    text(x1,y1, num2str(catnum),'color', 'r', 'fontweight', 'bold')
                elseif MCflags.button == 3, %right side listbox
                    catnum = strmatch(category(5:end),class2pick1, 'exact');
                    text(x1,y1, num2str(catnum),'color', 'r', 'fontweight', 'bold')
                end;
                classlist(selected_roi,mark_col_now) = catnum;
                MCflags.changed_selectrois = 1;
            else
                disp('Choose a category first!!')
                set(instructions_handle, 'string', ['Choose a category first!!'])
                button = 1;
            end;
        else
            if button(end) == 28,
                MCflags.go_back = 1;
            end;
        end;
    else
        button = 29; %just go on to next screen if no inputs
    end;
    clear x1 y1
end;



