%% Test selection & Load files
path = './Simulation/';

% id = 'ArtMw150';
id = 'udds';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
addpath('./Functions') % Add functions path
load(strcat(path,id,'/Settings.mat'));
load(strcat(path,id,'/Sim.mat'));

%% Estimation settings
cell = 1;
noise = -1; % noise < 0 to use current and voltage w\o noise
            % noise >= 0 to use current and voltage w\ noise

time = Sim.Current.Time;
time_10 = Sim.R0s.Time;

T = Settings.sampletime;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Filter

N = 1; %ordine del filtro
Fs = 0.01; %frequenza taglio filtro Hz
f_data = 1/T; %frequenza dati ingresso Hz 
% [b,a] = ellip(N,10e-3,10e1, Fs/(f_data/2), 'low'); % 0.005 120
[b,a] = ellip(N,10,40, Fs/(f_data/2), 'low'); % 0.005 120
% by sos filter
[sos1, g1] = tf2sos(b,a);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% AMA

% Parameters
win_length=90;
mwls_opt.row_num=30;
mwls_opt.dec_fact=round(win_length/(mwls_opt.row_num*T));
mwls_opt.threshold=0;
mwls_opt.en_p_correction=1;

% MWLS Input
mwls_input.sampletime=Settings.sampletime;
mwls_input.t=Sim.Current.Time;
mwls_input.v1=0;
mwls_input.v2=0;
mwls_input.soc=Sim.socs.Data(:,cell);
mwls_input.Q=Settings.Q(cell);
if noise < 0
    mwls_input.i=Sim.Current.Data;
    mwls_input.v=Sim.Voltages.Data(:,cell);
else
    mwls_input.i=Sim.CurrentNoise.Data;
    mwls_input.v=Sim.VoltagesNoise.Data(:,cell);
end

% Initialization of the params structure
mwls_params.t=0;
mwls_params.soc=mwls_input.soc(1);
mwls_params.r0=0.0004187;
mwls_params.r1=0.0002235;
mwls_params.c1=111860;
mwls_params.a1=1;
mwls_params.a = 0;
mwls_params.b0 = 0;
mwls_params.b1 = 0;
mwls_params.b2 = 0;

% Moving Window Least Squares
String = ['MWLS cell ', num2str(cell)];
disp(String);
[mwls_params] = MWLS_f(mwls_opt,mwls_input,mwls_params,sos1,g1);

% LUT OCV-SOC
soc_ocv.soc=Settings.soc_bp;
soc_ocv.ocv=Settings.ocv;

% Mix Algorithm Input
mix_input = mwls_input;
mix_input.soc_init = mix_input.soc(1);

% Mix Algorithm
String = ['MIX cell ', num2str(cell)];
disp(String);
[params_output,mix_output] = MixAlg(mix_input,soc_ocv, mwls_params);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% DEKF
String = ['DEKF cell ', num2str(cell)];
disp(String);
[ ekf_out ] = DEKF(mix_input);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% SOC Errors

socerr.amamax = max(abs(mix_output.soc'-Sim.socs.Data(:,cell)))*100;
socerr.amarms = rms(mix_output.soc'-Sim.socs.Data(:,cell))*100;
socerr.ekfmax = max(abs(ekf_out.soc'-Sim.socs.Data(:,cell)))*100;
socerr.ekfrms = rms(ekf_out.soc'-Sim.socs.Data(:,cell))*100;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Saving results

if noise < 0
    save([path,id,'/results_cell',num2str(cell)],'ekf_out','mix_input',...
        'mix_output','mwls_input','mwls_opt','mwls_params','params_output',...
        'soc_ocv','socerr')
else
    save([path,id,'/results_noisy_cell',num2str(cell)],'ekf_out','mix_input',...
        'mix_output','mwls_input','mwls_opt','mwls_params','params_output',...
        'soc_ocv','socerr')
end

%% Figure beta

figure('Name','SoC');
plot(time, Sim.socs.Data(:,cell), mix_output.t, mix_output.soc, ... 
    mix_output.t, ekf_out.soc)
legend('Model','AMA','DEKF')

figure('Name','R0');
plot(time_10, Sim.R0s.Data(:,cell), mix_output.t, params_output.r0, ...
    mix_output.t, ekf_out.r0);
legend('Model','AMA','DEKF')

figure('Name','\tau');
plot(time_10, Sim.Rss.Data(:,cell).*Sim.Css.Data(:,cell), ...
    mix_output.t, params_output.r1.*params_output.c1, mix_output.t, ekf_out.tau1)
legend('Model','AMA','DEKF')

figure('Name','Rs');
plot(time_10, Sim.Rss.Data(:,cell), mix_output.t, params_output.r1, ...
    mix_output.t, ekf_out.r1)
legend('Model','AMA','DEKF')

figure('Name','Vrc');
plot(time_10, Sim.Vrcs.Data(:,cell), mix_output.t, mix_output.vrc, mix_output.t, ekf_out.v1)
legend('Model','AMA','DEKF')

figure('Name','Voltage');
plot(time, Sim.Voltages.Data(:,cell), mix_output.t, mix_output.vm, mix_output.t, ekf_out.vm)
legend('Model','AMA','DEKF')

figure('Name','Cs');
plot(time_10, Sim.Css.Data(:,cell), mix_output.t, params_output.c1)
legend('Model','AMA')