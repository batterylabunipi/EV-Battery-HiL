%% Script which save the simulation results

Sim.vel = vel;
Sim.Pe = Pe;
Sim.Vbattery = Vbattery;
Sim.Current = Current;
Sim.CurrentNoise = CurrentNoise;
Sim.Tcells = Tcells;
Sim.socs = socs;
Sim.Voltages = Voltages;
Sim.VoltagesNoise = VoltagesNoise;
Sim.R0s = R0s;
Sim.Rss = Rss;
Sim.Css = Css;
Sim.Rls = Rls;
Sim.Cls = Cls;
Sim.Vrcs = Vrcs;
Sim.Voc = Voc;
Sim.Vmcont = Vmcont;
Sim.stopcondition = stopcondition;

clear vel Pe Vbattery Current CurrentNoise Tcells socs Voltages VoltagesNoise
clear R0s Rss Css Rls Cls Vrcs Voc Vmcont stopcondition

save Sim Sim

