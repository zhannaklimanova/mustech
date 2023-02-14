% Filter Definitions
% y[n] = x[n] - g * y[n-357] -> Schroeder allpass filter
M = 357;
g = 0.7;
b_filter_allpass = [1, zeros(1, M-1), g]; % feedforward coefficients
a_filter_allpass = 1; % feedbackward coefficient

% y[n] = x[n] - 0.95 * y[n-1037] -> feedback comb filter
N = 1037;
b_filter_feedbackcomb = [1, zeros(1, N-1), 0.95]; % feedforward coefficients
a_filter_feedbackcomb = 1; % feedbackward coefficient

% Impulse
num_samples = 10000;
impulse = [1; zeros(num_samples-1, 1)];

y1 = filter(b_filter_allpass, a_filter_allpass, impulse);
y2 = filter(b_filter_feedbackcomb, a_filter_feedbackcomb, y1);

figure; plot(0:num_samples-1, y2); title('Impulse Response'); xlabel('Time'); ylabel('Amplitude');
H2 = fft(y2);
figure; plot(mag2db(abs(H2))); title('Magnitude Response'); xlabel('Frequency(Hz)'); ylabel('Magnitude (dB)');