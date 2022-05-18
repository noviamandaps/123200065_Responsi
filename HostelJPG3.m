function varargout = HostelJPG(varargin)
% HostelJPG MATLAB code for HostelJPG.fig
%      HostelJPG, by itself, creates a new HostelJPG or raises the existing
%      singleton*.
%
%      H = HostelJPG returns the handle to a new HostelJPG or the handle to
%      the existing singleton*.
%
%      HostelJPG('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in HostelJPG.M with the given input arguments.
%
%      HostelJPG('Property','Value',...) creates a new HostelJPG or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before HostelJPG_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to HostelJPG_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help HostelJPG

% Last Modified by GUIDE v2.5 17-May-2022 07:38:16

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @HostelJPG_OpeningFcn, ...
                   'gui_OutputFcn',  @HostelJPG_OutputFcn, ...
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


% --- Executes just before HostelJPG is made visible.
function HostelJPG_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to HostelJPG (see VARARGIN)

% Choose default command line output for HostelJPG
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes HostelJPG wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = HostelJPG_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in show_table.
function show_table_Callback(hObject, eventdata, handles)
% hObject    handle to show_table (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

opts = detectImportOptions('Dataset_Hostel_Jepang.xlsx');
opts.SelectedVariableNames = (4:7);
data = readmatrix('Dataset_Hostel_Jepang.xlsx', opts);%membaca file ('Dataset_Hostel_Jepang.xlsx
set(handles.uitable2,'data',data,'visible','on');%menampilkan data dari file ('Dataset_Hostel_Jepang.xlsx kedalam uitable2 

% --- Executes on button press in proses_hasil.
function proses_hasil_Callback(hObject, eventdata, handles)
% hObject    handle to proses_hasil (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

opts = detectImportOptions('Dataset_Hostel_Jepang.xlsx');
opts.SelectedVariableNames = (4:7);
data = readmatrix('Dataset_Hostel_Jepang.xlsx', opts); %membaca file Dataset_Hostel_Jepang.xlsx
k=[0,0,1,0]; %merupakan cost atau benefit
w=[1,4,2,3]; %merupkan bobot per kriteria berdasarkan soal

%tahap 1
[m n]=size (data); %menginisialisasi ukuran data
w=w./sum(w); %membagi bobot per kriteria(w) dengan jumlah total keseluruhan bobot(sum(w))


%tahap 2 yaitu melakukan perhitungan vektor s perbaris
for j=1:n,
    if k(j)==0, w(j)=-1*w(j);
    end;
end;
for i=1:m,
    S(i)=prod(data(i,:).^w);
end;

opts = detectImportOptions('Dataset_Hostel_Jepang.xlsx');
opts.SelectedVariableNames = (1);
baru = readmatrix('Dataset_Hostel_Jepang.xlsx', opts);%membaca file Dataset_Hostel_Jepang.xlsx
xlswrite('data_hasil.xlsx', baru, 'Sheet1', 'B1'); %membuat file xlsx baru dan menulis data hasil di kolom B1
S=S'; %data hasil diubah dari horizontal ke vertikal
xlswrite('data_hasil.xlsx', S, 'Sheet1', 'C1'); %menulis data hasil di kolom C1


opts = detectImportOptions('data_hasil.xlsx');
opts.SelectedVariableNames = (1:2);
data = readmatrix('data_hasil.xlsx', opts); %membaca file data_hasil.xlsx

X=sortrows(data,2,'descend'); %data diurut dari yg besar ke kecil berdasarkan kolom 2
set(handles.uitable3,'data',X,'visible','on'); %data hasil ditampilkan pada uitable3 pada GUI
