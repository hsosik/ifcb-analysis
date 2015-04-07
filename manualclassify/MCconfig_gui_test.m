function varargout = MCconfig_gui_test(varargin)
%MCCONFIG_GUI_TEST M-file for MCconfig_gui_test.fig
%      MCCONFIG_GUI_TEST, by itself, creates a new MCCONFIG_GUI_TEST or raises the existing
%      singleton*.
%
%      H = MCCONFIG_GUI_TEST returns the handle to a new MCCONFIG_GUI_TEST or the handle to
%      the existing singleton*.
%
%      MCCONFIG_GUI_TEST('Property','Value',...) creates a new MCCONFIG_GUI_TEST using the
%      given property value pairs. Unrecognized properties are passed via
%      varargin to MCconfig_gui_test_OpeningFcn.  This calling syntax produces a
%      warning when there is an existing singleton*.
%
%      MCCONFIG_GUI_TEST('CALLBACK') and MCCONFIG_GUI_TEST('CALLBACK',hObject,...) call the
%      local function named CALLBACK in MCCONFIG_GUI_TEST.M with the given input
%      arguments.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES
% Edit the above text to modify the response to help MCconfig_gui_test

% Last Modified by GUIDE v2.5 07-Apr-2015 13:27:19

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @MCconfig_gui_test_OpeningFcn, ...
                   'gui_OutputFcn',  @MCconfig_gui_test_OutputFcn, ...
                   'gui_LayoutFcn',  [], ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
   gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
    end
% End initialization code - DO NOT EDIT


% --- Executes just before MCconfig_gui_test is made visible.
function MCconfig_gui_test_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   unrecognized PropertyName/PropertyValue pairs from the
%            command line (see VARARGIN)

% Choose default command line output for MCconfig_gui_test
handles.output = hObject;
handles.config_map = {...
    'pick_mode' 'pick_mode_checkbox' {'raw_roi' 'correct_classifier'};...
    'display_order' 'images_by_size_checkbox' [] ;...
    'alphabetize' 'alphabetize_checkbox' [];...
    'maxlist1' 'maxlist1_text' '' ;...
%    'setsize' '' '' ;...
%    'pixel_per_micron' '' '' ;...
%    'bar_length_micron' '' '' ;...
    'imresize_factor' 'imresize_text' '' ;...
%    'x_pixel_threshold' '' '' ;...
%    'y_pixel_threshold' '' '' ;...
    'threshold_mode' 'threshold_mode_popup' [] ;... %0 = all, 1 = larger, 2 = smaller
%    'dataformat' '' '' ;...
    'class_filestr' 'class_filestr_text' '' ;...
    'class2use' 'class2use_listbox' 'all' ;... %all
    'class2view1' 'class2use_listbox' 'value' ;...%value, must be mapped after class2use
    'class2use' 'default_class_popup' 'all' ;...
    'default_class' 'default_class_popup' 'value' ;...%must follow case for 'all' to populate popup list
    'class2use_file' 'class2use_file_text' '' ;...
    };
if length(varargin) > 0
    temp = load([ 'config' filesep varargin{1} '.mcconfig.mat']);
else
    temp = load([ 'config' filesep 'last.mcconfig.mat']);
end;
handles.MCconfig = temp.MCconfig;

%map MCconfig to GUI components
for ii = 1:size(handles.config_map,1), 
    map = handles.config_map(ii,:);
    h = handles.(map{2});
    if strcmp(get(h, 'style'), 'checkbox')
        if ~isempty(map{3})
            v = strmatch(handles.MCconfig.(char(map(1))), map{3});
            set(h,'value', v-1);
        else
            set(h,'value', handles.MCconfig.(char(map(1))));
        end;
    elseif strcmp(get(h, 'style'), 'edit') | strcmp(get(h, 'style'), 'text')
        v = handles.MCconfig.(char(map(1)));
        if isnumeric(v)
            set(h, 'string', num2str(v))
        else
            set(h, 'string', v)
        end;
    elseif strcmp(get(h, 'style'), 'listbox')
        str = handles.MCconfig.(char(map(1)));
        if strcmp(map(3), 'value')
           [~,~,v] = intersect(str, get(h, 'string'));
            set(h,'value', v, 'listboxtop', 1)
        else %all
            set(h, 'string', str, 'listboxtop', 1);
        end
    elseif strcmp(get(h, 'style'), 'popupmenu')
        str = handles.MCconfig.(char(map(1)));
        if strcmp(map(3), 'value')
            in_v = handles.MCconfig.(char(map(1)));
            if isnumeric(in_v)
                [~,~,v] = intersect(in_v, str2num(get(h, 'string')));
            else
                [~,~,v] = intersect(in_v, get(h, 'string'));
            end;
            set(h, 'value', v)
        else %all
            set(h, 'string', str);
        end      
    end;
end
%check about enable status
if get(handles.pick_mode_checkbox,'value')
    set([handles.classpath_text handles.class_filestr_text], 'enable', 'on')
else
    set([handles.classpath_text handles.class_filestr_text], 'enable', 'off')
end
    
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes MCconfig_gui_test wait for user response (see UIRESUME)
% uiwait(handles.main_figure);


% --- Outputs from this function are returned to the command line.
function varargout = MCconfig_gui_test_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure

varargout{1} = handles.output;
varargout{2} = handles.MCconfig;


% --- Executes on selection change in pick_mode.
function pick_mode_Callback(hObject, eventdata, handles)
% hObject    handle to pick_mode (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns pick_mode contents as cell array
%        contents{get(hObject,'Value')} returns selected item from pick_mode


% --- Executes during object creation, after setting all properties.
function pick_mode_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pick_mode (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in display_ordered_listbox.
function display_ordered_listbox_Callback(hObject, eventdata, handles)
% hObject    handle to display_ordered_listbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns display_ordered_listbox contents as cell array
%        contents{get(hObject,'Value')} returns selected item from display_ordered_listbox


% --- Executes during object creation, after setting all properties.
function display_ordered_listbox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to display_ordered_listbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function roipath_text_Callback(hObject, eventdata, handles)
% hObject    handle to roipath_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of roipath_text as text
%        str2double(get(hObject,'String')) returns contents of roipath_text as a double


% --- Executes during object creation, after setting all properties.
function roipath_text_CreateFcn(hObject, eventdata, handles)
% hObject    handle to roipath_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in roipath_browse.
function roipath_browse_Callback(hObject, eventdata, handles)
% hObject    handle to roipath_browse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
path1 = get(handles.roipath_browse,'String');
roipath = uigetdir(path1);
set(handles.roipath_text, 'string', roipath)


% --- Executes on selection change in start_file_popup.
function start_file_popup_Callback(hObject, eventdata, handles)
% hObject    handle to start_file_popup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns start_file_popup contents as cell array
%        contents{get(hObject,'Value')} returns selected item from start_file_popup


% --- Executes during object creation, after setting all properties.
function start_file_popup_CreateFcn(hObject, eventdata, handles)
% hObject    handle to start_file_popup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in class_order_listbox.
function class_order_listbox_Callback(hObject, eventdata, handles)
% hObject    handle to class_order_listbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns class_order_listbox contents as cell array
%        contents{get(hObject,'Value')} returns selected item from class_order_listbox


% --- Executes during object creation, after setting all properties.
function class_order_listbox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to class_order_listbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function maxlist1_text_Callback(hObject, eventdata, handles)
% hObject    handle to maxlist1_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of maxlist1_text as text
%        str2double(get(hObject,'String')) returns contents of maxlist1_text as a double            
        [val status] = str2num(get(hObject,'String'));
        if ~status || (status && (rem(val,1) ~= 0 || val <= 0))
            set(hObject,'String', '50');
           uiwait(msgbox(['Left list size must be a positive integer']))
        end;

% --- Executes during object creation, after setting all properties.
function maxlist1_text_CreateFcn(hObject, eventdata, handles)
% hObject    handle to maxlist1_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function main_figure_CreateFcn(hObject, eventdata, handles)
% hObject    handle to main_figure (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in pick_mode_checkbox.
function pick_mode_checkbox_Callback(hObject, eventdata, handles)
% hObject    handle to pick_mode_checkbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hint: get(hObject,'Value') returns toggle state of pick_mode_checkbox

if get(hObject, 'Value')
    set([handles.classpath_text handles.class_filestr_text], 'enable', 'on')
else
    set([handles.classpath_text handles.class_filestr_text], 'enable', 'off')
end


function manualpath_text_Callback(hObject, eventdata, handles)
% hObject    handle to manualpath_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of manualpath_text as text
%        str2double(get(hObject,'String')) returns contents of manualpath_text as a double


% --- Executes during object creation, after setting all properties.
function manualpath_text_CreateFcn(hObject, eventdata, handles)
% hObject    handle to manualpath_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in manualpath_browse.
function manualpath_browse_Callback(hObject, eventdata, handles)
% hObject    handle to manualpath_browse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
path1 = get(handles.manualpath_browse,'String');
manualpath = uigetdir(path1);
set(handles.manualpath_text, 'string', manualpath)


function classpath_text_Callback(hObject, eventdata, handles)
% hObject    handle to classpath_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of classpath_text as text
%        str2double(get(hObject,'String')) returns contents of classpath_text as a double


% --- Executes during object creation, after setting all properties.
function classpath_text_CreateFcn(hObject, eventdata, handles)
% hObject    handle to classpath_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in classpath_browse.
function classpath_browse_Callback(hObject, eventdata, handles)
% hObject    handle to classpath_browse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
path1 = get(handles.classpath_browse,'String');
classpath = uigetdir(path1);
set(handles.classpath_text, 'string', classpath)


% --- Executes when main_figure is resized.
function main_figure_ResizeFcn(hObject, eventdata, handles)
% hObject    handle to main_figure (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function imresize_text_Callback(hObject, eventdata, handles)
% hObject    handle to imresize_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of imresize_text as text
%        str2double(get(hObject,'String')) returns contents of imresize_text as a double
        [val status] = str2num(get(hObject,'String'));
        if ~status || val <= 0 
           set(hObject,'String', '1');
           uiwait(msgbox(['Rescale factor must be a positive number']))
        end;


% --- Executes during object creation, after setting all properties.
function imresize_text_CreateFcn(hObject, eventdata, handles)
% hObject    handle to imresize_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes when user attempts to close main_figure.
function main_figure_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to main_figure (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure

Save_menu_Callback([], [], handles) %just save to last.mcconfig.mat

delete(hObject);


% --- Executes on button press in images_by_size_checkbox.
function images_by_size_checkbox_Callback(hObject, eventdata, handles)
% hObject    handle to images_by_size_checkbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of images_by_size_checkbox


% --- Executes on button press in alphabetize_checkbox.
function alphabetize_checkbox_Callback(hObject, eventdata, handles)
% hObject    handle to alphabetize_checkbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of alphabetize_checkbox



function class_filestr_text_Callback(hObject, eventdata, handles)
% hObject    handle to class_filestr_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of class_filestr_text as text
%        str2double(get(hObject,'String')) returns contents of class_filestr_text as a double


% --- Executes during object creation, after setting all properties.
function class_filestr_text_CreateFcn(hObject, eventdata, handles)
% hObject    handle to class_filestr_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in load_class2use_pushbutton.
function load_class2use_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to load_class2use_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[f p ] = uigetfile(['config' filesep '*class2use*.mat']);
temp = load([p f]);
handles.MCconfig.class2use = temp.class2use;
set(handles.class2use_listbox, 'string', temp.class2use, 'min', 0, 'max', length(temp.class2use), 'value', []);
set(handles.default_class_popup, 'string', temp.class2use);
[~,~,v] = intersect(handles.MCconfig.default_class, temp.class2use);
if ~isempty(v)
    set(handles.default_class_popup, 'value', v);
else
    set(handles.default_class_popup, 'value', 1);
end;

[~,temp] = fileparts(f);
set(handles.class2use_file_text, 'string', temp);
%reset the highlights for class2view if current are subset of just loaded class2use
str = handles.MCconfig.class2view1;
[~,~,v] = intersect(str, get(handles.class2use_listbox, 'string'));
if ~isempty(v)
    set(handles.class2use_listbox,'value', v, 'listboxtop', 1)
end;
%reset class2view in case not all retained
handles.MCconfig.class2view1 = v;


% --- Executes on selection change in class2use_listbox.
function class2use_listbox_Callback(hObject, eventdata, handles)
% hObject    handle to class2use_listbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns class2use_listbox contents as cell array
%        contents{get(hObject,'Value')} returns selected item from class2use_listbox
temp = get(hObject, 'value');
if length(temp) < length(handles.MCconfig.class2use) %if user has deselected some, make sure view all is unchecked
    set(handles.class2view_all_checkbox, 'value', 0);
end
set(handles.default_class_popup, 'string', get(hObject, 'string'));
[~,~,v] = intersect(handles.MCconfig.default_class, get(hObject, 'string'));
if ~isempty(v)
    set(handles.default_class_popup, 'value', v);
else
    set(handles.default_class_popup, 'value', 1);
end;


% --- Executes during object creation, after setting all properties.
function class2use_listbox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to class2use_listbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in class2view_all_checkbox.
function class2view_all_checkbox_Callback(hObject, eventdata, handles)
% hObject    handle to class2view_all_checkbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of class2view_all_checkbox
if get(hObject, 'value')
    set(handles.class2use_listbox, 'value', 1:length(handles.MCconfig.class2use) , 'listboxtop', 1);
else
    set(handles.class2use_listbox, 'value', [] , 'listboxtop', 1);
end


% --- Executes on selection change in default_class_popup.
function default_class_popup_Callback(hObject, eventdata, handles)
% hObject    handle to default_class_popup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns default_class_popup contents as cell array
%        contents{get(hObject,'Value')} returns selected item from default_class_popup


% --- Executes during object creation, after setting all properties.
function default_class_popup_CreateFcn(hObject, eventdata, handles)
% hObject    handle to default_class_popup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --------------------------------------------------------------------
function uipushtool3_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to uipushtool3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function File_menu_Callback(hObject, eventdata, handles)
% hObject    handle to File_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Save_menu_Callback(hObject, eventdata, handles)
% hObject    handle to Save_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

uicontrol(handles.maxlist1_label) %just make sure the cursor wasn't left in a edit box
drawnow
for ii = 1:size(handles.config_map,1), 
    map = handles.config_map(ii,:);
    h = handles.(map{2});
    if strcmp(get(h, 'style'), 'checkbox')
        v = get(h, 'value');
        if ~isempty(map{3})
            handles.MCconfig.(char(map(1))) = map{3}(v+1); 
        else
            handles.MCconfig.(char(map(1))) = v; 
        end;
    elseif strcmp(get(h, 'style'), 'edit') || strcmp(get(h, 'style'), 'text')
        [v s] = str2num(get(h, 'string'));
        if s
            handles.MCconfig.(char(map(1))) = v;
        else
            handles.MCconfig.(char(map(1))) = get(h, 'string');
        end
    elseif strcmp(get(h, 'style'), 'listbox')
        str = get(h, 'string');
        if strcmp(map(3), 'value')
            v = get(h,'value');
            handles.MCconfig.(char(map(1))) = str(v);
        else %all
            handles.MCconfig.(char(map(1))) = str;
        end
        elseif strcmp(get(h, 'style'), 'popupmenu')
            str = get(h, 'string');
            v = get(h, 'value');
            if strcmp(map(3), 'value')
                [vstr s] = str2num(str{v});
                if s
                    handles.MCconfig.(char(map(1))) = vstr;
                else
                    handles.MCconfig.(char(map(1))) = str(v);
                end
            end
    end
end
MCconfig = handles.MCconfig;
save([ 'config' filesep 'last.mcconfig.mat'], 'MCconfig');
if ~isempty(hObject)
    [f p] = uiputfile('config\*.mcconfig.mat', 'Save config');
    if f
        save([ p f ], 'MCconfig');
    end
end


% --------------------------------------------------------------------
function load_config_menu_Callback(hObject, eventdata, handles)
% hObject    handle to load_config_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[f p] = uigetfile('config\*.mcconfig.mat', 'Load config');
if f
    temp = load([ p f]);
    if isfield(temp, 'MCconfig')
        handles.MCconfig = temp.MCconfig;
    else
        msgbox('Not a valid configuration file')
    end
end


% --- Executes on selection change in threshold_mode_popup.
function threshold_mode_popup_Callback(hObject, eventdata, handles)
% hObject    handle to threshold_mode_popup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns threshold_mode_popup contents as cell array
%        contents{get(hObject,'Value')} returns selected item from threshold_mode_popup


% --- Executes during object creation, after setting all properties.
function threshold_mode_popup_CreateFcn(hObject, eventdata, handles)
% hObject    handle to threshold_mode_popup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
