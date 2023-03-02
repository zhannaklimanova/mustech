f0s = logspace(1.75, 3.75, 10);
fs = 44100; 
wave = get_oscillator(0.00001, f0s(10), fs); % when choosing a's the aliasing energy needs to be very small
wave = get_oscillator(4, f0s(9), fs);
% figure;
% plot(wave);
block_wave = wave(1: 2^14);
% figure;
% plot(block_wave);

window = hann(2^14);
windowed_wave = block_wave.*window;
% figure;
% plot(windowed_wave);
fft_wave = abs(fft(windowed_wave));
% fftLength = floor(length(windowed_wave)) + 1;
fftLength = length(windowed_wave);
wave_db = db(fft_wave);
freq = 0:fs/length(fft_wave):(fs*(1-1/length(fft_wave)));


figure;
plot(freq(1: fftLength), wave_db(1: fftLength)); xlabel('Frequency (Hz)'); ylabel('Magnitude (dB)'); title('Frequency Response');
