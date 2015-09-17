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

% Last Modified by GUIDE v2.5 27-May-2015 18:59:00

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
    'filenum2start' 'start_file_popup' 'value';... %'value2str';...
    'resolver_function' 'resolver_function_edit' '';...
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
if length(varargin) > 0 %handle input config file
    f = char(varargin{1});
end;
if exist('f', 'var')%~isempty(f)
    fullf = f;
    if isequal(f, 'default')
        handles.MCconfig = MCconfig_default();
    elseif isequal(exist(f, 'file'), 2),
        temp = load(f);
        handles.MCconfig = temp.MCconfig;
    elseif ~isempty(f)
        fullf = [handles.configpath f '.mcconfig.mat'];
        temp = load([handles.configpath f '.mcconfig.mat']);
        handles.MCconfig = temp.MCconfig;
    end;
    handles.MCconfig.settings.configfile = fullf;
else %otherwise get last config if exists
    fullf = [ handles.configpath 'last.mcconfig.mat'];
    if exist(fullf, 'file'),
        temp = load(fullf);
        handles.MCconfig = temp.MCconfig;
        handles.MCconfig.settings.configfile = fullf;
    else
        handles.MCconfig = MCconfig_default();
        if ~exist('config', 'dir'),
            mkdir('config')
        end
    end    
end
if length(varargin) > 1 %handle input filelist
    handles.MCconfig.resultfiles = varargin{2};
    handles.MCconfig.roifiles = varargin{2};
    handles.MCconfig.settings.all_file_checkbox = 0;
end

handles.MCconfig_saved = handles.MCconfig; %initialize to track save status

handles = map_MCconfig2GUI(hObject, eventdata, handles);
% Update handles structure
guidata(handles.MCconfig_main_figure, handles);

% UIWAIT makes ManageMCconfig wait for user response (see UIRESUME)
 uiwait(handles.MCconfig_main_figure);  %uncommented to control output wait for user completion (heidi)

%
function handles = map_MCconfig2GUI (hObject, eventdata, handles) 
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
                if v > length(get(h, 'string')) %reset to first value to avoid crash if invalid input
                    v = 1;
                end;
            else
                [~,~,v] = intersect(str, get(h, 'string'));
            end;
            set(h, 'value', v)
        elseif strcmp(map(3), 'value2str')
            num = handles.MCconfig.(char(map(1)));
            [~,~,v] = intersect(num2str(num), cellstr(char(get(h, 'string'))));
            %[~,~,v] = intersect(num, str2num(cell2mat(get(h, 'string')));
            if isempty(v) %reset to first value if invalid input
                v = 1;
            end
            set(h, 'value', v)
        else %all
            set(h, 'string', str);
        end      
    end
end


hset = [handles.IFCB_format1_menu handles.IFCB_format2_menu handles.VPR_format1_menu handles.FlowCam_format1_menu];
set(hset, 'checked', 'off')
switch handles.MCconfig.dataformat
    case 0
        set(handles.IFCB_format1_menu, 'checked', 'on')
    case 1
        set(handles.IFCB_format2_menu, 'checked', 'on')
    case 2
        set(handles.VPR_format1_menu, 'checked', 'on')
    case 3
        set(handles.FlowCam_format1_menu, 'checked', 'on')
end

%check about enable status
if get(handles.pick_mode_checkbox,'value')
    set([handles.classpath_text handles.class_filestr_text handles.class_filestr_label handles.classpath_label handles.classpath_browse], 'visible', 'on')
else
    set([handles.classpath_text handles.class_filestr_text handles.class_filestr_label handles.classpath_label handles.classpath_browse], 'visible', 'off')
end

%update settings to correspond to existing object status
eventdata_temp.opening = 1;
handles = alphabetize_checkbox_Callback(hObject, eventdata, handles);
all_file_checkbox_Callback(hObject, eventdata, handles)
threshold_mode_popup_Callback(hObject, eventdata, handles)
eventdata_temp.NewValue = get(handles.resolve_file_locations_buttongroup, 'selectedobject'); %what is it now
resolve_file_locations_buttongroup_SelectionChangeFcn(hObject, eventdata_temp, handles)
new_review_buttongroup_SelectionChangeFcn(handles.new_review_buttongroup, eventdata_temp, handles) %ensure correct related settings
%pick_mode_checkbox_Callback(handles.pick_mode_checkbox, [], handles) %must be done after new_review
update_filelists(handles)



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
    'settings', settings,...
    'resolver_function', 'resolve_files2gui.m'...
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
if ~isempty(handles) 
    % The figure can be deleted now
    delete(hObject);
else %user closed window pre-maturely (e.g., closed startMC)
    varargout{1} = [];
end


function roipath_text_Callback(hObject, eventdata, handles)
% hObject    handle to roipath_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of roipath_text as text
%        str2double(get(hObject,'String')) returns contents of roipath_text as a double
oldpath = handles.MCconfig.roibase_path;
handles.MCconfig.roibase_path = get(hObject, 'string');
guidata(handles.MCconfig_main_figure, handles);
if ~isequal(get(hObject, 'string'), oldpath) %if path changed
%       handles.MCconfig.roifiles = [];
       if get(handles.all_file_checkbox, 'value')
           all_file_checkbox_Callback([], [], handles)
       else
          % handles.MCconfig.roifiles = []; %handled now in all_file_checkbox_Callback
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
roipath = fullfile(uigetdir(path1), filesep);
if roipath
    set(handles.roipath_text, 'string', roipath)
    roipath_text_Callback([], [], handles)
end


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
function MCconfig_main_figure_CreateFcn(hObject, eventdata, handles)
% hObject    handle to MCconfig_main_figure (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in pick_mode_checkbox.
function pick_mode_checkbox_Callback(hObject, eventdata, handles)
% hObject    handle to pick_mode_checkbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hint: get(hObject,'Value') returns toggle state of pick_mode_checkbox
hset = [handles.classpath_text handles.class_filestr_text handles.classpath_label handles.classpath_browse handles.class_filestr_label handles.classfiles_listbox handles.classfiles_text];
if get(handles.pick_mode_checkbox, 'Value')  %correction case
    set(hset, 'visible', 'on')
    if ~isfield(eventdata, 'opening') %skip first time since update_filelists called again just after
        update_filelists(handles)
    end
else %raw_roi case (same for 'review existing')
    set(hset, 'visible', 'off')
    handles.MCconfig.classfiles = [];
    guidata(handles.MCconfig_main_figure, handles);
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
guidata(handles.MCconfig_main_figure, handles)


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
manualpath = fullfile(uigetdir(path1), filesep);
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
   guidata(handles.MCconfig_main_figure, handles); 
   

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


% --- Executes when MCconfig_main_figure is resized.
function MCconfig_main_figure_ResizeFcn(hObject, eventdata, handles)
% hObject    handle to MCconfig_main_figure (see GCBO)
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


% --- Executes when user attempts to close MCconfig_main_figure.
function MCconfig_main_figure_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to MCconfig_main_figure (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hint: delete(hObject) closes the figure
handles = Save_menu_Callback([], [], handles) %just save to last.mcconfig.mat
if ~isfield(handles.MCconfig.settings,'configfile')
    handles.MCconfig.settings.configfile = [ handles.configpath 'last.mcconfig.mat'];
end
guidata(handles.MCconfig_main_figure, handles);

%following to manage uiwait to control no output until user is done (heidi)
if isequal(get(handles.MCconfig_main_figure, 'waitstatus'), 'waiting')
%% The GUI is still in UIWAIT, us UIRESUME
    uiresume(handles.MCconfig_main_figure);
else
%% The GUI is no longer waiting, just close it
    delete(handles.MCconfig_main_figure);
end


% --- Executes on button press in alphabetize_checkbox.
function handles = alphabetize_checkbox_Callback(hObject, eventdata, handles)
% hObject    handle to alphabetize_checkbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of alphabetize_checkbox
%get any currently highlighted class2view
listnow = get(handles.class2use_listbox, 'string');
tempv = get(handles.class2use_listbox, 'value');
class2viewnow = listnow(tempv);
%now make sure the lists are set properly and synced to MCconfig.class2use (even if just loaded from save config)
listnow = handles.MCconfig.class2use;
if isequal(get(handles.alphabetize_checkbox, 'value'), 1)
    [~, sort_ind] = sort(lower(listnow));
    [~, handles.settings.class2use_sort_ind] = sort(sort_ind); %order to sort back to original from alphabetical
    listnow = listnow(sort_ind); %make sure keep original capitals
    set(handles.class2use_listbox, 'string', listnow);
else
    set(handles.class2use_listbox, 'string', listnow);
end
set(handles.default_class_popup, 'string', listnow);
[~,~,v] = intersect(handles.MCconfig.default_class, listnow);
if ~isempty(v)
    set(handles.default_class_popup, 'value', v);
else
    set(handles.default_class_popup, 'value', 1);
end;
%reset the highlights for class2view if current are subset of just loaded class2use
str = class2viewnow;
if ~isempty(str)
    [~,~,v] = intersect(str, listnow);
    if ~isempty(v)
        set(handles.class2use_listbox,'value', v, 'listboxtop', 1)
    end;
    %reset class2view in case not all retained
    handles.MCconfig.class2view1 = listnow(v);
end
guidata(handles.MCconfig_main_figure, handles);
    %reset highlights for class2view to match status of checkbox
%class2view_all_checkbox_Callback(hObject, eventdata, handles)


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
    temp = ManageClassLabels({''}, {'fromMC'}); %open class2use gui with blank list
end
if ~isempty(temp.filename)
    handles.MCconfig.class2use = temp.class2use;
    handles.filename = temp.filename;
    set(handles.class2use_listbox, 'string', temp.class2use, 'min', 0, 'max', length(temp.class2use), 'value', []);
    set(handles.class2use_file_text, 'string', temp.filename);
    handles = alphabetize_checkbox_Callback(hObject, eventdata, handles);
    guidata(handles.MCconfig_main_figure, handles);
else
    uiwait(msgbox([handles.msgbox_fontstr 'No list loaded. You must save a class2use file to load here.'], handles.msgbox_cs))
end;


% --- Executes on selection change in class2use_listbox.
function class2use_listbox_Callback(hObject, eventdata, handles)
% hObject    handle to class2use_listbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns class2use_listbox contents as cell array
%        contents{get(hObject,'Value')} returns selected item from class2use_listbox
temp = get(hObject, 'value');
if length(temp) < length(get(handles.class2use_listbox, 'string')) %if user has deselected some, make sure view all is unchecked
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
if get(handles.class2view_all_checkbox, 'value')
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
tempall = get(handles.default_class_popup, 'string');
tempv = get(handles.default_class_popup, 'value');
handles.MCconfig.default_class = tempall(tempv);
guidata(handles.MCconfig_main_figure, handles);


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
function handles = Save_menu_Callback(hObject, eventdata, handles)
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
%deal with special index conversion case if alphabetize in use
if isequal(get(handles.alphabetize_checkbox, 'value'), 1)
    handles.MCconfig.class2use = handles.MCconfig.class2use(handles.settings.class2use_sort_ind);
end;

%check stitchfile case for MVCO
if isempty(handles.MCconfig.resultfiles)
    handles.MCconfig.stitchfiles = [];
end

%check dataformat
if isequal(get(handles.IFCB_format1_menu, 'checked'), 'on')
    handles.MCconfig.dataformat = 0;
elseif isequal(get(handles.IFCB_format2_menu, 'checked'), 'on')
    handles.MCconfig.dataformat = 1;
elseif isequal(get(handles.VPR_format1_menu, 'checked'), 'on')
    handles.MCconfig.dataformat = 2;
elseif isequal(get(handles.FlowCam_format1_menu, 'checked'), 'on')
    handles.MCconfig.dataformat = 3;
end

MCconfig = handles.MCconfig;
guidata(handles.MCconfig_main_figure, handles);

if ~isequal(handles.MCconfig, handles.MCconfig_saved) && isempty(hObject)
    opt.Interpreter = 'tex'; opt.Default = 'Save';
    selectedButton = questdlg({[handles.msgbox_fontstr ' Are you sure you want to quit without saving changes?']}, 'Quit choice', 'Save', 'Quit now', opt);
    switch selectedButton
        case 'Save'
            if isempty(hObject)
                hObject = handles.MCconfig_main_figure;
            end
        case 'Quit now'
            hObject = [];
    end
end
if  ~isempty(hObject)
    if isfield(handles.MCconfig.settings,'configfile')
        [startp, ~] = fileparts(handles.MCconfig.settings.configfile);
        if isempty(startp)
            startp = handles.configpath;
        end
    else
        startp = handles.configpath;
    end
    [f p] = uiputfile(['*.mcconfig.mat'], 'Save configuration', startp);
    %outstr = '.mcconfig.mat'; 
    %if isempty(regexp(f, outstr))  %work around for different behavior of uiputfile on MAC
    %    f = regexprep(f, '.mat', outstr);
    %end
    if ~isequal(f,0)
        outstr = '.mcconfig.mat'; 
        if isempty(regexp(f, outstr))  %work around for different behavior of uiputfile on MAC
            f = regexprep(f, '.mat', outstr);
        end
        fullf = [p f];
        handles.MCconfig.settings.configfile = fullf;
        handles.MCconfig_saved = handles.MCconfig;
        guidata(handles.MCconfig_main_figure, handles);
        save(fullf, 'MCconfig');
    end
end
guidata(handles.MCconfig_main_figure, handles);
save([ handles.configpath 'last.mcconfig.mat'], 'MCconfig');


% --------------------------------------------------------------------
function load_config_menu_Callback(hObject, eventdata, handles)
% hObject    handle to load_config_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if isfield(handles.MCconfig.settings,'configfile')
    [startp, ~] = fileparts(handles.MCconfig.settings.configfile);
    if isempty(startp)
        startp = handles.configpath;
    end
else
    startp = handles.configpath;
end
[f p] = uigetfile(fullfile(startp, '*.mcconfig.mat'), 'Load config');
if ~isequal(f,0)
    fullf = [p f];
    temp = load([ p f]);
    if isfield(temp, 'MCconfig')
        handles.MCconfig = temp.MCconfig;
        handles.MCconfig.settings.configfile = fullf;
        handles.MCconfig_saved = handles.MCconfig; %initialize to track save status
    else
        uiwait(msgbox([handles.msgbox_fontstr 'Not a valid configuration file'], handles.msgbox_cs))
    end
end
map_MCconfig2GUI(hObject, eventdata, handles)


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


% --------------------------------------------------------------------
function reset_default_menu_Callback(hObject, eventdata, handles)
% hObject    handle to reset_default_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.MCconfig = MCconfig_default();
map_MCconfig2GUI(hObject, eventdata, handles)


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
        if get(handles.simple_paths_radiobutton, 'value')
            set(handles.roipath_text, 'string', p)
        end
        handles.MCconfig.roifiles = unique([handles.MCconfig.roifiles; fullf]);
    else %review_radiobutton
        handles.MCconfig.resultfiles = unique([handles.MCconfig.resultfiles; fullf]);
    end
    guidata(handles.MCconfig_main_figure, handles);
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
        %filespec = '*.mat';
        typestr = 'manual result';
        temp = [dir([p 'I*.mat']); dir([p 'D*.mat'])];
    else
        p = [get(handles.roipath_text, 'string') filesep];
        filespec = '*.roi';
        typestr = 'image';
        temp = dir([p filespec]);
    end
    set(handles.select_files_pushbutton, 'enable', 'off')
    if isempty(temp)
        uiwait(msgbox([handles.msgbox_fontstr 'No files found. Check your ' typestr 'path setting.'], handles.msgbox_cs))
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
    guidata(handles.MCconfig_main_figure, handles);
    if ~isfield(eventdata, 'opening') %skip first time since update_filelists called again just after    
        update_filelists( handles )
    end
else
    set(handles.select_files_pushbutton, 'enable', 'on')
    new_or_review = get(get(handles.new_review_buttongroup, 'selectedobject'), 'tag');
    switch new_or_review
        case 'review_radiobutton'
            handles.MCconfig.resultfiles = [];
        case 'start_new_radiobutton'
            handles.MCconfig.roifiles = [];
    end
    %clear_files_pushbutton_Callback(hObject, eventdata, handles)
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
handles.MCconfig.stitchfiles = [];
set(handles.select_files_pushbutton, 'string', 'Select files')
set(handles.all_file_checkbox, 'value', 0)
set(handles.start_file_popup, 'value', 1)
handles.MCconfig.filenum2start = 1;
guidata(handles.MCconfig_main_figure, handles);


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
    if isequal(get(handles.MCconfig_main_figure, 'visible'), 'on') %skip the first pass through when starting up
        button = questdlg([handles.msgbox_fontstr 'Switching file selection method will clear your current file list'], 'New or Review', 'Clear list', 'Cancel', opt);
        if isequal(button, 'Clear list')
            clear_files_pushbutton_Callback(hObject, [], handles)
            if get(handles.all_file_checkbox, 'value')
                all_file_checkbox_Callback(hObject, eventdata, handles)
            end
        else
            set(handles.new_review_buttongroup, 'selectedobject', eventdata.OldValue)
        end
    end
end
% if isequal(get(get(handles.new_review_buttongroup, 'selectedobject'), 'tag'), 'review_radiobutton')
%     set(handles.pick_mode_checkbox, 'enable', 'off', 'value', 0)
% else
%     set(handles.pick_mode_checkbox, 'enable', 'on')
% end
pick_mode_checkbox_Callback([], eventdata, handles)
guidata(handles.MCconfig_main_figure, handles);



function resolver_function_edit_Callback(hObject, eventdata, handles)
% hObject    handle to resolver_function_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of resolver_function_edit as text
%        str2double(get(hObject,'String')) returns contents of resolver_function_edit as a double
fullf = get(handles.resolver_function_edit, 'string');
if exist(fullf, 'file')
    set(handles.resolver_function_edit, 'foregroundcolor', 'k')
    update_filelists(handles)
else
    uiwait(msgbox([handles.msgbox_fontstr 'Resolver function not found - select a valid function.'], handles.msgbox_cs))
    set(handles.resolver_function_edit, 'foregroundcolor', 'r')
end

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
if ~isequal(f,0)
    set(handles.resolver_function_edit, 'string', fullfile(p,f), 'foregroundcolor', 'k')
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

%simple paths case
set(hset, 'visible', 'off')
set(handles.roipath_label, 'string', 'Image path (roi files)')
set(handles.classpath_label, 'string', 'Class file path')
if isequal(eventdata.NewValue, handles.standard_resolver_radiobutton) %standard resolver case
    set(handles.roipath_label, 'string', 'Common image path (roi files)')
    set(handles.classpath_label, 'string', 'Common class file path')
elseif isequal(eventdata.NewValue, handles.resolver_func_radiobutton) %custom resolver case
    set(hset, 'visible', 'on')
    resolver_function_edit_Callback(hObject, eventdata, handles)
elseif isequal(eventdata.NewValue, handles.simple_paths_radiobutton) %simple paths case
    set(handles.resolver_function_edit, 'string', [])
end
if ~isfield(eventdata, 'opening') %skip first time since update_filelists called again just after
    update_filelists(handles)
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
set(handles.status_text, 'string', 'Checking files...')
pause(.001)
m = msgbox('Checking file status...please wait.');
if ~exist(get(handles.manualpath_text, 'string'), 'dir')
    if isequal(get(handles.MCconfig_main_figure, 'visible'), 'on') %skip the first pass through when starting up
        uiwait(msgbox([handles.msgbox_fontstr 'Path not found - select a valid manual result path.'], handles.msgbox_cs))
    end
else %some manual files may be in listbox
    new_or_review = get(get(handles.new_review_buttongroup, 'selectedobject'), 'tag');
    switch new_or_review
        case 'review_radiobutton'
            f = handles.MCconfig.resultfiles;
            [~, f] = cellfun(@fileparts,f, 'uniformoutput', false); %bin only
        case 'start_new_radiobutton'
            f = handles.MCconfig.roifiles; 
            [~, f] = cellfun(@fileparts,f, 'uniformoutput', false); %bin only
    end
    p = get(handles.manualpath_text, 'string');
    x = '.mat';
    if ~isempty(f{1}) %set the manual files list
        fullf = cellstr([char(f) repmat(x,length(f),1)]);
        fullf = fullfile(p,fullf);
        temp = cellfun(@exist, fullf, 'uniformoutput', true);
    else
        fullf = [];
        temp = [];
    end
    handles.MCconfig.resultfiles = fullf;
    set(handles.resultfiles_listbox, 'string', handles.MCconfig.resultfiles)
    
    %now set the roi files
    path_method = get(get(handles.resolve_file_locations_buttongroup, 'selectedobject'), 'tag');
    switch path_method
        case 'simple_paths_radiobutton'
            p = get(handles.roipath_text, 'string');
            if ~isempty(f{1})
                if handles.MCconfig.dataformat == 2 %VPR case
                    fullf = cellstr(fullfile(p,filesep)); %make sure has trailing filesep
                else %other cases
                    x = '.roi';
                    fullf = cellstr([char(f) repmat(x,size(f,1),1)]);
                    fullf = fullfile(p,fullf);
                end;
                temp = cellfun(@exist, fullf, 'uniformoutput', true);
            else
                fullf = [];
                temp = [];
            end
            handles.MCconfig.roifiles = fullf;
        case {'standard_resolver_radiobutton' 'resolver_func_radiobutton'} %resolver case
            if ~isempty(handles.MCconfig.resultfiles),
                handles = resolve_files(handles, handles.MCconfig.resultfiles);
            end
    end
    set(handles.roifiles_listbox, 'string', handles.MCconfig.roifiles);
    
    %now set the class files
    if get(handles.pick_mode_checkbox, 'value')  %check for classfiles
        switch path_method
            case 'simple_paths_radiobutton'
                p = get(handles.classpath_text, 'string');
                x = [get(handles.class_filestr_text, 'string') '.mat'];
                if ~isempty(f{1})
                    f = cellstr([char(f) repmat(x,size(f,1),1)]);
                    fullf = fullfile(p,f);
                else
                    fullf = [];
                end
                handles.MCconfig.classfiles = fullf;
            case {'standard_resolver_radiobutton' 'resolver_func_radiobutton'}
                if ~isempty(handles.MCconfig.roifiles)
                    handles = resolve_files(handles, handles.MCconfig.roifiles);
                end
        end
    else %don't start from classifier
        handles.MCconfig.classfiles = []; %make sure empty if not starting from class even by resolver function
        %run resolver anyway in case need stitch files for MVCO custom resolver
        if ~isempty(handles.MCconfig.roifiles) && ~get(handles.simple_paths_radiobutton, 'value')
            handles = resolve_files(handles, handles.MCconfig.roifiles);
        end
    end
    set(handles.classfiles_listbox, 'string', handles.MCconfig.classfiles);
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
%check and mark missing class files
if ~isempty(handles.MCconfig.classfiles) && isequal(get(handles.classfiles_listbox, 'visible'), 'on')
    fullf = mark_notfound_inlist(handles.MCconfig.classfiles, handles);
    set(handles.classfiles_listbox, 'string', fullf)
end
%mark all result files missing if manualpath is missing
if ~isempty(handles.MCconfig.resultfiles)
    if ~exist(get(handles.manualpath_text, 'string'), 'dir')
        fullf = handles.MCconfig.resultfiles;
        for ii = 1:length(fullf), fullf(ii) = {['<html><font color="red">', fullf{ii}, '</font><html>']}; end
        %fullf = mark_notfound_inlist(handles.MCconfig.resultfiles, handles);
        set(handles.resultfiles_listbox, 'string', fullf)
    end
end
%check and mark missing roi files
if ~isempty(handles.MCconfig.roifiles)
    fullf = mark_notfound_inlist(handles.MCconfig.roifiles, handles);
    set(handles.roifiles_listbox, 'string', fullf)
end

guidata(handles.MCconfig_main_figure, handles);
set(handles.status_text, 'string', 'Status: Ready')
if ishandle(m)
    delete(m)
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
guidata(handles.MCconfig_main_figure, handles);


% --------------------------------------------------------------------
function FlowCam_format1_menu_Callback(hObject, eventdata, handles)
% hObject    handle to FlowCam_format1_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if isequal(get(hObject, 'checked'), 'off')
    set(get(get(hObject, 'parent'), 'children'),'checked', 'off') %set all in submenu to off
    set(hObject, 'checked', 'on')
else
    set(hObject, 'checked', 'off')
end
handles.MCconfig.dataformat = 3; %get(handles.VPR_format1_menu, 'value'); 
guidata(handles.MCconfig_main_figure, handles);


% --- Executes on button press in return_pushbutton.
function return_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to return_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
MCconfig_main_figure_CloseRequestFcn(hObject, eventdata, handles)

function handles = resolve_files(handles, filelist)
if get(handles.standard_resolver_radiobutton, 'value')
    resolver_handle = @resolve_standard;
else
    full_func_file = get(handles.resolver_function_edit, 'string');
    [p f] = fileparts(full_func_file);
    if exist(full_func_file, 'file')
        pnow = pwd;
        cd(p)
        resolver_handle = str2func(f);
        cd(pnow)
    else
        resolver_handle = [];
        uiwait(msgbox([handles.msgbox_fontstr 'Resolver function not found - select a valid function file.'], handles.msgbox_cs))  
        set(handles.resolver_function_edit, 'foregroundcolor', 'r')
    end
end
if ~isempty(resolver_handle)
    baseroi = get(handles.roipath_text, 'string');
    baseclass = get(handles.classpath_text, 'string');
    class_filestr = get(handles.class_filestr_text, 'string');
    fstruct = feval(resolver_handle, filelist, baseroi, baseclass, class_filestr); 
    handles.MCconfig.roifiles = fstruct.roifiles;
    handles.MCconfig.classfiles = fstruct.classfiles;
    if isfield(fstruct, 'stitchfiles')
        handles.MCconfig.stitchfiles = fstruct.stitchfiles;
    end
    guidata(handles.MCconfig_main_figure, handles);   
end


function files_struct = resolve_standard(filelist, baseroipath, baseclasspath, class_filestr);
%standard case for <base_path>\yyyy\<IFCB_day_dir>\
[~,files] = cellfun(@fileparts,filelist, 'uniformoutput', false);

files = char(files);
n = length(filelist);
sep = repmat(filesep,n,1);

%create lists of roi/class files with fullpath
roibase = repmat(char(baseroipath),n,1);
classbase = repmat(char(baseclasspath),n,1);
roiext = repmat('.roi',n,1);
classext = repmat([class_filestr '.mat'],n,1);
if files(1,1) == 'D',
    roipath = [roibase files(:,2:5) sep files(:,1:9) sep];
    classpath = [classbase files(:,2:5) sep files(:,1:9) sep]; 
else      
    roipath = [roibase sep files(:,7:10) sep files(:,1:14) sep];
    classpath = [classbase sep files(:,7:10) sep files(:,1:14) sep]; 
end;
roifiles = cellstr([roipath files roiext]);
classfiles = cellstr([classpath files classext]);

files_struct.classfiles = classfiles;
files_struct.roifiles = roifiles;


function fullf = mark_notfound_inlist(fullf, handles)
    missing = cellfun(@exist, fullf, 'uniformoutput', true);
    missing = find(missing==0);
    if ~isempty(missing)
        for ii = 1:length(missing), fullf(missing(ii)) = {['<html><font color="red">', fullf{missing(ii)}, '</font><html>']}; end
    %    handles.file_check_flag = 1; %one or more bad roi files
    if isequal(get(handles.MCconfig_main_figure, 'visible'), 'on') %skip the first pass through when starting up
        uiwait(msgbox({[handles.msgbox_fontstr 'Files shown in red text cannot be found.']; ' ';  'If your data is in multiple folders, ''simple paths'' is not an option.'; ' '; 'Specify a resolver function instead.'}, handles.msgbox_cs))
    end
    end


% --------------------------------------------------------------------
function quit_menu_Callback(hObject, eventdata, handles)
% hObject    handle to quit_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
MCconfig_main_figure_CloseRequestFcn(hObject, eventdata, handles)



% % DISCARD
% % function update_filelists (handles)
% % set(handles.status_text, 'string', 'Checking files...')
% % pause(.001)
% % m = msgbox('Checking file status...please wait.');
% % if ~exist(get(handles.manualpath_text, 'string'), 'dir')
% %     if isequal(get(handles.MCconfig_main_figure, 'visible'), 'on') %skip the first pass through when starting up
% %         uiwait(msgbox([handles.msgbox_fontstr 'Path not found - select a valid manual result path.'], handles.msgbox_cs))
% %     end
% % else %some manual files in listbox
% %     if isequal(get(get(handles.new_review_buttongroup, 'selectedobject'), 'tag'), 'review_radiobutton')
% %         f = handles.MCconfig.resultfiles;
% %         x = '.mat';
% %         [~, f] = cellfun(@fileparts,f, 'uniformoutput', false); %bin only
% %         p = get(handles.manualpath_text, 'string');
% %         if ~isempty(f{1})
% %                 f = cellstr([char(f) repmat(x,length(f),1)]);
% %                 fullf = fullfile(p,f);
% %                 temp = cellfun(@exist, fullf, 'uniformoutput', true);
% %             else
% %                 fullf = [];
% %                 temp = [];
% %         end
% %         handles.MCconfig.resultfiles = fullf;
% %         set(handles.resultfiles_listbox, 'string', handles.MCconfig.resultfiles)
% %         h = handles.resultfiles_listbox; %review means manual list is master
% %         if get(handles.simple_paths_radiobutton, 'value')
% %             [~, f] = cellfun(@fileparts,cellstr(get(h, 'string')), 'uniformoutput', false);
% %             p = get(handles.roipath_text, 'string');
% %             x = '.roi';
% %             if ~isempty(f{1})
% %                 f = cellstr([char(f) repmat(x,size(f,1),1)]);
% %                 fullf = fullfile(p,f);
% %                 temp = cellfun(@exist, fullf, 'uniformoutput', true);
% %             else
% %                 fullf = [];
% %                 temp = [];
% %             end
% %             handles.MCconfig.roifiles = fullf;
% %         else %resolver case
% %             if ~isempty(handles.MCconfig.resultfiles),
% %                 handles = resolve_files(handles, handles.MCconfig.resultfiles);
% %             end;
% %         end
% %         set(handles.roifiles_listbox, 'string', handles.MCconfig.roifiles);
% %     else  %start new
% %         fullf = handles.MCconfig.roifiles;
% %         set(handles.roifiles_listbox, 'string', fullf)
% %         h = handles.roifiles_listbox; %new means roi list is master
% %         [~, f] = cellfun(@fileparts,cellstr(get(h, 'string')), 'uniformoutput', false);
% %         p = get(handles.manualpath_text, 'string');
% %         p2 = get(handles.roipath_text, 'string');
% %         x = '.mat';
% %         x2 = '.roi';
% %         if ~isempty(f{1})
% %             fullf = cellstr([char(f) repmat(x,size(f,1),1)]);
% %             fullf = fullfile(p,fullf);
% %             fullf2 = cellstr([char(f) repmat(x2,size(f,1),1)]);
% %             fullf2 = fullfile(p2,fullf2);
% %         else
% %             fullf = [];
% %             fullf2 = [];
% %         end;
% %         handles.MCconfig.resultfiles = fullf;
% %         handles.MCconfig.roifiles = fullf2;
% %         set(handles.resultfiles_listbox, 'string', handles.MCconfig.resultfiles);
% %         set(handles.roifiles_listbox, 'string', handles.MCconfig.roifiles);
% %         if get(handles.pick_mode_checkbox, 'value')  %check for classfiles
% %             if get(handles.simple_paths_radiobutton, 'value')
% %                 %f as above
% %                 p = get(handles.classpath_text, 'string');
% %                 x = [get(handles.class_filestr_text, 'string') '.mat'];
% %                 if ~isempty(f{1})
% %                     f = cellstr([char(f) repmat(x,size(f,1),1)]);
% %                     fullf = fullfile(p,f);
% %                 else
% %                     fullf = [];
% %                 end
% %                 handles.MCconfig.classfiles = fullf;
% %             else
% %                 if ~isempty(handles.MCconfig.roifiles)
% %                     handles = resolve_files(handles, handles.MCconfig.roifiles);
% %                 end
% %             end
% %             set(handles.classfiles_listbox, 'string', handles.MCconfig.classfiles);
% %         else  %don't start from classifier
% %             handles.MCconfig.classfiles = [];%make sure empty if not starting from class even by resolver function
% %             %run resolver anyway in case need stitch files for MVCO custom resolver
% %             if ~isempty(handles.MCconfig.roifiles) && ~get(handles.simple_paths_radiobutton, 'value')
% %                 handles = resolve_files(handles, handles.MCconfig.roifiles);
% %             end
% %         end
% %     end
% %     if ~isempty(handles.MCconfig.resultfiles)
% %         [~,temp] = fileparts(handles.MCconfig.resultfiles{1});
% %         if isequal(temp(1), 'I')
% %             set(get(get(handles.IFCB_format1_menu, 'parent'), 'children'),'checked', 'off') %set all in submenu to off
% %             set(handles.IFCB_format1_menu, 'checked', 'on')
% %         elseif isequal(temp(1), 'D')
% %             set(get(get(handles.IFCB_format1_menu, 'parent'), 'children'),'checked', 'off') %set all in submenu to off
% %             set(handles.IFCB_format2_menu, 'checked', 'on')
% %         end
% %         set(handles.start_file_popup, 'string', cellstr(num2str((1:length(handles.MCconfig.resultfiles))')))
% %     end
% % end
% % if ~isempty(handles.MCconfig.classfiles) && isequal(get(handles.classfiles_listbox, 'visible'), 'on')
% %     fullf = mark_notfound_inlist(handles.MCconfig.classfiles, handles);
% %     set(handles.classfiles_listbox, 'string', fullf)
% % end
% % if ~isempty(handles.MCconfig.resultfiles)
% %     if ~exist(get(handles.manualpath_text, 'string'), 'dir')
% %         fullf = handles.MCconfig.resultfiles;
% %         for ii = 1:length(fullf), fullf(ii) = {['<html><font color="red">', fullf{ii}, '</font><html>']}; end
% %         %fullf = mark_notfound_inlist(handles.MCconfig.resultfiles, handles);
% %         set(handles.resultfiles_listbox, 'string', fullf)
% %     end
% % end
% % if ~isempty(handles.MCconfig.roifiles)
% %     fullf = mark_notfound_inlist(handles.MCconfig.roifiles, handles);
% %     set(handles.roifiles_listbox, 'string', fullf)
% % end
% % 
% % guidata(handles.MCconfig_main_figure, handles);
% % set(handles.status_text, 'string', 'Status: Ready')
% % if ishandle(m)
% %     delete(m)
% % end
