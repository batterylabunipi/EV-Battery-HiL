function [ Results ] = packet_read(M)
%PACKET_READ: Read a packet of data from Memory Mapped.

    while(M.read('uint32',0,1)~=1)  
    end
        
    Results.I = M.read('single', 4, 1);
    Results.Vcells = M.read('single', 64, 12);
    Results.R = M.read('single', 304, 12);
    Results.C = M.read('single', 352, 12);
    Results.R0 = M.read('single', 400, 12);
    Results.SOC = M.read('single', 448, 12);
    Results.Vm = M.read('single', 496, 12);
    Results.Vrc = M.read('single', 548, 12);
    Results.excyc = M.read('uint32', 648, 1);
end

