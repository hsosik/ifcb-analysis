function varargout = ManageClassLabels(varargin)
%labels = ManageClassLabels(class2use_file)
% GUI for creating and editing lists of class labels ("class2use")
% for use with IFCB (and other) image annotation and classification
% Input:
%   (optional) class2use full file name: string specifying class2use file to load if desired
% Output:
%   labels: structure containing two fields
%       class2use - cell array of class labels
%       filename - cellstr full filename on disk if available
%
%IFCB image annotation software system
%Heidi M. Sosik, Woods Hole Oceanographic Institution, 8 June 2009
%
% MANAGECLASSLABELS MATLAB code for ManageClassLabels.fig
%      MANAGECLASSLABELS, by itself, creates a new MANAGECLASSLABELS or raises the existing
%      singleton*.
%
%      H = MANAGECLASSLABELS returns the handle to a new MANAGECLASSLABELS or the handle to
%      the existing singleton*.
%
%      MANAGECLASSLABELS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MANAGECLASSLABELS.M with the given input arguments.
%
%      MANAGECLASSLABELS('Property','Value',...) creates a new MANAGECLASSLABELS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ManageClassLabels_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ManageClassLabels_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ManageClassLabels

% Last Modified by GUIDE v2.5 20-Apr-2015 09:25:23

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ManageClassLabels_OpeningFcn, ...
                   'gui_OutputFcn',  @ManageClassLabels_OutputFcn, ...
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


% --- Executes just before ManageClassLabels is made visible.
function ManageClassLabels_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ManageClassLabels (see VARARGIN)

% Choose default command line output for ManageClassLabels
%handles.output = hObject;

handles.unsaved = 0;
if length(varargin) > 1,
    if isequal(varargin{2}, {'fromMC'})
        set(handles.back2MC_pushbutton, 'enable', 'on', 'visible', 'on')
    end
end
if length(varargin) > 0 && ~isempty(char(varargin{1}))
    filename = char(varargin{1});
    handles.filename = filename;
    temp = fileparts(filename);
    if isempty(temp) %if no path specified make a default place
        temp = fileparts(which('ManageClassLabels'));
        temp = [temp filesep 'config' filesep];
        handles.configpath = temp;    
    else
        handles.configpath = [temp filesep];
    end;
    if exist(filename, 'file')
        temp = load(filename, 'class2use');
        set(handles.class2use_uitable, 'data', temp.class2use(:));
    end
else %make a default place to put class2use files
    temp = fileparts(which('ManageClassLabels'));
    temp = [temp filesep 'config' filesep];
    handles.configpath = temp;
    if ~exist(temp, 'dir')
        mkdir(temp)
    end
    handles.filename = [];
end
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes ManageClassLabels wait for user response (see UIRESUME)
 uiwait(handles.figure1);  %uncommented to control output to wait for user completion (heidi)


% --- Outputs from this function are returned to the command line.
function varargout = ManageClassLabels_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
%varargout{1} = handles.output;
if ~handles.unsaved,
    temp = get(handles.class2use_uitable, 'data'); %output class2use
    labels.class2use = temp(:,1);
else 
    labels.class2use = [];
end;
labels.filename = handles.filename;
varargout{1} = labels;

% The figure can be deleted now
delete(handles.figure1);


% --- Executes on button press in add_class_pushbutton.
function add_class_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to add_class_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

data=get(handles.class2use_uitable, 'data');
data(end+1,:)={''}; %  
set(handles.class2use_uitable, 'data', data, 'ColumnEditable', logical(1));
jscroll = findjobj(handles.class2use_uitable);
jtable = jscroll.getViewport.getView;
col = 1; row = size(data,1);
jtable.editCellAt(row-1, col-1);
jscroll = findjobj(handles.class2use_uitable);
jtable = jscroll.getViewport.getView;
col = 1; row = size(data,1);
jtable.changeSelection(row-1,col-1, false, false);
jtable.editCellAt(row-1, col-1);
jtable.setSurrendersFocusOnKeystroke(true);jtable.setSurrendersFocusOnKeystroke(true);
jtable.getEditorComponent().requestFocus();
handles.unsaved = 1; guidata(handles.figure1, handles);


% --------------------------------------------------------------------
function file_menu_Callback(hObject, eventdata, handles)
% hObject    handle to file_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function handles = save_menu_Callback(hObject, eventdata, handles)
% hObject    handle to save_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    class2use = get(handles.class2use_uitable, 'data');
    class2use = class2use(:,1)';
    [f p] = uiputfile('class2use*.mat', 'Save category list', [handles.configpath 'class2use_new']);
    if ~isequal(f,0)
       save([ p f ], 'class2use');
       handles.unsaved = 0;
       handles.filename = [p f];
    else 
       handles.filename = [];
    end
    guidata(handles.figure1, handles);

% --------------------------------------------------------------------
function load_menu_Callback(hObject, eventdata, handles)
% hObject    handle to load_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[f p ] = uigetfile([handles.configpath '*class2use*.mat']);
if ~isequal(f,0)
    temp = load([p f]);
    handles.filename = [p f];
    set(handles.class2use_uitable, 'data', temp.class2use(:))
    handles.unsaved = 0; 
    guidata(handles.figure1, handles);
    drawnow
end;


% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure
%keyboard
if handles.unsaved
    handles = save_menu_Callback([], eventdata, handles);
end
if isempty(handles.filename)
    opt.Interpreter = 'tex'; opt.Default = 'Cancel quit';
       selectedButton = questdlg({'\fontsize{12}Are you sure you want to quit without saving your category labels?'...
            '', 'You cannot use this list to manually classify images if you do not save.'},...
            'Saving', 'Quit now', 'Cancel quit', opt);    
        switch selectedButton
            case 'Quit now'
                %following to manage uiwait to control no output until user is done (heidi)
                if isequal(get(handles.figure1, 'waitstatus'), 'waiting')
                    % The GUI is still in UIWAIT, us UIRESUME
                    uiresume(handles.figure1);
                else
                    % The GUI is no longer waiting, just close it
                    delete(hObject);
                end
            case 'Cancel quit'
                save_menu_Callback(hObject, eventdata, handles)              
        end
else
    %following to manage uiwait to control no output until user is done (heidi)
    if isequal(get(hObject, 'waitstatus'), 'waiting')
        % The GUI is still in UIWAIT, us UIRESUME
        uiresume(handles.figure1);
    else
        % The GUI is no longer waiting, just close it
        delete(handles.figure1);
    end
end


% --- Executes on button press in edit_class_checkbox.
function edit_class_checkbox_Callback(hObject, eventdata, handles)
% hObject    handle to edit_class_checkbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of edit_class_checkbox
if get(handles.warning_display_checkbox,'value') && get(hObject, 'value')
    w = warndlg('If you have already used this list to produce results, edit class names with extreme caution. You can overwrite revised labels, but class numbers will remain unchanged. If you need a new class, add it to the end of the list.', 'Warning', 'modal');
    drawnow
end
if get(hObject, 'value') %if edit
    data=get(handles.class2use_uitable, 'data');
    edit_value = logical(ones(1,size(data,1))); 
    set(handles.class2use_uitable, 'ColumnEditable', edit_value);
    handles.unsaved = 1; guidata(handles.figure1, handles);
else %not edit
    set(handles.class2use_uitable, 'ColumnEditable', logical(0));
end

% --- Executes when entered data in editable cell(s) in class2use_uitable.
function class2use_uitable_CellEditCallback(hObject, eventdata, handles)
% hObject    handle to class2use_uitable (see GCBO)
% eventdata  structure with the following fields (see UITABLE)
%	Indices: row and column indices of the cell(s) edited
%	PreviousData: previous data for the cell(s) edited
%	EditData: string(s) entered by the user
%	NewData: EditData or its converted form set on the Data property. Empty if Data was not changed
%	Error: error string when failed to convert EditData to appropriate value for Data
% handles    structure with handles and user data (see GUIDATA)
    set(handles.class2use_uitable, 'ColumnEditable', logical(0));
    set(handles.edit_class_checkbox, 'value', 0)
    uicontrol(handles.save_file_pushbutton) %force focus away from uitable so another cell is not editable before settings above take effect

% --- Executes on button press in warning_display_checkbox.
function warning_display_checkbox_Callback(hObject, eventdata, handles)
% hObject    handle to warning_display_checkbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of warning_display_checkbox


% --- Executes during object creation, after setting all properties.
function warning_display_checkbox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to warning_display_checkbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in clear_table_pushbutton.
function clear_table_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to clear_table_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
   selectedButton = questdlg({'Are you sure you want to clear all your category labels?'},...
            'Clear all', 'Yes', 'Cancel', 'Cancel');    
        switch selectedButton
            case 'Yes'
                set(handles.class2use_uitable, 'data', {'unclassified'})
                handles.unsaved = 1;  guidata(handles.figure1, handles);     
            case 'Cancel'
        end


% --- Executes on button press in load_file_pushbutton.
function load_file_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to load_file_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    load_menu_Callback(hObject, eventdata, handles)

% --- Executes on button press in save_file_pushbutton.
function save_file_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to save_file_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
save_menu_Callback([], eventdata, handles)


% --------------------------------------------------------------------
function quit_menu_Callback(hObject, eventdata, handles)
% hObject    handle to quit_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    figure1_CloseRequestFcn(handles.figure1, eventdata, handles)
    

% --- Executes when selected cell(s) is changed in class2use_uitable.
function class2use_uitable_CellSelectionCallback(hObject, eventdata, handles)
% hObject    handle to class2use_uitable (see GCBO)
% eventdata  structure with the following fields (see UITABLE)
%	Indices: row and column indices of the cell(s) currently selecteds
% handles    structure with handles and user data (see GUIDATA)

if ~get(handles.edit_class_checkbox, 'value'),
    set(handles.class2use_uitable, 'ColumnEditable', logical(0));
    set(handles.edit_class_checkbox, 'value', 0)
   %handles.unsaved = 1; guidata(hObject, handles);
    jscroll = findjobj(handles.class2use_uitable);
    jtable = jscroll.getViewport.getView;
end


% --- Executes on button press in back2MC_pushbutton.
function back2MC_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to back2MC_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    figure1_CloseRequestFcn(handles.figure1, eventdata, handles)
