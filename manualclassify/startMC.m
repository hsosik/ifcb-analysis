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

% Last Modified by GUIDE v2.5 21-Apr-2015 14:12:21

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
handles.msgbox_fontstr = '\fontsize{12}'

fullf = fullfile(handles.configpath, 'startMC_path.mat');
if exist(fullf, 'file')
    load(fullf) %last_path
else
    last_path = handles.configpath;
end
if length(varargin) > 0
    f = varargin{1};
    if exist(f, 'dir') %full path with input
        set(handles.configfile_text, 'string', f);
    elseif exist(fullfile(last_path,[f '.mcconfig.mat']), 'file')
        set(handles.configfile_text, 'string', fullfile(last_path,[f '.mcconfig.mat']));
    else
        msgbox({[handles.msgbox_fontstr 'Input config file not found. Starting from last known.'];' ';'Load from the file menu in Edit Configuration to locate your file.'}, handles.msgbox_cs)
        set(handles.configfile_text, 'string', []);
    end
else
    set(handles.configfile_text, 'string', [handles.configpath 'last.mcconfig.mat'])
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
hset = findobj('style', 'pushbutton');
set(hset, 'enable', 'inactive')
if ~isempty(fullf)
    handles.MCconfig = ManageMCconfig(cellstr(fullf));
else
    handles.MCconfig = ManageMCconfig();
end
set(hset, 'enable', 'on')
set(handles.configfile_text, 'string', handles.MCconfig.settings.configfile)
guidata(hObject, handles)

% --- Executes on button press in startMC_pushbutton.
function startMC_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to startMC_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
hset = findobj('style', 'pushbutton');
set(hset, 'enable', 'inactive')
if ~isfield(handles, 'MCconfig')
    temp = load(get(handles.configfile_text, 'string'), 'MCconfig');
    handles.MCconfig = temp.MCconfig;
end 
manual_classify_5_0(handles.MCconfig)
set(hset, 'enable', 'on')


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
delete(hObject);


% --- Executes on button press in quit_pushbutton.
function quit_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to quit_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
figure1_CloseRequestFcn(handles.figure1, eventdata, handles)
