%% Trans

clc;clear;close all;

Var_list = dir(fullfile([pwd,'/Data/Port_data']));

for ii = 3:numel(Var_list)
    load([pwd,'/Data/Port_data/',Var_list(ii).name]);
end

num = numel(p_image);

disp('DATA PROCESSING . . . ')

for ii = 1:num
    filter_num = Filters(ii)
    filterValue = filter_racter(filter_num)
    eta = Eta(ii)
    trans4q(ii,filterValue,det2sam,pixSize,Del,eta,spot_yy,spot_zz,mm,nn,Origin_data_head);

end

disp(['tran4q END']);

minVals = nan(num,4);
maxVals = nan(num,4);

for ii = 1:num
    filename = [Origin_data_head,sprintf('%.5d',p_image(ii)),'.tif.mat'];
    load([pwd,'/Data/Qdata/',filename],'Q_x','Q_y','Q_z','V');
    minVals(ii,:) = min( [Q_x(:) Q_y(:) Q_z(:) V(:)] );
    maxVals(ii,:) = max( [Q_x(:) Q_y(:) Q_z(:) V(:)] );
end

save([pwd,'/Data/mmdata/mmdata.mat'],'minVals','maxVals');
