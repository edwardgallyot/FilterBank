function [B, A] = lp2lp_DSP(f, Fs)
%LP2 Summary of this function goes here
%   Detailed explanation goes here

T = 1 / Fs;

numerator_1 = f / (2 / T);

denominator_1 = 1 + numerator_1;

denominator_2 = 1 - numerator_1;

coeff_1 = numerator_1 / denominator_1;

coeff_2 = denominator_2 / denominator_1;

B = [coeff_1, coeff_1];
A = [1, -coeff_2];

end

