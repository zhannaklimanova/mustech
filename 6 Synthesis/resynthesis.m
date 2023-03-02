% The following script resynthesises a triangle.wav sound file using
% sinusoidal oscillators of the estimated parameters. 

% Read and play audio file
filename = 'triangle.wav';
[y, Fs] = audioread(filename);
% soundsc(y, Fs);  % play original sound

% Time Domain
figure;
plot(y);

% Frequency Response
yt = abs(fft(y));
fftLength = floor(length(yt)/2) + 1; % from DFT: kn/N
yt_dB = db(yt);
freq = 0:Fs/length(yt):(Fs*(1-1/length(yt))); % from 0 to ~44100 with a spacing of 0.2424
figure;
plot(freq(1: fftLength), yt_dB(1: fftLength)); xlabel('Frequency (Hz)'); ylabel('Magnitude (dB)'); title('Frequency Response');

resynthesised_wave = 0;
frequencies = [29.3247, 1009.16, 1065.87, 1291.26, 1912.89, 1957.24, 2353.49, 3496.91, 3644.50, 5084.91, 5332.73, 5850.89, 4235.60, 5002.65, 6354.98, 7356.38, 8208.49, 8576.45, 9956.83, 10262.0, 11439.8, 11739.5, 12576.9, 12812.2, 13407.5, 14249.4, 15054.7, 15839.0, 16600.0, 17054.1, 17654.9, 18434.6, 18988.4, 19489.5, 20686.3, 21860.2];
amplitudes  = [11.0797, 4.45458, 24.9706, 54.1807, 24.5434, 33.3542, 65.9572, 18.3881, 11.2591, 42.7128, 28.5350, 6.55286, 62.9177, 64.0040, 45.3408, 6.56487, 41.0257, 21.3823, 17.9287, 38.6468, 17.3009, 42.5259, 29.8734, 19.5959, 31.9230, 32.6840, 25.8918, 29.2961, 14.2865, 22.5698, 26.9000, 16.3472, 41.5771, 11.9316, 15.4804, 30.5613];

for idx = 1:length(frequencies)
    frequency = frequencies(idx);
    amplitude = amplitudes(idx);
    resynthesised_wave = resynthesised_wave + get_frequency(frequency, Fs, amplitude);
end

envelope = get_envelope(Fs+1);
scaled_wave = envelope .* resynthesised_wave;
figure;
plot(resynthesised_wave);
plot(scaled_wave);
soundsc(scaled_wave, Fs); % play resynthesised sound
