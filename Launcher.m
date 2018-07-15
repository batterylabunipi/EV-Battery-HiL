%% Launcher script for the model
%% Load data and path
addpath('./Model')
addpath('./Sim_Model')

% Driving cycles
load ./Model/cycledata/cycles_artemis
load ./Model/cycledata/cycles_epa
load ./Model/cycledata/cycles_nedc
load ./Model/cycledata/cycles_wltp
load ./Model/cycledata/Japan_Light_Duty_Vehicles
load ./Model/cycledata/United_States_Light-Duty_Vehicles

% Battery parameters
load ./Model/cell_model_params
load ./Model/entropy

%% Select the model to be used
model='./Sim_Model/CompleteModel';
% model='./Sim_Model/CompleteModelFPGA';

%% Select the driving profile
% Please, uncomment the row relative to the desired driving profile.
% id = 'J1015'; Settings.profile = 18;
% id = 'SFTP_US06'; Settings.profile = 17;
% id = 'SFTP_SC03'; Settings.profile = 16;
% id = 'NYCC'; Settings.profile = 15;
% id = 'LA92short'; Settings.profile = 14;
% id = 'LA92'; Settings.profile = 13;
% id = 'IM240'; Settings.profile = 12;
id = 'ArtMw150'; Settings.profile = 11;
% id = 'ArtMw130'; Settings.profile = 10; 
% id = 'ArtRoad'; Settings.profile = 9;
% id = 'ArtUrban'; Settings.profile = 8;
% id = 'WLTP_class_3'; Settings.profile = 7;
% id = 'NEDC'; Settings.profile = 6;
% id = 'EUDC'; Settings.profile = 5;
% id = 'ECE_R15'; Settings.profile = 4;
% id = 'ftp'; Settings.profile = 3;
% id = 'hwfet'; Settings.profile = 2;
% id = 'udds'; Settings.profile = 1;


%% Run the model
SetCreator; % Create settings 
save Settings Settings % Save settings file
OCV_LUT = interp1(Settings.soc_bp, Settings.ocv,[0:0.001:1]);
dec_fact = single(30);
sim(model); % Run the simulation
ArchData; % Save data in a folder