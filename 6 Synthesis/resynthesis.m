% Read and play audio file
filename = 'triangle.wav';
[y, Fs] = audioread(filename);
% soundsc(y, Fs);  % play normalized sound

% Time Domain
figure;
plot(y);

% Frequency Response
yt = abs(fft(y));
fftLength = floor(length(yt)/2) + 1; % from DFT: kn/N
yt_dB = db(yt);
freq = 0:Fs/length(yt):(Fs*(1-1/length(yt))); % from 0 to ~44100 with a spacing of 0.2424
% figure;
% plot(freq(1: fftLength), yt_dB(1: fftLength)); xlabel('Frequency (Hz)'); ylabel('Magnitude (dB)'); title('Frequency Response');

resynthesised_wave = 0;
frequencies = [29.3247, 1065.87, 1291.26, 2353.49, 4235.6, 5002.65, 5329.34, 6354.98, 7845.369];
amplitudes = [11.0797, 24.9706, 54.1807, 65.9572, 62.9177, 64.004, 29.0352, 45.3408, 35.2009];

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
soundsc(scaled_wave, Fs);
