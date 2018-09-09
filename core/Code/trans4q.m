
function [Q_x, Q_y, Q_z, V] = trans4q(ii,filterValue,det2sam,pixSize,del,eta,spot_yy,spot_zz,m,n,Origin_data_head)

   angle = [del eta];
   
%% 读取图片，去除坏点 

    filename = [Origin_data_head,sprintf('%.5d',(ii-1)),'.tif'];
    data = imread([pwd,'/Data/Origin_data/',filename]);
    
    data(:,234)=data(:,233);
    data(:,235)=data(:,236);
    data(73,104) = 0.5*(data(73,103)+data(73,105));
    data(92,259)=data(91,259);
    data(92,260)=data(91,260);
    data(91,222)=data(90,222);
    data(92,222)=data(93,222);
    data(92,221)=data(93,221);
    data(72,274)=data(73,274);
    data(72,275)=data(73,275);
    data(71,275)=data(70,275);
    data(71,274)=data(70,275);
    data(92,260)=data(91,260);

% % %  end
    ccdim = double(data);
    
%% converting degrees to radians #comment by wulx

    theta_i = pi * (-angle(2))/180; %入射角Eta转换为弧度
    phi_i = 0; %只在一个平面内
    theta_0 = pi * (angle(1)-angle(2))/180; 
    %angel1-angel2表示的是探测器接收到的出射光到到空间平面的夹角
    phi_0 = 0;
    
    % find k incident
    ki_x = cos(theta_i) .* cos(phi_i);
    ki_y = cos(theta_i) .* sin(phi_i);
    ki_z = sin(theta_i);
    
    % find k0
    % find theta,phi of outgoing/scattered x-ray, assuming ccd is perpendicular to x axis
    theta = nan(m, n);
    phi = nan(m, n);
    
    % parfor: parallel processing
    parfor k = 1:n
        for l = 1:m
            zc = pixSize * (k - spot_zz + 1); % incident beam spot on ccd
            yc = pixSize * (spot_yy - l + 1); % 3090-214 is the first line
            theta(l,k) = asin(zc / sqrt(det2sam^2 + yc^2 + zc^2)); % radian
            phi(l,k) = asin(yc / sqrt(det2sam^2 + yc^2)); % radian
        end
    end
    
    theta = theta + theta_0;
    phi = phi + phi_0;
    
    ko_x = cos(theta) .* cos(phi);
    ko_y = cos(theta) .* sin(phi);
    ko_z = sin(theta);
    
    % find q
    Q_x = single( (3.789/1.0598) .* (ko_x - ki_x) ); % in rul of LAO
    Q_y = single( (3.789/1.0598) .* (ko_y - ki_y) );
    Q_z = single( (3.789/1.0598) .* (ko_z - ki_z) );
%% 切割背底
  bg = 0.5 * (mean(ccdim(1:2,:)) + mean(ccdim(194:195,:)));
  bbtemp(1:195) = 1;
  bg = bbtemp' * bg;
  ccdim = max ((ccdim - bg),0.1);
%% 存储
    V = single( (1 / filterValue) .* ccdim ); 
    save([pwd,'/Data/Qdata/',filename,'.mat'], 'Q_x', 'Q_y', 'Q_z', 'V');
    disp([filename, ' saved as .MAT file']);
end

