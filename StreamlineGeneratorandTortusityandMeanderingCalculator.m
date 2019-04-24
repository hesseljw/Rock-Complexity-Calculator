% STREAMLINE GENERATOR AND TORTUSITY & MEANDERINGCALCULATOR Version 1.0
% HESSEL JULIUST
% Last Updated - 30 September 2018

function varargout = StreamlineGeneratorandTortusityandMeanderingCalculator(varargin)
% STREAMLINEGENERATORANDTORTUSITYANDMEANDERINGCALCULATOR MATLAB code for StreamlineGeneratorandTortusityandMeanderingCalculator.fig
%      STREAMLINEGENERATORANDTORTUSITYANDMEANDERINGCALCULATOR, by itself, creates a new STREAMLINEGENERATORANDTORTUSITYANDMEANDERINGCALCULATOR or raises the existing
%      singleton*.
%
%      H = STREAMLINEGENERATORANDTORTUSITYANDMEANDERINGCALCULATOR returns the handle to a new STREAMLINEGENERATORANDTORTUSITYANDMEANDERINGCALCULATOR or the handle to
%      the existing singleton*.
%
%      STREAMLINEGENERATORANDTORTUSITYANDMEANDERINGCALCULATOR('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in STREAMLINEGENERATORANDTORTUSITYANDMEANDERINGCALCULATOR.M with the given input arguments.
%
%      STREAMLINEGENERATORANDTORTUSITYANDMEANDERINGCALCULATOR('Property','Value',...) creates a new STREAMLINEGENERATORANDTORTUSITYANDMEANDERINGCALCULATOR or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before StreamlineGeneratorandTortusityandMeanderingCalculator_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to StreamlineGeneratorandTortusityandMeanderingCalculator_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help StreamlineGeneratorandTortusityandMeanderingCalculator

% Last Modified by GUIDE v2.5 06-Oct-2018 23:50:20

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @StreamlineGeneratorandTortusityandMeanderingCalculator_OpeningFcn, ...
                   'gui_OutputFcn',  @StreamlineGeneratorandTortusityandMeanderingCalculator_OutputFcn, ...
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


% --- Executes just before StreamlineGeneratorandTortusityandMeanderingCalculator is made visible.
function StreamlineGeneratorandTortusityandMeanderingCalculator_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to StreamlineGeneratorandTortusityandMeanderingCalculator (see VARARGIN)

% Choose default command line output for StreamlineGeneratorandTortusityandMeanderingCalculator
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes StreamlineGeneratorandTortusityandMeanderingCalculator wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = StreamlineGeneratorandTortusityandMeanderingCalculator_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% Import Velocity Data
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[FileName,PathName] = uigetfile('*.csv','Select the DVSS CSV file');
 Data = readtable(fullfile(PathName,FileName));
handles.Data=Data
set(handles.text19,'String',FileName)


guidata(hObject,handles)


%GENERATE STREAMLINE
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Data=handles.Data;
PanjangXYZ =   str2double((get(handles.edit1,'String')));
PangkatPengali =   str2double((get(handles.edit2,'String')));
PangkatJumlahIterasi =   str2double((get(handles.edit3,'String')));
JarakAntarSeed =   str2double((get(handles.edit4,'String')));



PanjangX = PanjangXYZ;
PanjangY = PanjangXYZ;
PanjangZ = PanjangXYZ;

ut = Data(:,2);
vt = Data(:,3);
wt = Data(:,4);
u = table2array(ut);
v = table2array(vt);
w = table2array(wt);

U = reshape(u,PanjangXYZ,PanjangXYZ,PanjangXYZ);
V = reshape(v,PanjangXYZ,PanjangXYZ,PanjangXYZ);
W = reshape(w,PanjangXYZ,PanjangXYZ,PanjangXYZ);

%Agak iterasi sedikit
U = U*10^(8+PangkatPengali);
V = V*10^(8+PangkatPengali);
W = W*10^(8+PangkatPengali);

garis = 1;
JumlahGaris = PanjangXYZ;
JumlahGaris2 = PanjangXYZ*PanjangXYZ;

  h = waitbar(0,'Generating Streamline...');
    gariss = JumlahGaris^2;
  
        
for GarisY=1:JarakAntarSeed:JumlahGaris
    for GarisZ=1:JarakAntarSeed:JumlahGaris
    
     sx = []   ;
     sy = []   ;
     sz = []   ;
        
    %Seed Awal Streamline
    sx(1) = 1;
    sy(1) = GarisY;
    sz(1) = GarisZ;
     i = 2;
     j = 2;
     k = 2;

dt = 0.00001;
 for m=1:10^(PangkatJumlahIterasi)
     

         if (sx(m)>=1 && sx(m)< PanjangX) && (sy(m)>=1 && sy(m)< PanjangY) && (sz(m)>=1 && sz(m)< PanjangZ) 
           i = round(sx(m));
           j = round(sy(m));
           k = round(sz(m));

           
           sx(m+1) = sx(m) + U(i,j,k)*dt;
           sy(m+1) = sy(m) + V(i,j,k)*dt;
           sz(m+1) = sz(m) + W(i,j,k)*dt;
         else
             break
         end
    end
    line{garis}.x = sx;
    line{garis}.y = sy;
    line{garis}.z = sz; 
    garis = garis+1;
    garis
    end
    waitbar(garis / gariss)
 

end

  close(h) 

%Merapikan Streamline

h4 = waitbar(0,'Clearing Unused Streamline'); 





for k = 1:length(line)
   
    temp1 = line{k};
    
    if (max(temp1.x) < (PanjangXYZ-1) )
        line {k} = [];
    end
    
end
line = line(~cellfun(@isempty, line));


waitbar(.33,h4,'Clearing Unused Streamline');
pause(1)




for k = 1:length(line)
   
    temp1 = line{k};
    
    if (min(temp1.x) > 1 )
        line {k} = [];
    end
    
end
line = line(~cellfun(@isempty, line));

waitbar(.67,h4,'Clearing Unused Streamline');
pause(1)


for k = 1:length(line)
    temp1 = line{k};
     for j = 1:1:length(temp1.x)   
       if (temp1.x) > PanjangX 
        line{k}.x(j) = [];
        line{k}.y(j) = [];
        line{k}.z(j) = [];
       end
    end
end
line = line(~cellfun(@isempty, line));

waitbar(1,h4,'Clearing Unused Streamline');
pause(1)

close(h4);

% for k = 1:length(line)
%    
%     temp1 = line{k};
%     
%     if (max(temp1.x) > 2567 )
%         line {k} = [];
%     end
%     
% end
% line = line(~cellfun(@isempty, line));

%Plot Streamline
% 
%  h2 = waitbar(0,'Plotting Streamline...');
%     gariss = length(line);
% 
h3 = figure (1)
set(h3,'Visible','off') 
for i=1:1:length(line)
    
        plot3(line{i}.x,line{i}.y,line{i}.z)
        hold on
%         waitbar(i / gariss)
end

set(gca,'box','on')
set(gca,'projection','perspective')

set(h3,'Visible','on') 
title('Streamline')

% close(h2) 

Filename = sprintf('Streamline_%s.mat', datestr(now,'mm-dd-yyyy HH-MM'));
oldfolder = pwd
cd output
save(Filename,'line')


message = sprintf('The streamline is saved in output folder');
uiwait(helpdlg(message));

% Filename = sprintf('StreamlineData_%s.txt', datestr(now,'mm-dd-yyyy HH-MM'));
% oldfolder = pwd
% cd output
% fprintf(fileID,'Exponential Function\n\n');
% fprintf(fileID,'%6.2f %12.8f\n', y);
% cd(oldfolder)

Filename2 = sprintf('StreamlineData_%s.txt', datestr(now,'mm-dd-yyyy HH-MM'));
fileID = fopen(Filename2,'w');
Panjangxyz='Panjang XYZ';
Pangkatpengali='Pangkat Pengali';
PangkatjumlahIterasi='Pangkat Jumlah Iterasi';
Jarakantarseed='Jarak Antar Seed';
fprintf(fileID,'%6s %12s\n',Panjangxyz);
fprintf(fileID,'%6.2f %12.8f\r\n',PanjangXYZ);
fprintf(fileID,'%6s %12s\n',Pangkatpengali);
fprintf(fileID,'%6.2f %12.8f\r\n',PangkatPengali);
fprintf(fileID,'%6s %12s\n',PangkatjumlahIterasi);
fprintf(fileID,'%6.2f %12.8f\r\n',PangkatJumlahIterasi);
fprintf(fileID,'%6s %12s\n',Jarakantarseed);
fprintf(fileID,'%6.2f %12.8f\r\n',JarakAntarSeed);
fclose(fileID);

cd(oldfolder)

guidata(hObject,handles)


% ImportStreamline
function pushbutton5_Callback(hObject, eventdata, handles)
[FileName,PathName] = uigetfile('*.mat','Select the Streamline data file');
oldfolder = pwd;
cd(PathName);
handles.linedat=load(FileName)
cd(oldfolder);

set(handles.text9,'String',FileName)


guidata(hObject,handles)


% CALCULATE TORTUOSITY AND MEADERING PARAMETER
function pushbutton4_Callback(hObject, eventdata, handles)

h7 = waitbar(0,'Calculating Streamline & Meandering Parameter..'); 

line=handles.linedat.line;

linee = line;
JumlahGaris = length(linee)

waitbar(.33,h7,'Calculating Streamline & Meandering Parameter..');
pause(1)
for garis=1:JumlahGaris
 
     LTeta = 0;
 
 Leng = max(linee{garis}.x)-min(linee{garis}.x) ;
 ndat = length(linee{garis}.x);
 teta = zeros(1,ndat);
 
 
 v{garis}.x = zeros(1,ndat);
 v{garis}.y = zeros(1,ndat);
 v{garis}.z = zeros(1,ndat);
 

 
%Pembuatan Vektor
    for i = 1:ndat-1
            v{garis}.x(i) = linee{garis}.x(i+1)-linee{garis}.x(i); 
            v{garis}.y(i) = linee{garis}.y(i+1)-linee{garis}.y(i);
            v{garis}.z(i) = linee{garis}.z(i+1)-linee{garis}.z(i);
    end
 
 
  
 for i = 1:ndat-2
     
     %Perhitungan Sudut 
        DotProduct(i)= (v{garis}.x(i)*v{garis}.x(i+1)) + (v{garis}.y(i)*v{garis}.y(i+1)) + (v{garis}.z(i)*v{garis}.z(i+1));
        PanjangV1(i) = sqrt ((v{garis}.x(i))^2 + (v{garis}.y(i))^2 + (v{garis}.z(i))^2 );
        PanjangV2(i) = sqrt ((v{garis}.x(i+1))^2 + (v{garis}.y(i+1))^2 + (v{garis}.z(i+1))^2);
        teta(i) = abs(acos(DotProduct(i)/(PanjangV1(i)* PanjangV2(i))));
        derajat(i) = rad2deg(teta(i));
     
 end
 
   
 for i = 1:ndat-1
      %Jumlah Total Sudut dikalikan panjang vektor
      r1 = linee{garis}.x(i+1)-linee{garis}.x(i);
      r1 = r1*r1;
      r2 = linee{garis}.y(i+1)-linee{garis}.y(i);
      r2 = r2*r2;
      r3 = linee{garis}.z(i+1)-linee{garis}.z(i);
      r3 = r3*r3;
      r(i) = sqrt(r1 + r2 + r3);
 end
 
waitbar(.50,h7,'Calculating Streamline & Meandering Parameter..');
pause(1)
 
 
r = r(2:end);
 
for i = 1:ndat-2
        LTeta(i) = teta(i)*r(i);
    end
 
gammagaris = sum(LTeta)/Leng;
gamma(garis) = gammagaris;
panjanglintasan(garis) = sum(r);
tortuositas(garis) = sum(r)/256;
 
end

waitbar(.67,h7,'Calculating Streamline & Meandering Parameter..');
pause(1)
 

 gamma = gamma';
 gamma = gamma(~isnan(gamma))';
 
 
  

%Menghitung perata-rataan tortuositas
 
gammameanaritmatik = sum(gamma)/length(linee)
tortuositasmeanaritmatik = sum(tortuositas)/length(linee)

  
waitbar(.80,h7,'Calculating Streamline & Meandering Parameter..');
pause(1)

set(handles.text13,'String',tortuositasmeanaritmatik)
set(handles.text15,'String',gammameanaritmatik)



message = sprintf('The Tortuosity is %f:', tortuositasmeanaritmatik);
uiwait(helpdlg(message));
message = sprintf('The Meandering Parameter is %f:', gammameanaritmatik);

Filename = sprintf('Streamline_%s.mat', datestr(now,'mm-dd-yyyy HH-MM'));
oldfolder = pwd
cd output

Filename3 = sprintf('TortuosityAndMeanderingParameterData_%s.txt', datestr(now,'mm-dd-yyyy HH-MM'));
fileID = fopen(Filename3,'w');
tortuositas='Tortuosity :';
meandering='Meandering Parameter :';
numbline='Number of Streamline :';

fprintf(fileID,'%6s %12s\n',tortuositas);
fprintf(fileID,'%6.7f %12.8f\r\n',tortuositasmeanaritmatik);
fprintf(fileID,'%6s %12s\n',meandering);
fprintf(fileID,'%6.7f %12.8f\r\n',gammameanaritmatik);
fprintf(fileID,'%6s %12s\n',numbline);
fprintf(fileID,'%6.1f %12.8f\r\n',length(line));

fclose(fileID);

cd(oldfolder)

waitbar(1,h7,'Calculating Streamline & Meandering Parameter..');
pause(1)

close(h7)

uiwait(helpdlg(message));



%EDIT1 = NSLICE
%EDIT2 = Pangkat Pengali
%EDIT3 = Jumlah Iterasi
%EDIT4 = Jurak Antar Seed

function edit1_Callback(hObject, eventdata, handles)
function edit2_Callback(hObject, eventdata, handles)
function edit3_Callback(hObject, eventdata, handles)
function edit4_Callback(hObject, eventdata, handles)




function edit1_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function edit2_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function edit3_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit4_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end






