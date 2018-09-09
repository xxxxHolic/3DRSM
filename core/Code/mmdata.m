clc;clear;
load([pwd,'\data\Origin data\specs\match.mat'],'match');
num1 = numel(match);
for i = 1:num1
    Qspace_name = cell2mat(match(i,1));
    Qpath = [pwd,'\data\Q_space\',Qspace_name];
    datapath = fullfile(Qpath,'*.tif.mat');
    F = dir(datapath);
    fileNames = sortedby(F,'name');
    num2 = numel( fileNames );
    
    minVals = nan(num2, 4);
    maxVals = nan(num2, 4);

 for j = 1:num2
    load(fullfile(Qpath, fileNames{j}), 'Q_x', 'Q_y', 'Q_z', 'V');
%     disp([fileNames{j} ' was loaded'])
    minVals(j,:) = min( [Q_x(:) Q_y(:) Q_z(:) V(:)] );
    maxVals(j,:) = max( [Q_x(:) Q_y(:) Q_z(:) V(:)] );
%     disp( num2str(minVals(j, 1:3)) );
%     disp( num2str(maxVals(j, 1:3)) );
 end
    save([pwd,'\data\mmdata\', cell2mat(match(i,1)),'.mat'], 'minVals', 'maxVals');
    disp(['mmdata',cell2mat(match(i,1)),'be saved']);
    clear minVals maxVals j ;
end