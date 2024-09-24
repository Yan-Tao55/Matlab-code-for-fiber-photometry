%% NOTE：This MATLAB script is copyrighted by Thinkertech.%%
function varargout = TrippleColorMultiChannel_OG_VideoSync_gui_v3(varargin)
% TRIPPLECOLORMULTICHANNEL_OG_VIDEOSYNC_GUI_V3 MATLAB code for TrippleColorMultiChannel_OG_VideoSync_gui_v3.fig
%      TRIPPLECOLORMULTICHANNEL_OG_VIDEOSYNC_GUI_V3, by itself, creates a new TRIPPLECOLORMULTICHANNEL_OG_VIDEOSYNC_GUI_V3 or raises the existing
%      singleton*.
%
%      H = TRIPPLECOLORMULTICHANNEL_OG_VIDEOSYNC_GUI_V3 returns the handle to a new TRIPPLECOLORMULTICHANNEL_OG_VIDEOSYNC_GUI_V3 or the handle to
%      the existing singleton*.
%
%      TRIPPLECOLORMULTICHANNEL_OG_VIDEOSYNC_GUI_V3('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TRIPPLECOLORMULTICHANNEL_OG_VIDEOSYNC_GUI_V3.M with the given input arguments.
%
%      TRIPPLECOLORMULTICHANNEL_OG_VIDEOSYNC_GUI_V3('Property','Value',...) creates a new TRIPPLECOLORMULTICHANNEL_OG_VIDEOSYNC_GUI_V3 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before TrippleColorMultiChannel_OG_VideoSync_gui_v3_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to TrippleColorMultiChannel_OG_VideoSync_gui_v3_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help TrippleColorMultiChannel_OG_VideoSync_gui_v3

% Last Modified by GUIDE v2.5 05-May-2022 20:58:35

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @TrippleColorMultiChannel_OG_VideoSync_gui_v3_OpeningFcn, ...
                   'gui_OutputFcn',  @TrippleColorMultiChannel_OG_VideoSync_gui_v3_OutputFcn, ...
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


% --- Executes just before TrippleColorMultiChannel_OG_VideoSync_gui_v3 is made visible.
function TrippleColorMultiChannel_OG_VideoSync_gui_v3_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to TrippleColorMultiChannel_OG_VideoSync_gui_v3 (see VARARGIN)

% Choose default command line output for TrippleColorMultiChannel_OG_VideoSync_gui_v3
clc
javaFrame=get(hObject,'javaFrame');
set(javaFrame,'FigureIcon',javax.swing.ImageIcon('logo_thinkertech.png'))
clc
addpath('TDMSReader');
addpath('Libraries');
addpath(genpath(pwd));

global passdata;
passdata=[];
path=load('Readpath.mat');
passdata.readpath=path.readpath;
set(handles.rate,'Value',2);
passdata.interval_cal=1/40;
passdata.ManualMark_upindex=[];
passdata.videocue1=[];
passdata.videocue2=[];
passdata.videocue3=[];
passdata.videocue4=[];
set(handles.MarkTime,'String','MarkTime');
passdata.InputMark=[];
passdata.calmode_index=2;
set(handles.smooth_sli,'Value',1.0);

handles.output = hObject;
set(handles.MarkOn_bt,'Value',0);
set(handles.MarkSetting_pan,'Visible','off');
set(handles.CalCorrection_bt,'Value',0);
set(handles.CalCorrection_pan,'Visible','off');


set(handles.Zoom_On_radio,'Value',1);
set(handles.cue_channel,'Value',1);
set(handles.cal_pm,'Value',1);
set(handles.Average_bt,'Value',0);
set(handles.Plotting_bt,'Value',0);
set(handles.AveragePlottingPannel,'Visible','off');

% set(handles.Cal,'Visible','on');
% set(handles.Event,'Visible','off');
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes TrippleColorMultiChannel_OG_VideoSync_gui_v3 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = TrippleColorMultiChannel_OG_VideoSync_gui_v3_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --------------------------------------------------------------------



function filepath_ed_Callback(hObject, eventdata, handles)
% hObject    handle to filepath_ed (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of filepath_ed as text
%        str2double(get(hObject,'String')) returns contents of filepath_ed as a double


% --- Executes during object creation, after setting all properties.
function filepath_ed_CreateFcn(hObject, eventdata, handles)
% hObject    handle to filepath_ed (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in MarkOn_bt.
function MarkOn_bt_Callback(hObject, eventdata, handles)
% hObject    handle to MarkOn_bt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
von=get(handles.MarkOn_bt,'Value');
if von==1
    set(handles.MarkSetting_pan,'Visible','on');
elseif von==0
    pos=get(handles.MarkSetting_pan,'Position');
    %     set(handles.MarkSetting_pan,'Position',[pos(1) pos(2) pos(3) 35]);
    %     pause(0.03);
    %     set(handles.MarkSetting_pan,'Position',[pos(1) pos(2) pos(3) 30]);
    %     pause(0.03);
    %     set(handles.MarkSetting_pan,'Position',[pos(1) pos(2) pos(3) 25]);
    %     pause(0.03);
    %     set(handles.MarkSetting_pan,'Position',[pos(1) pos(2) pos(3) 20]);
    %     pause(0.03);
    %     set(handles.MarkSetting_pan,'Position',[pos(1) pos(2) pos(3) 15]);
    %     pause(0.03);
    %     set(handles.MarkSetting_pan,'Position',[pos(1) pos(2) pos(3) 10]);
    %     pause(0.03);
    %     set(handles.MarkSetting_pan,'Position',[pos(1) pos(2) pos(3) 5]);
    %     pause(0.03);
    set(handles.MarkSetting_pan,'Position',[pos(1) pos(2) pos(3) pos(4)-pos(4)/6]);
    pause(0.03);
    set(handles.MarkSetting_pan,'Position',[pos(1) pos(2) pos(3) pos(4)-2*pos(4)/6]);
    pause(0.03);
    set(handles.MarkSetting_pan,'Position',[pos(1) pos(2) pos(3) pos(4)-3*pos(4)/6]);
    pause(0.03);
    set(handles.MarkSetting_pan,'Position',[pos(1) pos(2) pos(3) pos(4)-4*pos(4)/6]);
    pause(0.03);
    set(handles.MarkSetting_pan,'Position',[pos(1) pos(2) pos(3) pos(4)-5*pos(4)/6]);
    pause(0.03);
%     set(handles.MarkSetting_pan,'Position',[pos(1) pos(2) pos(3) 10pos(4)-2*pos(4)/6]);
%     pause(0.03);
%     set(handles.MarkSetting_pan,'Position',[pos(1) pos(2) pos(3) 5]);
%     pause(0.03);
    set(handles.MarkSetting_pan,'Visible','off');
    set(handles.MarkSetting_pan,'Position',[pos(1) pos(2) pos(3) pos(4)]);
end



% --- Executes on button press in AllDataPreView_bt.
function AllDataPreView_bt_Callback(hObject, eventdata, handles)
% hObject    handle to AllDataPreView_bt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global passdata;
color=['r','g','b','c','m','y','k'];

if ~isfield(passdata,'data470')&&~isfield(passdata,'data405')&&~isfield(passdata,'data580')&&~isfield(passdata,'cue')
    return
end

datachannelread=0;
if ~isempty(passdata.data405)
    datachannelread=datachannelread+1;
end
if ~isempty(passdata.data470)
    datachannelread=datachannelread+1;
end
if ~isempty(passdata.data580)
    datachannelread=datachannelread+1;
end
drawindex=datachannelread+1;
%%
color=['r','g','b','c','m','y','k','r','g','b','c'];
figure('NumberTitle', 'off', 'Name', 'Data Preview ');
subplot(drawindex,1,1)
%             t=interval*(1:1:handles.length_cue);
for i=1:size(passdata.cue,2)
    time=1:1:size(passdata.cue,1);
    time=time'*(passdata.interval_cal/2);
    plot(time,passdata.cue(:,i)+(size(passdata.cue,2)-i)*1.1,color(i));
    %                 eval(['plot(t,handles.data_cue(:,' num2str(i) '),'+(handles.channelnum_cue-i)*1.1',',''',color(i),'''',');']);
    hold on;
    title('Event Channel');
end
xlabel('Time (s)');
hold off;
color=['r','g','b','c','m','y','k','r','g','b','c'];
%%
datachannelread=2;
if ~isempty(passdata.data405)
    subplot(drawindex,1,datachannelread)
    t=1:1:size(passdata.data405,1);
    t=t'*passdata.interval_cal;
    for i=1:size(passdata.data405,2)-1
        plot(t,passdata.data405(:,i+1),color(i));
        hold on;
    end
    datachannelread=datachannelread+1;
    hold off;
    xlabel('Time (s)');
    title('Cal405 Channel');
end
%%
if ~isempty(passdata.data470)
    subplot(drawindex,1,datachannelread)
    t=1:1:size(passdata.data470,1);
    t=t'*passdata.interval_cal;
    for i=1:size(passdata.data470,2)-1
        plot(t,passdata.data470(:,i+1),color(i));
        hold on;
    end
    datachannelread=datachannelread+1;
    hold off;
    xlabel('Time (s)');
    title('Cal470 Channel');
end
%%
if ~isempty(passdata.data580)
    subplot(drawindex,1,datachannelread)
    t=1:1:size(passdata.data580,1);
    t=t'*passdata.interval_cal;
    for i=1:size(passdata.data580,2)-1
        plot(t,passdata.data580(:,i+1),color(i));
        hold on;
    end
    datachannelread=datachannelread+1;
    hold off;
    xlabel('Time (s)');
    title('Cal580 Channel');
end



% --- Executes on button press in Average_bt.
function Average_bt_Callback(hObject, eventdata, handles)
% hObject    handle to Average_bt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value=get(handles.Average_bt,'Value');
if value==1
    
    set(handles.Plotting_pannel,'Visible','off');
    if get(handles.Plotting_bt,'Value')==1
        set(handles.Plotting_bt,'Value',0);
        set(handles.Average_pannel,'Visible','on');
        set(handles.Plotting_pannel,'Visible','off');
    else
        pos1=get(handles.AveragePlottingPannel,'Position');
%         pos2=get(handles.DataPreView_axes,'Position');
%         
%         pos2(4)=pos2(4)-pos1(4);
        %     pos2(2)=pos2(2)+pos1(4);
        set(handles.Average_pannel,'Visible','on');
        set(handles.Plotting_pannel,'Visible','off');
%         set(handles.DataPreView_axes,'Position',pos2);
        set(handles.AveragePlottingPannel,'Visible','on');
    end
    %%
else
    
    pos=get(handles.AveragePlottingPannel,'Position');
    set(handles.AveragePlottingPannel,'Position',[pos(1) pos(2)+pos(4)/3 pos(3) pos(4)-pos(4)/3]);
    pause(0.03);
    set(handles.AveragePlottingPannel,'Position',[pos(1) pos(2)+2*pos(4)/3 pos(3)  pos(4)-2*pos(4)/3]);
    pause(0.03);
    set(handles.AveragePlottingPannel,'Position',[pos(1) pos(2)+3*pos(4)/3 pos(3) pos(4)-3*pos(4)/3]);
    pause(0.03);
    set(handles.AveragePlottingPannel,'Visible','off');
    set(handles.AveragePlottingPannel,'Position',[pos(1) pos(2) pos(3) pos(4)]);
    
%     pos2=get(handles.DataPreView_axes,'Position');
%     pos2(4)=pos2(4)+pos(4);
%     set(handles.DataPreView_axes,'Position',pos2);
end
guidata(hObject,handles);


% --- Executes on button press in Plotting_bt.
function Plotting_bt_Callback(hObject, eventdata, handles)
% hObject    handle to Plotting_bt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value=get(handles.Plotting_bt,'Value');
if value==1
    if get(handles.Average_bt,'Value')==1
        set(handles.Average_bt,'Value',0);
        set(handles.Average_pannel,'Visible','off');
        set(handles.Plotting_pannel,'Visible','on');
%         %%
%         pos1=get(handles.AveragePlottingPannel,'Position');
%         pos2=get(handles.DataPreView_axes,'Position');
%         
%         pos2(4)=pos2(4)-pos1(4);
%         set(handles.DataPreView_axes,'Position',pos2);
%         set(handles.AveragePlottingPannel,'Visible','on');
    else  
        pos1=get(handles.AveragePlottingPannel,'Position');
%         pos2=get(handles.DataPreView_axes,'Position');
        
%         pos2(4)=pos2(4)-pos1(4);
        set(handles.Average_pannel,'Visible','off');
        set(handles.Plotting_pannel,'Visible','on');
%         set(handles.DataPreView_axes,'Position',pos2);
        set(handles.AveragePlottingPannel,'Visible','on');
    end
    %%
else
    pos=get(handles.AveragePlottingPannel,'Position');
    set(handles.AveragePlottingPannel,'Position',[pos(1) pos(2)+pos(4)/3 pos(3) pos(4)-pos(4)/3]);
    pause(0.03);
    set(handles.AveragePlottingPannel,'Position',[pos(1) pos(2)+2*pos(4)/3 pos(3)  pos(4)-2*pos(4)/3]);
    pause(0.03);
    set(handles.AveragePlottingPannel,'Position',[pos(1) pos(2)+3*pos(4)/3 pos(3) pos(4)-3*pos(4)/3]);
    pause(0.03);
    set(handles.AveragePlottingPannel,'Visible','off');
    set(handles.AveragePlottingPannel,'Position',[pos(1) pos(2) pos(3) pos(4)]);
    
%     pos2=get(handles.DataPreView_axes,'Position');
%     pos2(4)=pos2(4)+pos(4);
%     set(handles.DataPreView_axes,'Position',pos2);
end
guidata(hObject,handles);


% --- Executes on button press in OtherFunction_bt.
function OtherFunction_bt_Callback(hObject, eventdata, handles)
% hObject    handle to OtherFunction_bt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clc
if isfield(handles,'h1')
    clc
else
    handles.h1=OtherFunction;
end




% --- Executes on button press in CalCorrection_bt.
function CalCorrection_bt_Callback(hObject, eventdata, handles)
% hObject    handle to CalCorrection_bt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
von=get(handles.CalCorrection_bt,'Value');
if von==1
    pos1=get(handles.CalCorrection_pan,'Position');
    pos2=get(handles.DataPreView_axes,'Position');
    pos2(4)=pos2(4)-pos1(4);
    pos2(2)=pos2(2)+pos1(4);
    set(handles.DataPreView_axes,'Position',pos2);
    set(handles.CalCorrection_pan,'Visible','on');
elseif von==0
    pos=get(handles.CalCorrection_pan,'Position');
    set(handles.CalCorrection_pan,'Position',[pos(1) pos(2) pos(3) pos(4)-pos(4)/5]);
    pause(0.03);
    set(handles.CalCorrection_pan,'Position',[pos(1) pos(2) pos(3) pos(4)-2*pos(4)/5]);
    pause(0.03);
    set(handles.CalCorrection_pan,'Position',[pos(1) pos(2) pos(3) pos(4)-3*pos(4)/5]);
    pause(0.03);
    set(handles.CalCorrection_pan,'Position',[pos(1) pos(2) pos(3) pos(4)-4*pos(4)/5]);
    pause(0.03);
    set(handles.CalCorrection_pan,'Position',[pos(1) pos(2) pos(3) pos(4)-5*pos(4)/5]);
    pause(0.03);
    set(handles.CalCorrection_pan,'Visible','off');
    set(handles.CalCorrection_pan,'Position',[pos(1) pos(2) pos(3) pos(4)]);
    pos2=get(handles.DataPreView_axes,'Position');
    pos2(4)=pos2(4)+pos(4);
    pos2(2)=pos2(2)-pos(4);
    set(handles.DataPreView_axes,'Position',pos2);
end

% Hint: get(hObject,'Value') returns toggle state of CalCorrection_bt


% --- Executes on selection change in cal_pm.
function cal_pm_Callback(hObject, eventdata, handles)
% hObject    handle to cal_pm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global passdata;
if ~isfield(passdata,'data405')&&~isfield(passdata,'data470')&&~isfield(passdata,'data580')
    return;
end
DrawData1_dualmulti;

% Hints: contents = cellstr(get(hObject,'String')) returns cal_pm contents as cell array
%        contents{get(hObject,'Value')} returns selected item from cal_pm


% --- Executes during object creation, after setting all properties.
function cal_pm_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cal_pm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function smooth_sli_Callback(hObject, eventdata, handles)
% hObject    handle to smooth_sli (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global passdata;
if ~isfield(passdata,'data405')&&~isfield(passdata,'data470')&&~isfield(passdata,'data580')
    return;
end
DrawData1_dualmulti;

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function smooth_sli_CreateFcn(hObject, eventdata, handles)
% hObject    handle to smooth_sli (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on selection change in MarkTime.
function MarkTime_Callback(hObject, eventdata, handles)
% hObject    handle to MarkTime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns MarkTime contents as cell array
%        contents{get(hObject,'Value')} returns selected item from MarkTime


% --- Executes during object creation, after setting all properties.
function MarkTime_CreateFcn(hObject, eventdata, handles)
% hObject    handle to MarkTime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in ClearMark_bt.
function ClearMark_bt_Callback(hObject, eventdata, handles)
% hObject    handle to ClearMark_bt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clc
global passdata
if ~isfield(passdata,'data405')&&~isfield(passdata,'data470')&&~isfield(passdata,'data580')
    msgbox('请读取钙信号数据之后使用该功能！！！');
    return;
else
    if ~isempty(passdata.ManualMark_upindex)
        dig=['请确定是否清除手动设置的打标时间点数据？'];
        choice=questdlg(dig, ...
            'Selection Dialog', ...
            'Yes', 'No','No');
        if isempty(choice)
            msgbox('用户取消清除手动打标的时间点 !!!');
            return
        else
            if strcmp(choice,'No')
                msgbox('用户取消清除手动打标的时间点 !!!!');
                return
            else
                %% clear mark
                passdata.ManualMark_upindex=[];
                listbox_cell=cell(1,1);
                listbox_cell{1,1}='MarkTime';
                set(handles.MarkTime,'String',listbox_cell);
                set(handles.MarkTime,'Value',1);
                DrawData1_dualmulti;
            end
        end
    end
end

% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1


% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in SaveInputMark_bt.
function SaveInputMark_bt_Callback(hObject, eventdata, handles)
% hObject    handle to SaveInputMark_bt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clc
global passdata
if ~isfield(passdata,'data405')&&~isfield(passdata,'data470')&&~isfield(passdata,'data580')
    msgbox('请读取钙信号数据之后使用该功能！！！');
    return;
end
if isfield(passdata,'cue')
    if ~isempty(passdata.cue)
        %         passdata.InputMark.Finalyupindex_' num2str(i) '=exam_upindex;']);
        if isfield(passdata,'cue')
            %%
            data.InputMark=passdata.InputMark;
            data.ManualMark_upindex=passdata.ManualMark_upindex;
            data.videocue1=passdata.videocue1;
            data.videocue2=passdata.videocue2;
            data.videocue3=passdata.videocue3;
            data.videocue4=passdata.videocue4;
            data.cue=passdata.cue;
            name=strrep(passdata.cuefilepath,passdata.cuepart,'_editmark.mat');
            dig=['是否想要另存为数据文件? 如果选择no, 数据将保存在 ' name '!!!'];
            choice=questdlg(dig, ...
                'Selection Dialog', ...
                'Yes', 'No','No');
            if isempty(choice)
                save(strrep(passdata.cuefilepath,passdata.cuepart,'_editmark.mat'),'data');
            else
                if strcmp(choice,'No')
                    save(strrep(passdata.cuefilepath,passdata.cuepart,'_editmark.mat'),'data');
                elseif strcmp(choice,'Yes')
                    [SaveFileName,SavePathName,SaveIndex] = uiputfile('*.mat;','Save as',passdata.readpath); %设置默认路径
                    if isequal(SaveFileName,0) || isequal(SavePathName,0) || isequal(SaveIndex,0)
                        disp('User seleceted Cancel');
                        save(strrep(passdata.cuefilepath,passdata.cuepart,'_editmark.mat'),'data');
                    else
                        path=[SavePathName SaveFileName];
                        save(path,'data');
                    end
                end
            end
            
            msgbox('操作成功 !!!');
            %%
        end
    end
% elseif isfield(passdata,'cal')
%     if isfield(passdata,'ManualMark_upindex')
%         data.ManualMark_upindex=passdata.ManualMark_upindex;
%         data.videocue1=passdata.videocue1;
%         data.videocue2=passdata.videocue2;
%         data.videocue3=passdata.videocue3;
%         data.videocue4=passdata.videocue4;
%         
%         name=strrep(passdata.file_path_and_name_cal,passdata.file_part_cal,'_editmark.mat');
%         dig=['是否想要另存为数据文件? 如果选择no, 数据将保存在 ' name '!!!'];
%         choice=questdlg(dig, ...
%             'Selection Dialog', ...
%             'Yes', 'No','No');
%         if isempty(choice)
%             save(strrep(passdata.file_path_and_name_cal,passdata.file_part_cal,'_editmark.mat'),'data');
%         else
%             if strcmp(choice,'No')
%                 save(strrep(passdata.file_path_and_name_cal,passdata.file_part_cal,'_editmark.mat'),'data');
%             elseif strcmp(choice,'Yes')
%                 [SaveFileName,SavePathName,SaveIndex] = uiputfile('*.mat;','Save as',passdata.readpath); %设置默认路径
%                 if isequal(SaveFileName,0) || isequal(SavePathName,0) || isequal(SaveIndex,0)
%                     disp('User seleceted Cancel');
%                     save(strrep(passdata.file_path_and_name_cal,passdata.file_part_cal,'_editmark.mat'),'data');
%                 else
%                     path=[SavePathName SaveFileName];
%                     save(path,'data');
%                 end
%             end
%         end
%         msgbox('操作成功 !!!');
%     end
end




% --- Executes on button press in ResetMark_bt.
function ResetMark_bt_Callback(hObject, eventdata, handles)
% hObject    handle to ResetMark_bt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clc
global passdata;
if ~isfield(passdata,'data405')&&~isfield(passdata,'data470')&&~isfield(passdata,'data580')
    msgbox('请读取钙信号数据之后使用该功能！！！');
    return;
end
if isfield(passdata,'cue')
    
    if ~isempty(passdata.cue)
        if isfield(passdata,'InputMark')
            dig=['是否要重置打标时间到初始化记录时间位置？'];
            choice=questdlg(dig, ...
                'Selection Dialog', ...
                'Yes', 'No','No');
            if isempty(choice)
                msgbox('取消重置打标时间到初始化记录时间位置 !!!');
                return
            else
                if strcmp(choice,'No')
                    msgbox('取消重置打标时间到初始化记录时间位置 !!!!');
                    return
                else
                    %% reset mark
                    for i=1:size(passdata.cue,2)
                        cue=smooth(passdata.cue(:,i),5);
                        cue(cue<0.7)=0;
                        cue(cue>=0.7)=1;
                        current_cue=cue;
                        exam_upindex=1+find(diff(current_cue)==1)'-4;
                        exam_trialnum = size(exam_upindex,2);
                        eval(['passdata.InputMark.upindex_' num2str(i) '=exam_upindex;']);
                        eval(['passdata.InputMark.Finalyupindex_' num2str(i) '=exam_upindex;']);
                        eval(['passdata.InputMark.trialnum_' num2str(i) '=exam_trialnum;']);
                    end
                end
                DrawData1_dualmulti;
            end
            %%
        end
    end
end


% --- Executes on selection change in cue_channel.
function cue_channel_Callback(hObject, eventdata, handles)
% hObject    handle to cue_channel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global passdata;
if ~isfield(passdata,'data405')&&~isfield(passdata,'data470')&&~isfield(passdata,'data580')
    msgbox('请读取钙信号数据之后使用该功能！！！');
    return;
end
% if ~isfield(passdata,'cue')
%     return;
% else 
%     if isempty(passdata.cue)
%         return;
%     end
% end
DrawData1_dualmulti;

% Hints: contents = cellstr(get(hObject,'String')) returns cue_channel contents as cell array
%        contents{get(hObject,'Value')} returns selected item from cue_channel


% --- Executes during object creation, after setting all properties.
function cue_channel_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cue_channel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function correcttime1_ed_Callback(hObject, eventdata, handles)
% hObject    handle to correcttime1_ed (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of correcttime1_ed as text
%        str2double(get(hObject,'String')) returns contents of correcttime1_ed as a double


% --- Executes during object creation, after setting all properties.
function correcttime1_ed_CreateFcn(hObject, eventdata, handles)
% hObject    handle to correcttime1_ed (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function correcttime2_ed_Callback(hObject, eventdata, handles)
% hObject    handle to correcttime2_ed (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of correcttime2_ed as text
%        str2double(get(hObject,'String')) returns contents of correcttime2_ed as a double


% --- Executes during object creation, after setting all properties.
function correcttime2_ed_CreateFcn(hObject, eventdata, handles)
% hObject    handle to correcttime2_ed (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in lambda_pm.
function lambda_pm_Callback(hObject, eventdata, handles)
% hObject    handle to lambda_pm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns lambda_pm contents as cell array
%        contents{get(hObject,'Value')} returns selected item from lambda_pm


% --- Executes during object creation, after setting all properties.
function lambda_pm_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lambda_pm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ploy_ed_Callback(hObject, eventdata, handles)
% hObject    handle to ploy_ed (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ploy_ed as text
%        str2double(get(hObject,'String')) returns contents of ploy_ed as a double


% --- Executes during object creation, after setting all properties.
function ploy_ed_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ploy_ed (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in lambdacorrect_bt.
function lambdacorrect_bt_Callback(hObject, eventdata, handles)
% hObject    handle to lambdacorrect_bt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clc
global passdata;
calmode=get(handles.calmode_pm,'Value');
switch calmode
    case 1
        modeindex='data405';
        cal=passdata.data405;
    case 2
        modeindex='data470';
        cal=passdata.data470;
    case 3
        modeindex='data580';
        cal=passdata.data580;
end
if isfield(passdata,modeindex)
    if ~isempty(cal)
        value=get(handles.lambda_pm,'Value')+4;
        correction_time=str2num(get(handles.correcttime1_ed,'String'));
        if isempty(correction_time)
            msgbox('请输入正确的CorrecttionTimes/s的开始时间，时间格式应输入数值不包含特殊符号！！！');
            return
        end
        correction_time_2=str2num(get(handles.correcttime2_ed,'String'));
        if isempty(correction_time_2)
            msgbox('请输入正确的CorrecttionTimes/s的结束时间，时间格式应输入数值不包含特殊符号！！！');
            return
        end
        %% 判定时间格式是否正确
        interval=passdata.interval_cal;
        maxtime=size(cal,1)*interval;
        if correction_time>correction_time_2
            p=correction_time;
            correction_time=correction_time_2;
            correction_time_2=p;
        end
        if correction_time<=0
            correction_time=0;
        end
        if correction_time_2<=0
            return;
        end
        if correction_time_2>maxtime
            correction_time_2=maxtime;
        end
        set(handles.correcttime1_ed,'String',num2str(correction_time));
        set(handles.correcttime2_ed,'String',num2str(correction_time_2));
        %% 检索起始位置
        cal_index=get(handles.cal_pm,'Value');
        start_index=correction_time/interval;
        end_index=correction_time_2/interval;
        if start_index==0
            start_index=1;
        end
        correction_data=cal(start_index:end_index,cal_index+1);
        correction_data=correction_data';
        %% 检索间隔点位置
        if round(correction_time/interval)==0
            part_index=0;
            part_index_end=end_index+1;
        else
            part_index=round(correction_time/interval)-1;
            part_index_end=end_index+1;
        end
        %% 存储间隔位置数据
        raw_start=correction_data(1);
        raw_end=correction_data(end);
        %% 计算
        lambda=10^(value+1);
        [correction_data,~]=airPLS(correction_data, lambda,2,0.05);
        if isempty(correction_data)
            msgbox('该时间段不可矫正，判断该通道数据是否包含有效信息！！！');
            return;
        end
        correction_data=correction_data+(raw_start-correction_data(1));
        correction_data=correction_data';
        passdata.cal_correction_index=[];
        if part_index==0
            passdata.correction_data=[correction_data;cal(part_index_end:end,cal_index+1)-raw_end+correction_data(end)];
            passdata.correction_index=1;
            passdata.cal_correction_index.cal_index=cal_index;
            passdata.cal_correction_index.calmode=calmode;
        else
            passdata.correction_data=[cal(1:part_index,cal_index+1);correction_data;cal(part_index_end:end,cal_index+1)-raw_end+correction_data(end)];
            passdata.correction_index=1;
            passdata.cal_correction_index.cal_index=cal_index;
            passdata.cal_correction_index.calmode=calmode;
        end
        DrawData1_dualmulti_Correct;
    end
end

% --- Executes on button press in ploycorrect_bt.
function ploycorrect_bt_Callback(hObject, eventdata, handles)
% hObject    handle to ploycorrect_bt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clc
global passdata;
calmode=get(handles.calmode_pm,'Value');
switch calmode
    case 1
        modeindex='data405';
        cal=passdata.data405;
    case 2
        modeindex='data470';
        cal=passdata.data470;
    case 3
        modeindex='data580';
        cal=passdata.data580;
end
if isfield(passdata,modeindex)
    if ~isempty(cal)
        value=get(handles.lambda_pm,'Value')+4;
        correction_time=str2num(get(handles.correcttime1_ed,'String'));
        if isempty(correction_time)
            msgbox('请输入正确的CorrecttionTimes/s的开始时间，时间格式应输入数值不包含特殊符号！！！');
            return
        end
        correction_time_2=str2num(get(handles.correcttime2_ed,'String'));
        if isempty(correction_time_2)
            msgbox('请输入正确的CorrecttionTimes/s的结束时间，时间格式应输入数值不包含特殊符号！！！');
            return
        end
        %% 判定时间格式是否正确
        interval=passdata.interval_cal;
        maxtime=size(cal,1)*interval;
        if correction_time>correction_time_2
            p=correction_time;
            correction_time=correction_time_2;
            correction_time_2=p;
        end
        if correction_time<=0
            correction_time=0;
        end
        if correction_time_2<=0
            return;
        end
        if correction_time_2>maxtime
            correction_time_2=maxtime;
        end
        set(handles.correcttime1_ed,'String',num2str(correction_time));
        set(handles.correcttime2_ed,'String',num2str(correction_time_2));
        %% 检索起始位置
        cal_index=get(handles.cal_pm,'Value');
        start_index=correction_time/interval;
        end_index=correction_time_2/interval;
        if start_index==0
            start_index=1;
        end
        correction_data=cal(start_index:end_index,cal_index+1);
        correction_data=correction_data';
        %% 检索间隔点位置
        if round(correction_time/interval)==0
            part_index=0;
            part_index_end=end_index+1;
        else
            part_index=round(correction_time/interval)-1;
            part_index_end=end_index+1;
        end
        %% 存储间隔位置数据
        raw_start=correction_data(1);
        raw_end=correction_data(end);
        %% 计算
        values = correction_data;
        [xData, yData] = prepareCurveData( [], values );
        n=2;
        [p,s,mu] = polyfit(xData,yData,n);
        fit_y = polyval(p,xData,[],mu);
        correction_data= values-fit_y';
        %%
        if isempty(correction_data)
            msgbox('该时间段不可矫正，判断该通道数据是否包含有效信息！！！');
            return;
        end
        correction_data=correction_data+(raw_start-correction_data(1));
        correction_data=correction_data';
        if part_index==0
            passdata.correction_data=[correction_data;cal(part_index_end:end,cal_index+1)-raw_end+correction_data(end)];
            passdata.correction_index=2;
            passdata.cal_correction_index.cal_index=cal_index;
            passdata.cal_correction_index.calmode=calmode;
        else
            passdata.correction_data=[cal(1:part_index,cal_index+1);correction_data;cal(part_index_end:end,cal_index+1)-raw_end+correction_data(end)];
            passdata.correction_index=2;
            passdata.cal_correction_index.cal_index=cal_index;
            passdata.cal_correction_index.calmode=calmode;
        end
        DrawData1_dualmulti_Correct;
    end
end



% --- Executes on button press in LambdaSaveCorrect_bt.
function LambdaSaveCorrect_bt_Callback(hObject, eventdata, handles)
% hObject    handle to LambdaSaveCorrect_bt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clc
global passdata;
if isfield(passdata,'correction_data')
    if ~isempty(passdata.correction_data)
        if isfield(passdata,'cal_correction_index') && passdata.correction_index==1
            switch passdata.cal_correction_index.calmode
                case 1
                    modeindex='data405';
                    cal=passdata.data405;
                case 2
                    modeindex='data470';
                    cal=passdata.data470;
                case 3
                    modeindex='data580';
                    cal=passdata.data580;
            end
            if size(cal,2)>=(passdata.cal_correction_index.cal_index+1)
                dig=['请确定是否要将' modeindex '' num2str(passdata.cal_correction_index.cal_index) ' 通道数据替换为矫正数据 ？？'];
                choice=questdlg(dig, ...
                    'Selection Dialog', ...
                    'Yes', 'No','No');
                if isempty(choice)
                    msgbox('用户取消操作 !!!');
                else
                    if strcmp(choice,'No')
                        msgbox('用户取消操作 !!!!');
                    else
                        if isfield(passdata,modeindex)
                            if ~isempty(cal)
                                cal(:,passdata.cal_correction_index.cal_index+1)=passdata.correction_data;
                                set(handles.cal_pm,'Value',passdata.cal_correction_index.cal_index);
                                set(handles.calmode_pm,'Value',passdata.cal_correction_index.calmode);
                                switch passdata.cal_correction_index.calmode
                                    case 1
                                        passdata.data405=cal;
                                        name=strrep(passdata.Cal405filepath,passdata.cal405part,'_CalProcessing.mat');
                                        data=cal;
                                        save(name,'data');
                                    case 2
                                        passdata.data470=cal;
                                        name=strrep(passdata.Cal470filepath,passdata.cal470part,'_CalProcessing.mat');
                                        data=cal;
                                        save(name,'data');
                                    case 3
                                        passdata.data580=cal;
                                        name=strrep(passdata.Cal580filepath,passdata.cal580part,'_CalProcessing.mat');
                                        data=cal;
                                        save(name,'data');
                                end
                                clear cal;
                                clear data;
                                DrawData1_dualmulti;
                                msgbox('操作成功 !!!');
                            end
                        end
                    end
                end
            end
        end
    end
end


% --- Executes on button press in PloySaveCorrect_bt.
function PloySaveCorrect_bt_Callback(hObject, eventdata, handles)
% hObject    handle to PloySaveCorrect_bt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clc
global passdata;
if isfield(passdata,'correction_data')
    if ~isempty(passdata.correction_data)
        if isfield(passdata,'cal_correction_index') && passdata.correction_index==2
            switch passdata.cal_correction_index.calmode
                case 1
                    modeindex='data405';
                    cal=passdata.data405;
                case 2
                    modeindex='data470';
                    cal=passdata.data470;
                case 3
                    modeindex='data580';
                    cal=passdata.data580;
            end
            if size(cal,2)>=(passdata.cal_correction_index.cal_index+1)
                dig=['请确定是否要将' modeindex '' num2str(passdata.cal_correction_index.cal_index) ' 通道数据替换为矫正数据 ？？'];
                choice=questdlg(dig, ...
                    'Selection Dialog', ...
                    'Yes', 'No','No');
                if isempty(choice)
                    msgbox('用户取消操作 !!!');
                else
                    if strcmp(choice,'No')
                        msgbox('用户取消操作 !!!!');
                    else
                        if isfield(passdata,modeindex)
                            if ~isempty(cal)
                                cal(:,passdata.cal_correction_index.cal_index+1)=passdata.correction_data;
                                set(handles.cal_pm,'Value',passdata.cal_correction_index.cal_index);
                                set(handles.calmode_pm,'Value',passdata.cal_correction_index.calmode);
                                switch passdata.cal_correction_index.calmode
                                    case 1
                                        passdata.data405=cal;
                                        name=strrep(passdata.Cal405filepath,passdata.cal405part,'_CalProcessing.mat');
                                        data=cal;
                                        save(name,'data');
                                    case 2
                                        passdata.data470=cal;
                                        name=strrep(passdata.Cal470filepath,passdata.cal470part,'_CalProcessing.mat');
                                        data=cal;
                                        save(name,'data');
                                    case 3
                                        passdata.data580=cal;
                                        name=strrep(passdata.Cal580filepath,passdata.cal580part,'_CalProcessing.mat');
                                        data=cal;
                                        save(name,'data');
                                end
                                clear cal;
                                clear data;
                                DrawData1_dualmulti;
                                msgbox('操作成功 !!!');
                            end
                        end
                    end
                end
            end
        end
    end
end



% --- Executes on button press in SaveSmooth_bt.
function SaveSmooth_bt_Callback(hObject, eventdata, handles)
% hObject    handle to SaveSmooth_bt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global passdata;
cal_index=get(handles.cal_pm,'Value');
smoothval=round(get(handles.smooth_sli,'Value'));
calmode=get(handles.calmode_pm,'Value');
switch calmode
    case 1
        modeindex='data405';
        cal=passdata.data405;
    case 2
        modeindex='data470';
        cal=passdata.data470;
    case 3
        modeindex='data580';
        cal=passdata.data580;
end
if smoothval>1
    dig=['请确定是否替换' modeindex '的' num2str(cal_index) ' 通道数据为平滑过后的数据？？？'];
    choice=questdlg(dig, ...
        'Selection Dialog', ...
        'Yes', 'No','No');
    if isempty(choice)
        msgbox('用户取消操作 !!!');
    else
        if strcmp(choice,'No')
            msgbox('用户取消操作 !!!!');
        else
            if isfield(passdata,modeindex)
                if ~isempty(cal)
                    exam=smooth(cal(:,cal_index+1),smoothval);
                    cal(:,cal_index+1)=exam;
                    
                    set(handles.smooth_sli,'Value',1);
                    switch calmode
                        case 1
                            passdata.data405=cal;
                            name=strrep(passdata.Cal405filepath,passdata.cal405part,'_CalProcessing.mat');
                            data=cal;
                            save(name,'data');
                            msgbox('操作成功 !!!');
                        case 2
                            passdata.data470=cal;
                            name=strrep(passdata.Cal470filepath,passdata.cal470part,'_CalProcessing.mat');
                            data=cal;
                            save(name,'data');
                            msgbox('操作成功 !!!');
                        case 3
                            passdata.data580=cal;
                            name=strrep(passdata.Cal580filepath,passdata.cal580part,'_CalProcessing.mat');
                            data=cal;
                            save(name,'data');
                            msgbox('操作成功 !!!');
                    end
                    DrawData1_dualmulti;
                end
            end
        end
    end
end






% --- Executes on selection change in calmode_pm.
function calmode_pm_Callback(hObject, eventdata, handles)
% hObject    handle to calmode_pm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global passdata
mode=get(handles.calmode_pm,'Value');
switch mode
    case 1
        if isfield(passdata,'data405')
            if isempty(passdata.data405)
                set(handles.calmode_pm,'Value',passdata.calmode_index);
                return
            else
                passdata.calmode_index=1;
            end
        else
            set(handles.calmode_pm,'Value',passdata.calmode_index);
            return
        end
    case 2
       if isfield(passdata,'data470')
            if isempty(passdata.data470)
                set(handles.calmode_pm,'Value',passdata.calmode_index);
                return
            else
                passdata.calmode_index=2;
            end
        else
            set(handles.calmode_pm,'Value',passdata.calmode_index);
            return
        end 
    case 3
        if isfield(passdata,'data580')
            if isempty(passdata.data580)
                set(handles.calmode_pm,'Value',passdata.calmode_index);
                return
            else
                passdata.calmode_index=3;
            end
        else
            set(handles.calmode_pm,'Value',passdata.calmode_index);
            return
        end 
end
%%
DrawData1_dualmulti;

guidata(hObject,handles);


% Hints: contents = cellstr(get(hObject,'String')) returns calmode_pm contents as cell array
%        contents{get(hObject,'Value')} returns selected item from calmode_pm


% --- Executes during object creation, after setting all properties.
function calmode_pm_CreateFcn(hObject, eventdata, handles)
% hObject    handle to calmode_pm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --------------------------------------------------------------------
function OpenEventData_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to OpenEventData (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global passdata;
[filename, pathname] = uigetfile({'*.tdms';'*.mat';'*.CSV'}, 'Open calcium_data file',passdata.readpath);
if isequal(filename,0)
    msgbox('用户取消读取！！！');
%     set(handles.filepath_ed,'String','Operation completed failed !!!!');
    return;
end

passdata.file_path_and_name_cue = fullfile(pathname, filename);

passdata.readpath=pathname(1:end-1);
%% 读取cue数据
[~,~,filepart_cue]=fileparts(passdata.file_path_and_name_cue);
% [filename,pathname]=uigetfile({'*.tdms'},'Open cue_data file','MultiSelect','on');%读取多个mat文件
% handles.file_path_and_name_cue = fullfile(pathname, filename(i));
if strcmp(filepart_cue,'.csv')
    cue=csvread(passdata.file_path_and_name_cue);
elseif strcmp(filepart_cue,'.tdms')
    file = TDMS_readTDMSFile(passdata.file_path_and_name_cue);
    cue=cat(1,file.data{3:end})';
elseif strcmp(filepart_cue,'.mat')
    cue=load(passdata.file_path_and_name_cue);
    if isfield(cue,'data')
        cue=cue.data;
    else
        msgbox('请选择争取的转换过后的mat文件 !!!!!') ;
    end
end
%%
if isempty(cue)
    msgbox('Event数据读取失败！！');
    return
else
    passdata.cue=cue;
end
%%      保存event数据
passdata.file_part_cue=filepart_cue;
passdata.channelnum_cue=size(passdata.cue,2);
passdata.length_cue=size(passdata.cue,1);
%% 计算event每个通道的上升沿位置
for i=1:passdata.channelnum_cue
    cue=smooth(passdata.cue(:,i),5);
    cue(cue<1)=0;
    cue(cue>=1)=1;
    current_cue=cue;
    exam_upindex=1+find(diff(current_cue)==1)'-4;
    exam_trialnum = size(exam_upindex,2);
    eval(['passdata.InputMark.upindex_' num2str(i) '=exam_upindex;']);
    eval(['passdata.InputMark.Finalyupindex_' num2str(i) '=exam_upindex;']);
    eval(['passdata.InputMark.trialnum_' num2str(i) '=exam_trialnum;']);  
end
%% 
stringcell=cell(passdata.channelnum_cue+5,1);
stringcell{1,1}='ManualMark';
for i=1:4
    stringcell{1+i,1}=['VideoCue' num2str(i)];
end
for i=1:passdata.channelnum_cue
    stringcell{i+5,1}=['D' num2str(i)];
end

set(handles.cue_channel,'String',stringcell);
%% 
set(handles.cue_channel,'Value',1);
%% 
passdata.cue_read=1;
set(handles.filepath_ed,'String','Event read completed !!!!');

DrawData1_dualmulti;

msgbox('Event数据读取成功！！！！');
guidata(hObject,handles);


% --- Executes on button press in EditInputMark.


% Hint: get(hObject,'Value') returns toggle state of EditManualMark


% --- Executes on button press in Zoom_On_radio.
function Zoom_On_radio_Callback(hObject, eventdata, handles)
% hObject    handle to Zoom_On_radio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global passdata;
handles.uipanel1;
if get(handles.Zoom_On_radio,'Value')
%     hA = gca;
%     zoom(hA, 'reset');
    zoom xon;
    %     DrawData1_dualmulti;
elseif get(handles.Zoom_On_radio,'Value')==0
    if ~isfield(passdata,'data405')&&~isfield(passdata,'data470')&&~isfield(passdata,'data580')
        msgbox('请读取钙信号数据之后使用该功能！！！');
        return;
    end
    if isempty(passdata.data405)&&isempty(passdata.data470)&&isempty(passdata.data580)
        set(handles.Zoom_On_radio,'Value',1);
    else
        zoom off
        set(gcf,'WindowButtonMotionFcn',{@ButtonMotionFcn,handles},'WindowButtonDownFcn',@ButttonDownFcn,'WindowButtonUpFcn',{@ButttonUpFcn,handles});
    end
end

% Hint: get(hObject,'Value') returns toggle state of Zoom_On_radio


% --- Executes on button press in togglebutton2.
function togglebutton2_Callback(hObject, eventdata, handles)
% hObject    handle to togglebutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of togglebutton2



function pretime_Callback(hObject, eventdata, handles)
% hObject    handle to pretime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of pretime as text
%        str2double(get(hObject,'String')) returns contents of pretime as a double


% --- Executes during object creation, after setting all properties.
function pretime_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pretime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function posttime_Callback(hObject, eventdata, handles)
% hObject    handle to posttime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of posttime as text
%        str2double(get(hObject,'String')) returns contents of posttime as a double


% --- Executes during object creation, after setting all properties.
function posttime_CreateFcn(hObject, eventdata, handles)
% hObject    handle to posttime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function control_1_Callback(hObject, eventdata, handles)
% hObject    handle to control_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of control_1 as text
%        str2double(get(hObject,'String')) returns contents of control_1 as a double


% --- Executes during object creation, after setting all properties.
function control_1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to control_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function control_2_Callback(hObject, eventdata, handles)
% hObject    handle to control_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of control_2 as text
%        str2double(get(hObject,'String')) returns contents of control_2 as a double


% --- Executes during object creation, after setting all properties.
function control_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to control_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Avearge_pb.
function Avearge_pb_Callback(hObject, eventdata, handles)
% hObject    handle to Avearge_pb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clc
global passdata
if ~isfield(passdata,'data405')&&~isfield(passdata,'data470')&&~isfield(passdata,'data580')
    msgbox('请读取钙信号数据之后使用该功能！！！');
    return;
end
calmode=get(handles.calmode_pm,'Value');
switch calmode
    case 1
        modeindex='data405';
        cal=passdata.data405;
    case 2
        modeindex='data470';
        cal=passdata.data470;
    case 3
        modeindex='data580';
        cal=passdata.data580;
end

if isfield(passdata,modeindex)
    if ~isempty(cal)
        %%
        %
        value=get(handles.cue_channel,'Value');
        if value>5
            if ~isfield(passdata,'cue')
                return
            else
                if isempty(passdata.cue)
                    return
                end
            end
            cue_index=value-5;
            eval(['upindex=passdata.InputMark.upindex_' num2str(cue_index) ';']);
            if isempty(upindex)
                msgbox('当前Cue通道未检测到打标时间点，请重新确认打标通道！！');
                return
            end
            interval_cue=passdata.interval_cal/2;
            upindex=upindex*interval_cue;
        elseif value==1
            upindex=passdata.ManualMark_upindex;
            if isempty(upindex)
                msgbox('手动打标模式未检测到打标时间点，请重新确认手动打标模式是否有做标记处理！！');
                return
            end
        elseif value>1&&value<=5
            
            eval(['upindex=passdata.videocue' num2str(value-1) ';']);
            if isempty(upindex)
                msgbox('该视频打标通道未检测到打标时间点，请重新确认手动打标模式是否有做标记处理！！');
                return
            end
        end
        cal_index=get(handles.cal_pm,'Value');
        currentcall=cal(:,cal_index+1);
        pre_time=str2num(get(handles.pretime,'String'));
        %% 判定输入时间格式
        if isempty(pre_time)
            msgbox('请输入正确的开始时间格式!!!');
            return;
        end
        if pre_time>=0
            msgbox('开始时间点请设置负值!!!');
            return;
        end
        post_time=str2num(get(handles.posttime,'String'));
        if isempty(post_time)
            msgbox('请输入正确的开始时间格式!!!');
            return;
        end
        %% 判定controltime时间设定
        control_from=str2num(get(handles.control_1,'String'));
        if isempty(control_from)
            msgbox('请输入正确的时间格式!!!');
            return;
        end
        control_to=str2num(get(handles.control_2,'String'));
        if isempty(control_to)
            msgbox('请输入正确的时间格式!!!');
            return;
        end
        %% 检测clims
        clims1=str2num(get(handles.clims_1,'String'));
        clims2=str2num(get(handles.clims_2,'String'));
        if isempty(clims1)||isempty(clims2)
            clims=[];
            set(handles.clims_1,'String','0');
            set(handles.clims_2,'String','0');
        elseif clims1>clims2
            p=clims1;
            clims1=clims2;
            clims2=p;
            set(handles.clims_1,'String',num2str(clims1));
            set(handles.clims_2,'String',num2str(clims2));
            clims=zeros(1,2);
            clims(1)=clims1;
            clims(2)=clims2;
        elseif clims1==clims2
            clims=[];
        else
            clims=zeros(1,2);
            clims(1)=clims1;
            clims(2)=clims2;
        end
        %% offset检测
        offset=str2num(get(handles.offset_average,'String'));
        if isempty(offset)
            offset=0;
        elseif length(offset)>passdata.channelnum_cal
            offset=offset(cal_index);
            set(handles.offset_average,'String',num2str(offset));
        elseif length(offset)>=1&& length(offset)<passdata.channelnum_cal
            offset=offset(1);
            set(handles.offset_average,'String',num2str(offset));
        end
        %% 打标数量检测
        trailnum=length(upindex);
        trialnumtemp=trailnum;
        
        %% 检测开始点是否超出范围时间点
        for i=1:trailnum
            if upindex(i) < abs(pre_time)
                upindex(i)=0;
                trialnumtemp = trialnumtemp-1;
            end
        end
        upindex(upindex==0)=[];
        trialnum=trialnumtemp;
        if trialnum==0
            msgbox('操作失败，请确定打标时间的时间是否超过开始时间点！！');
            return
        end
        %% 检测结束点是否超出范围时间点
        for i=1:trailnum
            if upindex(i)+post_time>size(cal,1)*passdata.interval_cal
                upindex(i)=0;
                trialnumtemp = trialnumtemp-1;
            end
        end
        trialnum=trialnumtemp;
        upindex(upindex==0)=[];
        if trialnum==0
            msgbox('操作失败，请确定打标时间的时间是否超过结束时间点!!!');
            return
        end
         %% 检测trail from数量
        trailfrom=str2num(get(handles.trailfrom1,'String'));
        if isempty(trailfrom)
            msgbox('请输入正确的开始时间格式!!!');
            return;
        end
        if trailfrom<=0
            trailfrom=1;
        end
        if trailfrom>length(upindex)
            trailfrom=length(upindex);
        end
        trailto=str2num(get(handles.trailfrom2,'String'));
        if isempty(trailto)
            msgbox('请输入正确的开始时间格式!!!');
            return;
        end
        if trailto>length(upindex)
            trailto=length(upindex);
        end
        if trailto<=0
            trailto=1;
        end
        if trailto<trailfrom
            p=trailfrom;
            trailfrom=trailto;
            trailto=p;
        end
        set(handles.trailfrom2,'String',num2str(trailto));
        set(handles.trailfrom1,'String',num2str(trailfrom));
        %%
        traildelete=str2num(get(handles.traildelete,'String'));
        if isempty(traildelete)
            msgbox('请输入正确的开始时间格式!!!');
            return;
        end
        %% 开始计算
        upindex=round(upindex/passdata.interval_cal);
        z_score=get(handles.Zsocre_avearge,'Value');
        alpha_check=get(handles.Alpha_On,'Value');
        trigger1_times = trigger_times_pretreatment_multi_traildelete(upindex,trailfrom,passdata.interval_cal,trailto-trailfrom+1,traildelete,[]);
        if isempty(trigger1_times)
            return
        end
        usingcheck=get(handles.UsingChannelCorrect,'Value');
        correct_mode=get(handles.correctmode,'Value');
        if (correct_mode~=calmode)&&usingcheck==1
            correct_channel=get(handles.CorrectChannel,'Value');
%             if calmode==1
%                 correct_mode=2;
%             else
%                 correct_mode=1;
%             end
%             
                
                values = currentcall;
                %%
                corr_start=str2num(get(handles.channelcorrecttime_1,'String'));
                if isempty(corr_start)
                    return
                end
                corr_end=str2num(get(handles.channelcorrecttime_2,'String'));
                if isempty(corr_end)
                    return
                end
                corr_start=round(corr_start/passdata.interval_cal);
                corr_end=round(corr_end/passdata.interval_cal);
                
                if corr_end>length(values)
                    msgbox('Basetime的时长超过出了钙信号总时长，请重新设置！！！');
                    return
                end
                if corr_start>length(values)
                    msgbox('Basetime的时长超过出了钙信号总时长，请重新设置！！！!!! ');
                    return
                end
                if corr_start<=0
                    set(handles.channelcorrecttime_1,'String','1');
                    corr_start=1/passdata.interval_cal;
                end
                
                switch correct_mode
                    case 1
                        if isfield(passdata,'data405')
                            if ~isempty(passdata.data405)
                                correct_values=passdata.data405(:,correct_channel+1);
                            else
                                msgbox('405通道数据为空，请检测405通道数据是否读取');
                                return
                            end
                        else
                            return
                        end
                    case 2
                        if isfield(passdata,'data470')
                            if ~isempty(passdata.data470)
                                correct_values=passdata.data470(:,correct_channel+1);
                            else
                                msgbox('470通道数据为空，请检测470通道数据是否读取');
                                return
                            end
                        else
                            return
                        end
                    case 3
                        if isfield(passdata,'data580')
                            if ~isempty(passdata.data580)
                                correct_values=passdata.data580(:,correct_channel+1);
                            else
                                msgbox('580通道数据为空，请检测580通道数据是否读取');
                                return
                            end
                        else
                            return
                        end
                end
                %%
                y=values(corr_start:corr_end);
                x=correct_values(corr_start:corr_end);
                Y=y;
                X=[ones(size(Y,1),1),x];
                [b,bint,r,rint,stats]=regress(Y,X);
                clear values;
                values_1=currentcall;
                values_2=correct_values;
                values=values_1-(b(1)+b(2)*values_2);
                values=values+mean(y);
                %%
                [psth1,psth1_mean,psth1_sem] = psth_wave2_multi(trigger1_times,passdata.interval_cal,values,-pre_time,post_time,control_from,control_to,offset,z_score);
                %%
       
        else
            [psth1,psth1_mean,psth1_sem] = psth_wave2_multi(trigger1_times,passdata.interval_cal,currentcall,-pre_time,post_time,control_from,control_to,offset,z_score);
        end
        times = pre_time:passdata.interval_cal:post_time;
        if alpha_check==1 && length(trigger1_times)>=2
            psth1Ctrl=psth1(:,times<0);
            ctrl = reshape(psth1Ctrl,size(psth1Ctrl,1).*size(psth1Ctrl,2),1);
            psth1Data = nanmean(psth1);  %每一组数据的平均值；
            baseMean = nanmean(ctrl);
            mCtrl = nanmean(psth1Ctrl,2);
            dataCtrl =  repmat(mCtrl,1,size(psth1,2));
            dif=psth1-dataCtrl; %difference between conditions
            poscolor=[238 44 44];
            negcolor=[0 0 255];
            alpha_level = str2num(get(handles.Alpha,'String'));
            [cpval, ~, ~, ~, ~]=mult_comp_perm_t1(dif,size(psth1,2),0,alpha_level);
            posSigIdx = psth1Data > baseMean & cpval<alpha_level;
            negSigIdx = psth1Data < baseMean & cpval<alpha_level;
            %%
            
            if z_score==1
                figure('NumberTitle', 'off', 'Name', 'Z_score data Preview ');
                areaErrorbar(times,psth1);
            else
                figure('NumberTitle', 'off', 'Name', 'DeltaF/F(%) data Preview ');
                areaErrorbar(times,psth1);
            end
            xlabel('Time (s)');
            set(gca,'Tickdir','out');
            if z_score==1
                ylabel('z-score');
            else
                ylabel('deltaF/F(%)');
            end
            sigPntPlot2(times,psth1Data,posSigIdx,negSigIdx,poscolor,negcolor);
            fig1 = figure;
            heatmapPlot(psth1,passdata.interval_cal,-pre_time,0.1,fig1,clims);
        else
            if z_score==1
                figure('NumberTitle', 'off', 'Name', 'Z_score data Preview ');
                drawErrorLine(times,psth1_mean,psth1_sem,'red',0.5);
            else
                figure('NumberTitle', 'off', 'Name', 'DeltaF/F(%) data Preview ');
                drawErrorLine(times,psth1_mean,psth1_sem,'red',0.5);
            end
            xlabel('Time (s)');
            set(gca,'Tickdir','out');
            if z_score==1
                ylabel('z-score');
            else
                ylabel('deltaF/F(%)');
            end
            fig1 = figure('NumberTitle', 'off', 'Name', 'Heatmap Preview ');
            heatmapPlot(psth1,passdata.interval_cal,-pre_time,0.1,fig1,clims); 
        end
        switch calmode
            case 1
                name=strrep(passdata.Cal405filepath,passdata.cal405part,'_averagedata.mat');
            case 2
                name=strrep(passdata.Cal470filepath,passdata.cal470part,'_averagedata.mat');
            case 3
                name=strrep(passdata.Cal580filepath,passdata.cal580part,'_averagedata.mat');
        end
        
        dig=['是否想要另存为数据文件? 如果选择no, 数据将保存在 ' name '!!!'];
        choice=questdlg(dig, ...
            'Selection Dialog', ...
            'Yes', 'No','No');
        if isempty(choice)
            save(name,'times','psth1','psth1_mean','psth1_sem');
        else
            if strcmp(choice,'No')
                save(name,'times','psth1','psth1_mean','psth1_sem');
            elseif strcmp(choice,'Yes')
                [SaveFileName,SavePathName,SaveIndex] = uiputfile('*.mat;','Save as',passdata.readpath); %设置默认路径
                if isequal(SaveFileName,0) || isequal(SavePathName,0) || isequal(SaveIndex,0)
                    disp('User seleceted Cancel');
                    save(name,'times','psth1','psth1_mean','psth1_sem');
                else
                    path=[SavePathName SaveFileName];
                    save(path,'times','psth1','psth1_mean','psth1_sem');
                    %这里保存所有读入的视频的处理结果
                end
            end
        end
    end
end

% --- Executes on button press in AveragePlayBack.
function AveragePlayBack_Callback(hObject, eventdata, handles)
% hObject    handle to AveragePlayBack (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clc
handles=guidata(hObject);
global passdata;
[filename, pathname] = uigetfile({'*.mat'},'MultiSelect','off','Open trail_data file',passdata.readpath);
if isequal(filename,0)
    return;
end
filename = fullfile(pathname, filename);

passdata.readpath=pathname(1:end-1);

[~,~,file_part_trail]=fileparts(filename);
if strcmp(file_part_trail,'.mat')
    
    data=load(filename);
    if ~isfield(data,'psth1_mean')
        msgbox('操作失败，请确定是否读取正确的average生成的文件数据 !!!!');
        
        return
    end
    
    figure('NumberTitle', 'off', 'Name', 'Trail data Preview ');
    drawErrorLine(data.times,data.psth1_mean,data.psth1_sem,'red',0.5);
    
    
    ylabel('deltaF/F(%)');
   
    
    figure('NumberTitle', 'off', 'Name', 'Heatmap Preview ');
    
    smoothed_data = linearSmooth1(data.psth1,0.1);
    
   
    imagesc(data.times,1:1:size(data.psth1,1),smoothed_data,[min(min(smoothed_data)),max(max(smoothed_data))]);
    colormap(jet);
else
    msgbox('操作失败，请确定是否读取正确的average生成的文件数据 !!!!');
    return;
end
guidata(hObject,handles);



function clims_1_Callback(hObject, eventdata, handles)
% hObject    handle to clims_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of clims_1 as text
%        str2double(get(hObject,'String')) returns contents of clims_1 as a double


% --- Executes during object creation, after setting all properties.
function clims_1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to clims_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function clims_2_Callback(hObject, eventdata, handles)
% hObject    handle to clims_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of clims_2 as text
%        str2double(get(hObject,'String')) returns contents of clims_2 as a double


% --- Executes during object creation, after setting all properties.
function clims_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to clims_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Alpha_Callback(hObject, eventdata, handles)
% hObject    handle to Alpha (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Alpha as text
%        str2double(get(hObject,'String')) returns contents of Alpha as a double


% --- Executes during object creation, after setting all properties.
function Alpha_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Alpha (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Alpha_On.
function Alpha_On_Callback(hObject, eventdata, handles)
% hObject    handle to Alpha_On (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Alpha_On


% --- Executes on button press in DeltaF_F_average.
function DeltaF_F_average_Callback(hObject, eventdata, handles)
% hObject    handle to DeltaF_F_average (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value=get(handles.DeltaF_F_average,'Value');
if value==1
    set(handles.Zsocre_avearge,'Value',0);
elseif value==0
    set(handles.Zsocre_avearge,'Value',1);
end
guidata(hObject,handles);

% Hint: get(hObject,'Value') returns toggle state of DeltaF_F_average


% --- Executes on button press in Zsocre_avearge.
function Zsocre_avearge_Callback(hObject, eventdata, handles)
% hObject    handle to Zsocre_avearge (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value=get(handles.Zsocre_avearge,'Value');
if value==1
    set(handles.DeltaF_F_average,'Value',0);
elseif value==0
    set(handles.DeltaF_F_average,'Value',1);
end
guidata(hObject,handles);

% Hint: get(hObject,'Value') returns toggle state of Zsocre_avearge



function offset_average_Callback(hObject, eventdata, handles)
% hObject    handle to offset_average (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of offset_average as text
%        str2double(get(hObject,'String')) returns contents of offset_average as a double


% --- Executes during object creation, after setting all properties.
function offset_average_CreateFcn(hObject, eventdata, handles)
% hObject    handle to offset_average (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function evalutiontime1_Callback(hObject, eventdata, handles)
% hObject    handle to evalutiontime1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of evalutiontime1 as text
%        str2double(get(hObject,'String')) returns contents of evalutiontime1 as a double


% --- Executes during object creation, after setting all properties.
function evalutiontime1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to evalutiontime1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function evalutiontime2_Callback(hObject, eventdata, handles)
% hObject    handle to evalutiontime2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of evalutiontime2 as text
%        str2double(get(hObject,'String')) returns contents of evalutiontime2 as a double


% --- Executes during object creation, after setting all properties.
function evalutiontime2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to evalutiontime2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function control_plot_1_Callback(hObject, eventdata, handles)
% hObject    handle to control_plot_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of control_plot_1 as text
%        str2double(get(hObject,'String')) returns contents of control_plot_1 as a double


% --- Executes during object creation, after setting all properties.
function control_plot_1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to control_plot_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function control_plot_2_Callback(hObject, eventdata, handles)
% hObject    handle to control_plot_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of control_plot_2 as text
%        str2double(get(hObject,'String')) returns contents of control_plot_2 as a double


% --- Executes during object creation, after setting all properties.
function control_plot_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to control_plot_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in DeltaF_F_plot.
function DeltaF_F_plot_Callback(hObject, eventdata, handles)
% hObject    handle to DeltaF_F_plot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value=get(handles.DeltaF_F_plot,'Value');
if value==1
    set(handles.Zsocre_plot,'Value',0);
elseif value==0
    set(handles.Zsocre_plot,'Value',1);
end
guidata(hObject,handles);

% Hint: get(hObject,'Value') returns toggle state of DeltaF_F_plot


% --- Executes on button press in Zsocre_plot.
function Zsocre_plot_Callback(hObject, eventdata, handles)
% hObject    handle to Zsocre_plot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value=get(handles.Zsocre_plot,'Value');
if value==1
    set(handles.DeltaF_F_plot,'Value',0);
elseif value==0
    set(handles.DeltaF_F_plot,'Value',1);
end
guidata(hObject,handles);

% Hint: get(hObject,'Value') returns toggle state of Zsocre_plot



function offset_plot_Callback(hObject, eventdata, handles)
% hObject    handle to offset_plot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of offset_plot as text
%        str2double(get(hObject,'String')) returns contents of offset_plot as a double


% --- Executes during object creation, after setting all properties.
function offset_plot_CreateFcn(hObject, eventdata, handles)
% hObject    handle to offset_plot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Plotting.
function Plotting_Callback(hObject, eventdata, handles)
% hObject    handle to Plotting (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clc
global passdata
if ~isfield(passdata,'data405')&&~isfield(passdata,'data470')&&~isfield(passdata,'data580')
    msgbox('请读取钙信号数据之后使用该功能！！！');
    return;
end
calmode=get(handles.calmode_pm,'Value');
switch calmode
    case 1
        modeindex='data405';
        cal=passdata.data405;
    case 2
        modeindex='data470';
        cal=passdata.data470;
    case 3
        modeindex='data580';
        cal=passdata.data580;
end

if isfield(passdata,modeindex)
    if ~isempty(cal)
        zscore=get(handles.Zsocre_plot,'Value');
        %%
        if isempty(str2num(get(handles.control_plot_1,'String')))
            return
        else
            controltime(1)=str2num(get(handles.control_plot_1,'String'));
        end
        if isempty(str2num(get(handles.control_plot_2,'String')))
            return
        else
            controltime(2)=str2num(get(handles.control_plot_2,'String'));
        end
        %%
        if isempty(str2num(get(handles.evalutiontime1,'String')))
            return
        else
            evaluationtime(1)=str2num(get(handles.evalutiontime1,'String'));
        end
        
        if isempty(str2num(get(handles.evalutiontime2,'String')))
            return
        else
           evaluationtime(2)=str2num(get(handles.evalutiontime2,'String')); 
        end
        
        offset = str2num(get(handles.offset_plot,'String'));
        if isempty(offset)
            offset=0;
        end
        %%
        cal_index=get(handles.cal_pm,'Value');
        interval=passdata.interval_cal;
        %%
        evaluationtime(evaluationtime(:)<=0)=1;
        evaluationtime(evaluationtime(:)>=size(cal,1)*interval)=size(cal,1)*interval;
        if evaluationtime(1)>evaluationtime(2)
            p= evaluationtime(1);
            evaluationtime(1)=evaluationtime(2);
            evaluationtime(2)=p;
            set(handles.evalutiontime1,'String',num2str(evaluationtime(1)));
            set(handles.evalutiontime2,'String',num2str(evaluationtime(2)));
        end
        
        if evaluationtime(1)==evaluationtime(2)
            evaluationtime=[];
            set(handles.evalutiontime1,'String','0');
            set(handles.evalutiontime2,'String','0');
            msgbox(' 时间范围设置错误，请检查起始时候设置是否正确或者超出总时长!!');
            return;
        end
        %%
        if length(offset)~=size(cal,2)-1
            if ~isempty(offset)
                current_offset=offset(1);
            else
                current_offset=0;
            end
        else
            current_offset=offset(cal_index);
        end
        %%
        controltime(controltime(:)>=size(cal,1)*interval)=size(cal,1)*interval;
        controltime(controltime(:)<=0)=1;
        
        if controltime(1)==controltime(2)
            msgbox('control time 时间范围设置错误，请检查起始时候设置是否正确!!');
            return
        end
        if controltime(1)>controltime(2)
            p= controltime(1);
            controltime(1)=controltime(2);
            controltime(2)=p;
            set(handles.control_plot_1,'String',num2str(controltime(1)));
            set(handles.control_plot_2,'String',num2str(controltime(2)));
        end
        %% 计算
        using_check=get(handles.UsingChannelCorrect_2,'Value');
        correct_mode=get(handles.correctmode_2,'Value');
        if (correct_mode~=calmode)&&using_check==1
            correct_channel=get(handles.CorrectChannel_2,'Value');
%             if calmode==1
%                 
%                 correct_mode=2;
%             else
%                 correct_mode=1;
%             end
            
                values = cal(:,cal_index+1);
                %%
                corr_start=str2num(get(handles.channelcorrecttime_3,'String'));
                if isempty(corr_start)
                    return
                end
                corr_end=str2num(get(handles.channelcorrecttime_4,'String'));
                if isempty(corr_end)
                    return
                end
                corr_start=round(corr_start/passdata.interval_cal);
                corr_end=round(corr_end/passdata.interval_cal);
                
                if corr_end>length(values)
                    msgbox('Basetime的时长超过出了钙信号总时长，请重新设置！！！');
                    return
                end
                if corr_start>length(values)
                    msgbox('Basetime的时长超过出了钙信号总时长，请重新设置！！！!!! ');
                    return
                end
                if corr_start<=0
                    set(handles.channelcorrecttime_3,'String','1');
                    corr_start=1/passdata.interval_cal;
                end
                
                switch correct_mode
                    case 1
                        if isfield(passdata,'data405')
                            if ~isempty(passdata.data405)
                                correct_values=passdata.data405(:,correct_channel+1);
                            else
                                msgbox('405通道数据为空，请检测405通道数据是否读取');
                                return
                            end
                        else
                            return
                        end
                    case 2
                        if isfield(passdata,'data470')
                            if ~isempty(passdata.data470)
                                correct_values=passdata.data470(:,correct_channel+1);
                            else
                                msgbox('470通道数据为空，请检测470通道数据是否读取');
                                return
                            end
                        else
                            return
                        end
                    case 3
                        if isfield(passdata,'data580')
                            if ~isempty(passdata.data580)
                                correct_values=passdata.data580(:,correct_channel+1);
                            else
                                msgbox('580通道数据为空，请检测580通道数据是否读取');
                                return
                            end
                        else
                            return
                        end
                end
                %%
                y=values(corr_start:corr_end);
                x=correct_values(corr_start:corr_end);
                Y=y;
                X=[ones(size(Y,1),1),x];
                [b,bint,r,rint,stats]=regress(Y,X);
                clear values;
                values_1=cal(:,cal_index+1);
                values_2=correct_values;
                values=values_1-(b(1)+b(2)*values_2);
                values=values+mean(y);
                %%
          
        else
            values=cal(:,cal_index+1);
        end
        %%
        time_index=(1:1:size(cal,1))*interval;
        ss=find(abs(time_index-controltime(1))==min(abs(time_index-controltime(1))));
        ee=find(abs(time_index-controltime(2))==min(abs(time_index-controltime(2))));
        controldata=values(ss:ee);
        
        if isempty(evaluationtime)
            evaluationdata=values;
            ss=1;
            evaluationtime(1)=0;
            evaluationtime(2)=time_index(end);
            ee=length(time_index);
        else
            ss=find(abs(time_index-evaluationtime(1))==min(abs(time_index-evaluationtime(1))));
            ee=find(abs(time_index-evaluationtime(2))==min(abs(time_index-evaluationtime(2))));
            evaluationdata=values(ss:ee);
        end
        %% plot
        if zscore==1
            figure('NumberTitle', 'off', 'Name', 'z_score data Preview ');
            plot(time_index(ss:ee),(evaluationdata-mean(controldata))/std(controldata));
            xlabel('Time (s)');
            ylabel('z-score');
            data=(evaluationdata-mean(controldata))/std(controldata);
            figure('NumberTitle', 'off', 'Name', 'Heatmap data Preview ')
            imagesc((time_index(ss:ee))',1:1:1,(data)',[min(data),max(data)]);
            colormap(jet);
            set(gca,'Ytick',1:1:1,'YTickLabel',1:1:1);
        else
            figure('NumberTitle', 'off', 'Name', 'deltaF/F(%) data Preview ');
            plot(time_index(ss:ee),(evaluationdata-mean(controldata))/(mean(controldata)-offset)*100);
            xlabel('Time (s)');
            ylabel('deltaF/F(%)');
            data=(evaluationdata-mean(controldata))/(mean(controldata)-offset)*100;
            figure('NumberTitle', 'off', 'Name', 'Heatmap data Preview ')
            imagesc((time_index(ss:ee))',1:1:1,(data)',[min(data),max(data)]);
            colormap(jet);
            set(gca,'Ytick',1:1:1,'YTickLabel',1:1:1);
        end
        data=data;
        times=time_index(ss:ee);
        %% save data
        switch calmode
            case 1
                name=strrep(passdata.Cal405filepath,passdata.cal405part,'_Plot.mat');
            case 2
                name=strrep(passdata.Cal470filepath,passdata.cal470part,'_Plot.mat');
            case 3
                name=strrep(passdata.Cal580filepath,passdata.cal580part,'_Plot.mat');
        end
        dig=['是否想要另存为数据文件? 如果选择no, 数据将保存在 ' name '!!!'];
        choice=questdlg(dig, ...
            'Selection Dialog', ...
            'Yes', 'No','No');
        if isempty(choice)
            save(name,'times','data','evaluationtime','controltime');
        else
            if strcmp(choice,'No')
                save(name,'times','data','evaluationtime','controltime');
            elseif strcmp(choice,'Yes')
                [SaveFileName,SavePathName,SaveIndex] = uiputfile('*.mat;','Save as',passdata.readpath); %设置默认路径
                if isequal(SaveFileName,0) || isequal(SavePathName,0) || isequal(SaveIndex,0)
                    disp('User seleceted Cancel');
                    save(name,'times','data','evaluationtime','controltime');
                else
                    path=[SavePathName SaveFileName];
                    save(path,'times','data','evaluationtime','controltime');
                end
            end
        end
    end
end


% --- Executes on button press in PlayBack_plot.
function PlayBack_plot_Callback(hObject, eventdata, handles)
% hObject    handle to PlayBack_plot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clc
global passdata;
handles=guidata(hObject);
[filename, pathname] = uigetfile({'*.mat'}, 'MultiSelect','off','Open trail_data file',passdata.readpath);
if isequal(filename,0)
    return;
end
filename = fullfile(pathname, filename);

passdata.readpath=pathname(1:end-1);

[~,~,file_part_trail]=fileparts(filename);
if strcmp(file_part_trail,'.mat')

    data=load(filename);
    if ~isfield(data,'data')
        msgbox('操作失败，请确定是否读取正确的plot生成的文件数据 !!!!');
        
        return
    end
   
    figure('NumberTitle', 'off', 'Name', 'Trail data Preview ');
    plot(data.times,data.data);
    ylabel('deltaF/F(%)');
    
    figure('NumberTitle', 'off', 'Name', 'Heatmap data Preview ')
    imagesc(data.times',1:1:1,data.data',[min(data.data),max(data.data)]);
    colormap(jet);
    set(gca,'Ytick',1:1:1,'YTickLabel',1:1:1);
    
    
else
    msgbox('操作失败，请确定是否读取正确的plot生成的文件数据 !!!!');
    return;
end
guidata(hObject,handles)


% --------------------------------------------------------------------



function time_insert_Callback(hObject, eventdata, handles)
% hObject    handle to time_insert (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of time_insert as text
%        str2double(get(hObject,'String')) returns contents of time_insert as a double


% --- Executes during object creation, after setting all properties.
function time_insert_CreateFcn(hObject, eventdata, handles)
% hObject    handle to time_insert (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in InsertMark.
function InsertMark_Callback(hObject, eventdata, handles)
% hObject    handle to InsertMark (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clc
global passdata
if ~isfield(passdata,'data405')&&~isfield(passdata,'data470')&&~isfield(passdata,'data580')
    msgbox('请读取钙信号数据之后使用该功能！！！');
    return;
else
    ManualMark_on=get(handles.cue_channel,'Value');
    calmode=get(handles.calmode_pm,'Value');
    switch calmode
        case 1
            modeindex='data405';
            cal=passdata.data405;
        case 2
            modeindex='data470';
            cal=passdata.data470;
        case 3
            modeindex='data580';
            cal=passdata.data580;
    end
    if ManualMark_on>5
        if isfield(passdata,'cue')
            insert_time=str2num(get(handles.time_insert,'String'));
            if isempty(insert_time)
                return
            end
            if length(insert_time)>1
                insert_time=insert_time(end);
                return
            end
            if ~isempty(passdata.cue)
                %%
                if insert_time<size(cal,1)*passdata.interval_cal
                    if isempty(passdata.MarkIndex)
                        %% fpsmark存储线的最大值与最小值
                        passdata.fpsmark=[passdata.minwave;passdata.maxwave];
                    else
                        delete(passdata.linefig);
                        passdata.fpsmark=[passdata.fpsmark,passdata.fpsmark(:,1)];
                    end
                    passdata.MarkIndex=sort([passdata.MarkIndex,insert_time]);
                else
                    msgbox('错误设置，打标插入时间点超过总时长！！！')
                    return
                end
                %% 绘图更新存储mark
                %%  更新mark
                if ~isempty(passdata.MarkIndex)
                    
                    
                    listbox_cell=cell(1,1+length(passdata.MarkIndex));
                    listbox_cell{1,1}='MarkTime';
                    
                    for i=2:(1+length(passdata.MarkIndex))
                        listbox_cell{1,i}=num2str(passdata.MarkIndex(i-1));
                    end
                    if isfield(passdata,'mouseSignindex')
                        if ~isempty(passdata.mouseSignindex)
                            index=passdata.mouseSignindex+1;
                        else
                            index=1+length(passdata.MarkIndex);
                        end
                    else
                        index=1+length(passdata.MarkIndex);
                    end
                    set(handles.MarkTime,'String',listbox_cell);
                    set(handles.MarkTime,'Value',1);
                else
                    listbox_cell=cell(1,1);
                    listbox_cell{1,1}='MarkTime';
                    set(handles.MarkTime,'String',listbox_cell);
                    set(handles.MarkTime,'Value',1);
                end
                %%
                linex=[passdata.MarkIndex;passdata.MarkIndex];
                passdata.linefig=line(linex,passdata.fpsmark,'Color','b','LineWidth',1);
                cueindex=passdata.mode1_channel;
                interval=passdata.interval_cal/2;
                eval(['passdata.InputMark.upindex_' num2str(cueindex) '=passdata.MarkIndex/interval;']);
                %%
            end
        else
            return
        end
    elseif ManualMark_on==1
        insert_time=str2num(get(handles.time_insert,'String'));
        if isempty(insert_time)
            return
        end
        if length(insert_time)>1
            insert_time=insert_time(end);
            return
        end
        if insert_time<size(cal,1)*passdata.interval_cal
            %%
            if isempty(passdata.MarkIndex)
                passdata.fpsmark=[passdata.minwave;passdata.maxwave];
            else
                delete(passdata.linefig);
                passdata.fpsmark=[passdata.fpsmark,passdata.fpsmark(:,1)];
            end
            passdata.MarkIndex=sort([passdata.MarkIndex,insert_time]);
            %%
            linex=[passdata.MarkIndex;passdata.MarkIndex];
            passdata.linefig=line(linex,passdata.fpsmark,'Color','b','LineWidth',1);
            passdata.ManualMark_upindex=passdata.MarkIndex;
            
            if ~isempty(passdata.ManualMark_upindex)
                
                passdata.ManualMark_upindex=sort(passdata.ManualMark_upindex);
                listbox_cell=cell(1,1+length(passdata.ManualMark_upindex));
                listbox_cell{1,1}='MarkTime';
                
                for i=2:(1+length(passdata.ManualMark_upindex))
                    listbox_cell{1,i}=num2str(passdata.ManualMark_upindex(i-1));
                end
                if isfield(passdata,'mouseSignindex')
                    if ~isempty(passdata.mouseSignindex)
                        index=passdata.mouseSignindex+1;
                    else
                        index=1+length(passdata.ManualMark_upindex);
                    end
                else
                    index=1+length(passdata.ManualMark_upindex);
                end
                set(handles.MarkTime,'String',listbox_cell);
                set(handles.MarkTime,'Value',1);
            else
                listbox_cell=cell(1,1);
                listbox_cell{1,1}='MarkTime';
                set(handles.MarkTime,'String',listbox_cell);
                set(handles.MarkTime,'Value',1);
            end
        else
            msgbox('错误设置，打标插入时间点超过总时长！！！')
            return
        end
    elseif ManualMark_on>1&&ManualMark_on<=5
        insert_time=str2num(get(handles.time_insert,'String'));
        if isempty(insert_time)
            return
        end
        if length(insert_time)>1
            insert_time=insert_time(end);
            return
        end
        if insert_time<size(cal,1)*passdata.interval_cal
            %%
            if isempty(passdata.MarkIndex)
                passdata.fpsmark=[passdata.minwave;passdata.maxwave];
            else
                delete(passdata.linefig);
                passdata.fpsmark=[passdata.fpsmark,passdata.fpsmark(:,1)];
            end
            passdata.MarkIndex=sort([passdata.MarkIndex,insert_time]);
            %%
            linex=[passdata.MarkIndex;passdata.MarkIndex];
            passdata.linefig=line(linex,passdata.fpsmark,'Color','b','LineWidth',1);
            videoindex=get(handles.cue_channel,'Value')-1;
            passdata.MarkIndex=sort(passdata.MarkIndex);
            eval(['passdata.videocue' num2str(videoindex) '=passdata.MarkIndex;']);
            
            if ~isempty(passdata.MarkIndex)
                
                listbox_cell=cell(1,1+length(passdata.MarkIndex));
                listbox_cell{1,1}='MarkTime';
                
                for i=2:(1+length(passdata.MarkIndex))
                    listbox_cell{1,i}=num2str(passdata.MarkIndex(i-1));
                end
                if isfield(passdata,'mouseSignindex')
                    if ~isempty(passdata.mouseSignindex)
                        index=passdata.mouseSignindex+1;
                    else
                        index=1+length(passdata.MarkIndex);
                    end
                else
                    index=1+length(passdata.MarkIndex);
                end
                set(handles.MarkTime,'String',listbox_cell);
                set(handles.MarkTime,'Value',1);
            else
                listbox_cell=cell(1,1);
                listbox_cell{1,1}='MarkTime';
                set(handles.MarkTime,'String',listbox_cell);
                set(handles.MarkTime,'Value',1);
            end
        else
            msgbox('错误设置，打标插入时间点超过总时长！！！')
            return
        end
    end
    set(handles.trailfrom1,'String',num2str(1));
    set(handles.trailfrom2,'String',num2str(length(passdata.MarkIndex)));
end


%%%%%%%%%


% --- Executes on button press in LoadMarkSetting.
function LoadMarkSetting_Callback(hObject, eventdata, handles)
% hObject    handle to LoadMarkSetting (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clc
global passdata;
if ~isfield(passdata,'data405')&&~isfield(passdata,'data470')&&~isfield(passdata,'data580')
    msgbox('请读取钙信号数据之后使用该功能！！！');
    return;
else
    [filename, pathname] = uigetfile({'*.mat'},'MultiSelect','off','Open trail_data file',passdata.readpath);
    if isequal(filename,0)
        return;
    end
    passdata.readpath=pathname(1:end-1);
    filename = fullfile(pathname, filename);
    [~,~,file_part_trail]=fileparts(filename);
    if strcmp(file_part_trail,'.mat')
        data=load(filename);
        if isfield(data,'data')
            data=data.data;
            if isfield(data,'ManualMark_upindex')
                set(handles.cue_channel,'Value',1);
                passdata.ManualMark_upindex=data.ManualMark_upindex;
                passdata.videocue1=data.videocue1;
                passdata.videocue2=data.videocue2;
                passdata.videocue3=data.videocue3;
                passdata.videocue4=data.videocue4;
                if isfield(data,'cue')
                    passdata.InputMark=data.InputMark;
                    passdata.cue=data.cue;
                    passdata.channelnum_cue=size(passdata.cue,2);
                    passdata.length_cue=size(passdata.cue,1);
                    passdata.cue_read=1;
                    %%
                    stringcell=cell(passdata.channelnum_cue+5,1);
                    stringcell{1,1}='ManualMark';
                    for i=1:4
                         stringcell{i+1,1}=['VideoCue' num2str(i)];
                    end
                    for i=1:passdata.channelnum_cue
                        stringcell{i+5,1}=['D' num2str(i)];
                    end
                    set(handles.cue_channel,'String',stringcell);
                    %%
                    set(handles.cue_channel,'Value',1);
                end
                DrawData1_dualmulti;
            elseif isfield(data,'videocue1')
                passdata.videocue1=data.videocue1;
                passdata.videocue2=data.videocue2;
                passdata.videocue3=data.videocue3;
                passdata.videocue4=data.videocue4;
            else
                msgbox('请读取正确的打标数据！！！');
                return;
            end
        else
            msgbox('请读取正确的打标数据！！！');
            return;
        end
        
    else
        msgbox('请读取正确的打标数据！！！');
        return;
    end
    
end



% --- Executes on button press in DeleteSelectedlMark.
function DeleteSelectedlMark_Callback(hObject, eventdata, handles)
% hObject    handle to DeleteSelectedlMark (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clc
global passdata

if ~isfield(passdata,'data405')&&~isfield(passdata,'data470')&&~isfield(passdata,'data580')
    msgbox('请读取钙信号数据之后使用该功能！！！');
    return;
else
    ManualMark_on=get(handles.cue_channel,'Value');
    if ManualMark_on>5
        if isfield(passdata,'cue')
            deletetime=get(handles.MarkTime,'Value');
            if deletetime==1
                return
            end
            
            if ~isempty(passdata.cue)
                %%
                deletetime=deletetime-1;
                if deletetime>length(passdata.MarkIndex)
                    return
                else
                    passdata.MarkIndex(deletetime)=[];
                    passdata.fpsmark=passdata.fpsmark(:,2:end);
                    delete(passdata.linefig);
                end
                %% 绘图更新存储mark
                %%  更新mark
                if ~isempty(passdata.MarkIndex)
                    
                    
                    listbox_cell=cell(1,1+length(passdata.MarkIndex));
                    listbox_cell{1,1}='MarkTime';
                    
                    for i=2:(1+length(passdata.MarkIndex))
                        listbox_cell{1,i}=num2str(passdata.MarkIndex(i-1));
                    end
                    if isfield(passdata,'mouseSignindex')
                        if ~isempty(passdata.mouseSignindex)
                            index=passdata.mouseSignindex+1;
                        else
                            index=1+length(passdata.MarkIndex);
                        end
                    else
                        index=1+length(passdata.MarkIndex);
                    end
                    set(handles.MarkTime,'String',listbox_cell);
                    set(handles.MarkTime,'Value',deletetime);
                else
                    listbox_cell=cell(1,1);
                    listbox_cell{1,1}='MarkTime';
                    set(handles.MarkTime,'String',listbox_cell);
                    set(handles.MarkTime,'Value',1);
                end
                %%
                linex=[passdata.MarkIndex;passdata.MarkIndex];
                passdata.linefig=line(linex,passdata.fpsmark,'Color','b','LineWidth',1);
                cueindex=passdata.mode1_channel;
                interval=passdata.interval_cal/2;
                eval(['passdata.InputMark.upindex_' num2str(cueindex) '=passdata.MarkIndex/interval;']);
                %%
            end
        else
            return
        end
    elseif ManualMark_on==1
        deletetime=get(handles.MarkTime,'Value');
        if deletetime==1
            return
        end
        deletetime=deletetime-1;
        if deletetime<=length(passdata.MarkIndex)
            %%
            passdata.MarkIndex(deletetime)=[];
            passdata.fpsmark=passdata.fpsmark(:,2:end);
            delete(passdata.linefig);
            passdata.MarkIndex=sort([passdata.MarkIndex]);
            %%
            linex=[passdata.MarkIndex;passdata.MarkIndex];
            passdata.linefig=line(linex,passdata.fpsmark,'Color','b','LineWidth',1);
            passdata.ManualMark_upindex=passdata.MarkIndex;
            
            if ~isempty(passdata.ManualMark_upindex)
                
                passdata.ManualMark_upindex=sort(passdata.ManualMark_upindex);
                listbox_cell=cell(1,1+length(passdata.ManualMark_upindex));
                listbox_cell{1,1}='MarkTime';
                
                for i=2:(1+length(passdata.ManualMark_upindex))
                    listbox_cell{1,i}=num2str(passdata.ManualMark_upindex(i-1));
                end
                if isfield(passdata,'mouseSignindex')
                    if ~isempty(passdata.mouseSignindex)
                        index=passdata.mouseSignindex+1;
                    else
                        index=1+length(passdata.ManualMark_upindex);
                    end
                else
                    index=1+length(passdata.ManualMark_upindex);
                end
                set(handles.MarkTime,'String',listbox_cell);
                set(handles.MarkTime,'Value',deletetime);
            else
                listbox_cell=cell(1,1);
                listbox_cell{1,1}='MarkTime';
                set(handles.MarkTime,'String',listbox_cell);
                set(handles.MarkTime,'Value',1);
            end
        else
            return
        end
    elseif ManualMark_on>1&&ManualMark_on<=5
        deletetime=get(handles.MarkTime,'Value');
        if deletetime==1
            return
        end
        deletetime=deletetime-1;
        if deletetime<=length(passdata.MarkIndex)
            %%
            passdata.MarkIndex(deletetime)=[];
            passdata.fpsmark=passdata.fpsmark(:,2:end);
            delete(passdata.linefig);
            passdata.MarkIndex=sort([passdata.MarkIndex]);
            %%
            linex=[passdata.MarkIndex;passdata.MarkIndex];
            passdata.linefig=line(linex,passdata.fpsmark,'Color','b','LineWidth',1);
            videoindex=get(handles.cue_channel,'Value')-1;
            eval(['passdata.videocue' num2str '=passdata.MarkIndex']);
            
            if ~isempty(passdata.MarkIndex)
                listbox_cell=cell(1,1+length(passdata.MarkIndex));
                listbox_cell{1,1}='MarkTime';
                
                for i=2:(1+length(passdata.MarkIndex))
                    listbox_cell{1,i}=num2str(passdata.MarkIndex(i-1));
                end
                if isfield(passdata,'mouseSignindex')
                    if ~isempty(passdata.mouseSignindex)
                        index=passdata.mouseSignindex+1;
                    else
                        index=1+length(passdata.MarkIndex);
                    end
                else
                    index=1+length(passdata.MarkIndex);
                end
                set(handles.MarkTime,'String',listbox_cell);
                set(handles.MarkTime,'Value',deletetime);
            else
                listbox_cell=cell(1,1);
                listbox_cell{1,1}='MarkTime';
                set(handles.MarkTime,'String',listbox_cell);
                set(handles.MarkTime,'Value',1);
            end
        else
            return
        end
    end
    set(handles.trailfrom1,'String',num2str(1));
    set(handles.trailfrom2,'String',num2str(length(passdata.MarkIndex)));
end


% --- Executes when figure1 is resized.
function figure1_SizeChangedFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function OpenCalTimeData_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to OpenCalTimeData (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clc
global passdata
if isfield(passdata,'readpath')
    [filenametxt,filepathtxt]=uigetfile({'*.TXT'},'Open txt_data file','MultiSelect','off',passdata.readpath);
else
    [filenametxt,filepathtxt]=uigetfile({'*.TXT'},'Open txt_data file','MultiSelect','off');
end
if isequal(filenametxt,0)
    return;
end
fullfiletxt=fullfile(filepathtxt,filenametxt);
[~,~,file_part_trail]=fileparts(fullfiletxt);

if ~strcmp(file_part_trail,'.TXT') && ~strcmp(file_part_trail,'.txt')
    msgbox('操作失败，请确定是否读取正确的txt文件数据 !!!!');
    return;
end
time=importdata(fullfiletxt);

passdata.time0=datenum(time{1,1},'yyyy-mm-dd HH.MM.SS.FFF');
passdata.time_duration=datenum(time{end,1},'yyyy-mm-dd HH.MM.SS.FFF');
passdata.time_duration=(passdata.time_duration-passdata.time0)*24*60*60;
msgbox('时间数据读取成功 !!!');
clc


% --- Executes on button press in VideoSync.
function VideoSync_Callback(hObject, eventdata, handles)
% hObject    handle to VideoSync (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clc
if isfield(handles,'h2')
    clc
else
    handles.h2=VideoSync;
end


% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure
clc
global passdata;
readpath=passdata.readpath;
p= mfilename('fullpath');
[filepath,~,~] = fileparts(p);
savepath=[filepath '\Readpath.mat'];
save(savepath,'readpath');
delete(hObject);



function trailfrom1_Callback(hObject, eventdata, handles)
% hObject    handle to trailfrom1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of trailfrom1 as text
%        str2double(get(hObject,'String')) returns contents of trailfrom1 as a double


% --- Executes during object creation, after setting all properties.
function trailfrom1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to trailfrom1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function trailfrom2_Callback(hObject, eventdata, handles)
% hObject    handle to trailfrom2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of trailfrom2 as text
%        str2double(get(hObject,'String')) returns contents of trailfrom2 as a double


% --- Executes during object creation, after setting all properties.
function trailfrom2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to trailfrom2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function traildelete_Callback(hObject, eventdata, handles)
% hObject    handle to traildelete (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of traildelete as text
%        str2double(get(hObject,'String')) returns contents of traildelete as a double


% --- Executes during object creation, after setting all properties.
function traildelete_CreateFcn(hObject, eventdata, handles)
% hObject    handle to traildelete (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Tocsv_mat.
function Tocsv_mat_Callback(hObject, eventdata, handles)
% hObject    handle to Tocsv_mat (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clc
global passdata
if ~isfield(passdata,'data470')&&~isfield(passdata,'data405')&&~isfield(passdata,'data580')&&~isfield(passdata,'cue')
    return
end
%%
h=waitbar(0,'please wait');
filepath=strrep(passdata.cuefilepath,passdata.cuepart,'.csv');
waitbar(10/100,h);
data=passdata.cue;
csvwrite(filepath,data);
waitbar(25/100,h);
filepath=strrep(passdata.cuefilepath,passdata.cuepart,'.mat');
save(filepath,'data');
if ~isempty(passdata.data405)
    filepath=strrep(passdata.Cal405filepath,passdata.cal405part,'.csv');
    data=passdata.data405_raw;
    csvwrite(filepath,data);
    waitbar(35/100,h);
    filepath=strrep(passdata.Cal405filepath,passdata.cal405part,'.mat');
    save(filepath,'data');
end
if ~isempty(passdata.data470)
    waitbar(45/100,h);
    filepath=strrep(passdata.Cal470filepath,passdata.cal470part,'.csv');
    data=passdata.data470_raw;
    csvwrite(filepath,data);
    waitbar(55/100,h);
    filepath=strrep(passdata.Cal470filepath,passdata.cal470part,'.mat');
    save(filepath,'data');
    waitbar(75/100,h);
end
if ~isempty(passdata.data580)
    
    filepath=strrep(passdata.Cal580filepath,passdata.cal580part,'.csv');
    data=passdata.data580_raw;
    csvwrite(filepath,data);
    waitbar(85/100,h);
    filepath=strrep(passdata.Cal580filepath,passdata.cal580part,'.mat');
    save(filepath,'data');
    waitbar(95/100,h);
end
waitbar(100/100,h);
delete(h);
msgbox('Operation succeeds !!!!');
%%


% --------------------------------------------------------------------
function open_all_data_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to open_all_data (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global passdata;
clc
if isfield(passdata,'readpath')
    [file, path] = uigetfile({'*'}, 'MultiSelect','on','请读取本次实验转换过后的所有csv文件或者mat文件',passdata.readpath);
else
    [file, path] = uigetfile({'*'}, 'MultiSelect','on','请读取本次实验转换过后的所有csv文件或者mat文件');
end
if isnumeric(file)
    return;
end

if ischar(file)
    msgbox('请读取本次实验所有的文件！！！！');
    return
else
    filenum=size(file,2);
    if filenum<2
        msgbox('请读取本次实验所有的文件！！！！');
        return
    end
    string='';
    for i=1:filenum
        string=[string file{i}];
    end
    %% 判断读取文件数量
    if ~contains(string,'Event')&&~contains(string,'event')
        msgbox('请重新读取Event文件！！！！');
        return
    end
    
    if ~contains(string,'405') && ~contains(string,'470') 
        msgbox('请重新读取405 470数据文件！！！！');
        return
    end
    if ~contains(string,'470')
        choice=questdlg('470文件没有读取是否继续！！！！', ...
            'Selection Dialog', ...
            'Yes', 'No','No');
        if ~strcmp(choice,'Yes')
            msgbox('用户取消继续读取.......');
            return
        end
    end
    if ~contains(string,'405')
        choice=questdlg('405文件没有读取是否继续！！！！', ...
            'Selection Dialog', ...
            'Yes', 'No','No');
        if ~strcmp(choice,'Yes')
            msgbox('用户取消继续读取.......');
            return
        end
    end

    %%
end
passdata.readpath=path(1:end-1);
data405=[];
data470=[];
data580=[];
cue=[];
passdata.data405=[];
passdata.data470=[];
passdata.data580=[];
passdata.cue=[];
h=waitbar(0,'Event 405 470 文件读取中，请稍等..........');
for i=1:size(file,2)
    string=char(file(i));
    examstring=[path,string];
    [~,~,file_part]=fileparts(examstring);
    if strcmp(file_part,'.csv')
        %%
        if contains(string,'Event')||contains(string,'event')
            cue =csvread(examstring);
            passdata.cuefilepath=examstring;
            passdata.cuepart='.csv';
            
        elseif contains(string,'405')
            data405=csvread(examstring);
            passdata.Cal405filepath=examstring;
            passdata.cal405part='.csv';
            
            passdata.channelnum_cal=size(data405,2)-1;
            set(handles.cal_pm,'String',num2str((1:1:passdata.channelnum_cal)'));
            set(handles.cal_pm,'Value',1);
            
            set(handles.CorrectChannel_2,'String',num2str((1:1:passdata.channelnum_cal)'));
            set(handles.CorrectChannel_2,'Value',1);
            set(handles.CorrectChannel,'String',num2str((1:1:passdata.channelnum_cal)'));
            set(handles.CorrectChannel,'Value',1);
        elseif contains(string,'470')
            data470=csvread(examstring);
            passdata.Cal470filepath=examstring;
            passdata.cal470part='.csv';
            
            passdata.channelnum_cal=size(data470,2)-1;
            set(handles.cal_pm,'String',num2str((1:1:passdata.channelnum_cal)'));
            set(handles.cal_pm,'Value',1);
            
            set(handles.CorrectChannel_2,'String',num2str((1:1:passdata.channelnum_cal)'));
            set(handles.CorrectChannel_2,'Value',1);
            set(handles.CorrectChannel,'String',num2str((1:1:passdata.channelnum_cal)'));
            set(handles.CorrectChannel,'Value',1);
            
        elseif contains(string,'580')
            data580=csvread(examstring);
            passdata.Cal580filepath=examstring;
            passdata.cal580part='.csv';
            
            passdata.channelnum_cal=size(data580,2)-1;
            set(handles.cal_pm,'String',num2str((1:1:passdata.channelnum_cal)'));
            set(handles.cal_pm,'Value',1);
            
            set(handles.CorrectChannel_2,'String',num2str((1:1:passdata.channelnum_cal)'));
            set(handles.CorrectChannel_2,'Value',1);
            set(handles.CorrectChannel,'String',num2str((1:1:passdata.channelnum_cal)'));
            set(handles.CorrectChannel,'Value',1);
            
        end
        %%
    elseif strcmp(file_part,'.tdms')
        if contains(string,'Event')||contains(string,'event')
            data =TDMS_readTDMSFile(examstring);
            cue=cat(1,data.data{3:end})';
            passdata.cuefilepath=examstring;
            passdata.cuepart='.tdms';
        elseif contains(string,'405')
            data =TDMS_readTDMSFile(examstring);
            data405=cat(1,data.data{3:end})';
            passdata.Cal405filepath=examstring;
            passdata.cal405part='.tdms';
            
            passdata.channelnum_cal=size(data405,2)-1;
            set(handles.cal_pm,'String',num2str((1:1:passdata.channelnum_cal)'));
            set(handles.cal_pm,'Value',1);
            
            set(handles.CorrectChannel_2,'String',num2str((1:1:passdata.channelnum_cal)'));
            set(handles.CorrectChannel_2,'Value',1);
            set(handles.CorrectChannel,'String',num2str((1:1:passdata.channelnum_cal)'));
            set(handles.CorrectChannel,'Value',1);
            
        elseif contains(string,'470')
            data =TDMS_readTDMSFile(examstring);
            data470=cat(1,data.data{3:end})';
            passdata.Cal470filepath=examstring;
            passdata.cal470part='.tdms';
            
            passdata.channelnum_cal=size(data470,2)-1;
            set(handles.cal_pm,'String',num2str((1:1:passdata.channelnum_cal)'));
            set(handles.cal_pm,'Value',1);
            
            set(handles.CorrectChannel_2,'String',num2str((1:1:passdata.channelnum_cal)'));
            set(handles.CorrectChannel_2,'Value',1);
            set(handles.CorrectChannel,'String',num2str((1:1:passdata.channelnum_cal)'));
            set(handles.CorrectChannel,'Value',1);
            
        elseif contains(string,'580')
            data =TDMS_readTDMSFile(examstring);
            data580=cat(1,data.data{3:end})';
            passdata.Cal580filepath=examstring;
            passdata.cal580part='.tdms';
            
            passdata.channelnum_cal=size(data580,2)-1;
            set(handles.cal_pm,'String',num2str((1:1:passdata.channelnum_cal)'));
            set(handles.cal_pm,'Value',1);
            
            set(handles.CorrectChannel_2,'String',num2str((1:1:passdata.channelnum_cal)'));
            set(handles.CorrectChannel_2,'Value',1);
            set(handles.CorrectChannel,'String',num2str((1:1:passdata.channelnum_cal)'));
            set(handles.CorrectChannel,'Value',1);
            
        end
    elseif strcmp(file_part,'.mat')
        if contains(string,'Event')||contains(string,'event')
            data =load(examstring);
            cue=data.data;
            passdata.cuefilepath=examstring;
            passdata.cuepart='.mat';
        elseif contains(string,'405')
            data =load(examstring);
            data405=data.data;
            passdata.Cal405filepath=examstring;
            passdata.cal405part='.mat';
            
            passdata.channelnum_cal=size(data405,2)-1;
            set(handles.cal_pm,'String',num2str((1:1:passdata.channelnum_cal)'));
            set(handles.cal_pm,'Value',1);
            
            set(handles.CorrectChannel_2,'String',num2str((1:1:passdata.channelnum_cal)'));
            set(handles.CorrectChannel_2,'Value',1);
            set(handles.CorrectChannel,'String',num2str((1:1:passdata.channelnum_cal)'));
            set(handles.CorrectChannel,'Value',1);
            
        elseif contains(string,'470')
            data =load(examstring);
            data470=data.data;
            passdata.Cal470filepath=examstring;
            passdata.cal470part='.mat';
            
            passdata.channelnum_cal=size(data470,2)-1;
            set(handles.cal_pm,'String',num2str((1:1:passdata.channelnum_cal)'));
            set(handles.cal_pm,'Value',1);
            
            set(handles.CorrectChannel_2,'String',num2str((1:1:passdata.channelnum_cal)'));
            set(handles.CorrectChannel_2,'Value',1);
            set(handles.CorrectChannel,'String',num2str((1:1:passdata.channelnum_cal)'));
            set(handles.CorrectChannel,'Value',1);
            
        elseif contains(string,'580')
            data =load(examstring);
            data580=data.data;
            passdata.Cal580filepath=examstring;
            passdata.cal580part='.mat';
            
            passdata.channelnum_cal=size(data580,2)-1;
            set(handles.cal_pm,'String',num2str((1:1:passdata.channelnum_cal)'));
            set(handles.cal_pm,'Value',1);
            
            set(handles.CorrectChannel_2,'String',num2str((1:1:passdata.channelnum_cal)'));
            set(handles.CorrectChannel_2,'Value',1);
            set(handles.CorrectChannel,'String',num2str((1:1:passdata.channelnum_cal)'));
            set(handles.CorrectChannel,'Value',1);
            
        end
    end
end
waitbar(25/100,h);
%%

if isempty(cue)
    msgbox('请重新读取Event文件！！！！');
    return
end

passdata.cue=cue;
%%
passdata.channelnum_cue=size(passdata.cue,2);
passdata.length_cue=size(passdata.cue,1);
%% 计算event每个通道的上升沿位置
for i=1:passdata.channelnum_cue
    cue=smooth(passdata.cue(:,i),5);
    cue(cue<0.7)=0;
    cue(cue>=0.7)=1;
    current_cue=cue;
    exam_upindex=1+find(diff(current_cue)==1)'-4;
    exam_trialnum = size(exam_upindex,2);
    eval(['passdata.InputMark.upindex_' num2str(i) '=exam_upindex;']);
    eval(['passdata.InputMark.Finalyupindex_' num2str(i) '=exam_upindex;']);
    eval(['passdata.InputMark.trialnum_' num2str(i) '=exam_trialnum;']);
end
%% cue通道更新
stringcell=cell(passdata.channelnum_cue+5,1);
stringcell{1,1}='ManualMark';
for i=1:4
    stringcell{1+i,1}=['VideoCue' num2str(i)];
end
for i=1:passdata.channelnum_cue
    stringcell{i+5,1}=['D' num2str(i)];
end
set(handles.cue_channel,'String',stringcell);
set(handles.cue_channel,'Value',1);
passdata.cue_read=1;
waitbar(50/100,h);
passdata.data405=data405;
passdata.data470=data470;
passdata.data580=data580;
waitbar(100/100,h);
close(h);

if isempty(passdata.interval_cal)
    passdata.interval_cal=1/40;
    set(handles.rate,'Value',2);
end

%%
if isempty(passdata.data470)
    
    set(handles.calmode_pm,'Value',1);
    passdata.calmode_index=1;
else
    set(handles.calmode_pm,'Value',2);
    passdata.calmode_index=2;
end
passdata.cal_read=1;
passdata.data580_raw=passdata.data580;
passdata.data405_raw=passdata.data405;
passdata.data470_raw=passdata.data470;

set(handles.filepath_ed,'String','Cal read completed !!!!');
set(handles.filepath_ed,'String',path);
set(handles.cal_pm,'Value',1);
msgbox('数据读取成功！！！！');
DrawData1_dualmulti;

guidata(hObject,handles);


% --- Executes during object creation, after setting all properties.
function InsertMark_CreateFcn(hObject, eventdata, handles)
% hObject    handle to InsertMark (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on selection change in CorrectChannel.
function CorrectChannel_Callback(hObject, eventdata, handles)
% hObject    handle to CorrectChannel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns CorrectChannel contents as cell array
%        contents{get(hObject,'Value')} returns selected item from CorrectChannel


% --- Executes during object creation, after setting all properties.
function CorrectChannel_CreateFcn(hObject, eventdata, handles)
% hObject    handle to CorrectChannel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in correctmode_1.
function correctmode_1_Callback(hObject, eventdata, handles)
% hObject    handle to correctmode_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns correctmode_1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from correctmode_1


% --- Executes during object creation, after setting all properties.
function correctmode_1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to correctmode_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function channelcorrecttime_1_Callback(hObject, eventdata, handles)
% hObject    handle to channelcorrecttime_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of channelcorrecttime_1 as text
%        str2double(get(hObject,'String')) returns contents of channelcorrecttime_1 as a double


% --- Executes during object creation, after setting all properties.
function channelcorrecttime_1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to channelcorrecttime_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function channelcorrecttime_2_Callback(hObject, eventdata, handles)
% hObject    handle to channelcorrecttime_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of channelcorrecttime_2 as text
%        str2double(get(hObject,'String')) returns contents of channelcorrecttime_2 as a double


% --- Executes during object creation, after setting all properties.
function channelcorrecttime_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to channelcorrecttime_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in UsingChannelCorrect.
function UsingChannelCorrect_Callback(hObject, eventdata, handles)
% hObject    handle to UsingChannelCorrect (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of UsingChannelCorrect


% --- Executes on selection change in CorrectChannel_2.
function CorrectChannel_2_Callback(hObject, eventdata, handles)
% hObject    handle to CorrectChannel_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns CorrectChannel_2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from CorrectChannel_2


% --- Executes during object creation, after setting all properties.
function CorrectChannel_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to CorrectChannel_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in correctmode_2.
function correctmode_2_Callback(hObject, eventdata, handles)
% hObject    handle to correctmode_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns correctmode_2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from correctmode_2


% --- Executes during object creation, after setting all properties.
function correctmode_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to correctmode_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function channelcorrecttime_3_Callback(hObject, eventdata, handles)
% hObject    handle to channelcorrecttime_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of channelcorrecttime_3 as text
%        str2double(get(hObject,'String')) returns contents of channelcorrecttime_3 as a double


% --- Executes during object creation, after setting all properties.
function channelcorrecttime_3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to channelcorrecttime_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function channelcorrecttime_4_Callback(hObject, eventdata, handles)
% hObject    handle to channelcorrecttime_4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of channelcorrecttime_4 as text
%        str2double(get(hObject,'String')) returns contents of channelcorrecttime_4 as a double


% --- Executes during object creation, after setting all properties.
function channelcorrecttime_4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to channelcorrecttime_4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in UsingChannelCorrect_2.
function UsingChannelCorrect_2_Callback(hObject, eventdata, handles)
% hObject    handle to UsingChannelCorrect_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of UsingChannelCorrect_2


% --- Executes during object creation, after setting all properties.
function Plotting_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Plotting (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --------------------------------------------------------------------
function LoadTimeStamp_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to LoadTimeStamp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clc
global passdata
if isfield(passdata,'readpath')
    [filenametxt,filepathtxt]=uigetfile({'*.TXT'},'Open txt_data file','MultiSelect','off',passdata.readpath);
else
    [filenametxt,filepathtxt]=uigetfile({'*.TXT'},'Open txt_data file','MultiSelect','off');
end
if isequal(filenametxt,0)
    return;
end
fullfiletxt=fullfile(filepathtxt,filenametxt);
[~,~,file_part_trail]=fileparts(fullfiletxt);

if ~strcmp(file_part_trail,'.TXT') && ~strcmp(file_part_trail,'.txt')
    msgbox('操作失败，请确定是否读取正确的txt文件数据 !!!!');
    return;
end
time=importdata(fullfiletxt);
passdata.readpath=filepathtxt(1:end-1);
passdata.time0=datenum(time{1,1},'yyyy-mm-dd HH.MM.SS.FFF');
passdata.time_duration=datenum(time{end,1},'yyyy-mm-dd HH.MM.SS.FFF');
passdata.time_duration=(passdata.time_duration-passdata.time0)*24*60*60;
msgbox('时间数据读取成功 !!!');
clc


% --- Executes on selection change in correctmode.
function correctmode_Callback(hObject, eventdata, handles)
% hObject    handle to correctmode (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns correctmode contents as cell array
%        contents{get(hObject,'Value')} returns selected item from correctmode


% --- Executes during object creation, after setting all properties.
function correctmode_CreateFcn(hObject, eventdata, handles)
% hObject    handle to correctmode (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in rate.
function rate_Callback(hObject, eventdata, handles)
% hObject    handle to rate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global passdata
index=get(handles.rate,'Value');
if index==1
    passdata.interval_cal=1/30;
elseif index==2
    passdata.interval_cal=1/40;
end


if ~isfield(passdata,'data405')&&~isfield(passdata,'data470')&&~isfield(passdata,'data580')
    return;
end
DrawData1_dualmulti;
% Hints: contents = cellstr(get(hObject,'String')) returns rate contents as cell array
%        contents{get(hObject,'Value')} returns selected item from rate


% --- Executes during object creation, after setting all properties.
function rate_CreateFcn(hObject, eventdata, handles)
% hObject    handle to rate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
