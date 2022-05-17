function [B,A] = lp2_2ndorderpeak(w_c, gain, Fs)
%LP2_2NDORDERPEAK Summary of this function goes here
% K is the centre frequency
% V is the gain
% Q is the steepness of the cut / boost

K = tan(pi * (w_c / Fs));

V = 10^(gain / 20);

Q = 0.8;


coeff_1 = 1;

coeff_2 = (2 * (K^2 - 1))/(1 + (1/Q)*K + K^2);

coeff_3 = (1 - (1/Q)*K + K^2)/(1 + (1/Q)*K + K^2);

coeff_4 = (1 + (V/Q)*K + K^2)/(1 + (1/Q)*K + K^2);

coeff_5 = (2 * (K^2 - 1))/(1 + (1/Q)*K + K^2);

coeff_6 = (1 - (V/Q)*K + K^2)/(1 + (1/Q)*K + K^2);


A = [coeff_1, coeff_2, coeff_3] .* Q;
B = [coeff_4, coeff_5, coeff_6] .* Q;
end

