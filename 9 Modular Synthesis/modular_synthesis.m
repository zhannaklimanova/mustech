% Load marimba sample
[marimba, Fs] = audioread("marimba.aif");
marimba = marimba(:,1); % Take one channel if stereo

% Load dry strike sample
[dry_strike, Fs_dry] = audioread("tap_da_hand_on_da_tabel.wav");
dry_strike = dry_strike(:,1); % Take one channel if stereo
assert(Fs == Fs_dry, 'Sample rates must be the same');

% Perform FFT and obtain parameters
yt = abs(fft(marimba));
fftLength = floor(length(yt)/2) + 1;
yt_dB = db(yt);
freq = 0:Fs/length(yt):(Fs*(1-1/length(yt)));
figure;
plot(freq(1: fftLength), yt_dB(1: fftLength)); xlabel('Frequency (Hz)'); ylabel('Magnitude (dB)'); title('Frequency Response');

% Manually obtaining parameters
num_modes = 5;
frequencies = [65, 648, 964, 1417, 1948];  % approximate modal center frequencies
radii = exp(-pi*B/Fs); % approximate modal radii
amplitudes = [70, 44, 27, 21, 17]; % approximate modal amplitudes of the peaks
B = [0.999, 8, 15, 2, 57];

a0 = 1;
b1 = 0;
peaks = 0;
for i = 1:num_modes
    a1 = -2*radii(i)*cos(2*pi*frequencies(i)*(1/Fs));
    a2 = (radii(i).^2);
    b0 = (1-(radii(i).^2))/2;
    b2 = -b0;
    peaks = peaks + amplitudes(i)*filter([b0, b1, b2], [a0, a1, a2], dry_strike);
end

resonance_filters = peak1 + peak2 + peak3 + peak4 + peak5;
soundsc(resonance_filters, Fs);

