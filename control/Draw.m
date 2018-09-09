%ISOSLICE_TEST
% by wulx, 2013/5/27
% % %% optional: smooth 3D data by filters(box or gaussian)
% % % cut out the D

clc;clear;

load('scan_list.mat');

% for ii = 8:numel(scan_list)

ii = 52;

% file = ['PMNPT_11072015_',sprintf('%.4d',scan_list(ii))];
file = ['PMNPT_11072015_',sprintf('%.4d',ii)];
path = [pwd,'/Result/',file,'/'];
load([path,'D.mat']);
mmpath = fullfile([path,'mmdata.mat']);

% D = D(2:end,1:end,2:end);
% % % % save cut_D.MAT;
% % % % load cut_D.MAT;
% % % % compres the D
% % % % D = (D(:,1:2:end,:)+D(:,2:2:end,:))/2;
% % % % D = (D(:,1:2:end,:)+D(:,2:2:end,:))/2;
% % % % D = (D(:,:,1:5:end)+D(:,:,2:5:end)+D(:,:,3:5:end)+D(:,:,4:5:end)+D(:,:,5:5:end))/5;
% D = (D(1:2:end,:,:)+D(2:2:end,:,:))/2;
% D = (D(:,:,1:2:end)+D(:,:,2:2:end))/2;
% D = (D(:,1:2:end,:)+D(:,2:2:end,:))/2;
% % 
%  D = smooth3(D, 'box', 3);
% % save compres_D.MAT -v7.3;
% % % % D = smooth3(D, 'box', 3);
% set params
% sx =52

isoval = 100;

isoslice(D, isoval,mmpath);

% view(45,30);

pause;close all;

% end
% oaxes([0 365 0]);