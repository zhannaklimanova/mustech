function wave = get_frequency(F0, Fs, amplitude)
% DUMBFUN  An example Matlab function.
%
%   Y = DUMBFUN(X,Z) doesn't do much.  The Z parameter is optional
%   and should either be a scalar or equal in size to X.
T = 1/Fs;                      % sampling period
t = 0:T:1;                 % time vector
omega = 2*pi*F0;                % angular frequency
phi = -2*pi*0.25;              % 1/4 cycle phase offset
% wave = cos(omega*t + phi);
wave = amplitude * cos(omega*t + phi); % length = 1 * Fs

% N = 6;                         % number of sinusoid components to sum
% 
% omega = 2*pi*F0;                % angular frequency
% phi = -2*pi*0.25;              % 1/4 cycle phase offset
% 
% x = 0;
% for n = 1:2:2*N,
%   x = x + cos(n*omega*t + phi) ./ n;
% end