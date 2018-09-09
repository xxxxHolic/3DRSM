% -- Ported for PTO

% -- All the Path

Path = dir(fullfile([pwd,'/Data']));

%%
for ii = 3:numel(Path)
    path = [pwd,'/Data/',Path(ii).name];
    eval([Path(ii).name,'_path = path']);
    save([pwd,'/Data/port_data/',Path(ii).name,'_path.mat'],[Path(ii).name,'_path']);
end

%%
port_data = importdata('spec_s.xlsx');

for ii = 1:numel(port_data.textdata) 
    eval([port_data.textdata{ii},'= port_data.data(ii)']);
    save([pwd,'/Data/Port_data/',port_data.textdata{ii},'.mat'],port_data.textdata{ii});
end

% save([pwd,'/Data/port_data/Port_data.mat'],'Port_data');

%%
spec = dir([pwd,'/Data/spec/*.txt']);
spec_name = spec.name;
path = [pwd,'/Data/Origin_data'];
col_name{1} = 'Eta';
col_name{2} = 'Filters';
col_name{3} = 'p_image';
Data_spec = spec_reader(spec_name,col_name);
eval([col_name{1},'= Data_spec{1}.',col_name{1},';']);save([pwd,'/Data/Port_data/',col_name{1},'.mat'],col_name{1});
eval([col_name{2},'= Data_spec{2}.',col_name{2},';']);save([pwd,'/Data/Port_data/',col_name{2},'.mat'],col_name{2});
eval([col_name{3},'= Data_spec{3}.',col_name{3},';']);save([pwd,'/Data/Port_data/',col_name{3},'.mat'],col_name{3});

%%
filter_racter = [1 1 1 1 1 1 1 1 1] ;
save([pwd,'/Data/port_data/filter_racter.mat'],'filter_racter');

%% 

Origin_data_head = 'pil_';
save([pwd,'/Data/port_data/Origin_data_head.mat'],'Origin_data_head');