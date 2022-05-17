function [B, A] = lp2ls_DSP(w_c, gain, Fs)
%LP2LS_DSP Summary of this function goes here
%   Detailed explanation goes here

%%%%%%%%%%%%%%%%%%%%%%%%%%

% Calculate the numerator and denominator ready for z domain conversion

T = 1 / Fs;

a = 2 / T;

w_a = laplace_f_warp(w_c, Fs);

b = gain * w_a;

num = b / a;

denom = w_a / a; 

%%%%%%%%%%%%%%%%%%%%%%%%%

% Move into the z domain using the num and denom
% multiply by z + 1

a = num + 1;
b = -1 + num;
c = 1 + denom;
d = -1 + denom;

coeff_1 = a / c;
coeff_2 = b / c;
coeff_3 = c / c;
coeff_4 = d / c;

%%%%%%%%%%%%%%%%%%%%%%

% Finally return the coefficients

B = [coeff_1, coeff_2];
A = [coeff_3, coeff_4];

end

