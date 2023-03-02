function x = get_oscillator(a, f0, fs)
dur = 1;
NT = floor(dur*fs);
t = dur*(0:NT-1)/NT;
x = zeros(NT, 1);

% f0s = logspace(1.75, 3.75, 10);

% a = 0.79;
% for j = 1:length(f0s)
for i = 1:NT
    x(i) = sin(2*pi*f0*t(i)) / (1+a^2-2*a*cos(2*pi*f0*t(i)));
end
 

% end