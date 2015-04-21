function varargout = ManageMCconfig(varargin)
%MANAGEMCCONFIG M-file for ManageMCconfig.fig
%      MANAGEMCCONFIG, by itself, creates a new MANAGEMCCONFIG or raises the existing
%      singleton*.
%
%      H = MANAGEMCCONFIG returns the handle to a new MANAGEMCCONFIG or the handle to
%      the existing singleton*.
%
%      MANAGEMCCONFIG('Property','Value',...) creates a new MANAGEMCCONFIG using the
%      given property value pairs. Unrecognized properties are passed via
%      varargin to ManageMCconfig_OpeningFcn.  This calling syntax produces a
%      warning when there is an existing singleton*.
%
%      MANAGEMCCONFIG('CALLBACK') and MANAGEMCCONFIG('CALLBACK',hObject,...) call the
%      local function named CALLBACK in MANAGEMCCONFIG.M with the given input
%      arguments.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES
% Edit the above text to modify the response to help ManageMCconfig

% Last Modified by GUIDE v2.5 20-Apr-2015 15:05:15

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ManageMCconfig_OpeningFcn, ...
                   'gui_OutputFcn',  @ManageMCconfig_OutputFcn, ...
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


% --- Executes just before ManageMCconfig is made visible.
function ManageMCconfig_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   unrecognized PropertyName/PropertyValue pairs from the
%            command line (see VARARGIN)

% Choose default command line output for ManageMCconfig
handles.output = hObject;
handles.config_map = {...
    'pick_mode' 'pick_mode_checkbox' {'raw_roi' 'correct'};...
    'display_order' 'images_by_size_checkbox' [] ;...
    'alphabetize' 'alphabetize_checkbox' [];...
    'maxlist1' 'maxlist1_text' '' ;...
    'setsize' 'setsize_text' '' ;...
    'pixel_per_micron' 'pixels_per_micron_text' '' ;...
    'bar_length_micron' 'bar_length_text' '' ;...
    'imresize_factor' 'imresize_text' '' ;...
    'x_pixel_threshold' 'xsize_text' '' ;...
    'y_pixel_threshold' 'ysize_text' '' ;...
    'threshold_mode' 'threshold_mode_popup' 'value' ;... %1 = all, 2 = larger, 3 = smaller
%    'threshold_mode' 'threshold_mode_popup' 'value2str' ;... %1 = all, 2 = larger, 3 = smaller
    'class_filestr' 'class_filestr_text' '' ;...
    'class2use' 'class2use_listbox' 'all' ;... %all
    'class2view1' 'class2use_listbox' 'value' ;...%value, must be mapped after class2use
    'class2use' 'default_class_popup' 'all' ;...
    'default_class' 'default_class_popup' 'value' ;...%must follow case for 'all' to populate popup list
    'class2use_file' 'class2use_file_text' '' ;...
    'roibase_path' 'roipath_text' '';...
    'resultpath' 'manualpath_text' '';...
    'classpath' 'classpath_text' '';...
    'resultfiles' 'resultfiles_listbox' '';...
    'roifiles' 'roifiles_listbox' '';...
    'classfiles' 'classfiles_listbox' '';...
    'list_fontsize' 'list_fontsize_popup' 'value2str';...
    'verbose' 'verbose_checkbox' '';...
    'filenum2start' 'start_file_popup' 'value2str';...
 %%now map some settings that are not needed for manual_classify but are needed to reload in ManageMCconfig
    'settings.start_new_radiobutton' 'start_new_radiobutton' ''; ...
    'settings.review_radiobutton' 'review_radiobutton' ''; ...
    'settings.simple_paths_radiobutton' 'simple_paths_radiobutton' ''; ...
    'settings.resolver_func_radiobutton' 'resolver_func_radiobutton' '';...
    'settings.pick_mode_checkbox' 'pick_mode_checkbox' '';...
    'settings.all_file_checkbox' 'all_file_checkbox' '';...
  %  '' '' '';...
    };

%set some default info and settings
temp = fileparts(which('ManageMCconfig'));
temp = [temp filesep 'config' filesep];
handles.configpath = temp;
if ~exist(temp, 'dir')
    mkdir(temp)
end
handles.msgbox_cs.Interpreter = 'tex';
handles.msgbox_cs.WindowStyle = 'modal';
handles.msgbox_fontstr = '\fontsize{12}';

if length(varargin) > 0
    f = char(varargin{1});
    if exist(f, 'file'),
        temp = load(f);
        fullf = f;
    else
        fullf = [handles.configpath varargin{1} '.mcconfig.mat'];
        temp = load([handles.configpath varargin{1} '.mcconfig.mat']);
    end;
    handles.MCconfig = temp.MCconfig;
    handles.MCconfig.settings.configfile = fullf;
else
    f = [ handles.configpath 'last.mcconfig.mat'];
    if exist(f, 'file'),
        temp = load([ handles.configpath 'last.mcconfig.mat']);
        handles.MCconfig = temp.MCconfig;
    else
        handles.MCconfig = MCconfig_default();
        if ~exist('config', 'dir'),
            mkdir('config')
        end
    end    
end
handles.MCconfig_saved = handles.MCconfig; %initialize to track save status

map_MCconfig2GUI(hObject, handles)
%update settings to correspond to existing object status
all_file_checkbox_Callback(hObject, [], handles)
threshold_mode_popup_Callback(hObject, eventdata, handles)
eventdata_temp.NewValue = get(handles.resolve_file_locations_buttongroup, 'selectedobject'); %what is it now
resolve_file_locations_buttongroup_SelectionChangeFcn(hObject, eventdata_temp, handles)
new_review_buttongroup_SelectionChangeFcn(handles.new_review_buttongroup, [], handles) %ensure correct related settings
%pick_mode_checkbox_Callback(handles.pick_mode_checkbox, [], handles) %must be done after new_review
update_filelists(handles)

% Update handles structure
guidata(handles.main_figure, handles);

% UIWAIT makes ManageMCconfig wait for user response (see UIRESUME)
 uiwait(handles.main_figure);  %uncommented to control output wait for user completion (heidi)

%
function map_MCconfig2GUI (hObject, handles) 
%map MCconfig to GUI components
for ii = 1:size(handles.config_map,1), 
    map = handles.config_map(ii,:);
    h = handles.(map{2});
    value_from_MCconfig = eval(['handles.MCconfig.' char(map{1})]); %necessary to handle nested structures
    if strcmp(get(h, 'style'), 'checkbox') | strcmp(get(h, 'style'), 'radiobutton')
        if ~isempty(map{3})
            v = strmatch(value_from_MCconfig, map{3});
            set(h,'value', v-1);
        else
            set(h,'value', value_from_MCconfig);
        end;
    elseif strcmp(get(h, 'style'), 'edit') | strcmp(get(h, 'style'), 'text')
        v = value_from_MCconfig;
        if isnumeric(v)
            set(h, 'string', num2str(v))
        else
            set(h, 'string', v)
        end;
    elseif strcmp(get(h, 'style'), 'listbox')
        str = value_from_MCconfig;
        if strcmp(map(3), 'value')
           [~,~,v] = intersect(str, get(h, 'string'));
            set(h,'value', v, 'listboxtop', 1)
        else %all
            set(h, 'string', str, 'listboxtop', 1);
        end
    elseif strcmp(get(h, 'style'), 'popupmenu')
        str = handles.MCconfig.(char(map(1)));
        if strcmp(map(3), 'value')
           % in_v = handles.MCconfig.(char(map(1)));
            if isnumeric(str)
                v = str;
            else
                [~,~,v] = intersect(str, get(h, 'string'));
            end;
            set(h, 'value', v)
        elseif strcmp(map(3), 'value2str')
            num = handles.MCconfig.(char(map(1)));
            [~,~,v] = intersect(num2str(num), get(h, 'string'));
            set(h, 'value', v)
        else %all
            set(h, 'string', str);
        end      
    end
end

switch handles.MCconfig.dataformat
    case 0
        set(handles.IFCB_format1_menu, 'checked', 'on')
    case 1
        set(handles.IFCB_format2_menu, 'checked', 'on')
    case 2
        set(handles.VPR_format1_menu, 'checked', 'on')
end

%check about enable status
if get(handles.pick_mode_checkbox,'value')
    set([handles.classpath_text handles.class_filestr_text handles.class_filestr_label handles.classpath_label handles.classpath_browse], 'visible', 'on')
else
    set([handles.classpath_text handles.class_filestr_text handles.class_filestr_label handles.classpath_label handles.classpath_browse], 'visible', 'off')
end
guidata(handles.main_figure, handles);



%
function MCconfig = MCconfig_default()
settings = struct('start_new_radiobutton', 1, 'review_radiobutton', 0, 'simple_paths_radiobutton', 1, 'resolver_func_radiobutton', 0, 'pick_mode_checkbox', 0, 'all_file_checkbox', 0);
MCconfig = struct(...
    'pick_mode', 'raw_roi',...
    'display_order', 1,...
    'alphabetize', 1,...
    'maxlist1', 75,...
    'threshold_mode', 1,...
    'x_pixel_threshold', 150,...
    'y_pixel_threshold', 75,...
    'setsize', 200,...
    'pixel_per_micron', 3.4,...
    'bar_length_micron', 10,...
    'imresize_factor', 1,...
    'resultpath', 'C:\IFCB\Manual\',...
    'roibase_path', 'C:\IFCB\data\',...
    'classpath', 'C:\IFCB\class\',...
    'class2use_file', '',...
    'class2use', {'unclassified'},...
    'class_filestr', '_class_v1',...
    'default_class', 'unclassified',...
    'resultfiles', [],...
    'class2view1', {'unclassified'},...
    'dataformat', 0,...
    'stitchfiles', [],...
    'classfiles', [],...
    'roifiles', [],...
    'verbose', 1,...
    'list_fontsize', 8,...
    'filenum2start', 1,...
    'settings', settings...
    );
MCconfig.class2use = {'unclassified' 'class1'};

% --- Outputs from this function are returned to the command line.
function varargout = ManageMCconfig_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure

%varargout{1} = handles.output;
varargout{1} = handles.MCconfig;
% The figure can be deleted now
delete(hObject);


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

oldpath = handles.MCconfig.roibase_path;
handles.MCconfig.roibase_path = get(hObject, 'string');
guidata(handles.main_figure, handles);
if ~isequal(get(hObject, 'string'), oldpath) %if path changed
%       handles.MCconfig.roifiles = [];
       if get(handles.all_file_checkbox, 'value')
           all_file_checkbox_Callback([], [], handles)
       else
           handles.MCconfig.roifiles = [];
           update_filelists(handles)       
       end
end
   


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
path1 = get(handles.roipath_text,'String');
roipath = uigetdir(path1);
if roipath
    set(handles.roipath_text, 'string', roipath)
    roipath_text_Callback([], [], handles)
end



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
            set(hObject,'String', num2str(handles.MCconfig.maxlist1));
           uiwait(msgbox([handles.msgbox_fontstr 'Left list size must be a positive integer'], handles.msgbox_cs))
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
hset = [handles.classpath_text handles.class_filestr_text handles.classpath_label handles.classpath_browse handles.class_filestr_label handles.classfiles_listbox handles.classfiles_text];
if get(handles.pick_mode_checkbox, 'Value')
    set(hset, 'visible', 'on')
    update_filelists(handles)
else
    set(hset, 'visible', 'off')
    handles.MCconfig.classfiles = [];
    guidata(handles.main_figure, handles);
end


function manualpath_text_Callback(hObject, eventdata, handles)
% hObject    handle to manualpath_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of manualpath_text as text
%        str2double(get(hObject,'String')) returns contents of manualpath_text as a double
if get(handles.all_file_checkbox, 'value') %&& get(handles.review_radiobutton, 'value')
    all_file_checkbox_Callback(hObject, [], handles)
end
update_filelists (handles)
guidata(handles.main_figure, handles);


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
path1 = get(handles.manualpath_text,'String');
manualpath = uigetdir(path1);
if manualpath
   set(handles.manualpath_text, 'string', manualpath)
   manualpath_text_Callback([], [], handles)
end


function classpath_text_Callback(hObject, eventdata, handles)
% hObject    handle to classpath_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of classpath_text as text
%        str2double(get(hObject,'String')) returns contents of classpath_text as a double
%   p = get(handles.classpath_text, 'string');
   update_filelists(handles)
   guidata(handles.main_figure, handles);

   
   

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
path1 = get(handles.classpath_text,'String');
classpath = uigetdir(path1, 'Pick a class file directory');
if classpath
    set(handles.classpath_text, 'string', classpath)
    classpath_text_Callback(hObject, [], handles)
end


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
           set(hObject,'String', num2str(handles.MCconfig.imresize_factor));
           uiwait(msgbox([handles.msgbox_fontstr 'Rescale factor must be a positive number'], handles.msgbox_cs))
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
if ~isfield(handles.MCconfig.settings,'configfile')
    handles.MCconfig.settings.configfile = [ handles.configpath 'last.mcconfig.mat'];
end
%following to manage uiwait to control no output until user is done (heidi)
if isequal(get(hObject, 'waitstatus'), 'waiting')
% The GUI is still in UIWAIT, us UIRESUME
uiresume(handles.main_figure);
else
% The GUI is no longer waiting, just close it
delete(handles.main_figure);
end


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
filename = get(handles.class2use_file_text, 'string');
if ~strcmp(filename, 'class2use_file') && ~isempty(filename)
    temp = ManageClassLabels(cellstr(filename), {'fromMC'});
else
    temp = ManageClassLabels(); %open class2use gui with blank list
end
if ~isempty(temp.filename)
    handles.MCconfig.class2use = temp.class2use;
    handles.filename = temp.filename;
    set(handles.class2use_listbox, 'string', temp.class2use, 'min', 0, 'max', length(temp.class2use), 'value', []);
    set(handles.default_class_popup, 'string', temp.class2use);
    [~,~,v] = intersect(handles.MCconfig.default_class, temp.class2use);
    if ~isempty(v)
        set(handles.default_class_popup, 'value', v);
    else
        set(handles.default_class_popup, 'value', 1);
    end;
    set(handles.class2use_file_text, 'string', temp.filename);
    %reset the highlights for class2view if current are subset of just loaded class2use
    str = handles.MCconfig.class2view1;
    if ~isempty(str)
        [~,~,v] = intersect(str, get(handles.class2use_listbox, 'string'));
        if ~isempty(v)
            set(handles.class2use_listbox,'value', v, 'listboxtop', 1)
        end;
        %reset class2view in case not all retained
        handles.MCconfig.class2view1 = v;
    end
    guidata(handles.main_figure, handles);
    %reset highlights for class2view to match status of checkbox
    class2view_all_checkbox_Callback(hObject, eventdata, handles)
else
    msgbox([handles.msgbox_fontstr 'No list loaded. You must save a class2use file to load here.'], handles.msgbox_cs)
end;


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
function Save_menu_Callback(hObject, eventdata, handles)
% hObject    handle to Save_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

uicontrol(handles.maxlist1_label) %just make sure the cursor wasn't left in an edit box
drawnow
for ii = 1:size(handles.config_map,1), 
    map = handles.config_map(ii,:);
    h = handles.(map{2});
    if strcmp(get(h, 'style'), 'checkbox') || strcmp(get(h, 'style'), 'radiobutton')
        v = get(h, 'value');
        if ~isempty(map{3})
            handles.MCconfig.(char(map(1))) = char(map{3}(v+1)); 
        else
            eval(['handles.MCconfig.' char(map(1)) ' = v;']) %manage case with nested structures for radiobuttons
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
            %[vstr s] = str2num(str{v});
            if isnumeric(handles.MCconfig.(char(map(1))))  %s 
                handles.MCconfig.(char(map(1))) = v; %vstr;
            else
                handles.MCconfig.(char(map(1))) = str(v);
            end
        elseif strcmp(map(3), 'value2str')
            v = get(h, 'value');
            handles.MCconfig.(char(map(1))) = str2num((str{v}));
        end
    end
end

%check dataformat
if isequal(get(handles.IFCB_format1_menu, 'checked'), 'on')
    handles.MCconfig.dataformat = 0;
elseif isequal(get(handles.IFCB_format2_menu, 'checked'), 'on')
    handles.MCconfig.dataformat = 1;
else %isequal(get(handles.VPR_format1_menu, 'checked'), 'on')
    handles.MCconfig.dataformat = 2;
end

MCconfig = handles.MCconfig;
guidata(handles.main_figure, handles);

if ~isequal(handles.MCconfig, handles.MCconfig_saved) && isempty(hObject)
    opt.Interpreter = 'tex'; opt.Default = 'Save';
    selectedButton = questdlg({[handles.msgbox_fontstr ' Are you sure you want to quit without saving changes?']}, 'Quit choice', 'Save', 'Quit now', opt);
    switch selectedButton
        case 'Save'
            if isempty(hObject)
                hObject = handles.main_figure;
            end
        case 'Quit now'
            hObject = [];
    end
end
if  ~isempty(hObject)
    if isfield(handles.MCconfig.settings,'configfile')
        [startp, ~] = fileparts(handles.MCconfig.settings.configfile);
    else
        startp = handles.configpath;
    end
    [f p] = uiputfile(['*.mcconfig.mat'], 'Save configuration', startp);
    outstr = '.mcconfig.mat'; 
    if isempty(findstr(f, '.mcconfig.mat'))  %work around for different behavior of uiputfile on MAC
        f = [f outstr];
    end
    if f
        fullf = [p f];
        handles.MCconfig.settings.configfile = fullf;
        handles.MCconfig_saved = handles.MCconfig;
        guidata(handles.main_figure, handles);
        save(fullf, 'MCconfig');
    end
end
save([ handles.configpath 'last.mcconfig.mat'], 'MCconfig');
% --------------------------------------------------------------------
function load_config_menu_Callback(hObject, eventdata, handles)
% hObject    handle to load_config_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if isfield(handles.MCconfig.settings,'configfile')
    [startp, ~] = fileparts(handles.MCconfig.settings.configfile);
else
    startp = handles.configpath;
end
[f p] = uigetfile(fullfile(startp, '*.mcconfig.mat'), 'Load config');
if f
    fullf = [p f];
    temp = load([ p f]);
    if isfield(temp, 'MCconfig')
        handles.MCconfig = temp.MCconfig;
        handles.MCconfig.settings.configfile = fullf;
    else
        msgbox([handles.msgbox_fontstr 'Not a valid configuration file'], handles.msgbox_cs)
    end
end
map_MCconfig2GUI(hObject, handles);



% --- Executes on selection change in threshold_mode_popup.
function threshold_mode_popup_Callback(hObject, eventdata, handles)
% hObject    handle to threshold_mode_popup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns threshold_mode_popup contents as cell array
%        contents{get(hObject,'Value')} returns selected item from threshold_mode_popup
if get(handles.threshold_mode_popup, 'value') ~= 1
    set([handles.xsize_label handles.xsize_text handles.xsize_units_label handles.ysize_label handles.ysize_text handles.ysize_units_label], 'visible', 'on')
else
    set([handles.xsize_label handles.xsize_text handles.xsize_units_label handles.ysize_label handles.ysize_text handles.ysize_units_label], 'visible', 'off')
end


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



function ysize_text_Callback(hObject, eventdata, handles)
% hObject    handle to ysize_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ysize_text as text
%        str2double(get(hObject,'String')) returns contents of ysize_text as a double
  [val status] = str2num(get(hObject,'String'));
        if ~status || (status && (rem(val,1) ~= 0 || val <= 0))
            set(hObject,'String', num2str(handles.MCconfig.y_pixel_threshold));
           uiwait(msgbox([handles.msgbox_fontstr 'y size threshold must be a positive integer'], handles.msgbox_cs))
        end;

% --- Executes during object creation, after setting all properties.
function ysize_text_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ysize_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function xsize_text_Callback(hObject, eventdata, handles)
% hObject    handle to xsize_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of xsize_text as text
%        str2double(get(hObject,'String')) returns contents of xsize_text as a double

[val status] = str2num(get(hObject,'String'));
        if ~status || (status && (rem(val,1) ~= 0 || val <= 0))
            set(hObject,'String', num2str(handles.MCconfig.y_pixel_threshold));
           uiwait(msgbox([handles.msgbox_fontstr 'x size threshold must be a positive integer'], handles.msgbox_cs))
        end;
        
        
% --- Executes during object creation, after setting all properties.
function xsize_text_CreateFcn(hObject, eventdata, handles)
% hObject    handle to xsize_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function setsize_text_Callback(hObject, eventdata, handles)
% hObject    handle to setsize_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of setsize_text as text
%        str2double(get(hObject,'String')) returns contents of setsize_text as a double

[val status] = str2num(get(hObject,'String'));
        if ~status || (status && (rem(val,1) ~= 0 || val <= 0))
            set(hObject,'String', num2str(handles.MCconfig.setsize));
           uiwait(msgbox([handles.msgbox_fontstr 'Set size must be a positive integer'], handles.msgbox_cs))
        end;

% --- Executes during object creation, after setting all properties.
function setsize_text_CreateFcn(hObject, eventdata, handles)
% hObject    handle to setsize_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function bar_length_text_Callback(hObject, eventdata, handles)
% hObject    handle to bar_length_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of bar_length_text as text
%        str2double(get(hObject,'String')) returns contents of bar_length_text as a double
[val status] = str2num(get(hObject,'String'));
        if ~status || (status && (rem(val,1) ~= 0 || val <= 0))
            set(hObject,'String', num2str(handles.MCconfig.bar_length_micron));
           uiwait(msgbox([handles.msgbox_fontstr 'Scale bar length must be a positive integer'], handles.msgbox_cs))
        end;

% --- Executes during object creation, after setting all properties.
function bar_length_text_CreateFcn(hObject, eventdata, handles)
% hObject    handle to bar_length_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function pixels_per_micron_text_Callback(hObject, eventdata, handles)
% hObject    handle to pixels_per_micron_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of pixels_per_micron_text as text
%        str2double(get(hObject,'String')) returns contents of pixels_per_micron_text as a double

   [val status] = str2num(get(hObject,'String'));
        if ~status || val <= 0 
           set(hObject,'String', num2str(handles.MCconfig.pixel_per_micron));
           uiwait(msgbox([handles.msgbox_fontstr 'Pixels per micron value must be a positive number'], handles.msgbox_cs))
        end;

        
% --- Executes during object creation, after setting all properties.
function pixels_per_micron_text_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pixels_per_micron_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function bar_length_label_CreateFcn(hObject, eventdata, handles)
% hObject    handle to bar_length_label (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --------------------------------------------------------------------
function File_menu_Callback(hObject, eventdata, handles)
% hObject    handle to File_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function reset_default_menu_Callback(hObject, eventdata, handles)
% hObject    handle to reset_default_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.MCconfig = MCconfig_default();
map_MCconfig2GUI(hObject, handles)



% --- Executes on button press in select_files_pushbutton.
function select_files_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to select_files_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(handles.review_radiobutton, 'value'),
    path2start = get(handles.manualpath_text, 'string');
    disp_str = 'Select files to review';
    filespec = '*.mat';
else %otherwise start_new_radiobutton is selected
    path2start = get(handles.roipath_text, 'string');
    disp_str = 'Select new ROI files';
    filespec = '*.roi';
end
[ f p ] = uigetfile([path2start filesep filespec], disp_str, 'multiselect', 'on');
if ~isequal(f,0)
    f = cellstr(f);
    fullf = cellstr([repmat(p,size(f,2),1), char(f)]);
    if get(handles.start_new_radiobutton, 'value')
        set(handles.roipath_text, 'string', p)
        handles.MCconfig.roifiles = unique([handles.MCconfig.roifiles; fullf]);
    else %review_radiobutton
        handles.MCconfig.resultfiles = unique([handles.MCconfig.resultfiles; fullf]);
    end
    guidata(handles.main_figure, handles);
    set(handles.select_files_pushbutton, 'string', 'Select more files')
    update_filelists (handles)
end;

% --- Executes on selection change in resultfiles_listbox.
function resultfiles_listbox_Callback(hObject, eventdata, handles)
% hObject    handle to resultfiles_listbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns resultfiles_listbox contents as cell array
%        contents{get(hObject,'Value')} returns selected item from resultfiles_listbox
set(hObject, 'value', []) %no function to selecing in this list box


% --- Executes during object creation, after setting all properties.
function resultfiles_listbox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to resultfiles_listbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --- Executes on button press in all_file_checkbox.
function all_file_checkbox_Callback(hObject, eventdata, handles)
% hObject    handle to all_file_checkbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of all_file_checkbox

if get(handles.all_file_checkbox,'value')
    if get(handles.review_radiobutton, 'value')
        p = [get(handles.manualpath_text, 'string') filesep];
        filespec = '*.mat';
        typestr = 'manual result';
    else
        p = [get(handles.roipath_text, 'string') filesep];
        filespec = '*.roi';
        typestr = 'image';
    end
    set(handles.select_files_pushbutton, 'enable', 'off')
    temp = dir([p filespec]);
    if isempty(temp)
        msgbox([handles.msgbox_fontstr 'No files found. Check your ' typestr 'path setting.'], handles.msgbox_cs)
        fullf = [];
        %set(handles.all_file_checkbox, 'value', 0)
    else
        f = {temp.name}';
        fullf = cellstr([repmat(p,size(f,1),1), char(f)]);
    end
    if get(handles.start_new_radiobutton, 'value')
        handles.MCconfig.roifiles = fullf;
    else %review_radiobutton
        handles.MCconfig.resultfiles = fullf;
    end
    guidata(handles.main_figure, handles);
    update_filelists( handles )
else
    set(handles.select_files_pushbutton, 'enable', 'on')
    clear_files_pushbutton_Callback(hObject, eventdata, handles)
end


% --- Executes on button press in clear_files_pushbutton.
function clear_files_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to clear_files_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.resultfiles_listbox, 'string', [])
set(handles.roifiles_listbox, 'string', [])
set(handles.classfiles_listbox, 'string', [])
handles.MCconfig.resultfiles = [];
handles.MCconfig.roifiles = [];
handles.MCconfig.classfiles = [];
set(handles.select_files_pushbutton, 'string', 'Select files')
guidata(handles.main_figure, handles);


% --- Executes when selected object is changed in new_review_buttongroup.
function new_review_buttongroup_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in new_review_buttongroup 
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)
if ~isempty(get(handles.resultfiles_listbox, 'string'))
    opt.Interpreter = 'tex'; opt.Default = 'Cancel';
    if isequal(get(handles.main_figure, 'visible'), 'on') %skip the first passed through when starting up
        button = questdlg([handles.msgbox_fontstr 'Switching file selection method will clear your current file list'], 'New or Review', 'Clear list', 'Cancel', opt);
        if isequal(button, 'Clear list')
            clear_files_pushbutton_Callback(hObject, [], handles)
            if get(handles.all_file_checkbox, 'value')
                all_file_checkbox_Callback(hObject, [], handles)
            end
        else
            set(handles.new_review_buttongroup, 'selectedobject', eventdata.OldValue)
        end
    end
end
if isequal(get(get(handles.new_review_buttongroup, 'selectedobject'), 'tag'), 'review_radiobutton')
    set(handles.pick_mode_checkbox, 'enable', 'off', 'value', 0)
else
    set(handles.pick_mode_checkbox, 'enable', 'on')
end
pick_mode_checkbox_Callback([], [], handles)
guidata(handles.main_figure, handles);



function resolver_function_edit_Callback(hObject, eventdata, handles)
% hObject    handle to resolver_function_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of resolver_function_edit as text
%        str2double(get(hObject,'String')) returns contents of resolver_function_edit as a double


% --- Executes during object creation, after setting all properties.
function resolver_function_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to resolver_function_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in resolver_browse.
function resolver_browse_Callback(hObject, eventdata, handles)
% hObject    handle to resolver_browse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
p = handles.configpath;
[ f p ] = uigetfile([p filesep 'resolve*.m'], 'resolve*.m');
if f
    set(handles.resolver_function_text, 'string', roipath)
end


% --- Executes on selection change in classfiles_listbox.
function classfiles_listbox_Callback(hObject, eventdata, handles)
% hObject    handle to classfiles_listbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns classfiles_listbox contents as cell array
%        contents{get(hObject,'Value')} returns selected item from classfiles_listbox
set(hObject, 'value', []) %no function to selecing in this list box


% --- Executes during object creation, after setting all properties.
function classfiles_listbox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to classfiles_listbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes when selected object is changed in resolve_file_locations_buttongroup.
function resolve_file_locations_buttongroup_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in resolve_file_locations_buttongroup 
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)
hset = [handles.resolver_function_edit handles.resolver_browse];
if isequal(eventdata.NewValue, handles.resolver_func_radiobutton)
    set(hset, 'visible', 'on')
else
    set(hset, 'visible', 'off')
end
    


% --- Executes during object creation, after setting all properties.
function roifiles_listbox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to roifiles_listbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function new_review_buttongroup_CreateFcn(hObject, eventdata, handles)
% hObject    handle to new_review_buttongroup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


function update_filelists (handles)
if ~exist(get(handles.manualpath_text, 'string'), 'dir')
    if isequal(get(handles.main_figure, 'visible'), 'on') %skip the first passed through when starting up                
        msgbox([handles.msgbox_fontstr 'Path not found - select a valid manual result path.'], handles.msgbox_cs)
    end
    set(handles.resultfiles_listbox, 'string', [])
else
    if get(handles.simple_paths_radiobutton, 'value')
        if isequal(get(get(handles.new_review_buttongroup, 'selectedobject'), 'tag'), 'review_radiobutton')
            set(handles.resultfiles_listbox, 'string', handles.MCconfig.resultfiles)
            h = handles.resultfiles_listbox; %review means manual list is master
            [~, f] = cellfun(@fileparts,cellstr(get(h, 'string')), 'uniformoutput', false);
            p = get(handles.roipath_text, 'string');
            x = '.roi';
            if ~isempty(f{1})
                f = cellstr([char(f) repmat(x,size(f,1),1)]);
                fullf = fullfile(p,f);
                temp = cellfun(@exist, fullf, 'uniformoutput', true);
            else
                fullf = [];
                temp = [];
            end
            handles.MCconfig.roifiles = fullf;
            set(handles.roifiles_listbox, 'string', handles.MCconfig.roifiles);
            temp = find(temp==0);
            if ~isempty(temp)
                for ii = 1:length(temp), fullf(temp(ii)) = {['<html><font color="red">', fullf{temp(ii)}, '</font><html>']}; end
                set(handles.roifiles_listbox, 'string', fullf)
                    if isequal(get(handles.main_figure, 'visible'), 'on') %skip the first passed through when starting up                
                        msgbox({[handles.msgbox_fontstr 'Image files shown in red text cannot be found.']; ' ';  'If your image data is in multiple folders, ''simple paths'' is not an option.'; ' '; 'Specify a resolver function instead.'}, handles.msgbox_cs)
                    end
                %handles.file_check_flag = 1; %one or more bad roi files
            end
        else
            set(handles.roifiles_listbox, 'string', handles.MCconfig.roifiles)
            h = handles.roifiles_listbox; %new means roi list is master
            [~, f] = cellfun(@fileparts,cellstr(get(h, 'string')), 'uniformoutput', false);
            p = get(handles.manualpath_text, 'string');
            x = '.mat';
            if ~isempty(f{1})
                fullf = cellstr([char(f) repmat(x,size(f,1),1)]);
                fullf = fullfile(p,fullf);
            else
                fullf = [];
            end;
            handles.MCconfig.resultfiles = fullf;
            set(handles.resultfiles_listbox, 'string', handles.MCconfig.resultfiles);           
            if get(handles.pick_mode_checkbox, 'value')  %check for classfiles
                %f as above %f = handles.MCconfig.binlist;
                p = get(handles.classpath_text, 'string');
                x = [get(handles.class_filestr_text, 'string') '.mat'];
                if ~isempty(f{1})
                    f = cellstr([char(f) repmat(x,size(f,1),1)]);
                    fullf = fullfile(p,f);
                    temp = cellfun(@exist, fullf, 'uniformoutput', true);
                else
                    fullf = [];
                    temp = [];
                end
                handles.MCconfig.classfiles = fullf;
                set(handles.classfiles_listbox, 'string', handles.MCconfig.classfiles);
                temp = find(temp==0);
                if ~isempty(temp)
                    for ii = 1:length(temp), fullf(temp(ii)) = {['<html><font color="red">', fullf{temp(ii)}, '</font><html>']}; end
                    set(handles.classfiles_listbox, 'string', fullf)
                    if isequal(get(handles.main_figure, 'visible'), 'on') %skip the first passed through when starting up
                        msgbox({[handles.msgbox_fontstr 'Class files shown in red text cannot be found. Verify class file path.'];' '; 'If your classes files are in multiple folders, ''simple paths'' is not an option. Specify a resolver function instead.'; ' '; 'If you proceed with these settings, the files in red will be displayed without considering classifier results.'}, 'Missing Class Files', handles.msgbox_cs)
                    end
                 %   handles.file_check_flag = 1; %one or more bad roi files
                end   
            end
        end
        % [~, handles.MCconfig.binlist] = cellfun(@fileparts,get(handles.resultfiles_listbox, 'string'), 'uniformoutput', false);
    else
        %case for resolver function
    end
    if ~isempty(handles.MCconfig.resultfiles)
        [~,temp] = fileparts(handles.MCconfig.resultfiles{1});
        if isequal(temp(1), 'I')
            set(get(get(handles.IFCB_format1_menu, 'parent'), 'children'),'checked', 'off') %set all in submenu to off
            set(handles.IFCB_format1_menu, 'checked', 'on')
        elseif isequal(temp(1), 'D')
            set(get(get(handles.IFCB_format1_menu, 'parent'), 'children'),'checked', 'off') %set all in submenu to off
            set(handles.IFCB_format2_menu, 'checked', 'on')
        end
        set(handles.start_file_popup, 'string', cellstr(num2str((1:length(handles.MCconfig.resultfiles))')))
    end
    guidata(handles.main_figure, handles);
end


% --- Executes on button press in verbose_checkbox.
function verbose_checkbox_Callback(hObject, eventdata, handles)
% hObject    handle to verbose_checkbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of verbose_checkbox


% --- Executes on selection change in list_fontsize_popup.
function list_fontsize_popup_Callback(hObject, eventdata, handles)
% hObject    handle to list_fontsize_popup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns list_fontsize_popup contents as cell array
%        contents{get(hObject,'Value')} returns selected item from list_fontsize_popup


% --- Executes during object creation, after setting all properties.
function list_fontsize_popup_CreateFcn(hObject, eventdata, handles)
% hObject    handle to list_fontsize_popup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --------------------------------------------------------------------
function VPR_format1_menu_Callback(hObject, eventdata, handles)
% hObject    handle to VPR_format1_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if isequal(get(hObject, 'checked'), 'off')
    set(get(get(hObject, 'parent'), 'children'),'checked', 'off') %set all in submenu to off
    set(hObject, 'checked', 'on')
else
    set(hObject, 'checked', 'off')
end
handles.MCconfig.dataformat = 2; %get(handles.VPR_format1_menu, 'value'); 
guidata(handles.main_figure, handles);



% --------------------------------------------------------------------
function IFCB_format1_menu_Callback(hObject, eventdata, handles)
% hObject    handle to IFCB_format1_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function IFCB_format2_menu_Callback(hObject, eventdata, handles)
% hObject    handle to IFCB_format2_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function advanced_menu_Callback(hObject, eventdata, handles)
% hObject    handle to advanced_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function dataformat_menu_Callback(hObject, eventdata, handles)
% hObject    handle to dataformat_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function dataformat_contextmenu_Callback(hObject, eventdata, handles)
% hObject    handle to dataformat_contextmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
