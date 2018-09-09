function fileNames = sortedby(F, method)
%SORTEDBY sorted by file names
%
% varargin:
%   F       --  files (struct array with fields: 
%                        name, date, bytes, isdir and datenum)
%   method  --  sorting method, 'name' (default) or 'datenum'
%
% varargout:
%  filesNames  --  files sorted by the specified method

% copyright (c) wulx, gurdy.woo@gmail.com
% last modified by wulx, 2013/10/26

narginchk(1, 2);
if nargin < 2, method = 'name'; end % default method

fileNames = { F.name };
switch method
    case 'name' % method #2 - sorted by file name
        fileNoExp = '\w+_(?<fileNo>\d+).\w+';
        fileExps = regexp(fileNames, fileNoExp, 'names');
        fileNos = cellfun(@(f) str2double(f.fileNo), fileExps);
        
        [~, idx] = sort(fileNos, 'ascend'); % sorted by file name
        
        fileNames = fileNames( idx );
    case 'datenum' % method #1 - sorted by date number
        [~, idx] = sort( [F.datenum] ); % sorted by datenum
        
        fileNames = fileNames( idx );
    otherwise
        error('unknown method, you should choose name or datenum')
end
