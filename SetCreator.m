%% Parameter

% General
Settings.sampletime = 0.1;
Settings.soc_stop_cond = 0;

% Battery
Settings.N = 96; % Number of cells
Settings.Q = 66.2*3600*ones(1,Settings.N); % Capacity of the cells
Settings.SoCi = 1*ones(1,Settings.N);
Settings.ocv = ocv;
Settings.soc_bp = soc_bp./100;
Settings.params_bp = params_bp./100;
Settings.R0lut3d = repmat(R0,1,Settings.N);
Settings.Rslut3d = repmat(Rs,1,Settings.N);
Settings.Rllut3d = repmat(Rl,1,Settings.N);
Settings.Cslut3d = repmat(Cs,1,Settings.N);
Settings.Cllut3d = repmat(Cl,1,Settings.N);
Settings.Bp2 = Bp2;
Settings.Bp3 = Bp3;

clear Bp2 Bp3 Cl Cllut3d Cs Cslut3d dec_fact N params_bp Rl Rs soc_bp ocv
clear Temperature R0

% Select the speed test profile (1 for UDDS, 2 for HWFET, 3 for FTP, 
% 4 for ECE_R15, 5 for EUDC, 6 for NEDC, 7 for WLTP_class_3, 8 for ArtUrban, 
% 9 for ArtRoad, 10 for ArtMw130, 11 for ArtMw150, 12 for IM240, 13 for LA92, 
% 14 for LA92short, 15 for NYCC, 16 for SFTP_SC03, 17 for SFTP_US06 and 
% 18 for J1015).
Settings.profile = 1;

% Thermal model parameters
Settings.RoomTemp = 25; % Room Temperature in °C
Settings.InitTemp = 25; % Cell Initial Temperature in °C
Settings.ThermRthca = 6; %9; % Thermal resistance cell to ambient in K/W; 
Settings.ThermRthcc = 3; %6; % Thermal resistance cell to cell in K/W;
Settings.ThermCap = 900; %320; % Thermal capacitance in J/W;
Settings.Strings  = 8;  % Number of strings in the battery pack;
Settings.ThermModelEnable = -1; % >=0 to enable the thermal model, otherwise
                               % the constant room temperature is used.

% Current sensor
Settings.CurrNbits = 16;
Settings.CurrFS = 400;
Settings.CurrVar = 0.001;
Settings.CurrOff = 0.2;

% Voltage sensor
Settings.VoltNbits = 16;
Settings.VoltFS = 5;
Settings.VoltVar = 0.0001;
Settings.VoltOff = 0;
