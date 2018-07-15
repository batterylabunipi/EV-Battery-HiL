function hil_comm_sfunc(block)

    setup(block);
    %endfunction
    
function setup(block)
  
  cell_number = 12;

  block.NumDialogPrms  = 0;
  
  %% Register number of input and output ports
  block.NumInputPorts  = 14;
  block.NumOutputPorts = 1;
  
  %% Setup functional port properties  
  block.InputPort(1).Dimensions        = [1];
  block.InputPort(1).DirectFeedthrough = false;
  block.InputPort(1).DatatypeID        = 1;
  block.InputPort(1).SamplingMode = 'sample';
  block.InputPort(2).Dimensions        = [cell_number,1];
  block.InputPort(2).DirectFeedthrough = false;
  block.InputPort(2).DatatypeID        = 1;
  block.InputPort(2).SamplingMode = 'sample';
  block.InputPort(3).Dimensions        = [1];
  block.InputPort(3).DirectFeedthrough = false;
  block.InputPort(3).DatatypeID        = 1;
  block.InputPort(3).SamplingMode = 'sample';
  block.InputPort(4).Dimensions        = [1];
  block.InputPort(4).DirectFeedthrough = false;
  block.InputPort(4).DatatypeID        = 1;
  block.InputPort(4).SamplingMode = 'sample';
  block.InputPort(5).Dimensions        = [cell_number,1];
  block.InputPort(5).DirectFeedthrough = false;
  block.InputPort(5).DatatypeID        = 1;
  block.InputPort(5).SamplingMode = 'sample';
  block.InputPort(6).Dimensions        = [cell_number,1];
  block.InputPort(6).DirectFeedthrough = false;
  block.InputPort(6).DatatypeID        = 1;
  block.InputPort(6).SamplingMode = 'sample';
  block.InputPort(7).Dimensions        = [cell_number,1];
  block.InputPort(7).DirectFeedthrough = false;
  block.InputPort(7).DatatypeID        = 1;
  block.InputPort(7).SamplingMode = 'sample';
  block.InputPort(8).Dimensions        = 1;
  block.InputPort(8).DirectFeedthrough = false;
  block.InputPort(8).DatatypeID        = 1;
  block.InputPort(8).SamplingMode = 'sample';
  block.InputPort(9).Dimensions        = [cell_number,1];
  block.InputPort(9).DirectFeedthrough = false;
  block.InputPort(9).DatatypeID        = 1;
  block.InputPort(9).SamplingMode = 'sample';
  block.InputPort(10).Dimensions        = [cell_number,1];
  block.InputPort(10).DirectFeedthrough = false;
  block.InputPort(10).DatatypeID        = 1;
  block.InputPort(10).SamplingMode = 'sample';
  block.InputPort(11).Dimensions        = 1;
  block.InputPort(11).DirectFeedthrough = false;
  block.InputPort(11).DatatypeID        = 1;
  block.InputPort(11).SamplingMode = 'sample';
  block.InputPort(12).Dimensions        = [1];
  block.InputPort(12).DirectFeedthrough = false;
  block.InputPort(12).DatatypeID        = 1;
  block.InputPort(12).SamplingMode = 'sample';
  block.InputPort(13).Dimensions        = [cell_number,1];
  block.InputPort(13).DirectFeedthrough = false;
  block.InputPort(13).DatatypeID        = 1;
  block.InputPort(13).SamplingMode = 'sample';
  block.InputPort(14).Dimensions        = [cell_number,6];
  block.InputPort(14).DirectFeedthrough = false;
  block.InputPort(14).DatatypeID        = 1;
  block.InputPort(14).SamplingMode = 'sample';
 
  block.OutputPort(1).Dimensions       = [cell_number,6]; % Outputs to compare (SoC, Vm, R0, R, C)
  block.OutputPort(1).DatatypeID       = 1;
  block.OutputPort(1).SamplingMode     = 'sample';
  
  %% Set block sample time to inherited
  %global SimulinkSampleTime
  block.SampleTimes = [0.1 0];
  
   %% Register methods
  block.RegBlockMethod('Outputs',                   @Output);  
  block.RegBlockMethod('Terminate',                 @Terminate);
  block.RegBlockMethod('Enable',                    @DoEnable);
  block.RegBlockMethod('SetInputPortSamplingMode',  @SetInputPortSamplingMode);

%endfunction

function DoEnable(~)
    SystemConsole.refreshMasters;
    global M
    %global SysConIndexPath
    M = SystemConsole.openMaster(1);

function SetInputPortSamplingMode(~)
    
function Output(block)
    
    global M
    
    if block.CurrentTime > 0    
        if (block.InputPort(11).Data == 1) 
            I = block.InputPort(1).Data;
            V = block.InputPort(2).Data(:);
            T = block.InputPort(3).Data;
            T1 = block.InputPort(4).Data;
            R0_init = block.InputPort(5).Data(:);
            R_init = block.InputPort(6).Data(:);
            C_init = block.InputPort(7).Data(:);
            dec_per = block.InputPort(8).Data;
            SoC_in = block.InputPort(9).Data(:);
            Qr = block.InputPort(10).Data(:);
            Ifilt = block.InputPort(12).Data;
            Vfilt = block.InputPort(13).Data(:);

            packet_write( I, Qr(1), Qr(2), Qr(3), Qr(4), Qr(5), Qr(6), ...
                Qr(7), Qr(8), Qr(9), Qr(10), Qr(11), Qr(12), T, T1, V(1), ...
                V(2), V(3), V(4), V(5), V(6), V(7), V(8), V(9), V(10), ...
                V(11),  V(12), R_init', R0_init', C_init', ...
                SoC_in(1), SoC_in(2), SoC_in(3), ...
                SoC_in(4), SoC_in(5), SoC_in(6), SoC_in(7), SoC_in(8), ...
                SoC_in(9), SoC_in(10), SoC_in(11), SoC_in(12), dec_per, ...
                Ifilt, Vfilt(1), Vfilt(2), Vfilt(3), Vfilt(4), Vfilt(5), ...
                Vfilt(6), Vfilt(7), Vfilt(8), Vfilt(9), Vfilt(10), ...
                Vfilt(11), Vfilt(12), M);
            M.write('uint32', 0, 1);
            results = packet_read(M);
        else
            I = block.InputPort(1).Data;
            V = block.InputPort(2).Data(:);
            T = block.InputPort(3).Data;
            T1 = block.InputPort(4).Data;
            R0_init = block.InputPort(5).Data(:);
            R_init = block.InputPort(6).Data(:);
            C_init = block.InputPort(7).Data(:);
            dec_per = block.InputPort(8).Data;
            SoC_in = block.InputPort(9).Data(:);
            Qr = block.InputPort(10).Data(:);
            Ifilt = block.InputPort(12).Data;
            Vfilt = block.InputPort(13).Data(:);
            % for AMA
            R0 = block.InputPort(14).Data(:,3);
            R = block.InputPort(14).Data(:,4);
            C  = block.InputPort(14).Data(:,5);


           packet_write( I, Qr(1), Qr(2), Qr(3), Qr(4), Qr(5), Qr(6), ...
                Qr(7), Qr(8), Qr(9), Qr(10), Qr(11), Qr(12), T, T1, V(1), ... 
                V(2), V(3), V(4), V(5), V(6), V(7), V(8), V(9), V(10), ...
                V(11),  V(12), R', R0', C', ...
                SoC_in(1), SoC_in(2), SoC_in(3), ...
                SoC_in(4), SoC_in(5), SoC_in(6), SoC_in(7), SoC_in(8), ...
                SoC_in(9), SoC_in(10), SoC_in(11), SoC_in(12), dec_per, ...
                Ifilt, Vfilt(1), Vfilt(2), Vfilt(3), Vfilt(4), Vfilt(5), ...
                Vfilt(6), Vfilt(7), Vfilt(8), Vfilt(9), Vfilt(10), ...
                Vfilt(11), Vfilt(12), M);
            M.write('uint32', 0, 3);
            results = packet_read(M);
        end

        % Post elaboration
        for i = 1:1:12
            scale1=1.5/Qr(i);
            scale2=Qr(i)/1.5;
            if (~isnan(results.R0(i)) && ~isnan(results.R(i)) && ...
                ~isnan(results.C(i)) && results.R0(i)>0.011*scale1 && ...
                results.R(i)>0.006*scale1 && results.C(i)>224*scale2 && ...
                results.R0(i)<0.17*scale1 && results.R(i)<0.1*scale1 && ...
                results.C(i)<6e3*scale2)

                block.OutputPort(1).Data(i,3) = results.R0(i);
                block.OutputPort(1).Data(i,4) = results.R(i);
                block.OutputPort(1).Data(i,5) = results.C(i); 

            else
                block.OutputPort(1).Data(i,3) = block.InputPort(14).Data(i,3);
                block.OutputPort(1).Data(i,4) = block.InputPort(14).Data(i,4);
                block.OutputPort(1).Data(i,5) = block.InputPort(14).Data(i,5); 
            end    
        end
        
        block.OutputPort(1).Data(:,1) = results.SOC';
        block.OutputPort(1).Data(:,2) = results.Vm';
        block.OutputPort(1).Data(:,6) = results.Vrc';
%         block.OutputPort(1).Data(:,3) = results.R0';
%         block.OutputPort(1).Data(:,4) = results.R';
%         block.OutputPort(1).Data(:,5) = results.C'; 
        
       
    end
    

function Terminate(~)
    global M;
    if (ismethod(M,'close'))
        M.close;
    end
    clear M;
    %endfunction