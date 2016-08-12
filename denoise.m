
function complete_OpeningFcn(hObject, eventdata, handles, varargin)
% Choose default command line output for example5
handles.output = hObject;
clc
% initalize error count and use edit1 object's userdata to store it.
data.number_errors = 0;
set(handles.edit1,'UserData',data)
% Update handles structure
guidata(hObject, handles);
% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
set(handles.edit1,'String',...
num2str(get(hObject,'Value')));
% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
function edit1_Callback(hObject, eventdata, handles)
val = str2double(get(hObject,'String'));
% Determine whether val is a number between 0 and 10.
if isnumeric(val) && length(val)==10 && ...
val >= get(handles.slider1,'min') && ...
val <= get(handles.slider1,'max')
set(handles.slider1,'Value',val);
else
% Retrieve and increment the error count.
% Error count is in the edit text UserData,
% so we already have its handle.
data = get(hObject,'UserData');
data.number_errors = data.number_errors+1;
% Save the changes.
set(hObject,'UserData',data);
% Display new total.
set(hObject,'String',...
['You have entered an invalid entry ',...
num2str(data.number_errors),' times.']);
% Restore focus to the edit text box after error
uicontrol(hObject)
end
% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'),
get(0,'defaultUicontrolBackgroundColor'))
set(hObject,'BackgroundColor','white');
end

In the case of the pushbutton 1 that is called sine, and if it only shows sine signal and signal with noise, it needs to be programmed as follow

% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
k =(0:9.0703e-005:5);
w=500*pi;
h=w.*k;
x = sin(h);
f=get(handles.slider1,'Value');
y = awgn(x,f,'measured');
D=crosscorr(x,y);
z=-20:1:20;
plot(handles.axes1,k,x)
plot(handles.axes2,k,y)
plot(handles.axes3,z,D)

For programming, push button 2, called de-noise sine, this button performs all the processing method, which was described previously. It is necessary to write all this code

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
menu= get(handles.popupmenu1,'Value');
switch menu
case 1 %case 1: coiflet 5
·% example3 code
k =(0:9.0703e-005:5);
w=500*pi;
h=w.*k;
x = sin(h);
f=get(handles.slider1,'Value');
y = awgn(x,f,'measured');
wname = 'coif5'; lev = 10; % wavelet that need to change!
tree = wpdec(y,lev,wname);
det1 = wpcoef(tree,2);
sigma = median(abs(det1))/0.6745;
alpha = 2;
thr =wpbmpen(tree,sigma,alpha);
keepapp = 1;
xd = wpdencmp(tree,'s','nobest',thr,keepapp);
D=crosscorr(x,xd);
z=-20:1:20;
plot(handles.axes1,k,x)
plot(handles.axes2,k,y)
plot(handles.axes3,k,xd)
set(gca,'XLim',[ 0.2, 0.24], ...
'YLim',[-1 1]);
plot(handles.axes4,z,D)
case 2 %case2 Daubechies 10
·% example3 code
case 3 %Case 3: Daubechies 9
·% example3 code
End

For programing push button 3, called de-noise audio, this button performs all processing method, which was described previously. It is necessary to write all this code

% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
menu= get(handles.popupmenu1,'Value');
switch menu
case 1 %case 1: Coiflet 5
·% example4 code
k = 0:9.0703e-005:5;
w=500*pi;
h=w.*k;
[x,Fs,nbits]= wavread ('voice');
f=get(handles.slider1,'Value');
y = awgn(x,f,'measured');
wavwrite(y,Fs,'noisyvoice')
wname = 'coif5'; lev = 10;
tree = wpdec(y,lev,wname);
det1 = wpcoef(tree,2);
sigma = median(abs(det1))/0.6745;
alpha = 2;
thr =wpbmpen(tree,sigma,alpha);
keepapp = 1;	
xd = wpdencmp(tree,'s','nobest',thr,keepapp);
D=crosscorr(x,xd);
z=-20:1:20;
plot(handles.axes1,k,x)
plot(handles.axes2,k,y)
plot(handles.axes3,k,xd)
plot(handles.axes4,z,D)
case 2 %case2 Daubechies 10
·% example4 code
case 3 %Case 3: Daubechies 9
·% example4 code
end
For programing push button 4 called exit
% --- Executes on button press in pushbutton4.
function pushbutton3_Callback(hObject, eventdata, handles)
close all
