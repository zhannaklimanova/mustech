% y[n] = x[n] + 0.95 x[n-7] -> feedforward comb filter
b_filter1 = [1, 0, 0, 0, 0, 0, 0, 0.95]; % feedforward coefficients
a_filter1 = 1; % feedbackward coefficient

% y[n] = x[n] - 0.95 y[n-7] -> feedback comb filter
b_filter2 = 1;
a_filter2 = [1, 0, 0, 0, 0, 0, 0, 0.95];

% y[n] = 0.81 x[n] - 1.73 x[n-1] + x[n-2] + 1.73 y[n-1] - 0.81 y[n-2] -> almost all pass filter
b_filter3 = [0.81, -1.73, 1];
a_filter3 = [1, -1.73, 0.81];

% View frequency responses of the three filters.
figure; freqz(b_filter1, a_filter1); title('Feedforward Comb Filter');
figure; freqz(b_filter2, a_filter2); title('Feedback Comb Filter');
figure; freqz(b_filter3, a_filter3); title('All Pass Filter');

% Impulse response of the three filters
num_samples = 512;
impulse = [1; zeros(num_samples-1, 1)];

y1 = filter(b_filter1, a_filter1, impulse);
figure; plot(0:num_samples-1, y1); title('Impulse Response of an Feedforward Comb Filter'); xlabel('Time'); ylabel('Magnitude (dB)');

y2 = filter(b_filter2, a_filter2, impulse);
figure; plot(0:num_samples-1, y2); title('Impulse Response of an Feedback Comb Filter'); xlabel('Time'); ylabel('Magnitude (dB)');

y3 = filter(b_filter3, a_filter3, impulse);
figure; plot(0:num_samples-1, y3); title('Impulse Response of an All Pass Filter'); xlabel('Time'); ylabel('Magnitude (dB)');

% Plot the magnitude and phase response of the three filters
H1 = fft(y1);
figure; plot(abs(H1)); title('Magnitude Response of an Feedforward Comb Filter'); xlabel('Frequency(Hz)'); ylabel('Magnitude (dB)');
figure; plot(angle(H1)); title('Phase Response of an Feedforward Comb Filter'); xlabel('Frequency(Hz)'); ylabel('Phase Shift');

H2 = fft(y2);
figure; plot(abs(H2)); title('Magnitude Response of an Feedback Comb Filter'); xlabel('Frequency(Hz)'); ylabel('Magnitude (dB)');
figure; plot(angle(H2)); title('Phase Response of an Feedback Comb Filter'); xlabel('Frequency(Hz)'); ylabel('Phase Shift');

H3 = fft(y3);
figure; plot(abs(H3)); title('Magnitude Response of an All Pass Filter'); xlabel('Frequency(Hz)'); ylabel('Magnitude (dB)');
figure; plot(angle(H3)); title('Phase Response of an All Pass Filter'); xlabel('Frequency(Hz)'); ylabel('Phase Shift');


