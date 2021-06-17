function varargout = HistogramTrueColour(varargin)
% HISTOGRAMTRUECOLOUR MATLAB code for HistogramTrueColour.fig
%      HISTOGRAMTRUECOLOUR, by itself, creates a new HISTOGRAMTRUECOLOUR or raises the existing
%      singleton*.
%
%      H = HISTOGRAMTRUECOLOUR returns the handle to a new HISTOGRAMTRUECOLOUR or the handle to
%      the existing singleton*.
%
%      HISTOGRAMTRUECOLOUR('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in HISTOGRAMTRUECOLOUR.M with the given input arguments.
%
%      HISTOGRAMTRUECOLOUR('Property','Value',...) creates a new HISTOGRAMTRUECOLOUR or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before HistogramTrueColour_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to HistogramTrueColour_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help HistogramTrueColour

% Last Modified by GUIDE v2.5 08-May-2021 08:26:33

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @HistogramTrueColour_OpeningFcn, ...
                   'gui_OutputFcn',  @HistogramTrueColour_OutputFcn, ...
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


% --- Executes just before HistogramTrueColour is made visible.
function HistogramTrueColour_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to HistogramTrueColour (see VARARGIN)

% Choose default command line output for HistogramTrueColour
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes HistogramTrueColour wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = HistogramTrueColour_OutputFcn(hObject, eventdata, handles) 
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
[filename,pathname] = uigetfile({'*.jpg';'*.jpeg';'*.png';'*.*'});
citra = imread([pathname,filename]);
axes(handles.axes1);
imshow(citra);

% mendapatkan info citra input
ket = imfinfo(fullfile([pathname,filename]));
% menampilkan jeniswarna citra kedalam statik text
set(handles.text2,'String',ket.ColorType);

handles.input = citra;
guidata(hObject,handles);

%  memebersihkan tampilan axes2
cla(handles.axes2);

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%panggil citra input
inputCitra = handles.input;

%dapatkan jennis warna citra inputnya
jenisCitra = get(handles.text2, 'String');
%tentukan tempat histogramnya 
axes(handles.axes2);
%seleksi histogramnya
if isequal(jenisCitra,'grayscale')
    histogram(inputCitra);
    grid on;
else
    %pisahkan layer citra
    ir = inputCitra(:,:,1);
    ig = inputCitra(:,:,2);
    ib = inputCitra(:,:,3);
    %buat histogram per layer
    histogram(ir, 'EdgeColor', 'r');
    hold on; %menumpuk tampian histogram
    grid on; %menampilkan garis bantu dalam histogram
    histogram(ig, 'EdgeColor', 'g');
    histogram(ib, 'EdgeColor', 'b');
end
