%% This code is used to read the spec to get the needed coloumn
 % -- need var: spec_file name of the need col
 % -- How to use it ?
 %    The spec should be the form :top line is the name of col; The other
 %    line is the value of the col 
 
% for example
% name = 'test.txt';
% col_name{1} = 'H'; col_name{2} = 'K';
% To use the Data_spec: The value of H:Data_spec{1}.H; The value of
% K:Data_spec{2}.K

function Data_spec = spec_reader(name,col_name)

Data = importdata(name);
num_data = Data.data;
tex_data = Data.textdata;

for ii = 1:numel(tex_data)
    for jj = 1:numel(col_name)
        tex_one = tex_data{ii};
        if strcmp(col_name{jj},tex_one)
            num_col = num_data(:,ii);
            Data_spec{jj} = struct(col_name{jj},num_col);
        end
    end
end
  
end