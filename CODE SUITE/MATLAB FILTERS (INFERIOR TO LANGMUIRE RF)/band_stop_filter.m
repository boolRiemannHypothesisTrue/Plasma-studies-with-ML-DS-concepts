% ��������� ����������������� ������ � �����
Fs = 1000;               % ������� ������������� (��)
t = 0:1/Fs:1-1/Fs;       % ������ �������
f_signal = 5;            % ������� ��������� ������� (��)
signal = sin(2*pi*f_signal*t);  % ������ ������

% ���������� ����
f_noise_low = 30;        % ������ ������� ���� (��)
f_noise_high = 100;      % ������� ������� ���� (��)
noise = 0.5 * sin(2*pi*f_noise_low*t) + 0.5 * sin(2*pi*f_noise_high*t);  % ��� � ��������� �� 30 �� �� 100 ��
high_freq_component = 0.3 * sin(2*pi*150*t);  % ������ ��������������� ����������
noisy_signal = signal + noise + high_freq_component + 0.2*randn(size(t));  % ������ � �����

% ���������� ���
N = length(noisy_signal);
f = Fs * (0:(N/2)) / N;            % ������� ������
signal_fft = fft(noisy_signal);     % ������ ��� ��� ������������ �������

% ����������� ��������� ������ ��� ���������� (��������� ���������� ������)
lower_cutoff_freq = 30;    % ������ ������� ������� (��)
upper_cutoff_freq = 100;   % ������� ������� ������� (��)

% �������������� ��������� ������ � ������� �������
lower_cutoff_index = round(lower_cutoff_freq * N / Fs);
upper_cutoff_index = round(upper_cutoff_freq * N / Fs);

% ���������� ����������: �������� ������� � �������� ���������
filtered_fft = signal_fft;
filtered_fft(lower_cutoff_index:upper_cutoff_index) = 0;  % �������� ������� � �������� ���������

% ���������� ��������� ���
filtered_signal = real(ifft(filtered_fft));

% ������������
figure;

% ������ ������ � ����������� ������
subplot(3,1,1);
plot(t, signal, 'k', 'LineWidth', 1.5); hold on;
plot(t, noisy_signal, 'r', 'LineWidth', 1);
title('$Original\ and\ Noisy\ Signal$', 'Interpreter', 'latex');
xlabel('$Time\ (s)$', 'Interpreter', 'latex');
ylabel('$Amplitude$', 'Interpreter', 'latex');
legend({'$Original$', '$Noisy$'}, 'Interpreter', 'latex');
grid on;

% ������������� ������
subplot(3,1,2);
plot(t, filtered_signal, 'b', 'LineWidth', 1.5);
title('$Filtered\ Signal\ (Bandstop\ FFT)$', 'Interpreter', 'latex');
xlabel('$Time\ (s)$', 'Interpreter', 'latex');
ylabel('$Amplitude$', 'Interpreter', 'latex');
grid on;

% ��������� ������� �� � ����� ����������
noisy_signal_fft = abs(fft(noisy_signal) / N);
filtered_signal_fft = abs(fft(filtered_signal) / N);

subplot(3,1,3);
plot(f, noisy_signal_fft(1:N/2+1), 'r', 'LineWidth', 1.5);
hold on;
plot(f, filtered_signal_fft(1:N/2+1), 'b', 'LineWidth', 1.5);
title('$Spectrum\ Before\ and\ After\ Bandstop\ Filtering$', 'Interpreter', 'latex');
xlabel('$Frequency\ (Hz)$', 'Interpreter', 'latex');
ylabel('$Magnitude$', 'Interpreter', 'latex');
legend({'$Noisy$', '$Filtered$'}, 'Interpreter', 'latex');
grid on;
