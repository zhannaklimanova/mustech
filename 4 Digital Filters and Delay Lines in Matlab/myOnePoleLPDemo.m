%%%%%%%
% myOnePoleLPDemo.m
%%%%%%%


% config
fs = 48000;     % sampling rate (Hz)

N = 2^8;        % length of input and output signals
f0 = 200;      % frequency of sinusoid (Hz)
doSinusoid = 1;	% if "1", then use sinusoid as input signal

fc = 100;       % cutoff frequency of the filter
g = 1.0;          % gain of the filter at DC (i.e., f=0)


% initialize relevant filter variables
b0 = 0;         % numerator coefficient
a1 = 0;         % denominator coefficient
s1 = 0;         % previous output: we need to store this, as this is the "state" of the filter


% define input signal: a unit impulse or a sinusoid
inputArray = zeros(N,1);
if doSinusoid ~=0
	inputArray(1) = 1;
else
	Ts = 1/fs;
	t = 0;
	for n = 1:N
		inputArray(n) = sin(2*pi*f0*t);
		t = t + Ts;
	end
end

% prepare array for output signal
outputArray = zeros(N,1);

% set filter coefficients given requirements for:
% 1. gain at DC: magnitude of filter response at f = 0 (i.e., at "DC")
% 2. cutoff frequency (f = fc)
[b0,a1] = OnePoleLP_SetCutoffAndGain(g,fc,fs);

tempInput = 0;
tempOutput = 0;
% obtain the output signal
for n=1:N
    tempInput = inputArray(n);
	[s1,tempOutput] = OnePoleLP_Tick(b0,a1,s1,tempInput);
	outputArray(n) = tempOutput;
end

figure;
stem(inputArray);
hold on;
stem(outputArray);





