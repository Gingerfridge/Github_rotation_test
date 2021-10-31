function varargout = Load_data_gui(varargin)
% LOAD_DATA_GUI MATLAB code for Load_data_gui.fig
%      LOAD_DATA_GUI, by itself, creates a new LOAD_DATA_GUI or raises the existing
%      singleton*.
%
%      H = LOAD_DATA_GUI returns the handle to a new LOAD_DATA_GUI or the handle to
%      the existing singleton*.
%
%      LOAD_DATA_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in LOAD_DATA_GUI.M with the given input arguments.
%
%      LOAD_DATA_GUI('Property','Value',...) creates a new LOAD_DATA_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Load_data_gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Load_data_gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Load_data_gui

% Last Modified by GUIDE v2.5 30-Oct-2021 16:46:38

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Load_data_gui_OpeningFcn, ...
                   'gui_OutputFcn',  @Load_data_gui_OutputFcn, ...
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


% --- Executes just before Load_data_gui is made visible.
function Load_data_gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Load_data_gui (see VARARGIN)

% Choose default command line output for Load_data_gui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

%%%% ADD Code here for it to load
%%% syntax for color change
% set(handles.text2, 'BackgroundColor', [0.5 0.5 1]);



set(handles.pushbutton8, 'BackgroundColor', [1 0.2 0.2]);
for i = 1:length(handles.uitable3.Data)
    handles.uitable3.Data{i,1} = NaN;
    handles.uitable3.Data{i,2} = NaN;
end


%  UIWAIT makes Load_data_gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);




% --- Outputs from this function are returned to the command line.
function varargout = Load_data_gui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in checkbox1.
function checkbox1_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox1


% --- Executes on button press in Load_gro_file_pushbutton1.
function Load_gro_file_pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to Load_gro_file_pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename,filepath] = uigetfile({'*.gro';'*.*'});
fullname = [filepath filename] ;
handles.text6.String = {filename};
Run_colour_changer(handles)



% % % ImageFile = imread(fullname)
% % % 
% % % %now display the image
% % % 
% % % axes(handles.axes1)
% % % imagesc(ImageFile);


% --- Executes on button press in Rotation_checkbox2.
function Rotation_checkbox2_Callback(hObject, eventdata, handles) %%%%ROT
% hObject    handle to Rotation_checkbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% Hint: get(hObject,'Value') returns toggle state of Rotation_checkbox2
Rotation_checkbox2 = get(hObject,'Value');
if handles.Rotation_checkbox2.Value
    handles.text2.String = {'This fuction takes a Gro file and rotates it around the x and y axis outputs the SLD profiles for fitting in matlab etc.'};
end
% If Checkbox B is selected, then the dropdown options would be A,B,C
if ~handles.Rotation_checkbox2.Value
    handles.text2.String = {'Tick the Rotation box to use this function'};
end
Run_colour_changer(handles)


% --- Executes during object creation, after setting all properties.
function uitable3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to uitable3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes when entered data in editable cell(s) in uitable3.
function [x,y] = uitable3_CellEditCallback(hObject, eventdata, handles)
% hObject    handle to uitable3 (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.TABLE)
%	Indices: row and column indices of the cell(s) edited
%	PreviousData: previous data for the cell(s) edited
%	EditData: string(s) entered by the user
%	NewData: EditData or its converted form set on the Data property. Empty if Data was not changed
%	Error: error string when failed to convert EditData to appropriate value for Data
% handles    structure with handles and user data (see GUIDATA)
x = eventdata;
y = handles;
z = hObject;
%%%% creates an array to feed into the rotation function
for i = 1:length(z.Data)
    TF(i) = isnan(z.Data{i,1});
    if z.Data{i,1} <= 1
        if z.Data{i,1} >= 0  

        else
             z.Data{i,1} = NaN;
        end
    else
        z.Data{i,1} = NaN;
    end
end
for i = 1:length(z.Data)
    z.Data{i,2} =  (z.Data{i,1}(1,1))*(6.91e-6)-0.56e-6;
end
TF = ~TF;
I = find(TF == 1);
for i = 1:length(I)
    D2O_frac(i,1) =  (z.Data{I(i),1}(1,1));
end
%     
% Contrasts = i*Logic
Run_colour_changer(handles)



function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu2.
function popupmenu2_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu2
contents = cellstr(get(hObject,'String'));
Value = contents{get(hObject,'Value')};
Run_colour_changer(handles)




% --- Executes during object creation, after setting all properties.
function popupmenu2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton2.
function [filepath] = pushbutton2_Callback(hObject, eventdata, handles) %%%%ROT
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filepath] = uigetdir;
handles.text5.String = {filepath};
Run_colour_changer(handles)


% --- Executes during object creation, after setting all properties.
function text5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called





% --- Executes on button press in checkbox3.
function checkbox3_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox3


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in popupmenu3.
function popupmenu3_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu3 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu3


% --- Executes during object creation, after setting all properties.
function popupmenu3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% --- Executes on button press in RUN_ROT_pushbutton3.


function edit5_Callback(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double
Run_colour_changer(handles)

% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --- Executes during object creation, after setting all properties.
function text2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%this function works the logic of the file prep process
function [Working_directory,Rotation_increment,protein_filename,protein_nickname,D2O_frac,Message,Working_boolean] = Function_check(handles)
Working_boolean = 0;    
handles.text5.String;
Working_directory = handles.text5.String;
D2O_frac = (1);
Rotation_increment = str2double((handles.popupmenu2.String{handles.popupmenu2.Value,1})); % this should work for the rotation code

protein_filename = handles.text6.String;


protein_nickname = handles.edit5.String;

if ~handles.Rotation_checkbox2.Value
    Message = "Check the rotation tickbox";
    %add not in the run section
else
%Must selct folder
tf_Work_Folder = strcmp(handles.text5.String,'Select Work Folder');
tf_Work_Folder_2 = strcmp(handles.text5.String,'0');
if tf_Work_Folder
    Message = "Select work folder";
    %add not in the run section
else
if tf_Work_Folder_2
    Message = "Select work folder";
    %add not in the run section
else    
    
    
%Must select gro file
tf_Gro_Name = strcmp(handles.text6.String,'Select .gro File');   
tf_Gro_Name_2 = strcmp(handles.text6.String,'0');  
if tf_Gro_Name
    Message = "Select .gro file from in the folder selected";
    %add not in the run section
else    
if tf_Gro_Name_2
    Message = "Select .gro file from in the folder selected";
    %add not in the run section
else 


% must fill in the contrast
D2O_frac = handles.uitable3.Data;
for i =1:length(D2O_frac)
    X(i,1) = D2O_frac{i,1};
end

X(isnan(X(:,1)),:) = [];

D2O_frac = X;
D2O_frac(isnan(D2O_frac(:,1)),:) = [];
D2O_test_1 = isnumeric(D2O_frac);
D2O_test_2 = isnan(D2O_frac);

if D2O_test_1 == 0
    Message = "Fill in D2O fraction table";
else
D2O_test_2i = isempty(D2O_test_2);
D2O_test_2ii = all(D2O_test_2(:) == 0)  ;  

if D2O_test_2i == 1
    Message = "Fill in D2O fraction table";
else

if D2O_test_2ii ~= 1   
    Message = "Fill in D2O fraction table";
else

Nick_Name_test_2 = isempty(handles.edit5.String);
if Nick_Name_test_2
    Message = "Please enter a name"
else
    
Nick_Name_test = any(regexp(handles.edit5.String,'[0-9]'))    
if Nick_Name_test
    Message = "NO NUMBERS in Name"
else
     
Working_boolean = 1;    
Message = "Running";
handles.text5.String{1,1};
Working_directory = handles.text5.String{1,1};
Rotation_increment = str2double((handles.popupmenu2.String{handles.popupmenu2.Value,1})); % this should work for the rotation code
protein_filename = handles.text6.String;
protein_nickname = handles.edit5.String;

end
end
end
end
end
end
end
end % 
end % 
end % 

function Run_colour_changer(handles)
[Working_directory,Rotation_increment,protein_filename,protein_nickname,D2O_frac,Message,Working_boolean] = Function_check(handles)
if Working_boolean == 1
    set(handles.pushbutton8, 'BackgroundColor', [0.47 0.67 0.19]);
    handles.text13.String = '';
    
else
    set(handles.pushbutton8, 'BackgroundColor', [1 0.2 0.2])
    handles.text13.String = '';
end



% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%Must tick box
[Working_directory,Rotation_increment,protein_filename,protein_nickname,D2O_frac,Message,Working_boolean] = Function_check(handles);
if Working_boolean == 0
Message;
handles.text13.String = Message;
else
cd(Working_directory);
Message;
handles.text13.String = Message;
end

handles.text13.String = Message;
%%%% this will run the code
% I should make it output some "important" loading information
[Loading_roation,Loading_Slicer,Loading_SLD] = rotation_slice_SLD_profile(protein_nickname,protein_filename,Rotation_increment,Working_directory,D2O_frac);


% --- Executes during object creation, after setting all properties.
function text11_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function text13_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
