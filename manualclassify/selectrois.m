function [ classlist, change_flag, go_back_flag ] = selectrois(instructions_handle, imagemap, classlist, class2pick1, class2pick2, mark_col)
%function [ classlist, change_flag, go_back_flag ] = selectrois(instructions_handle, imagemap, classlist, class2pick1, class2pick2, mark_col)
%For Imaging FlowCytobot roi viewing; Use with manual_classify scripts;
%Sets up a graph window for manual identification from a roi collage (use
%fillscreen.m to add the rois);
%Heidi M. Sosik, Woods Hole Oceanographic Institution, 30 May 2009
%modified 6 January 2010 to omit save line (all saves are now in manual_classify proper)
%modifedi 15 January 2010 to change mode of overriding a IDs between main list and subdivide lists, set so latest ID wins

%INPUT:
%instructions_handles - handle to text box for instructions
%imagemap = pixel map of roi index numbers as plotted, for use with ginput in manual_classify scripts
%classlist - matrix of class identity results
%class2pick1 - cell array of classes to consider for main selection (left buttons)
%class2pick2 - cell array of classes to consider for sub-divide selection (right buttons)
%mark_col - column of classlist to edit with manual identifications

%OUTPUT:
%classlist - matrix of (modified) class identity results
%change_flag - value of 1 if classlist has been changed, value of 0 if not
%go_back_flag - value of 1 if USER selected to go back one screen (default value = 0 to go forward)

global category button_flag

change_flag = 0;
go_back_flag = 0;
button = 1;  %reset to stop for ginput on next screen
while button(end) < 3 %& ~isempty(startbyte),  %
    [x1,y1,button] = ginput_crosshair;  % choose image locations using left button of mouse
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
                if button_flag == 1, %first set always goes with manual column
                    catnum = strmatch(category(5:end),class2pick1, 'exact');
                    mark_col_now = 2;
                    text(x1,y1, num2str(catnum),'color', 'r', 'fontweight', 'bold')
                    classlist(selected_roi,4:end) = NaN; %any previous subdivide IDs overridden by this new main manual ID, active subdiv will go to default in manual_classify, 1/15/10
                else %case for second set for subdividing
                    catnum = strmatch(category(5:end),class2pick2, 'exact');
                    mark_col_now = mark_col;
                    text(x1,y1, num2str(catnum),'color', 'b', 'fontweight', 'bold')
                    classlist(selected_roi,2) = NaN; %any previous main manual IDs overridden by this new subdivide category, will revert to default main category in manual_classify, 1/15/10
                end;
                classlist(selected_roi,mark_col_now) = catnum;
%                save(resultfile, 'classlist', '-append') 
                change_flag = 1;
            else
                disp('Choose a category first!!')
                set(instructions_handle, 'string', ['Choose a category first!!'])
                button = 1;
            end;
        else
            if button(end) == 28,
                go_back_flag = 1;
            end;
        end;
    else
        button = 29; %just go on to next screen if no inputs
    end;
    clear x1 y1
end;



