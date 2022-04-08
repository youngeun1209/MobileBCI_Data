clear all;
startup_bbci_toolbox

%% Load data
BTB.DataDir = 'A:\MobileBCI_BIDS_SD';
BTB.SaveDir = 'A:\MobileBCI_BIDS_SD\CSV';
BTB.task = 'SSVEP'; %ERP, SSVEP
datatype = 'eeg';
%%
switch(BTB.task)
    case 'SSVEP'
        disp_ival= [0 5000]; % SSVEP
        trig_sti = {11,12,13; '5.45','8.57','12'};
        nSub = 23;
    case 'ERP'
        disp_ival= [-200 800]; % ERP
        ref_ival= [-200 0] ;
        trig_sti = {2,1 ;'target','non-target'};
        nSub = 24;
end
%%

for subNum = 1:nSub
fprintf('Load Subject %02d ...\n',subNum)

for sesNum = 1:5
    
    sub_dire = sprintf('sub-%02d/ses-%02d',subNum,sesNum);
    % sub-01_task-ERP_speed-0.8_scalp-EEG
    naming = sprintf('sub-%02d_ses-%02d_task-%s_%s',...
        subNum,sesNum,BTB.task,datatype);
    filename = fullfile(BTB.DataDir,sub_dire,datatype,naming);
    
    % load data
    try
        [cnt, mrk_orig, hdr] = file_readBV(filename, 'Fs', 100);
    catch
        continue;
    end
    
    % create mrk
    mrk= mrk_defineClasses(mrk_orig, trig_sti);
    
    % segmentation
    epo = proc_segmentation(cnt, mrk, disp_ival);
    
    % channel select (scalp EEG - 1:32, ear EEG - 33:46, IMU - 47:73)
    epo_eeg = proc_selectChannels(epo,1:46);
    epo_imu = proc_selectChannels(epo,47:73);
    
    % save as CSV
    % eeg
    mkdir(fullfile(BTB.SaveDir,sub_dire,BTB.task,'eeg'))
    for nTr = 1:size(epo_eeg.y,2)
        data = epo_eeg.x(:,:,nTr);
        naming = sprintf('sub-%02d_ses-%02d_task-%s_%s_tr%03d.csv',...
            subNum,sesNum,BTB.task,'eeg',nTr);
        filename_save = fullfile(BTB.SaveDir,sub_dire,BTB.task,'eeg',naming);
        
        csvwrite(filename_save,data)
    end
    
    % imu
    mkdir(fullfile(BTB.SaveDir,sub_dire,BTB.task,'imu'))
    for nTr = 1:size(epo_imu.y,2)
        data = epo_imu.x(:,:,nTr);
        naming = sprintf('sub-%02d_ses-%02d_task-%s_%s_tr%03d.csv',...
            subNum,sesNum,BTB.task,'imu',nTr);
        filename_save = fullfile(BTB.SaveDir,sub_dire,BTB.task,'imu',naming);
        
        csvwrite(filename_save,data)
    end
    
    % groung truth
    mkdir(fullfile(BTB.SaveDir,sub_dire,BTB.task,'ylabel'))
    data = epo_eeg.y;
    naming = sprintf('sub-%02d_ses-%02d_task-%s_%s.csv',...
        subNum,sesNum,BTB.task,'ylabel');
    filename_save = fullfile(BTB.SaveDir,sub_dire,BTB.task,'ylabel',naming);

    csvwrite(filename_save,data)

    
end
end
