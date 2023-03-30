% Load marimba sample
[marimba, Fs] = audioread('marimba.aif');
marimba = marimba(:,1); % Take one channel if stereo

% Load dry strike sound
[dry_strike, Fs_dry] = audioread('taps_short_eto_recommended.wav');
dry_strike = dry_strike(:,1); % Take one channel if stereo
assert(Fs == Fs_dry, 'Sample rates must be the same');

% Perform FFT and obtain parameters
M = fft(marimba);
% frequencies = (0:length(M)-1)*Fs/length(M);
yt = abs(M);
fftLength = floor(length(yt)/2) + 1; % from DFT: kn/N
yt_dB = db(yt);
freq = 0:Fs/length(yt):(Fs*(1-1/length(yt)));
figure;
plot(freq(1: fftLength), yt_dB(1: fftLength)); xlabel('Frequency (Hz)'); ylabel('Magnitude (dB)'); title('Frequency Response');

lowest_freq = [65, 648, 964, 1417, 1948]; % of the peaks
B = [0.999, 8, 15, 2, 57];
r = exp(-pi*B/Fs);

nModes = 5;
f = lowest_freq;            % modal center frequencies
radii = r; % modal radii
amps = [ 70, 44, 27, 21, 17 ];                % modal amplitudes of the peaks
a0 = 1;
a1 = -2 * radii(1) * cos(2 * pi * f(1) * (1/Fs));
a2 = (radii(1).^2);
b0 = (1 - (radii(1).^2)) / 2;
b1 = 0;
b2 = -b0;
a1s = [a0, a1, a2];
b1s = [b0, b1, b2];


a1 = -2 * radii(2) * cos(2 * pi * f(2) * (1/Fs));
a2 = (radii(2).^2);
b0 = (1 - (radii(2).^2)) / 2;
b1 = 0;
b2 = -b0;

a2s = [a0, a1, a2];
b2s = [b0, b1, b2];

a1 = -2 * radii(3) * cos(2 * pi * f(3) * (1/Fs));
a2 = (radii(3).^2);
b0 = (1 - (radii(3).^2)) / 2;
b1 = 0;
b2 = -b0;

a3s = [a0, a1, a2];
b3s = [b0, b1, b2];

a1 = -2 * radii(4) * cos(2 * pi * f(4) * (1/Fs));
a2 = (radii(4).^2);
b0 = (1 - (radii(4).^2)) / 2;
b1 = 0;
b2 = -b0;

a4s = [a0, a1, a2];
b4s = [b0, b1, b2];

a1 = -2 * radii(5) * cos(2 * pi * f(5) * (1/Fs));
a2 = (radii(5).^2);
b0 = (1 - (radii(5).^2)) / 2;
b1 = 0;
b2 = -b0;

a5s = [a0, a1, a2];
b5s = [b0, b1, b2];


peak1 = amps(1) * filter(b1s, a1s, dry_strike);
peak2 = amps(2) * filter(b2s, a2s, dry_strike);
peak3 = amps(3) * filter(b3s, a3s, dry_strike);
peak4 = amps(4) * filter(b4s, a4s, dry_strike);
peak5 = amps(5) * filter(b5s, a5s, dry_strike);
resonance_filters_summed = peak1 + peak2 + peak3 + peak4 + peak5;
soundsc(resonance_filters_summed, Fs);


% [M_max, idx] = maxk(abs(M), 10); % Find the 10 strongest peaks
% f_peaks = frequencies(idx); % Obtain the frequencies of these peaks
% 
% % Set decay rates and relative gains 
% decay_rates = 1./[0.3 0.2 0.1 0.07 0.05 0.04 0.03 0.02 0.01 0.005];
% relative_gains = [1 0.8 0.6 0.4 0.3 0.2 0.15 0.1 0.05 0.02];
% 
% % Resynthesize the marimba sound
% resynth_signal = zeros(size(marimba));
% t = (0:length(marimba)-1)'/Fs;
% 
% for k = 1:length(f_peaks)
%     b = 2*pi*f_peaks(k);
%     a = decay_rates(k);
%     g = relative_gains(k);
%     resynth_signal = resynth_signal + g * exp(-a*t) .* sin(b*t);
% end
% 
% % Convolve the dry strike sound with the synthesized marimba signal
% resynth_signal = conv(resynth_signal, dry_strike);
% 
% % Normalize and listen to the resynthesized sound
% resynth_signal = resynth_signal / max(abs(resynth_signal));
% soundsc(resynth_signal, Fs);
% 
