function envelop_wave = get_envelope(Fs)
% DUMBFUN  An example Matlab function.
%
%   Y = DUMBFUN(X,Z) doesn't do much.  The Z parameter is optional
%   and should either be a scalar or equal in size to X.

T = 1/Fs;
x = [0, 30, 700, 1000];
y = [0.0, 1.0, 0.8, 0.0];
n = 0: Fs-1;
envelop_wave = interp1(x, y, 1000*n*T); % need to make this more triangle sound like by adding a exponential 