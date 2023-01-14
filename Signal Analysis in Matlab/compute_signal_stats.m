% Read audio file
filename = 'trumpet.wav';
[y, Fs] = audioread(filename);
T = 1/Fs;
yLen = length(y);
interval = (yLen*T)-T;
x = 0:T:interval;
M = 4275;
numBlocks = yLen/M;
T_blocks = ceil(interval)/numBlocks;
y_blocks = reshape(y, [M, numBlocks]);
x_blocks = 0:T_blocks:(numBlocks)*T_blocks-T_blocks;

% Calculate useful statistics
mn = sum(y_blocks)/M;
energy = sum(y_blocks.^2);
pow = energy/M;
rtmnsq = sqrt(pow);
variance = sum((y_blocks-mn).^2)/M;

% Plot the audio signal and useful statistics

% Note: the variance and power are similar due to negligable mean values.
% So the green and pink curves are overlapping. 
figure; title('Time Domain of trumpet.wav'); xlabel('Time (seconds)'); ylabel('Signal Amplitude');
hold on;
signal = stairs(x, y, 'black');
avg = stairs(x_blocks, mn, 'red');
power = stairs(x_blocks, pow, 'green');
root_mean_square = stairs(x_blocks, rtmnsq, 'blue');
variance = stairs(x_blocks, variance);

legend([signal, avg, power, root_mean_square, variance], 'signal', 'mean', 'power', 'rms power', 'variance');
legend('FontSize', 8);
hold off;
