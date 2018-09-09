%% This program is used to plot the transparent stucture 

clc;clear;close all;
% 
load('scan_list.mat');
% 
% for ii = 1:numel(scan_list)
ii = 62

% file = ['PMNPT_11072015_',sprintf('%.4d',scan_list(ii))];
file = ['PMNPT_11072015_',sprintf('%.4d',ii)];
path = [pwd,'/Result/',file,'/'];
load([path,'D.mat']);

dd = smooth3(D, 'box', 3);

D = dd(20:end,130:240,30:120);

figure, hold on;

hiso1 = patch(isosurface(D, 100));
isonormals(D,hiso1);
set(hiso1, 'FaceColor', [1 1 0], 'EdgeColor','none','FaceAlpha',0.3);
hiso2 = patch(isosurface(D, 400));
isonormals(D,hiso2);
set(hiso2, 'FaceColor', [0 1 1], 'EdgeColor','none','FaceAlpha',0.4);
% axes configure
hiso3 = patch(isosurface(D, 5000));
isonormals(D,hiso3);
set(hiso3, 'FaceColor', [0 0 1], 'EdgeColor','none','FaceAlpha',0.7);
% setAxes(D);
bds = volumebounds( D );
axis( bds );
daspect([1 1 1]);

% set(gca,'XTick',[0],'XTickLabel',[]);
% set(gca,'YTick',[0],'YTickLabel',[]);
% set(gca,'ZTick',[0],'ZTickLabel',[]);
% xlabel('H');ylabel('K');zlabel('L');

grid on;
% axis off;
% lighting and view
set(gca, 'projection', 'perspective')
box on
lighting phong
light('position',[ 1,-1,-1])
light('position',[ -1,1,1])
set(gca,'color',[1,1,1])
set(gcf,'color',[1,1,1])

% set(gca,'XTick',[172-20:1:172+20],'XTickLabel','xx');
% saveas(gcf,['scan_',sprintf('%.2d',scan_list(ii)),'.fig']);

view(-90,0);
% view(0,0)
% pause;
% close all;

% end