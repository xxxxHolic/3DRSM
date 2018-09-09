function setAxes(D , mmpath)
%SETTICKS SET TICKS and their labels

bds = volumebounds( D );
axis( bds );
daspect([1 1 1]);

% load minVals and maxVals
load(fullfile(mmpath), 'minVals', 'maxVals');
% % MinVals = min( minVals(:, 1:3) );
% % MaxVals = max( maxVals(:, 1:3) );

xBounds = [min( minVals(:, 1) ); max( maxVals(:, 1) )];
yBounds = [max( minVals(:, 2) ); min( maxVals(:, 2) )];
zBounds = [max( minVals(:, 3) ); min( maxVals(:, 3) )];

xTicks = bds(1:2);
xTickLabels = num2str(xBounds, 4);
yTicks = bds(3:4);
yTickLabels = num2str(yBounds, 4);
zTicks = bds(5:6);
zTickLabels = num2str(zBounds, 4);

set(gca, 'XTick', xTicks, 'XTickLabel', xTickLabels);
set(gca, 'YTick',  yTicks, 'YTickLabel', yTickLabels);
set(gca, 'ZTick', zTicks, 'ZTickLabel', zTickLabels);
