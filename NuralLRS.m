 function varargout = NuralLRS(varargin)
% NURALLRS MATLAB code for NuralLRS.fig
%      NURALLRS, by itself, creates a new NURALLRS or raises the existing
%      singleton*.
%
%      H = NURALLRS returns the handle to a new NURALLRS or the handle to
%      the existing singleton*.
%
%      NURALLRS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in NURALLRS.M with the given input arguments.
%
%      NURALLRS('Property','Value',...) creates a new NURALLRS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before NuralLRS_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to NuralLRS_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help NuralLRS

% Last Modified by GUIDE v2.5 14-Apr-2020 12:42:14

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @NuralLRS_OpeningFcn, ...
                   'gui_OutputFcn',  @NuralLRS_OutputFcn, ...
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


% --- Executes just before NuralLRS is made visible.
function NuralLRS_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to NuralLRS (see VARARGIN)

% Choose default command line output for NuralLRS
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes NuralLRS wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = NuralLRS_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes on button press in pushbutton1.    ��ͼƬD:\math work\�ҵ�ʶ��ϵͳ
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clc;
clear global exactarea;
global I;    % ȫ�ֱ��� I  
global doce; 
global L1;
[filename,pathname] = uigetfile('*jpg');  %���ļ��Ի��򲢶�ȡ�ļ�
if isequal(filename,0)              
    msgbox('δѡ��ͼƬ','ע��','error')
else
    pathfile=fullfile(pathname,filename);    %���ӵõ�����·����
    handles.filename=filename;
    guidata(hObject,handles);
    I=imread(pathfile);
    handles.figure1;
    axes(handles.axes1);
    imshow(I);
    title('������Ƭ');
    axes(handles.axes2);
    cla;
    doce='';  %����ַ�����
    L1=0;     %��ռ�ʱ��
    set(handles.text6,'string','');   %�����ʾ��
    set(handles.text5,'string','');
    set(handles.text4,'string','');
end


% --- Executes on button press in pushbutton3.  ��λ
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% global exactarea;
% global L1;
global shibie;    %������λ��־
shibie=0;    %��������
Dingwei();   %ִ�ж�λ����



% --- Executes on button press in pushbutton4.  ģ�����������ʶ��
function pushbutton4_Callback(hObject, eventdata, handles)  
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global doce;
global L1;
global exactarea;
global shibie;   
shibie=2;    %�����ر�
Dingwei();   %ִ�г��ƶ�λ

handles.figure1;
axes(handles.axes2);
cla;
imshow(exactarea);
title('��������');     %��ʾ����

piccrop();       %�����ַ�
recognition2();   %ʶ���ַ�
set(handles.text5,'string',doce);    %������
filename=handles.filename;
right=0;
for i=1:7
    if filename(i)==doce(i*2-1)
        right=right+1;
    end
end
if right==7
    set(handles.text6,'string','��ȷ');
    set(handles.text6,'ForegroundColor','blue');
else
    set(handles.text6,'string','����');
    set(handles.text6,'ForegroundColor','red');
end
L=num2str(L1);
set(handles.text4,'string',L);


% --- Executes during object creation, after setting all properties.
function axes1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes1
set(hObject,'xTick',[]);
set(hObject,'ytick',[]);
set(hObject,'box','on');


% --- Executes during object creation, after setting all properties.
function axes2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
set(hObject,'xTick',[]);
set(hObject,'ytick',[]);
set(hObject,'box','on');
% Hint: place code in OpeningFcn to populate axes2


% --- Executes on button press in pushbutton5.  �˳�
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close(handles.figure1);


% --- Executes on button press in pushbutton6.  �ַ��ָ�
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global shibie;   %������־
% global L1;
shibie=1;   %��������
Dingwei();  
piccrop();   %ִ���ַ�����
