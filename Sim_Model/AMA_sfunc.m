function AMA_sfunc(block)

  setup(block);
  
%endfunction


function setup(block)
  
  cell_number = 12;
  row_num = 30;

  block.NumDialogPrms  = 1;
  
  %% Register number of input and output ports
  block.NumInputPorts  = 22;
  block.NumOutputPorts = 10;
  
  %% Setup functional port properties  
  block.InputPort(1).Dimensions        = [1];
  block.InputPort(1).DirectFeedthrough = false;
  block.InputPort(1).DatatypeID        = 1;
  block.InputPort(1).SamplingMode = 'sample';
  block.InputPort(2).Dimensions        = [cell_number];
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
  block.InputPort(5).Dimensions        = [1,cell_number];
  block.InputPort(5).DirectFeedthrough = false;
  block.InputPort(5).DatatypeID        = 1;
  block.InputPort(5).SamplingMode = 'sample';
  block.InputPort(6).Dimensions        = [1,cell_number];
  block.InputPort(6).DirectFeedthrough = false;
  block.InputPort(6).DatatypeID        = 1;
  block.InputPort(6).SamplingMode = 'sample';
  block.InputPort(7).Dimensions        = [1,cell_number];
  block.InputPort(7).DirectFeedthrough = false;
  block.InputPort(7).DatatypeID        = 1;
  block.InputPort(7).SamplingMode = 'sample';
  block.InputPort(8).Dimensions        = [1,cell_number];
  block.InputPort(8).DirectFeedthrough = false;
  block.InputPort(8).DatatypeID        = 1;
  block.InputPort(8).SamplingMode = 'sample';
  block.InputPort(9).Dimensions        = [1,cell_number];
  block.InputPort(9).DirectFeedthrough = false;
  block.InputPort(9).DatatypeID        = 1;
  block.InputPort(9).SamplingMode = 'sample';
  block.InputPort(10).Dimensions        = [1,cell_number];
  block.InputPort(10).DirectFeedthrough = false;
  block.InputPort(10).DatatypeID        = 1;
  block.InputPort(10).SamplingMode = 'sample';
  block.InputPort(11).Dimensions        = [1,cell_number];
  block.InputPort(11).DirectFeedthrough = false;
  block.InputPort(11).DatatypeID        = 1;
  block.InputPort(11).SamplingMode = 'sample';
  block.InputPort(12).Dimensions        = [1,cell_number];
  block.InputPort(12).DirectFeedthrough = false;
  block.InputPort(12).DatatypeID        = 1;
  block.InputPort(12).SamplingMode = 'sample';
  block.InputPort(13).Dimensions        = [1,cell_number];
  block.InputPort(13).DirectFeedthrough = false;
  block.InputPort(13).DatatypeID        = 1;
  block.InputPort(13).SamplingMode = 'sample';
  block.InputPort(14).Dimensions        = 1;
  block.InputPort(14).DirectFeedthrough = false;
  block.InputPort(14).DatatypeID        = 1;
  block.InputPort(14).SamplingMode = 'sample';
  block.InputPort(15).Dimensions        = [cell_number,4];
  block.InputPort(15).DirectFeedthrough = false;
  block.InputPort(15).DatatypeID        = 1;
  block.InputPort(15).SamplingMode = 'sample';
  block.InputPort(16).Dimensions        = [row_num+2,cell_number];
  block.InputPort(16).DirectFeedthrough = false;
  block.InputPort(16).DatatypeID        = 1;
  block.InputPort(16).SamplingMode = 'sample';
  block.InputPort(17).Dimensions        = [row_num+2,cell_number];
  block.InputPort(17).DirectFeedthrough = false;
  block.InputPort(17).DatatypeID        = 1;
  block.InputPort(17).SamplingMode = 'sample';
  block.InputPort(18).Dimensions        = [row_num+2,cell_number];
  block.InputPort(18).DirectFeedthrough = false;
  block.InputPort(18).DatatypeID        = 1;
  block.InputPort(18).SamplingMode = 'sample';
  block.InputPort(19).Dimensions        = 1;
  block.InputPort(19).DirectFeedthrough = false;
  block.InputPort(19).DatatypeID        = 1;
  block.InputPort(19).SamplingMode = 'sample';
  block.InputPort(20).Dimensions        = [cell_number,3];
  block.InputPort(20).DirectFeedthrough = false;
  block.InputPort(20).DatatypeID        = 1;
  block.InputPort(20).SamplingMode = 'sample';
  block.InputPort(21).Dimensions        = [1];
  block.InputPort(21).DirectFeedthrough = false;
  block.InputPort(21).DatatypeID        = 1;
  block.InputPort(21).SamplingMode = 'sample';
  block.InputPort(22).Dimensions        = [cell_number];
  block.InputPort(22).DirectFeedthrough = false;
  block.InputPort(22).DatatypeID        = 1;
  block.InputPort(22).SamplingMode = 'sample';
  
  block.OutputPort(1).Dimensions       = [cell_number,5]; % Outputs to compare (SoC, Vm, R0, R, C)
  block.OutputPort(1).DatatypeID       = 1;
  block.OutputPort(1).SamplingMode     = 'sample';
  block.OutputPort(2).Dimensions       = [1,cell_number];
  block.OutputPort(2).DatatypeID       = 1;
  block.OutputPort(2).SamplingMode     = 'sample';
  block.OutputPort(3).Dimensions       = [1,cell_number];
  block.OutputPort(3).DatatypeID       = 1;
  block.OutputPort(3).SamplingMode     = 'sample';
  block.OutputPort(4).Dimensions       = [1,cell_number];
  block.OutputPort(4).DatatypeID       = 1;
  block.OutputPort(4).SamplingMode     = 'sample';
  block.OutputPort(5).Dimensions       = [1,cell_number];
  block.OutputPort(5).DatatypeID       = 1;
  block.OutputPort(5).SamplingMode     = 'sample';
  block.OutputPort(6).Dimensions       = [1,cell_number];
  block.OutputPort(6).DatatypeID       = 1;
  block.OutputPort(6).SamplingMode     = 'sample';
  block.OutputPort(7).Dimensions       = [row_num+2,cell_number];
  block.OutputPort(7).DatatypeID       = 1;
  block.OutputPort(7).SamplingMode     = 'sample';
  block.OutputPort(8).Dimensions       = [row_num+2,cell_number];
  block.OutputPort(8).DatatypeID       = 1;
  block.OutputPort(8).SamplingMode     = 'sample';
  block.OutputPort(9).Dimensions       = [row_num+2,cell_number];
  block.OutputPort(9).DatatypeID       = 1;
  block.OutputPort(9).SamplingMode     = 'sample';
  block.OutputPort(10).Dimensions       = [cell_number,3];
  block.OutputPort(10).DatatypeID       = 1;
  block.OutputPort(10).SamplingMode     = 'sample';
  
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

function SetInputPortSamplingMode(~)
% block.InputPort(1).SamplingMode = 'sample';
% block.InputPort(2).SamplingMode = 'sample';
% block.InputPort(3).SamplingMode = 'sample';
% block.InputPort(4).SamplingMode = 'sample';
% block.InputPort(5).SamplingMode = 'sample';
% block.InputPort(6).SamplingMode = 'sample';
% block.InputPort(7).SamplingMode = 'sample';
% block.InputPort(8).SamplingMode = 'sample';
% block.InputPort(9).SamplingMode = 'sample';
% block.InputPort(10).SamplingMode = 'sample';
% block.InputPort(11).SamplingMode = 'sample';
% block.OutputPort(1).SamplingMode = 'sample';
% block.OutputPort(2).SamplingMode = 'sample';
% block.OutputPort(3).SamplingMode = 'sample';
% block.OutputPort(4).SamplingMode = 'sample';
% block.OutputPort(5).SamplingMode = 'sample';
% block.OutputPort(6).SamplingMode = 'sample';
% block.OutputPort(7).SamplingMode = 'sample';
% block.OutputPort(8).SamplingMode = 'sample';
% block.OutputPort(9).SamplingMode = 'sample';
% block.OutputPort(10).SamplingMode = 'sample';
% block.OutputPort(11).SamplingMode = 'sample';
% block.OutputPort(12).SamplingMode = 'sample';
% block.OutputPort(13).SamplingMode = 'sample';
% block.OutputPort(14).SamplingMode = 'sample';
% block.OutputPort(15).SamplingMode = 'sample';

function Output(block)
    
    cell_number = 12;
    row_num = 30;
    
    for i = 1:cell_number
        
        OCV_LUT = block.DialogPrm(1).Data;
        if block.CurrentTime > 0 
            if (block.InputPort(14).Data == 1) 
                I = block.InputPort(1).Data;
                %V = block.InputPort(2).Data(i);
                V = 0;
                T = block.InputPort(3).Data;
                T1 = block.InputPort(4).Data;
                R0_init = block.InputPort(5).Data(i);
                R_init = block.InputPort(6).Data(i);
                C_init = block.InputPort(7).Data(i);
                Vm_in = block.InputPort(8).Data(i);
                SoC_in = block.InputPort(15).Data(i,1);
                Qr = block.InputPort(10).Data(i);
                I_new_in = block.InputPort(15).Data(i,2);
                Vrc_in = block.InputPort(15).Data(i,3);
                I_old = block.InputPort(15).Data(i,4);
                Ifilt = block.InputPort(21).Data;
                Vfilt = block.InputPort(22).Data(i);
                
                I_aux = zeros(row_num+2,1);
                V_aux = zeros(row_num+2,1);
                V_buff1 = zeros(row_num+2,1);
                V_buff2 = zeros(row_num+2,1);
                R0_o_aux = R0_init;
                R_o_aux = R_init;
                C_o_aux = C_init;
                R0_o = R0_init;
                R_o = R_init;
                C_o = C_init;
                R0 = R0_init;
                R = R_init;
                C = C_init;
            else
                I = block.InputPort(1).Data;
                V = block.InputPort(2).Data(i);
                T = block.InputPort(3).Data;
                T1 = block.InputPort(4).Data;
                R0_init = block.InputPort(5).Data(i);
                R_init = block.InputPort(6).Data(i);
                C_init = block.InputPort(7).Data(i);
                Vm_in = block.InputPort(8).Data(i);
                SoC_in = block.InputPort(9).Data(i);
                Qr = block.InputPort(10).Data(i);
                I_new_in = block.InputPort(11).Data(i);
                Vrc_in = block.InputPort(12).Data(i);
                I_old = block.InputPort(13).Data(i);
                I_aux = block.InputPort(16).Data(:,i);
                V_aux = block.InputPort(17).Data(:,i);
                V_buff1 = block.InputPort(18).Data(:,i);
                R0_o = block.InputPort(20).Data(i,1);
                C_o = block.InputPort(20).Data(i,2);
                R_o = block.InputPort(20).Data(i,3);
                Ifilt = block.InputPort(21).Data;
                Vfilt = block.InputPort(22).Data(i);
                R0 = R0_o;
                R = R_o;
                C = C_o;
%                 R0 = R0_init;
%                 R = R_init;
%                 C = C_init;
            end

            %% Mix Algorithm

            L = 1/(R0+R);
            I_new = I -(V-Vm_in)*L;
            SoC = SoC_in -((T/(72*Qr))*(I_new+I_new_in));
            if SoC > 100
                SoC = 100;
            elseif SoC<0
                SoC = 0;
            end
            Vrc = (1/(2*R*C+T))*((2*R*C-T)*Vrc_in + R*T*(I+I_old));
            Vm = OCV_LUT(round2ev(10*SoC)+1)-Vrc-R0*I;
            
            %% MWLS
            % I_aux and V_aux vectors contain the current and voltage samples 
            % belonging to the current identification window.
            
            if (block.InputPort(19).Data == 1)
                I_aux(1:row_num+1) = I_aux(2:row_num+2);
                I_aux(row_num+2) = Ifilt; 
                V_buff2 = V_buff1;
                V_buff1 = V_aux;
                V_aux(1:row_num+1) = V_aux(2:row_num+2);
                V_aux(row_num+2)   = Vfilt;
            
            
                % Build the system Ax=b.
                for z=1:row_num
                    A(row_num+1-z,:)=[V_aux(row_num+1-z)-V_aux(row_num+2-z), ...
                        I_aux(row_num+3-z),I_aux(row_num+2-z),I_aux(row_num+1-z)];
                end
                b = V_aux(end-(row_num-1):end)-V_buff2(end-(row_num-1):end);

                % Solve the Ax=b system to obtain the x vector, which contains the
                % coefficients of the ARX model.
                % x2 = A\b;
                [Q_,R_] = givensqr(A);
                R_ = triu(R_(1:4,1:4));
                d = Q_'*b;
                x2=R_\d(1:4);
                a1 = x2(1);
                b0 = x2(2);
                b1 = x2(3);
                b2 = x2(4);
                % The parameters of the electrical equivalent model are obtained
                % from the ARX coefficients by solving the system 
                c1=2*Qr*T1*(1-(a1/(2+a1)))*b0;
                c2=2*Qr*T1*(1-(a1/(2+a1)))*b1;
                c3=2*Qr*T1*(1-(a1/(2+a1)))*b2;
                c4=(-1+(a1/(2+a1)))*T1^2;
                c5=2*Qr*T1*(-1+(a1/(2+a1)));
                c6=Qr*T1^2*((a1/(2+a1)));
                c7=-2*T1^2;
                c8=-4*Qr*T1*((a1/(2+a1)));
                c9=-T1^2*(1+(a1/(2+a1)));
                c10=2*Qr*T1*(1+(a1/(2+a1)));
                c11=-Qr*T1^2*((a1/(2+a1)));
                D=[c5,c6,c4;
                    c8,0,c7;
                    c10,c11,c9]; 
                f=[c1;c2;c3];
                pa  = D\f;
                R0_o_aux = pa(1);
                C_o_aux = 1/pa(2);
                % alpha1_o = pa(3);
                R_o_aux = (-T1/(2*C_o_aux))*((a1/(2+a1)));

                % Post elaboration
                scale1=1.5/Qr;
                scale2=Qr/1.5;
                if (isnan(R0_o_aux) || isnan(R_o_aux) || isnan(C_o_aux)|| ...
                    R0_o_aux<0.011*scale1 || R_o_aux<0.006*scale1 || ...
                    C_o_aux<224*scale2 || R0_o_aux>0.17*scale1 || ...
                    R_o_aux>0.1*scale1 || C_o_aux>6e3*scale2)
                    % Do nothing
                else
                    R0_o = R0_o_aux;
                    R_o = R_o_aux;
                    C_o = C_o_aux;
                end
            end

            block.OutputPort(1).Data(i,1) = SoC;
            block.OutputPort(1).Data(i,2) = Vm;
            block.OutputPort(1).Data(i,3) = R0_o;
            block.OutputPort(1).Data(i,4) = R_o;
            block.OutputPort(1).Data(i,5) = C_o;
            block.OutputPort(2).Data(i) = Vm; 
            block.OutputPort(3).Data(i) = SoC;
            block.OutputPort(4).Data(i) = I_new;
            block.OutputPort(5).Data(i) = Vrc;
            block.OutputPort(6).Data(i) = I;
            block.OutputPort(7).Data(:,i) = I_aux;
            block.OutputPort(8).Data(:,i) = V_aux;
            block.OutputPort(9).Data(:,i) = V_buff1;
            block.OutputPort(10).Data(i,1) = R0_o;
            block.OutputPort(10).Data(i,2) = C_o;
            block.OutputPort(10).Data(i,3) = R_o;
        end
        
    end

%endfunction

function Terminate(~)

%endfunction