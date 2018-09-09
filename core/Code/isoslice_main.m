%ISOSLICE_TEST
% by wulx, 2013/5/27
% % %% optional: smooth 3D data by filters(box or gaussian)
% % % cut out the D
clc;clear;
load([pwd,'/Data/Res/','D.mat']);
mmpath = fullfile([pwd,'/Data/mmdata/mmdata.mat']);

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

isoval = 1500;
sx = 52;  

isoslice(D, isoval, sx, mmpath);
view(45,30);
% oaxes([0 365 0]);