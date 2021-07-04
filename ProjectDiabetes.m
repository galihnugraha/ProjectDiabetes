function varargout = ProjectDiabetes(varargin)
% PROJECTDIABETES MATLAB code for ProjectDiabetes.fig
%      PROJECTDIABETES, by itself, creates a new PROJECTDIABETES or raises the existing
%      singleton*.
%
%      H = PROJECTDIABETES returns the handle to a new PROJECTDIABETES or the handle to
%      the existing singleton*.
%
%      PROJECTDIABETES('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PROJECTDIABETES.M with the given input arguments.
%
%      PROJECTDIABETES('Property','Value',...) creates a new PROJECTDIABETES or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ProjectDiabetes_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ProjectDiabetes_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ProjectDiabetes

% Last Modified by GUIDE v2.5 04-Jul-2021 19:30:00

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ProjectDiabetes_OpeningFcn, ...
                   'gui_OutputFcn',  @ProjectDiabetes_OutputFcn, ...
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


% --- Executes just before ProjectDiabetes is made visible.
function ProjectDiabetes_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ProjectDiabetes (see VARARGIN)

% Choose default command line output for ProjectDiabetes
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes ProjectDiabetes wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = ProjectDiabetes_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
opts = detectImportOptions('diabetes-dataset.csv'); % Digunakan untuk mengambil dataset
opts.SelectedVariableNames = (1:8); % Digunakan untuk mengatur kolom berapa yang akan ditampilkan
data = readmatrix('diabetes-dataset.csv', opts); 
set(handles.uitable1,'data', data);

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

input1 = get(handles.data1, 'string');
input2 = get(handles.data2, 'string');
input3 = get(handles.data3, 'string');
input4 = get(handles.data4, 'string');
input5 = get(handles.data5, 'string');
input6 = get(handles.data6, 'string');
input7 = get(handles.data7, 'string');
input8 = get(handles.data8, 'string');

kosong = 0;
huruf = 0;

if isempty(input1) || isempty(input2) || isempty(input3) || isempty(input4) || isempty(input5) || isempty(input6) || isempty(input7) || isempty(input8)
    f = msgbox('Terdapat kolom yang kosong', 'Error','error');
    set(handles.hasil, 'String', '');
    kosong = 1;
end

if kosong == 0
    input1 = str2double(input1);
    input2 = str2double(input2);
    input3 = str2double(input3);
    input4 = str2double(input4);
    input5 = str2double(input5);
    input6 = str2double(input6);
    input7 = str2double(input7);
    input8 = str2double(input8);
    
    if isnan(input1) || isnan(input2) || isnan(input3) || isnan(input4) || isnan(input5) || isnan(input6) || isnan(input7) || isnan(input8)
        f = msgbox('Terdapat kolom yang berisi selain angka', 'Error','error');
        set(handles.hasil, 'String', '');
    else
        sample = [input1 input2 input3 input4 input5 input6 input7 input8];

        %parameter penentu klasifikasi
        opts = detectImportOptions('diabetes-dataset.csv');
        opts.SelectedVariableNames = (1:8);
        training = readmatrix('diabetes-dataset.csv', opts);

        %membaca file kolom klasifikasi
        opts = detectImportOptions('diabetes-dataset.csv');
        opts.SelectedVariableNames = (9);
        group = readmatrix('diabetes-dataset.csv', opts);

        class = fitcknn(training, group, 'NumNeighbors', 1);
        klasifikasi = predict(class, sample);

        if klasifikasi==1
            result= "diabetes";
        end
        if klasifikasi==0
            result= "not diabetes";
        end

        set(handles.hasil, 'string', result);
    end
end

function data1_Callback(hObject, eventdata, handles)
% hObject    handle to data1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of data1 as text
%        str2double(get(hObject,'String')) returns contents of data1 as a double


% --- Executes during object creation, after setting all properties.
function data1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to data1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function data2_Callback(hObject, eventdata, handles)
% hObject    handle to data2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of data2 as text
%        str2double(get(hObject,'String')) returns contents of data2 as a double


% --- Executes during object creation, after setting all properties.
function data2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to data2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function data3_Callback(hObject, eventdata, handles)
% hObject    handle to data3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of data3 as text
%        str2double(get(hObject,'String')) returns contents of data3 as a double


% --- Executes during object creation, after setting all properties.
function data3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to data3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function data4_Callback(hObject, eventdata, handles)
% hObject    handle to data4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of data4 as text
%        str2double(get(hObject,'String')) returns contents of data4 as a double


% --- Executes during object creation, after setting all properties.
function data4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to data4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function data5_Callback(hObject, eventdata, handles)
% hObject    handle to data5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of data5 as text
%        str2double(get(hObject,'String')) returns contents of data5 as a double


% --- Executes during object creation, after setting all properties.
function data5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to data5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function data6_Callback(hObject, eventdata, handles)
% hObject    handle to data6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of data6 as text
%        str2double(get(hObject,'String')) returns contents of data6 as a double


% --- Executes during object creation, after setting all properties.
function data6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to data6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function data7_Callback(hObject, eventdata, handles)
% hObject    handle to data7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of data7 as text
%        str2double(get(hObject,'String')) returns contents of data7 as a double


% --- Executes during object creation, after setting all properties.
function data7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to data7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function data8_Callback(hObject, eventdata, handles)
% hObject    handle to data8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of data8 as text
%        str2double(get(hObject,'String')) returns contents of data8 as a double


% --- Executes during object creation, after setting all properties.
function data8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to data8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function hasil_Callback(hObject, eventdata, handles)
% hObject    handle to hasil (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of hasil as text
%        str2double(get(hObject,'String')) returns contents of hasil as a double


% --- Executes during object creation, after setting all properties.
function hasil_CreateFcn(hObject, eventdata, handles)
% hObject    handle to hasil (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.data1, 'String', '');
set(handles.data2, 'String', '');
set(handles.data3, 'String', '');
set(handles.data4, 'String', '');
set(handles.data5, 'String', '');
set(handles.data6, 'String', '');
set(handles.data7, 'String', '');
set(handles.data8, 'String', '');
set(handles.hasil, 'String', '');