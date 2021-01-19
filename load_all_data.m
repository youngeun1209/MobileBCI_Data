clear all;

%% Load Isolated data
BTB.DataDir = 'A:\Scientific_data';
BTB.paradigm = 'ERP'; %ERP, SSVEP

%% 
if BTB.paradigm(1) == 'E'
    speed_pool = {'tr', '0.0', '0.8', '1.6', '2.0'};
else
    speed_pool = {'0.0', '0.8', '1.6', '2.0'};
end
%%
scalp_EEG = []; ear_EEG=[];IMU_EEG=[];
for subNum = 1:18

fprintf('Load Subject %02d ...\n',subNum)
%% Modality
modals = {'scalp','ear','IMU'};
for imodal = 1:3
modal = modals{imodal};

files = [BTB.DataDir '\' sprintf('s%02d_%s_%s_*',...
        subNum,modal,BTB.paradigm)];
    
filelist = dir(files);

%% speeds
for ispeed=1:length(filelist)
    %% load data
    f_cell = strsplit(erase(filelist(ispeed).name,'.mat'),'_');
    idx = find(ismember(speed_pool,f_cell(4)));
    data = load([BTB.DataDir '\' filelist(ispeed).name]);
    
    %% convert data formation
    epo = struct('x',data.preprocess_x,'fs',data.preprocess_fs,'clab',{data.preprocess_clab},...
        't',data.t,'y',data.event.y,'className',{data.event.className},'event',data.event,...
        'cnt_x',data.raw_x,'cnt_fs',data.raw_fs,'cnt_clab',{data.raw_clab},'data_name',filelist(ispeed).name);
    
    switch imodal
        case 1
            scalp_EEG{subNum,idx} = epo;
        case 2
            ear_EEG{subNum,idx} = epo;
        case 3
            IMU_EEG{subNum,idx} = epo;
    end
end
end

end
