function ReleaseFocus(fig)
% function ReleaseFocus(fig)
% disable/enable all uicontrols in a figure window to force focus back to
% main axes, from http://www.mathworks.com/matlabcentral/newsreader/view_thread/235825
        set(findobj(fig, 'Type', 'uicontrol'), 'Enable', 'off');
        drawnow; 
        set(findobj(fig, 'Type', 'uicontrol'), 'Enable', 'on');

