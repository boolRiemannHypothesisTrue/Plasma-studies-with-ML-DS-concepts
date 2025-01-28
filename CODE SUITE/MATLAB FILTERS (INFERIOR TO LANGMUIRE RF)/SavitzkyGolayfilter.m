% Параметры сигнала
Fs = 1000;                % Частота дискретизации (Гц)
t = 0:1/Fs:1-1/Fs;        % Вектор времени
f = 5;                    % Частота синусоиды (Гц)
signal = sin(2*pi*f*t);    % Чистый синусоидальный сигнал

% Добавление шума к сигналу
noisy_signal = signal + 0.5*randn(size(t));  % Сигнал с шумом (случайный гауссовский шум)

% Параметры фильтра Савицкого-Голея
window_size = 91;         % Размер окна (должен быть нечетным)
polynomial_order = 2;     % Степень полинома

% Применение фильтра Савицкого-Голея с использованием sgolayfilt
smoothed_signal = sgolayfilt(noisy_signal, polynomial_order, window_size);

% Визуализация результатов
figure;
subplot(3,1,1);
plot(t, signal, 'k', 'LineWidth', 1.5);
title('Чистый сигнал');
grid on;

subplot(3,1,2);
plot(t, noisy_signal, 'k', 'LineWidth', 1.5);
title('Сигнал с шумом');
grid on;

subplot(3,1,3);
plot(t, smoothed_signal, 'k', 'LineWidth', 1.5);
title('Сглаженный сигнал (фильтр Савицкого-Голея)');
grid on;

% Увеличиваем видимость на графиках
xlabel('Время (с)');
ylabel('Амплитуда');
