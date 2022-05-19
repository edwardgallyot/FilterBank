function [B, A] = lp2lp_DSP(f, Fs)
%LP2 Summary of this function goes here
%   Detailed explanation goes here

T = 1 / Fs;

x = f / (2 / T);

coeff_1 = x / (1 + x);

coeff_2 = (x - 1) / (x + 1);

B = [coeff_1, coeff_1];
A = [1, coeff_2];

end

