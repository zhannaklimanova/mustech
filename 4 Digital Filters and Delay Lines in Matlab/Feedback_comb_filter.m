N = 8000; % length of input and output signals
impulse = [1; zeros(N-1, 1)];
fs = 48000; % sampling rate (Hz)
c = 340; % speed of sound (m/s)
distances = [5, 10, 25]; % wall-to-wall distances (m)
distances_in_samples = [round(distances(1)/340 * fs), round(distances(2)/340 * fs), round(distances(3)/340 * fs)];  % wall-to-wall distances (samples)
fc = [20, 500, 5000]; % cut-off frequencies (Hz)

% initialize relevant delay line variables
delay_line  = zeros(round(50/c*fs),1); % circular buffer
max_length = round(50/c*fs); % this is also the max propagation distance 
write_pointer = 3; % initialize the write pointer to a random position between 1 and maxLength
desired_length = 10; % delay

% prepare array for output signal
output_signal = zeros(N, 1);

% Loop
s1 = 0;
feedback_term = 0;
for d_index = 1:length(distances)
    gain = 1/distances(d_index);
    read_pointer = DelayLine_SetLength(max_length, write_pointer, distances_in_samples(d_index));
    for c_index = 1:length(fc)
        [b0, a1] = OnePoleLP_SetCutoffAndGain(gain, fc(c_index), fs);
        for n=1:N 
	        [delay_line, write_pointer, read_pointer, delay_line_output] = DelayLine_Tick(max_length, delay_line, write_pointer, read_pointer, impulse(n) + feedback_term);
            [s1, filter_output] = OnePoleLP_Tick(b0, a1, s1, delay_line_output);
            feedback_term = filter_output;
            output_signal(n) = filter_output;
        end
        figure;
        plot(output_signal);
        title(sprintf('distance = %d, cutoff frequency = %d', distances(d_index), fc(c_index)));
        delay_line  = zeros(max_length,1);
    end
end
