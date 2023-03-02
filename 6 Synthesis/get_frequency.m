function wave = get_frequency(f0, fs, amplitude)
%   get_frequency
%   wave = get_frequency(f0, fs, amplitude) gets the frequnecy of a sine
%   wave for synthesis. 

T = 1/fs; % sampling period
t = 0:T:1; % time vector
omega = 2*pi*f0; % angular frequency
phi = -2*pi*0.25; % 1/4 cycle phase offset
wave = amplitude * cos(omega*t + phi); % Acos(omega(t)+phi)
