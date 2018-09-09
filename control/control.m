%% Control

clc;clear;close all;

scan_list = [83];
         
save('scan_list.mat','scan_list');
% copyfile('scan_list.mat',[pwd,'/core/Data/Port_data']);
Data_file_header = 'PMNPT_11072015_';
save('Data_file_header.mat','Data_file_header');
% copyfile('Data_file_header.mat',[pwd,'/core/Data/Port_data']);
old_path = pwd; 
save('old_path.mat','old_path');
% copyfile('old_path.mat',[pwd,'/core/Data/Port_data']);

for ii = 1:numel(scan_list)
    
save('ii.mat','ii');

if 7==exist([pwd,'/core/Data'])
    rmdir([pwd,'/core/Data'],'s');
    mkdir([pwd,'/core/Data']);
else
    mkdir([pwd,'/core/Data']);
end
    
addpath([pwd,'/core/Data']);

% rmdir([pwd,'/core/Data/Res'],'s');         mkdir([pwd,'/core/Data/Res']);       
% rmdir([pwd,'/core/Data/Qdata'],'s');       mkdir([pwd,'/core/Data/Qdata']);
% rmdir([pwd,'/core/Data/Port_data'],'s');   mkdir([pwd,'/core/Data/Port_data']);
% rmdir([pwd,'/core/Data/mmdata'],'s');      mkdir([pwd,'/core/Data/mmdata']);
% rmdir([pwd,'/core/Data/Origin_data'],'s'); mkdir([pwd,'/core/Data/Origin_data']);
% rmdir([pwd,'/core/Data/spec'],'s');        mkdir([pwd,'/core/Data/spec']);

mkdir([pwd,'/core/Data/Res']);       
mkdir([pwd,'/core/Data/Qdata']);
mkdir([pwd,'/core/Data/Port_data']);
mkdir([pwd,'/core/Data/mmdata']);
mkdir([pwd,'/core/Data/Origin_data']);
mkdir([pwd,'/core/Data/spec']);

addpath([pwd,'/core/Data/Res']);              
addpath([pwd,'/core/Data/Qdata']);       
addpath([pwd,'/core/Data/Port_data']);   
addpath([pwd,'/core/Data/mmdata']);
addpath([pwd,'/core/Data/Origin_data']);  
addpath([pwd,'/core/Data/spec']);

% scan_list = [46 47 48 49 50 51 52 53 54 55 56];
% save('scan_list.mat','scan_list');
% copyfile('scan_list.mat',[pwd,'/core/Data/Port_data']);
% Data_file_header = 'PMNPT_11072015_';
% save('Data_file_header.mat','Data_file_header');
% copyfile('Data_file_header.mat',[pwd,'/core/Data/Port_data']);

File_list = fullfile([pwd,'/Datafile/',Data_file_header,sprintf('%.4d',scan_list(ii))]);
copyfile(File_list,[pwd,'/core/Data/Origin_data']);
copyfile([pwd,'/SPEC/scan',num2str(scan_list(ii)),'.txt'],[pwd,'/core/Data/spec']);
copyfile([pwd,'/spec_s.xlsx'],[pwd,'/core/Data/spec']);
% old_path = pwd; 
% save('old_path.mat','old_path');
% copyfile('old_path.mat',[pwd,'/core/Data/Port_data']);
cd([pwd,'/core/']);

Port_var;trans;Interpolant;

disp('CORE running finshed!!');

abs_path = 'H:/3DRSM core';
cd(abs_path);
load([abs_path,'/old_path.mat']); 
load([abs_path,'/Data_file_header.mat']);
load([abs_path,'/scan_list.mat']);
load([abs_path,'/ii.mat']);
mkdir([abs_path,'/Result/',Data_file_header,sprintf('%.4d',scan_list(ii))]);
addpath([abs_path,'/Result/',Data_file_header,sprintf('%.4d',scan_list(ii))]);
copyfile([abs_path,'/core/Data/Res/D.mat'],[abs_path,'/Result/',Data_file_header,sprintf('%.4d',scan_list(ii))]);
copyfile([abs_path,'/core/Data/mmdata/mmdata.mat'],[abs_path,'/Result/',Data_file_header,sprintf('%.4d',scan_list(ii))]);
end