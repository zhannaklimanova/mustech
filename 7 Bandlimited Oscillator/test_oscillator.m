f0s = logspace(1.75, 3.75, 10);
fs = 44100; 
frequency =f0s(10);
a = 2.5;
wave = get_oscillator(a, frequency, fs);

block_wave = wave(1: 2^14);

window = hann(2^14);
windowed_wave = block_wave.*window;
fft_wave = abs(fft(windowed_wave));
fftLength = length(windowed_wave);
wave_db = db(fft_wave);
freq = 0:fs/length(fft_wave):(fs*(1-1/length(fft_wave)));

figure;
plot(freq(1: fftLength), wave_db(1: fftLength)); xlabel(sprintf('Frequency (Hz): %d', frequency)); ylabel('Magnitude (dB)'); title('Frequency Response');
