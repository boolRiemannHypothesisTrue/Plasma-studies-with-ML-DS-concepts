% Parameters
Fs = 1000;               % Sampling frequency (Hz)
t = 0:1/Fs:1-1/Fs;       % Time vector
f_signal = 5;            % Main signal frequency (Hz)
signal = sin(2*pi*f_signal*t);  % Pure signal

% Adding noise and higher frequency components
f_noise1 = 100;           % Noise frequency (Hz)
f_noise2 = 75;            % Second noise frequency (Hz)
noise1 = 0.5 * sin(2*pi*f_noise1*t);  % Noise at 100 Hz
noise2 = 0.5 * sin(2*pi*f_noise2*t);  % Noise at 75 Hz
high_freq_component = 0.3 * sin(2*pi*150*t);  % High-frequency useful component
important_component1 = 0.4 * sin(2*pi*30*t); % Important component at 30 Hz
important_component2 = 0.4 * sin(2*pi*120*t); % Important component at 120 Hz

% Noisy signal with additional important components
noisy_signal = signal + noise1 + noise2 + high_freq_component + ...
               important_component1 + important_component2 + 0.2*randn(size(t));  % Noisy signal

% Notch filter design to block 50-100 Hz
Q_factor = 30;           % Quality factor (narrowness of the notch)
f_low = 50;              % Lower bound of the frequency to block (Hz)
f_high = 100;            % Upper bound of the frequency to block (Hz)

% Create a series of notch filters to block frequencies between 50-100 Hz
wo1 = f_low / (Fs / 2);  % Normalized frequency for lower bound
wo2 = f_high / (Fs / 2); % Normalized frequency for upper bound

% Filter design for blocking both 50 Hz and 100 Hz
[b1, a1] = iirnotch(wo1, wo1/Q_factor);  
[b2, a2] = iirnotch(wo2, wo2/Q_factor);  

% Apply notch filters
filtered_signal = filtfilt(b1, a1, noisy_signal);  % Apply first notch filter
filtered_signal = filtfilt(b2, a2, filtered_signal);  % Apply second notch filter

% Frequency spectrum before and after filtering
N = length(t);
f = Fs * (0:(N/2)) / N;  % Frequency vector
noisy_signal_fft = abs(fft(noisy_signal) / N);
filtered_signal_fft = abs(fft(filtered_signal) / N);

% Visualization
figure;

% Original and noisy signal
subplot(4,1,1);
plot(t, signal, 'k', 'LineWidth', 1.5); hold on;
plot(t, noisy_signal, 'r', 'LineWidth', 1);
title('$Original\ and\ Noisy\ Signal$', 'Interpreter', 'latex');
xlabel('$Time\ (s)$', 'Interpreter', 'latex');
ylabel('$Amplitude$', 'Interpreter', 'latex');
legend({'$Original$', '$Noisy$'}, 'Interpreter', 'latex');
grid on;

% Filtered signal
subplot(4,1,2);
plot(t, filtered_signal, 'b', 'LineWidth', 1.5);
title('$Filtered\ Signal\ (Notch\ Filter)$', 'Interpreter', 'latex');
xlabel('$Time\ (s)$', 'Interpreter', 'latex');
ylabel('$Amplitude$', 'Interpreter', 'latex');
grid on;

% Frequency spectrum of noisy signal
subplot(4,1,3);
plot(f, noisy_signal_fft(1:N/2+1), 'r', 'LineWidth', 1.5);
title('$Spectrum\ of\ Noisy\ Signal$', 'Interpreter', 'latex');
xlabel('$Frequency\ (Hz)$', 'Interpreter', 'latex');
ylabel('$Magnitude$', 'Interpreter', 'latex');
grid on;

% Frequency spectrum after filtering
subplot(4,1,4);
plot(f, filtered_signal_fft(1:N/2+1), 'b', 'LineWidth', 1.5);
title('$Spectrum\ After\ Filtering$', 'Interpreter', 'latex');
xlabel('$Frequency\ (Hz)$', 'Interpreter', 'latex');
ylabel('$Magnitude$', 'Interpreter', 'latex');
grid on;
