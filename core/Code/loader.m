function D = loader(dataPath, fileNames, ss)
%LOADER LOAD scattered 4-D data and reduce or sampling them
%
% copyright (c) wulx
% Last Modified by wulx, 2013/5/26
%

num = numel( fileNames );
D = cell(num,1);
% load original data
parfor i =1:num
    fullName = fullfile(dataPath, fileNames{i});
    S = load(fullName, 'Q_x', 'Q_y', 'Q_z', 'V');
%     disp([fileNames{i} ' was loaded']);

    % uniform sampling
    unispl = @(c, s) c(1:s:end, 1:s:end);
    
    qx = unispl( S.Q_x, ss );
    qy = unispl( S.Q_y, ss );
    qz = unispl( S.Q_z, ss );
    v = unispl( S.V, ss );
    
    D{i} = [qx(:) qy(:) qz(:) v(:)];
end

D = cell2mat(D);