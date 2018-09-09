function isoslice(D, isoval, mmpath)
%ISOSLICE ISO-surface and SLICE
%
% copyright (c) wulx
% Last Modified by wulx, 2013/5/27
%modified by Z.Luo, 2013/6/5 to find the tilting tri-2 phase
%

figure, hold on;
% isosurface
hiso = patch(isosurface(D, isoval));
set(hiso, 'FaceColor', [0.7 0.2 0.3], 'EdgeColor','none');

% axes configure
setAxes(D, mmpath);

% lighting and view
set(gca, 'projection', 'perspective')
box on
lighting phong
light('position',[ 1,-1,-1])
light('position',[ -1,1,1])
set(gca,'color',[1,1,1])
set(gcf,'color',[1,1,1])
view(0,90);
% rotate3d on

% slice plane
% h = slice(D, [], sx, [], 'cubic');

% %  h = slice(D, [], [], sx, 'cubic');
% % %       rotate(h,[0 0 1], -17);
% %  set(h, 'FaceColor', 'blue', 'FaceAlpha', 0.3, 'EdgeColor', 'none');
% % cdata = get(h, 'CDATA');
end
