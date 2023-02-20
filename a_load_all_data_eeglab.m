clear all; close all; clc;
%% parameter setting
DataDir = 'A:\Mobile_BCI_OSF\sourcedata';

task = 'ERP'; %ERP, SSVEP
datatype = 'eeg';

switch(task)
    case 'SSVEP'
        ival= [0 5]; % SSVEP
        select_epoch = {  'S 11'  'S 12' 'S 13' };
        nSub = 23;
    case 'ERP'
        ival= [-0.2 0.8]; % ERP
        ref_ival= [-200 0] ;
        select_epoch = {  'S  1'  'S  2' };
        nSub = 24;
end
nSub=1;

subNum=1; sesNum=2;

sub_dire = sprintf('sub-%02d/ses-%02d',subNum,sesNum);
% sub-01_task-ERP_speed-0.8_scalp-EEG
naming = sprintf('sub-%02d_ses-%02d_task-%s_%s',...
    subNum,sesNum,task,datatype);
file_dir = fullfile(DataDir,sub_dire,datatype,naming);

% the header file
file = dir([file_dir, '*.vhdr']);

%% load
try
    EEG = pop_loadbv(file.folder,file.name);
catch
    warning('check the files');
end

EEG = eeg_checkset( EEG );

% epoch
EEG = pop_epoch(EEG, select_epoch, ival, 'epochinfo', 'yes');
    
% baseline
if task == 'ERP'
    EEG = pop_rmbase(EEG, ref_ival,[]);
end

