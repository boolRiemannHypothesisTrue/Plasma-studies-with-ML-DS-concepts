% ��������� ����������������� ������ � �����
Fs = 1000;               % ������� ������������� (��)
t = 0:1/Fs:1-1/Fs;       % ������ �������
f_signal = 5;            % ������� ��������� ������� (��)
signal = sin(2*pi*f_signal*t);  % ������ ������

% ���������� ����
f_noise = 50;            % ������� ���� (��)
noise = 0.5 * sin(2*pi*f_noise*t);  % ��� �� ������� 50 ��
noisy_signal = signal + noise + 0.2*randn(size(t));  % ������ � �����

% ������������� ���������� ��� ����������� ������� LMS
mu = 0.01;              % ����������� �������� (step size)
N = length(noisy_signal);  % ����� �������
M = 32;                 % ���������� ������������� ������� (������������ ����)
lms_filtered_signal = zeros(1, N);  % ������������� �������������� �������
error_signal = zeros(1, N);         % ������������� ������ �������
w = zeros(M, 1);                % ������ ������������� �������

% ���������� ������ LMS
for n = M:N
    % ������ ������� ������ ��� �������� ����
    x = noisy_signal(n:-1:n-M+1);
    
    % ����� ������� (������������)
    y = w' * x';
    
    % ������ (������� ����� �������� �������� � �������������)
    error_signal(n) = signal(n) - y;
    
    % ���������� ������������� ������� �� ��������� LMS
    w = w + 2 * mu * error_signal(n) * x';
    
    % ���������� ������� � �������� �������
    lms_filtered_signal(n) = y;
end

% ������������ �����������
figure;

% ������ ������ � ����������� ������
subplot(3,1,1);
plot(t, signal, 'k', 'LineWidth', 1.5); hold on;
plot(t, noisy_signal, 'r', 'LineWidth', 1);
title('Original and Noisy Signal');
xlabel('Time (s)');
ylabel('Amplitude');
legend('Original', 'Noisy');
grid on;

% ��������� ��������������� ������
subplot(3,1,2);
plot(t, lms_filtered_signal, 'b', 'LineWidth', 1.5);
title('Filtered Signal using LMS Adaptive Filter');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;

% ������ �������
subplot(3,1,3);
plot(t, error_signal, 'g', 'LineWidth', 1.5);
title('Error Signal (Difference between Desired and Output)');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;
