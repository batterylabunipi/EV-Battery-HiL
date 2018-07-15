function [params_out,mix_out] = MixAlg( mix_in,soc_ocv, params_in)
%% SoC estimation by using the Mixed Algorithm with parameters of the 
%  equivalent electrical model obtained by the MWLS algorithm. This
%  function return the parameter used during the estiomation besides the
%  SoC.

% Initialization.
mix_out.vm(1)=mix_in.v(1);
mix_out.vm2(1)=mix_in.v(1);
mix_out.soc(1) = mix_in.soc_init;
mix_out.i_new(1)=0;
mix_out.vrc(1) = 0;
mix_out.voc(1) = mix_in.v(1);
params_out.r0(1) = params_in.r0(1);
params_out.r1(1)= params_in.r1(1); 
params_out.c1(1)=params_in.c1(1);

params_out.a(1) = params_in.a(1);
params_out.b0(1)= params_in.b0(1); 
params_out.b1(1)=params_in.b1(1);
params_out.b2(1)=params_in.b2(1);
mix_out.t=mix_in.t';

params_out.soc=[0:0.001:1];
params_out.ocv=interp1(soc_ocv.soc,soc_ocv.ocv,params_out.soc);

% SoC estimation during the entire test.
for i = 2:length(mix_in.i)
    
    % Parameter post estimation. Negative values and NaN are discarded.
    aux = find(params_in.t==mix_in.t(i));
    if isempty(aux)==0    
        params_out.r0(i) = params_in.r0(aux);
        params_out.r1(i) = params_in.r1(aux);
        params_out.c1(i) = params_in.c1(aux);
    else 
        params_out.r0(i) = params_out.r0(i-1);
        params_out.r1(i) = params_out.r1(i-1);
        params_out.c1(i) = params_out.c1(i-1);
    end
    
    if  isempty(aux)==0    
        params_out.a(i) = params_in.a(aux);
        params_out.b0(i) = params_in.b0(aux);
        params_out.b1(i) = params_in.b1(aux);
        params_out.b2(i) = params_in.b2(aux);
    else 
        params_out.a(i) = params_out.a(i-1);
        params_out.b0(i) = params_out.b0(i-1);
        params_out.b1(i) = params_out.b1(i-1);
        params_out.b2(i) = params_out.b2(i-1);
    end  
    if(i>3)
        mix_out.vm2(i)= mix_in.v(i-2)+...
        params_out.a(i)* (mix_in.v(i-2)-mix_in.v(i-1))+ ...
        params_out.b0(i)* mix_in.i(i)+...
        params_out.b1(i)* mix_in.i(i-1)+...
        params_out.b2(i)* mix_in.i(i-2);
    end

    
    L = 1/(params_out.r0(i)+params_out.r1(i));
    
    mix_out.i_new(i) = mix_in.i(i) - (mix_in.v(i)-mix_out.vm(i-1))*L;
    
    mix_out.soc(i) = mix_out.soc(i-1)-((mix_in.sampletime/(2*mix_in.Q))*...
                                (mix_out.i_new(i)+mix_out.i_new(i-1)));
    if mix_out.soc(i) > 1
        mix_out.soc(i) = 1;
    elseif mix_out.soc(i)<0
        mix_out.soc(i) = 0;
    end
    
    mix_out.vrc(i)= (1/(2*params_out.r1(i)*params_out.c1(i) + mix_in.sampletime))*...
        ((2*params_out.r1(i)*params_out.c1(i) - mix_in.sampletime)*mix_out.vrc(i-1) + ...
        params_out.r1(i)*mix_in.sampletime*(mix_in.i(i)+mix_in.i(i-1)));
   
    mix_out.voc(i) = params_out.ocv(round(1000*mix_out.soc(i)+1));

    mix_out.vm(i) = mix_out.voc(i) - mix_out.vrc(i) - mix_in.i(i)*params_out.r0(i);

end
end

