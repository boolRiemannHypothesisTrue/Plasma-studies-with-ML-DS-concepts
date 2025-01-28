% Parameters
Fs = 1000;               % Sampling frequency (Hz)
t = 0:1/Fs:1-1/Fs;       % Time vector
f_signal = 5;            % Main signal frequency (Hz)
signal = sin(2*pi*f_signal*t);  % Pure signal

% Adding noise and higher frequency components
f_noise = 100;           % Noise frequency (Hz)
noise = 0.5 * sin(2*pi*f_noise*t);  % Noise at 100 Hz
high_freq_component = 0.3 * sin(2*pi*150*t);  % High-frequency useful component
noisy_signal = signal + noise + high_freq_component + 0.2*randn(size(t));  % Noisy signal

% Notch filter design to remove noise at 100 Hz
Q_factor = 30;           % Quality factor (narrowness of the notch)
wo = f_noise / (Fs / 2); % Normalized frequency
[b, a] = iirnotch(wo, wo/Q_factor);  % Notch filter design

% Apply notch filter
filtered_signal = filtfilt(b, a, noisy_signal);

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
