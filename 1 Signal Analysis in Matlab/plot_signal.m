% Read and play audio file
filename = 'triangle.wav';
[y, Fs] = audioread(filename);
soundsc(y, Fs);  % play normalized sound

% Plot the audio signal
T = 1/Fs;
x = 0:T:(length(y)*T)-T; 

% Time Domain
figure;
plot(x, y); title('Time Domain of triangle.wav'); xlabel('Time (s)'); ylabel('Amplitude');

% Frequency Response
yt = abs(fft(y));
fftLength = floor(length(yt)/2) + 1; % from DFT: kn/N
yt_dB = db(yt);
freq = 0:Fs/length(yt):(Fs*(1-1/length(yt))); % from 0 to ~44100 with a spacing of 0.2424
figure;
plot(freq(1: fftLength), yt_dB(1: fftLength)); xlabel('Frequency (Hz)'); ylabel('Magnitude (dB)'); title('Frequency Response');

% Spectrogram
WINDOW = 1024;
NOVERLAP = 512;
NFFT = 1024;
figure;
spectrogram(y, WINDOW, NOVERLAP, NFFT, Fs, 'yaxis'); title('Spectrogram of triangle.wav');