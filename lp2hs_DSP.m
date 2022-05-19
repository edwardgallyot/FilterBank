function [B, A] = lp2hs_DSP(w_c, gain, Fs)
%LP2HS Summary of this function goes here
%   Detailed explanation goes here

T = 1 / Fs;

w_a = laplace_f_warp(w_c, Fs);

x = w_a / (2 / T);

k = gain;

coeff_1 = (x + k) / (1 + x);
coeff_2 = ((-k) + x) / (1 + x);
coeff_3 = 1;
coeff_4 = (x - 1) / (1 + x);

B = [coeff_1, coeff_2];
A = [coeff_3, coeff_4];

end

