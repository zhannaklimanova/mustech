% Matlab implementation of a reverberator  using the filter command
% AP: y[n] = -g*x[n] + x[n-M] - g * y[n-M]
g_AP = 0.7;
M_AP = [227, 347, 443];
b_AP_1 = [-g_AP, zeros(1, M_AP(1)-1), 1]; % feedforward coefficients
b_AP_2 = [-g_AP, zeros(1, M_AP(2)-1), 1];
b_AP_3 = [-g_AP, zeros(1, M_AP(3)-1), 1];
a_AP_1 = [1, g_AP]; % feedbackward coefficient
a_AP_2 = [1, g_AP];
a_AP_3 = [1, g_AP];

% FBCF y[n] = x[n] - a*y[n-M2]
a_FBCF = [0.916, 0.899, 0.895, 0.881];
M_FBCF = [1117, 1361, 1423, 1619];

b_FBCF_1 = 1;
b_FBCF_2 = 1;
b_FBCF_3 = 1;
b_FBCF_4 = 1;
a_FBCF_1 = [1, zeros(1, M_FBCF(1)-1), a_FBCF(1)];
a_FBCF_2 = [1, zeros(1, M_FBCF(2)-1), a_FBCF(2)];
a_FBCF_3 = [1, zeros(1, M_FBCF(3)-1), a_FBCF(3)];
a_FBCF_4 = [1, zeros(1, M_FBCF(4)-1), a_FBCF(4)];

% Delay y[n] = x[n-M];
M1 = 211;
M2 = 179;
b_Delay_1 = [zeros(1, M1)-1, 1];
a_Delay_1 = 1;
b_Delay_2 = [zeros(1, M2)-1, 1];
a_Delay_2 = 1;

% Impulse
num_samples = 80000;
impulse = [1; zeros(num_samples-1, 1)];

% Creating the Filters
AP_1 = filter(b_AP_1, a_AP_1, impulse);
AP_2 = filter(b_AP_2, a_AP_2, AP_1);
AP_3 = filter(b_AP_3, a_AP_3, AP_2);

FBCF_1 = filter(b_FBCF_1, a_FBCF_1, AP_3);
FBCF_2 = filter(b_FBCF_2, a_FBCF_2, AP_3);
FBCF_3 = filter(b_FBCF_3, a_FBCF_3, AP_3);
FBCF_4 = filter(b_FBCF_4, a_FBCF_2, AP_3);

FBCF_sum = FBCF_1 + FBCF_2 + FBCF_3 + FBCF_4;

yl = filter(b_Delay_1, a_Delay_1, FBCF_sum);
yr = filter(b_Delay_2, a_Delay_2, FBCF_sum);

% Plotting Impulse Responses
figure; plot(0:num_samples-1, yl); title('Impulse Response of yl'); xlabel('Time'); ylabel('Magnitude'); hold on;
plot(0:num_samples-1, yr); title('Impulse Response of yl'); xlabel('Time'); ylabel('Magnitude');
