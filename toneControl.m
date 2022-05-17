function [output] = toneControl(input, lowCutoffFrequency, highCutoffFrequency, toneLowValue, toneMidValue, toneHighValue, loudnessValue)
% toneControl Summary of this function goes here
%   Detailed explanation goes here

toneLowValue = min(toneLowValue, 1);
toneHighValue = min(toneHighValue, 1);
toneMidValue = min(toneMidValue, 1);

toneLowValue = max(toneLowValue, 0);
toneHighValue = max(toneHighValue, 0);
toneMidValue = max(toneMidValue, 0);

toneLowValue = toneLowValue * 2;
toneHighValue = toneHighValue * 2;
toneMidValue = toneMidValue * 12;
toneMidValue = toneMidValue - 6;


% Read in the audio
[x_n, Fs] = audioread(input);

N = Fs / 2; 

channel_length = (length(x_n(:, 1)));

% First calculate the low cutoff frequency

w_c = highCutoffFrequency; 

w_a = laplace_f_warp(w_c, Fs); % Warp the frequency

[B, A] = lp2lp_DSP(w_a, Fs); % Use our own lp prototype converter

[hz_lp, f] = freqz(B, A, 22050, Fs);

y_n = filter(B, A, x_n);

% Move into the second cascading system
% Secondly calculate the high pass frequency

x_n = y_n;

w_c = lowCutoffFrequency;

w_a = laplace_f_warp(w_c, Fs); % Warp the frequency

[B, A] = lp2hp([1], [1, 1], w_a); % use matlabs lp2hp feature

[b, a] = bilinear(B, A, Fs); % perform the bilinear transfer

[hz_hp, f] = freqz(b, a, 22050, Fs); %  find the frequency response

y_n = filter(b, a, x_n);

% Low Boost/Cut

x_n = y_n;

w_c = lowCutoffFrequency;

[B, A] = lp2ls_DSP(w_c, toneLowValue, Fs);

[hz_ls, f] = freqz(B, A, 22050, Fs);

y_n = filter(B, A, x_n);

% Output the real signal

% High Boost/Cut

x_n = y_n;

[B, A] = lp2hs_DSP(highCutoffFrequency, toneHighValue, Fs);

[hz_hs, f] = freqz(B, A, 22050, Fs);

y_n = filter(B, A, x_n);

% Mid Boost/Cut

x_n = y_n;

[B, A] = lp2_2ndorderpeak(10000, toneMidValue, Fs);

[hz_mb, f] = freqz(B, A, 22050, Fs);

y_n = filter(B, A, x_n);

% write the ourput

output = real(y_n);

audiowrite('out.wav', output, Fs);

hz = (hz_hp .* hz_lp .* hz_ls .* hz_hs .* hz_mb);

% plot the frequency response

plot(f, abs(hz));

hold on;

% plot the cascading effects

plot(f, abs(hz_hp));
plot(f, abs(hz_lp));
plot(f, abs(hz_ls));
plot(f, abs(hz_hs));
plot(f, abs(hz_mb));

hold off;

end

