%% Save and move all data

mkdir(id)
movefile('Settings.mat',strcat('./',id));
movefile('Sim.mat',strcat('./',id));
