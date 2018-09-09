clc;clear;

%% load minVals and maxVals 构建插值网格坐标

dataPath = fullfile([pwd,'/Data/Qdata']);
dataFiles = fullfile(dataPath, '*.mat');
F = dir( dataFiles );
fileList = sortedby(F,'name');
load([pwd,'/data/mmdata/mmdata.mat'], 'minVals', 'maxVals');

stepVals = [0.001, 0.001, 0.001];

xLim = sort([min(minVals(:,1)) max(maxVals(:,1))]);
yLim = sort([max(minVals(:,2)) min(maxVals(:,2))]);
zLim = sort([min(minVals(:,3)) max(maxVals(:,3))]);

n = round( (xLim(2) - xLim(1)) / stepVals(1) ); % columes
m = round( (yLim(2) - yLim(1)) / stepVals(2) ); % rows
p = round( (zLim(2) - zLim(1)) / stepVals(3) ); % layers

D = nan(m, n, p);

xLsp = linspace(xLim(1), xLim(2), n);
yLsp = linspace(yLim(1), yLim(2), m);
zLsp = linspace(zLim(1), zLim(2), p);

%% 插值参数

ss = 3;
xnum = 10;
margins = [2 2];
xStarts = 1:xnum:n;
xEnds = [xStarts(2:end)-1, n];

%% 循环插值

for i = 1:numel(xStarts)
% for i = 10:20
    % set boundaries
    xLeftLoc = xStarts(i) - margins(1);
    if xLeftLoc<1
        xLeftLoc = 1;
    end
    xLeft = xLsp(xLeftLoc);
    
    xRightLoc = xEnds(i) + margins(2);
    if xRightLoc>n
        xRightLoc = n;
    end
    xRight = xLsp(xRightLoc);
    
    % maxValues in the box
    maxIn = (maxVals(:,1)>xLeft);
    % minValues in the box
    minIn = (minVals(:,1)<=xRight);
    % the slices in the box
    slicesIn = maxIn & minIn;
    
    if all(~slicesIn)
        continue;
    end
    
    fileNames = fileList(slicesIn);
    disp(['Loading box No. ' num2str(i)]);
    disp([num2str(sum(slicesIn)) 'slices in total.'])
    s4d = double( loader(dataPath, fileNames, ss) );
    filterIn = (s4d(:,1)>xLeft & s4d(:,1)<=xRight);
    s4d = s4d(filterIn, :);
    
    F =  scatteredInterpolant(s4d(:,1:3), s4d(:,4), 'linear', 'none');
    [xq, yq, zq] = meshgrid(xLsp(xStarts(i):xEnds(i)), yLsp, zLsp);
    D(:, xStarts(i):xEnds(i), :)  = F(xq, yq, zq);     
    Qxx(:, xStarts(i):xEnds(i), :)  =  xq;
    Qyy(:, xStarts(i):xEnds(i), :)  =  yq;
    Qzz(:, xStarts(i):xEnds(i), :)  =  zq;
end

%% save the data
save(['Data/Res/','D.mat'], 'D', '-v7.3');
save(['Data/Res/','Qspace.mat'],'Qxx','Qyy','Qzz','-v7.3');
disp(['Interpolant Finsh']);


