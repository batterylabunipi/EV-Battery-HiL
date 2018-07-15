function [ mwls_params] = MWLS_f(mwls_opt,mwls_input,mwls_params,sos1,g1)
%% Online parameter identification algorithm using Moving Window Least 
%  Squares (MWLS). The step_estimation must be a multiple of T*dec_fact 
%  product. In this function, the signals conditioning and the post
%  elaboration parts are missing.

%prova
I = sosfilt(sos1,mwls_input.i).*g1;
V = sosfilt(sos1,mwls_input.v).*g1;
% I = mwls_input.i;
% V = mwls_input.v;

% Initialization.
T_dec = mwls_input.sampletime*mwls_opt.dec_fact;

A = zeros(mwls_opt.row_num,4);
b = zeros(mwls_opt.row_num,1);

I_win = zeros(mwls_opt.row_num+2,1);
V_win = ones(mwls_opt.row_num+2,1)*mwls_input.v(1);
      
% Decimation of the test vectors.
t_dec = mwls_input.t(2:mwls_opt.dec_fact:end);
soc_dec = mwls_input.soc(2:mwls_opt.dec_fact:end);
% I_dec = mwls_input.i(2:mwls_opt.dec_fact:end);
I_dec = I(2:mwls_opt.dec_fact:end);
% V_dec = mwls_input.v(2:mwls_opt.dec_fact:end);
V_dec = V(2:mwls_opt.dec_fact:end);

% t_dec = [];
% % soc_dec = [];
% I_dec=[];
% V_dec=[];
% for i=2:mwls_opt.dec_fact:length(mwls_input.i)-mwls_opt.dec_fact
%    t_dec = [t_dec;mwls_input.t(i)];
% %    soc_dec = [soc_dec;mwls_input.soc(i)];
%    I_dec=[I_dec;sum( mwls_input.i(i:i+mwls_opt.dec_fact))/mwls_opt.dec_fact];
%    V_dec=[V_dec;sum( mwls_input.v(i:i+mwls_opt.dec_fact))/mwls_opt.dec_fact];
% end

std_I_win=[];
% Identification of the parameters trend during the entire test.
for i=1:1:length(I_dec)
    
    mwls_params.t = [mwls_params.t; t_dec(i)];
%     mwls_params.soc = [mwls_params.soc; soc_dec(i)];

    
    % I_win and V_win vectors contain the current and voltage samples 
    % belonging to the current identification window.
    I_win(1:mwls_opt.row_num+1) = I_win(2:mwls_opt.row_num+2);
    I_win(mwls_opt.row_num+2)   = I_dec(i);
    V_win(1:mwls_opt.row_num+1) = V_win(2:mwls_opt.row_num+2);
    V_win(mwls_opt.row_num+2)   = V_dec(i);
    
    % The new parameter values are update only if the standard deviation of
    % the current samples is greater than a threshold. This solution allows
    % to avoid some wrong identification.
    std_I_win=[std_I_win,std(I_win)];
    if std(I_win) > mwls_opt.threshold 
        
        % Build the system Ax=b.
        A1 = V_win(1:end-2)-V_win(2:end-1);
        A2 = I_win(3:end);
        A3 = I_win(2:end-1);
        A4= I_win(1:end-2);
        A = [A1,A2,A3,A4];
        b = V_win(3:end)-V_win(1:end-2);

        % Solve the Ax=b system to obtain the x vector, which contains the
        % coefficients of the ARX model.
        x2 = A\b;
        a1 = x2(1);
        b0 = x2(2);
        b1 = x2(3);
        b2 = x2(4);
        
        mwls_params.a = [mwls_params.a; a1];
        mwls_params.b0 = [mwls_params.b0; b0];
        mwls_params.b1 = [mwls_params.b1; b1];
        mwls_params.b2 = [mwls_params.b2; b2];
  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % The parameters of the electrical equivalent model are obtained
        % from the ARX coefficients by solving the system
        
        % Create the coefficients 
        c1=2*mwls_input.Q*T_dec*(1-(a1/(2+a1)))*b0;
        c2=2*mwls_input.Q*T_dec*(1-(a1/(2+a1)))*b1;
        c3=2*mwls_input.Q*T_dec*(1-(a1/(2+a1)))*b2;
        c4=(-1+(a1/(2+a1)))*T_dec^2;
        c5=2*mwls_input.Q*T_dec*(-1+(a1/(2+a1)));
        c6=mwls_input.Q*T_dec^2*((a1/(2+a1)));
        c7=-2*T_dec^2;
        c8=-4*mwls_input.Q*T_dec*((a1/(2+a1)));
        c9=-T_dec^2*(1+(a1/(2+a1)));
        c10=2*mwls_input.Q*T_dec*(1+(a1/(2+a1)));
        c11=-mwls_input.Q*T_dec^2*((a1/(2+a1)));
        % Compose the system
        D=[c5,c6,c4;
           c8,0,c7;
           c10,c11,c9]; 
        f=[c1;c2;c3];
 
        % Resolve the system
        pa  = D\f;
        % Rename the results
        R0_o = pa(1);
        C_o = 1/pa(2);
        alpha1_o = pa(3);
        % Calculate the R value
        R_o = (-T_dec/(2*C_o))*((a1/(2+a1)));
        
        n_prova = 10;
        % Post elaboration: useful to discard unreasonable value 
        if (mwls_opt.en_p_correction &&...
           (isnan(R0_o) || isnan(R_o) || isnan(C_o) || isnan(alpha1_o) || ...
            R0_o<0|| R_o<0 || C_o<0 || alpha1_o<0 ) ||...
            (abs(R0_o)>abs(mwls_params.r0(end))*n_prova ||...
                abs(R_o)>abs(mwls_params.r1(end))*n_prova ||...
                abs(C_o)>abs(mwls_params.c1(end))*n_prova))

            mwls_params.r0 = [mwls_params.r0; mwls_params.r0(end)];
            mwls_params.r1 = [mwls_params.r1; mwls_params.r1(end)];
            mwls_params.c1 = [mwls_params.c1; mwls_params.c1(end)];
            mwls_params.a1 = [mwls_params.a1; mwls_params.a1(end)];
        else
            mwls_params.r0 = [mwls_params.r0; R0_o];
            mwls_params.r1 = [mwls_params.r1; R_o];
            mwls_params.c1 = [mwls_params.c1; C_o];
            mwls_params.a1 = [mwls_params.a1; alpha1_o];
        end
                       
    else
        % If the current standard deviation is less than the threshold the
        % algorithm holds the values obtained in the previous step.
        mwls_params.r0 = [mwls_params.r0; mwls_params.r0(end)];
        mwls_params.r1 = [mwls_params.r1; mwls_params.r1(end)];
        mwls_params.c1 = [mwls_params.c1; mwls_params.c1(end)];
        mwls_params.a1 = [mwls_params.a1; mwls_params.a1(end)]; 
        
        mwls_params.a = [mwls_params.a; mwls_params.a(end)];
        mwls_params.b0 = [mwls_params.b0; mwls_params.b0(end)];
        mwls_params.b1 = [mwls_params.b1; mwls_params.b1(end)];
        mwls_params.b2 = [mwls_params.b2; mwls_params.b2(end)];
    end
end

mwls_params.stdI = std_I_win;

end

