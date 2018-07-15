function [ ekf_out ] = DEKF(ekf_in)
%% Dual EKF for SOC and cell model parameter estimation

%% Initialization parameter
R0 = 0.0004187;
Rs = 0.0002235;
Qr = ekf_in.Q;
taus = 25;
T = ekf_in.sampletime;

I = ekf_in.i;
V = ekf_in.v;

%% OCV_LUT fit
%Linear model Poly7:     
%f(x) = p1*x^7 + p2*x^6 + p3*x^5 + p4*x^4 + p5*x^3 + p6*x^2 + p7*x + p8
%Coefficients (with 95% confidence bounds):
%        p1 =       33.53  ;
%        p2 =      -108.7  ;
%        p3 =       129.1  ;
%        p4 =      -66.47  ;
%        p5 =       14.16  ;
%        p6 =      -2.629  ;
%        p7 =       1.813  ;
%        p8 =       3.338  ;
p1 =      -101.6;
p2 =       392.7;
p3 =      -608.5;
p4 =       474.6;
p5 =      -186.5;
p6 =        28.2;
p7 =       2.339;
p8 =       2.886;
%% Initialization

% States vector
x0 = [ekf_in.soc_init; -0.0001];
x = [];
x(:,1) = x0;

P = [];
P(:,:,1) = [5e-1,       0; %1e-2
            0,          1e-1];

% Parameter vector
q0 = [R0; 1/taus; Rs];
q = [];
q(:,1) = q0;

Pq = [];
Pq(:,:,1) = [5e-8,     0,       0;
             0,        5e-6,    0;
             0,        0,       8e-6];
         
Q = [];
Q11=8e-5;
Q22=6e-5;
% Q11=[9.46277891405730];
% Q22=[10.5261981890758];
Q(:,:,1) = [Q11,   0; 
            0,      Q22];

Qq = [];
Qq11=1e-10;
%Qq22=1e-6;
Qq22=4e-6;
Qq33=7e-10;
% Qq11=[6.73566854832345e-10];
% Qq22=[2.21490786580895e-07];
% Qq33=[1.38739505789168e-09];
Qq(:,:,1) = [Qq11,   0,   0; 
                0,   Qq22,   0;
                0,   0,   Qq33];
               
R = [];
R(1) = 1e-2;%1e-1; %5e-3; 

vm = [];
vm(1) = ekf_in.v(1);

dxkoverdq = [0,0,0; 
             0,0,0];
Cq = [0,0,0];
L = [0;0];

%% Recursive filtering Algorithm
k = length(I); % Length of the test
for i = 2:1:k
    
	% Prediction step
	% Parameter estimate time update
    q(:,i) = q(:,i-1); 
	% Error covariance of parameter time update
    Qq(:,:,i) = Qq(:,:,i-1);
    Pq(:,:,i) = Pq(:,:,i-1) + Qq(:,:,i);
	
	% State estimate time update
    x(:,i) = [x(1,i-1) - (T/Qr)*I(i);
              x(2,i-1)*exp(-T*q(2,i)) + q(3,i)*(1-exp(-T*q(2,i)))*I(i)];
	% Error covariance of state time update
    A = [1, 0;
         0, exp(-T*q(2,i))];
    Q(:,:,i) = Q(:,:,i-1);
    P(:,:,i) = A*P(:,:,i-1)*A' + Q(:,:,i);

	% Corrects step
    C = [7*p1*x(1,i)^6 + 6*p2*x(1,i)^5 + 5*p3*x(1,i)^4 + 4*p4*x(1,i)^3 + ...
         3*p5*x(1,i)^2 + 2*p6*x(1,i) + p7, -1];
    R(i) = R(i-1);
	
    L_buff = L;
    L = P(:,:,i)*C'*(C*P(:,:,i)*C'+R(i))^(-1); % Kalman Gain
	
    OCV(i) =  p1*x(1,i)^7 + p2*x(1,i)^6 + p3*x(1,i)^5 + p4*x(1,i)^4 + ...
          p5*x(1,i)^3 + p6*x(1,i)^2 + p7*x(1,i) + p8;
    vm(i) =  OCV(i) - x(2,i) - q(1,i)*I(i);
	% State estimate measurement update
    x(:,i) = x(:,i) + L*(V(i)-vm(i));
    if x(1,i) > 1
        x(1,i) = 1;
    elseif x(1,i) < 0
        x(1,i) = 0;
    end
	% Error covariance of state measurement update
    P(:,:,i) = (eye(2) - L*C)*P(:,:,i);
    P(:,:,i) = diag(diag(P(:,:,i)));
    
    dxkoverdq2 = dxkoverdq - L_buff*Cq;
    dxkoverdq = [0, 0,  0; 
                 0, T*exp(-T*q(2,i))*(q(3,i)*I(i)-x(2,i-1)), (1-exp(-T*...
                 q(2,i)))*I(i)] + A*dxkoverdq2;    
    Cq = [-I(i),0,0] + C*dxkoverdq;
	
    Lq = Pq(:,:,i)*Cq'*(Cq*Pq(:,:,i)*Cq'+R(i))^(-1); % Kalman Gain
	
    aux = Lq*(V(i)-vm(i));
	% Parameter estimate measurement update
    q(1:3,i) = q(1:3,i)+ aux(1:3); 
	% Error covariance of parameter measurement update
    Pq(:,:,i) = (eye(3) - Lq*Cq)*Pq(:,:,i);
%     if 1/q(2,i) > 50
%         q(2,i) = 1/50;
%     end
end

ekf_out.soc = x(1,:);
ekf_out.v1 = x(2,:);
ekf_out.r0 = q(1,:);
ekf_out.tau1 = 1./q(2,:);
ekf_out.r1 = q(3,:);
ekf_out.vm = vm;

display('ATTENZIONE: C''è la limitazione su \tau e SOC') 

end

