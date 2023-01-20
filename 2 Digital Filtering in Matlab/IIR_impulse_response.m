% Difference equaation => y[n] = 0.3x[n] + 1.5x[n-1] + (-0.3)x[n-2] - (-2.3)y[n-1] - (-0.8)y[n-2] 

% IIR filter equation
a = [1 -2.3 -0.8]; b = [0.3 1.5 -0.3];
impulse = [1; zeros(49,1)];
y = filter(b, a, impulse);
figure; stem(0:49, y); title('Impulse Response of an IIR Filter'); xlabel('Time'); ylabel('Magnitude (dB)');
figure; freqz(y);