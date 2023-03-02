function envelope_wave = get_envelope(fs)
% get_envelope obtains a amplitude envelope that will be used to scale the
% sound.
%
%   envelope_wave = get_envelope(Fs). The Fs parameter is the required
%   sample rate for the envelope waveform.

T = 1/fs;
tau = 0.2;

y = [3, 0];    % y1 and y2 values
a = exp(-T/tau);

% Do iteratively.

tvals =  0: fs-1;
envelope_wave = zeros(size(tvals));
envelope_wave(1) = y(1);
% tn = t(1);

for n = 2:length(tvals)
  envelope_wave(n) = a*envelope_wave(n-1) + (1-a)*y(2);
end

plot(tvals, envelope_wave)
xlabel('Time');
ylabel('Amplitude');
