% ��������� �������
Fs = 1000;                % ������� ������������� (��)
t = 0:1/Fs:1-1/Fs;        % ������ �������
f = 5;                    % ������� ��������� (��)
signal = sin(2*pi*f*t);    % ������ �������������� ������

% ���������� ���� � �������
noisy_signal = signal + 0.5*randn(size(t));  % ������ � ����� (��������� ����������� ���)

% ��������� ������� ���������-�����
window_size = 91;         % ������ ���� (������ ���� ��������)
polynomial_order = 2;     % ������� ��������

% ���������� ������� ���������-����� � �������������� sgolayfilt
smoothed_signal = sgolayfilt(noisy_signal, polynomial_order, window_size);

% ������������ �����������
figure;
subplot(3,1,1);
plot(t, signal, 'k', 'LineWidth', 1.5);
title('������ ������');
grid on;

subplot(3,1,2);
plot(t, noisy_signal, 'k', 'LineWidth', 1.5);
title('������ � �����');
grid on;

subplot(3,1,3);
plot(t, smoothed_signal, 'k', 'LineWidth', 1.5);
title('���������� ������ (������ ���������-�����)');
grid on;

% ����������� ��������� �� ��������
xlabel('����� (�)');
ylabel('���������');
