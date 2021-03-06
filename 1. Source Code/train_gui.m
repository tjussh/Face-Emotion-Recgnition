function varargout = train_gui(varargin)
% TRAIN_GUI MATLAB code for train_gui.fig
%      TRAIN_GUI, by itself, creates a new TRAIN_GUI or raises the existing
%      singleton*.
%
%      H = TRAIN_GUI returns the handle to a new TRAIN_GUI or the handle to
%      
%      the existing singleton*.
%
%      TRAIN_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TRAIN_GUI.M with the given input arguments.
%
%      TRAIN_GUI('Property','Value',...) creates a new TRAIN_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before train_gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to train_gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help train_gui

% Last Modified by GUIDE v2.5 06-Nov-2017 23:15:09

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @train_gui_OpeningFcn, ...
                   'gui_OutputFcn',  @train_gui_OutputFcn, ...
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


% --- Executes just before train_gui is made visible.
function train_gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%  varargin   command line arguments to train_gui (see VARARGIN)

% Choose default command line output for train_gui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes train_gui wait for user response (see UIRESUME)
% uiwait(handles.main_gui);


% --- Outputs from this function are returned to the command line.
function varargout = train_gui_OutputFcn(hObject, eventdata, handles) 
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
trainedClassifier = load('trained_classifier.mat');
final = predictor(handles.image,trainedClassifier.trainedClassifierVector);
axes(handles.emoji_axis);
Image = get_emotion_image(final);
imshow(Image);
set(handles.edit1,'string',final);



% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.webcam_gui = camera_gui();
uiwait(handles.webcam_gui);
axes(handles.orig_image_axis);
X = load('testframe.mat');
imshow(X.frame);
axes(handles.crop_image_axis);
I = detect_face(X.frame);
handles.image = I;
imshow(I);
guidata(hObject, handles);



% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
trainedClassifierVector = train();
save('trained_classifier.mat', 'trainedClassifierVector');
guidata(hObject, handles);


function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[FileName,PathName] = uigetfile('*.jpg','Select an image file');

axes(handles.orig_image_axis);
X = imread(strcat(PathName,FileName));
imshow(X);
handles.image = X;

axes(handles.crop_image_axis);
I = detect_face(X);
imshow(I);

guidata(hObject, handles);



% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
delete(handles.main_gui);
