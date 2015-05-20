function varargout = startMC(varargin)
% STARTMC MATLAB code for startMC.fig
%      STARTMC, by itself, creates a new STARTMC or raises the existing
%      singleton*.
%
%      H = STARTMC returns the handle to a new STARTMC or the handle to
%      the existing singleton*.
%
%      STARTMC('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in STARTMC.M with the given input arguments.
%
%      STARTMC('Property','Value',...) creates a new STARTMC or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before startMC_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to startMC_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help startMC

% Last Modified by GUIDE v2.5 22-Apr-2015 09:36:45

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @startMC_OpeningFcn, ...
                   'gui_OutputFcn',  @startMC_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
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


% --- Executes just before startMC is made visible.
function startMC_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to startMC (see VARARGIN)

% Choose default command line output for startMC
handles.output = hObject;

%set some default info and settings
temp = fileparts(which('StartMC'));
temp = [temp filesep 'config' filesep];
handles.configpath = temp;
if ~exist(temp, 'dir')
    mkdir(temp)
end

handles.msgbox_cs.Interpreter = 'tex';
handles.msgbox_cs.WindowStyle = 'modal';
handles.msgbox_fontstr = '\fontsize{12}';

fullf = fullfile(handles.configpath, 'startMC_path.mat');
if exist(fullf, 'file')
    load(fullf) %last_path
else
    last_path = handles.configpath;
end
if length(varargin) > 0 %handle the input config file
    f = varargin{1};
    if isequal(f, 'default')
        set(handles.configfile_text, 'string', {'default'});
    elseif exist(f, 'dir') %full path with input
        set(handles.configfile_text, 'string', f);
    elseif exist(fullfile(last_path,[f '.mcconfig.mat']), 'file')
        set(handles.configfile_text, 'string', fullfile(last_path,[f '.mcconfig.mat']));
    else
        msgbox({[handles.msgbox_fontstr 'Input config file not found in last known location. Starting from last known.'];' ';'Restart including path or load from the file menu in Edit Configuration to locate your file.'}, handles.msgbox_cs)
        set(handles.configfile_text, 'string', []);
    end
else %otherwise use the last config file if it exists
    f = [handles.configpath 'last.mcconfig.mat'];
    if exist(f, 'dir')
        set(handles.configfile_text, 'string', [handles.configpath 'last.mcconfig.mat']);
    else
        set(handles.configfile_text, 'string', []);
    end
end
if length(varargin) > 1 %handle an input file list
    handles.filelist = varargin{2};
end
    
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes startMC wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = startMC_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in edit_config_pushbutton.
function edit_config_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to edit_config_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
fullf = get(handles.configfile_text, 'string');
set(handles.status_text, 'String', 'Busy in configuration edit')
hset = findobj('style', 'pushbutton');
set(hset, 'enable', 'off')
%if ~isempty(fullf)
%    handles.MCconfig = ManageMCconfig(cellstr(fullf));
%else
%    handles.MCconfig = ManageMCconfig();
%end
if isfield(handles, 'filelist')
    handles.MCconfig = ManageMCconfig(cellstr(fullf), cellstr(handles.filelist));
elseif ~isempty(fullf)
    handles.MCconfig = ManageMCconfig(cellstr(fullf));
else
    handles.MCconfig = ManageMCconfig();
end
if ishandle(handles.figure1) %otherwise user closed window
    set(hset, 'enable', 'on')
    set(handles.status_text, 'String', 'Ready')
    set(handles.configfile_text, 'string', handles.MCconfig.settings.configfile)
    guidata(hObject, handles)
end

% --- Executes on button press in startMC_pushbutton.
function startMC_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to startMC_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.status_text, 'String', 'Busy in Manual Classify')
hset = findobj('style', 'pushbutton');
set(hset, 'enable', 'off')
if ~isfield(handles, 'MCconfig')
    f = get(handles.configfile_text, 'string');
    f = regexprep(f,'.mcconfig.mat', ''); %make sure '.mcconfig.mat' not included already
    f = [f '.mcconfig.mat']; %add '.mcconfig.mat'
    if isequal(exist(f, 'file'), 2)  %config file with full path exists
        temp = load(f, 'MCconfig');
        handles.MCconfig = temp.MCconfig;
    elseif isequal(exist(fullfile(handles.configpath, f), 'file'), 2) %config file in default path exists
        temp = load(fullfile(handles.configpath, f), 'MCconfig');
        handles.MCconfig = temp.MCconfig;
    else
        msgbox({[handles.msgbox_fontstr 'Input config file not found in last known location. Starting from last known.'];' ';'Restart including path or load from the file menu in Edit Configuration to locate your file.'}, handles.msgbox_cs)
        set(handles.configfile_text, 'string', []);
    end
end
if isfield(handles, 'MCconfig')
    manual_classify_5_0(handles.MCconfig)
end
if ishandle(handles.figure1) %otherwise user closed window
    set(hset, 'enable', 'on')
    set(handles.status_text, 'String', 'Ready')
end
 guidata(hObject, handles)
 

% --- Executes during object creation, after setting all properties.
function configfile_text_CreateFcn(hObject, eventdata, handles)
% hObject    handle to configfile_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure
[last_path,f] = fileparts(get(handles.configfile_text, 'string'));
save(fullfile(handles.configpath, 'startMC_path'), 'last_path')
f = findobj('type', 'figure', 'tag', 'MCconfig_main_figure');
if ~isempty(f) %ManageMCconfig window still open
    delete(f) %delete it
end
delete(hObject);


% --- Executes on button press in quit_pushbutton.
function quit_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to quit_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if isfield(handles, 'MCconfig')
    disp(handles.MCconfig)
end
figure1_CloseRequestFcn(handles.figure1, eventdata, handles)


% --------------------------------------------------------------------
function quit_menu_Callback(hObject, eventdata, handles)
% hObject    handle to quit_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function quit2_menu_Callback(hObject, eventdata, handles)
% hObject    handle to quit2_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
quit_pushbutton_Callback(hObject, eventdata, handles)
