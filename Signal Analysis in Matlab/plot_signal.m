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
yt_dB = db(yt);
yt_dB2 = arrayfun(@(yVal) mag2db(yVal), yt); % functional programming approach; yt_dB = yt_dB2
figure;
plot(x, yt_dB); title('Frequency Response of triangle.wav'); xlabel('Frequency (Hz)'); ylabel('Magnitude (dB)');

% Spectrogram
figure;
WINDOW = 1024;
NOVERLAP = 512;
NFFT = 1024;
spectrogram(y, WINDOW, NOVERLAP, NFFT, Fs, 'yaxis'); title('Spectrogram of triangle.wav');