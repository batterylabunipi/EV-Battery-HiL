function Y = round2ev(X)
% Round towards the nearest integer (unbiased rounding / round half to even)
%
% (c) 2013 Stephen Cobeldick
%
% Rounds the elements of X to the nearest integers. X may be an N-D matrix.
% Elements with a fraction of 0.5 round to the nearest even integer.
% For complex X, the imaginary and real parts are rounded independently.
%
% Syntax:
%  Y = round2ev(X)
%
% See also ROUND2OD ROUND2DN ROUND2UP ROUND2RA ROUND2ZE ROUND2SF ROUND2DP ROUND60063 DATEROUND ROUND CONVERGENT
%
% Note 1: Known as unbiased rounding, convergent rounding, Dutch rounding,
%         Gaussian rounding, statistician's rounding or bankers' rounding.
% Note 2: MATLAB's Fixed-Point toolbox provides "convergent".
% Note 3: Defined by ISO/IEC/IEEE 60559 (originally IEEE 754).

if isreal(X)
    Z = rem(X,2);
    Z(abs(Z)~=0.5) = 0;
else
    R = rem(real(X),2);
    J = rem(imag(X),2);
    R(abs(R)~=0.5) = 0;
    J(abs(J)~=0.5) = 0;
    Z = complex(R,J);
end
Y = round(X-Z);
%----------------------------------------------------------------------End!