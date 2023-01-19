% Calculating 2nd-order IIR filter coefficients:
center_frequency = 2000; % Hz
Fs = 44100; % Hz
T = 1/Fs;
r = 0.99;

a1 = -2 * r * cos(2*pi*Fs*T);
a2 = r.^2;
b0 = (1-r.^2)/2;
b1 = 0;
b2 = -b0;

b = [b0 b1 b2];
a = [1 a1 a2];

impulse = [1; zeros(49,1)];
y = filter(b, a, impulse);
% Frequnecy Response
[H, W] = freqz(b, a);
figure; 
plot(W, abs(H)); title('Frequency Response of a Digital Filter'); xlabel('Normalized Frequency'); ylabel('Magnitude (dB)');

% Filtering a noise signal
% noise = rand(1, Fs/2); 
% noisy_noise = [noise, -noise]; % random generated noise with a mean of 0
% disp(mean(noisy_noise));
noise = rand(1, Fs);
centered_noise = noise - mean(noise);

noise_filter = filter(b, a, noise);
figure;
spectrogram(noise_filter);

