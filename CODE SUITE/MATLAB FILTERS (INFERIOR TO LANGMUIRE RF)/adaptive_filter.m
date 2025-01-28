% Примерные экспериментальные данные с шумом
Fs = 1000;               % Частота дискретизации (Гц)
t = 0:1/Fs:1-1/Fs;       % Вектор времени
f_signal = 5;            % Частота основного сигнала (Гц)
signal = sin(2*pi*f_signal*t);  % Чистый сигнал

% Добавление шума
f_noise = 50;            % Частота шума (Гц)
noise = 0.5 * sin(2*pi*f_noise*t);  % Шум на частоте 50 Гц
noisy_signal = signal + noise + 0.2*randn(size(t));  % Сигнал с шумом

% Инициализация параметров для адаптивного фильтра LMS
mu = 0.01;              % Коэффициент обучения (step size)
N = length(noisy_signal);  % Длина сигнала
M = 32;                 % Количество коэффициентов фильтра (длительность окна)
lms_filtered_signal = zeros(1, N);  % Инициализация фильтрованного сигнала
error_signal = zeros(1, N);         % Инициализация ошибки фильтра
w = zeros(M, 1);                % Вектор коэффициентов фильтра

% Адаптивный фильтр LMS
for n = M:N
    % Вектор входных данных для текущего шага
    x = noisy_signal(n:-1:n-M+1);
    
    % Выход фильтра (предсказание)
    y = w' * x';
    
    % Ошибка (разница между желаемым сигналом и предсказанием)
    error_signal(n) = signal(n) - y;
    
    % Обновление коэффициентов фильтра по алгоритму LMS
    w = w + 2 * mu * error_signal(n) * x';
    
    % Применение фильтра к текущему сигналу
    lms_filtered_signal(n) = y;
end

% Визуализация результатов
figure;

% Чистый сигнал и зашумленный сигнал
subplot(3,1,1);
plot(t, signal, 'k', 'LineWidth', 1.5); hold on;
plot(t, noisy_signal, 'r', 'LineWidth', 1);
title('Original and Noisy Signal');
xlabel('Time (s)');
ylabel('Amplitude');
legend('Original', 'Noisy');
grid on;

% Адаптивно отфильтрованный сигнал
subplot(3,1,2);
plot(t, lms_filtered_signal, 'b', 'LineWidth', 1.5);
title('Filtered Signal using LMS Adaptive Filter');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;

% Ошибка фильтра
subplot(3,1,3);
plot(t, error_signal, 'g', 'LineWidth', 1.5);
title('Error Signal (Difference between Desired and Output)');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;
