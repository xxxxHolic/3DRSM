function [ccdsetup, ccdim, scaler, recip, angle, comments]=readccd(ccdfilename, readheader)
%READCCD is to read *.spe file to acquire the image and other info
% ccdim=readccd(ccdfilename, readheader)
% Input parameters--
%   ccdfilename is the *.spe file name, optional, if not given, ask for it.
%	readheader is the flag to indicate whether to read header or not.
% Output values--
%   ccdsetup is the returned values about CCD setups, including the CCD size 
%      (x,y in pixels), ROI region (xstart, xend, ystart, yend) and binning (xbin, ybin).
%   ccdim is the array holding ccd image. 
%   scaler includes ct_time, S[MON], S[scanb]
%   recip includes H, K, L, Energy, and filters
%   angle contains tth, th, chi, and phi
%   comments contains the 5 comment lines, among which line 2, 3, and 4 have been processed here.

global pathsave workpath
pathsave=pwd;
if isempty(workpath),				workpath = pwd;
elseif ~ischar(workpath),			workpath = pwd;
elseif exist(workpath, 'dir')==0,	workpath = pwd;
end	% end if isempty
cd(pathsave);

try
	% initialize the returned values.
	ccdsetup = 0;	scaler = 0;		recip = 0;		angle = 0;		comments = '';	ccdim = zeros(0);		
	if nargin < 2,			readheader = 1;
	elseif readheader ~= 0,	readheader = 1;
	end
    if nargin < 1,
        [filename, pathname]=uigetfile(fullfile(workpath,'*.spe'),'Read CCD .SPE file');
        if filename==0,     
            ccdim = 0;  scaler = 0; recip = 0;  angle = 0; 
            %comment1 = '';          comment5 = '';
            return;     
        end	% If canceled, just return.
        ccdfilename=fullfile(pathname,filename);
        workpath=pathname;
    end
    fid=fopen(ccdfilename,'r');             % Start reading the binary data file
    rstatus = fseek(fid, 6, 'bof');         % seek to   Byte 6
	if rstatus == -1,	error('Fseek error--Total number of pixels:X');			end
    ccdsetup(1) = fread(fid, 1, 'int16');	% total number of pixels of detector x-direction
    rstatus = fseek(fid, 2, 'cof');			%           Byte 10
	if rstatus == -1,	error('Fseek error--Exposure time');			end
    exptime = fread(fid, 1, 'float');		% exposure time
    rstatus = fseek(fid, 4, 'cof');			%           Byte 18
	if rstatus == -1,	error('Fseek error--Total number of pixels:Y');			end
    ccdsetup(2) = fread(fid, 1, 'int16');	% total number of pixels of detector y-direction
    rstatus = fseek(fid, 22, 'cof');        %           Byte 42
	if rstatus == -1,	error('Fseek error--ROI pixels:X');			end
    xdim = fread(fid, 1, 'uint16');         % ROI pixel number, x-direction
    rstatus = fseek(fid, 156, 'cof');       %           Byte 200
	if rstatus == -1,	error('Fseek error--Comments');			end
    comments = fread(fid, 400, '*char')';  % comment line 1-5
    %___________ Processing the comments lines ________
    [scaler, scount] = sscanf(comments(81:160), '%f', 3);   % scaler is ct_time, S[MON], S[scanb]
    if scount == 2,     scaler = [1; scaler];   end         % set default count time as 1 if not recorded.
    [recip, scount] = sscanf(comments(161:240), '%f', 5);   % recip is H, K, L, Energy, and filters/transmission
    if scount <= 3,     recip(4) = 19.5;        end         % set default Enengy to 19.5 keV if not recorded. 
    %if scount >= 5,     scaler = [ scaler; round( recip(5) ) ];
    if scount >= 5,     scaler = [ scaler; recip(5) ];
    else                scaler = [ scaler; 1 ]; end
	scaler = [scaler; exptime];				% put the exposure time at the end
    [angle, scount] = sscanf(comments(241:320), '%f', 6);   % angle is tth, th, chi, phi (and nu, mu)
	if (scount ~= 4 && scount ~= 6 && readheader),		
		error('Read comments4 error');
	end
	if (scount == 4),						angle = [angle; 0; 0];				end
    [misc, scount] = sscanf(comments(321:400), '%f', 5);	% misc includes ALPHA, BETA, AZIMUTH, EPOCH, (and filterTi)
	if (scount < 4 || scount > 5) && readheader,		error('Read comments5 error');		
	elseif (scount==4),		misc(5) = 0;
	end
	angle = [angle; misc];					% attach misc to angle
    %____________ End of processing comments __________
    rstatus = fseek(fid, 56, 'cof');        %           Byte 656
	if rstatus == -1,	error('Fseek error--ROI pixels:Y');			end
    ydim = fread(fid, 1, 'uint16');         % ROI pixel number, y-direction
    rstatus = fseek(fid, 788, 'cof');       %           Byte 1446
	if rstatus == -1,	error('Fseek error--number of frames');			end
    frame = fread(fid, 1, 'uint32');        % number of frames
    rstatus = fseek(fid, 62, 'cof');        %           Byte 1512
	if rstatus == -1,	error('Fseek error--ROI and binning');			end
    [ROI, scount] = fread(fid, 6, 'uint16');% ROI and binning, in order they are---
    %   for x, start and end pixel number and binning, and for y, same.
    if scount ~= 6,		error('Fread error--ROI and binning');			end
	ccdsetup = [ccdsetup, ROI([1:2, 4:5])', ROI([3,6])'];
    rstatus = fseek(fid, 2576, 'cof');      %           Byte 4100
	if rstatus == -1,	error('Fseek error--CCD Data');			end
    for ind = 1 : frame                     % The CCD ROI readings
        ccdim(:, :, ind) = fread(fid, [xdim, ydim], 'uint16');
    end
    fclose(fid);
catch
    errmsg = lasterr;
    fclose('all');
    hd=errordlg( errmsg, 'CCD data file read error!');
    if ishandle(hd),        uiwait(hd);     end
end