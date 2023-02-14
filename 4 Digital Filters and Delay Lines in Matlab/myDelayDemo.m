%%%%%%%
% myDelayDemo.m
%%%%%%%


% config
fs = 48000; % sampling rate (Hz)
N = 2^8;	% length of input and output signals
f0 = 1000;	% frequency of sinusoid (Hz)
doSinusoid = 0;	% if "1", then use sinusoid as input signal


% initialize relevant delay line variables
maxLength = 2^6;
delayLine  = zeros(maxLength,1);
writePointer = 3; %randsample(maxLength,1); % initialize the write pointer to a random position between 1 and maxLength


% define input signal: a unit impulse or a sinusoid
inputArray = zeros(N,1);
if doSinusoid ~=1
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

% set desired delay (in samples) for the delay length
desiredLength = 10;
readPointer = DelayLine_SetLength(maxLength,writePointer,desiredLength);

% obtain the (delayed) output signal
for n=1:N
	[delayLine,writePointer,readPointer,tempOut] = DelayLine_Tick(maxLength,delayLine,writePointer,readPointer,inputArray(n));
	outputArray(n) = tempOut;
end

figure;
stem(inputArray);
hold on;
stem(outputArray);





